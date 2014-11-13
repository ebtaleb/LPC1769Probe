
#include "stdio.h"
#include "string.h"
#include "LPC17xx.h"

#include "led7seg.h"
#include "temp.h"
#include "acc.h"

// custom headers
#include "constants.h"
#include "init_devices.h"
#include "int_handler.h"
#include "asm_shared.h"
#include "speaker.h"
#include "string_helpers.h"
#include "systick.h"

#include "globals.h"	// global variables
#include "print_oled.h"

extern int asm_variance(int x, int mean, int reset);

void SysTick_Handler(void) {

	static uint32_t acc_ticks_counter = 0;
	static uint32_t ls_ticks_counter = 0;
	static uint32_t oled_ticks_counter = 0;

	msTicks++;

	if (msTicks - acc_ticks_counter >= curr_acc_st) {
		acc_ticks_counter = msTicks;
	    acc_read(&x, &y, &z);
		z = z+zoff;
		curr_variance = asm_variance(z, mean, 0);
	}

	if (msTicks - ls_ticks_counter >= curr_ls_st) {
		ls_ticks_counter = msTicks;
		curr_lum = light_read();
	}

	if (msTicks - oled_ticks_counter >= 500) {
		oled_ticks_counter = msTicks;
		print_to_oled(curr_temp, curr_lum, curr_variance, &oled_strings);
	}
}

int
main(void)
{
	uint32_t tempTicks, sspTicks, reportTicks, SW4_Ticks = 0;

	char digits[10] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
	int counter = 0;

	int len, new_msg_len, combined_len = 0;
	uint8_t rep_msg[60] = {0};
	uint8_t new_msg[60] = {0};

	Bool ALARM_OFF = FALSE;
	int SW4 = 1;

	char xbe_str[40] = {0};
	init_report_str(xbe_str);
	init_oled_report(&oled_strings);

	prepare_7seg();

	init_GPIO();
	temp_init(getTick);

	prepare_oled();

	init_i2c();
	prepare_light();
	prepare_acc();

	init_uart();

    prepare_irqs();

	SysTick_Config(SystemCoreClock / 1000);

	while (1) {

		if (switch_mode_flag == REGULAR_MODE) {
			if (light_threshold_reached == FALSE) {
				curr_acc_st = ACC_ST_DIM;
				curr_ls_st = LS_ST_DIM;
				curr_ts_st = TS_ST_DIM;
			} else {
				curr_acc_st = ACC_ST_BRIGHT;
				curr_ls_st = LS_ST_BRIGHT;
				curr_ts_st = TS_ST_BRIGHT;
			}
		} else {
			curr_acc_st = ACC_ST_DIM;
			curr_ls_st = LS_ST_DIM;
			curr_ts_st = TS_ST_DIM;
		}

		if (msTicks - tempTicks > curr_ts_st) {
			tempTicks = msTicks;
			curr_temp = (double)temp_read() / (double)10;

            if (switch_mode_flag == REGULAR_MODE) {
                ALARM_OFF = FALSE;
                if (curr_temp < TEMP_WARN) {
                    ALARM_OFF = TRUE;
                }
            }
		}

        if (msTicks - SW4_Ticks >= 100) {
        	SW4_Ticks = msTicks;

	        if ((SW4 = (GPIO_ReadValue(1) >> 31) & 0x01) == 0) {
	            ALARM_OFF = TRUE;
	            Timer0_Wait(100);
	        }
        }

        if (ALARM_OFF == FALSE && switch_mode_flag == REGULAR_MODE) {
            NOTE_PIN_HIGH();
            Timer0_us_Wait(1300);
            NOTE_PIN_LOW();
            Timer0_us_Wait(1300);
        }

		if (msTicks - sspTicks > 1000) {
			sspTicks = msTicks;

			led7seg_setChar(digits[counter % 10], 0);
			counter++;

			gen_report_str(curr_temp, curr_lum, curr_variance, xbe_str);
			strcpy(rep_msg, xbe_str);
			xbe_str[6] = '\0';
		}

		if (msTicks - reportTicks > REPORTING_TIME) {
			reportTicks = msTicks;
			UART_Send(LPC_UART3, rep_msg, strlen(rep_msg), BLOCKING);

			if (switch_mode_flag == RELAY_MODE) {
				if (data_received_flag) {
					len = strlen(uart_receive_buff);
					if (uart_receive_buff[0] != '#' || len != 23 || uart_receive_buff[len-2] != '#' || uart_receive_buff[len-1] != '\r') {
						UART_Send(LPC_UART3, rep_msg, strlen(rep_msg), BLOCKING);
					} else {
						strcpy(new_msg, rep_msg);
						new_msg_len = strlen(new_msg);
						new_msg[new_msg_len-1] = '\0';

						// append the string to new message
						strcat(new_msg, uart_receive_buff);
						new_msg[new_msg_len-1] = '_';
						combined_len = len+new_msg_len-1;
						new_msg[combined_len-2] = '\r';
						new_msg[combined_len-1] = '\0';
						UART_Send(LPC_UART3, new_msg, combined_len, BLOCKING);
						new_msg[new_msg_len-1] = '\0';
					}
					int i = 0;
					for (i = 0; i < len; i++) {
						uart_receive_buff[i] = 0;
					}
					data_received_flag = FALSE;
				}
			}
		}
		light_threshold_reached = FALSE;
	}
}

