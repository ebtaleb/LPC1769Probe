#include "lpc17xx_pinsel.h"
#include "lpc17xx_uart.h"
#include "LPC17xx.h"
#include "string.h"

volatile uint32_t msTicks = 0;
char rx_buff[32];
Bool data_received_flag = FALSE;

void SysTick_Handler(void) {

	static uint32_t ticks_counter = 0;

	msTicks++;

//	if (msTicks - ticks_counter >= curr_acc_st) {
//		ticks_counter = msTicks;
//	}
}

void
UART3_IRQHandler(void)
{
	char rx_char;
	static int len = 0;
	while (LPC_UART3->LSR & UART_LSR_RDR) {
		rx_char = UART_ReceiveData(LPC_UART3);

		if (rx_char != '\r') {
			rx_buff[len++] = rx_char;
		} else {
			rx_buff[len] = '\r';
			rx_buff[len+1] = '\0';
			len = 0;
			data_received_flag = TRUE;
		}

	}
	//printf("derp\n");
}

void pinsel_uart3(void)
{
	PINSEL_CFG_Type PinCfg;
	PinCfg.Funcnum = 2;
	PinCfg.Pinnum = 0;
	PinCfg.Portnum = 0;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 1;
	PINSEL_ConfigPin(&PinCfg);
}

void init_uart(void)
{
	UART_CFG_Type uartCfg;
	UART_FIFO_CFG_Type uartFIFO;

	uartCfg.Baud_rate = 115200;
	uartCfg.Databits = UART_DATABIT_8;
	uartCfg.Parity = UART_PARITY_NONE;
	uartCfg.Stopbits = UART_STOPBIT_1;

	//pin select for uart3;
	pinsel_uart3();

	//supply power & setup working par.s for uart3
	UART_Init(LPC_UART3, &uartCfg);

	//enable transmit for uart3
	UART_TxCmd(LPC_UART3, ENABLE);

//	UART_FIFOConfigStructInit(&uartFIFO);
//	UART_FIFOConfig(LPC_UART3, &uartFIFO);

	UART_IntConfig(LPC_UART3, UART_INTCFG_RBR, ENABLE);

	/* Enable Interrupt for UART3 */
	NVIC_EnableIRQ(UART3_IRQn);
}

int
main(void)
{
	uint32_t currTicks = 0;
	uint8_t *msg = "N666_T26.9_L154_V000\r";
	uint8_t new_msg[60] = "N666_T26.9_L154_V000";

	init_uart();
	SysTick_Config(SystemCoreClock / 1000);

	int len,new_msg_len, combined_len = 0;

	while (1) {
		//if (msTicks - currTicks > 1000) {
		//	currTicks = msTicks;
			if (data_received_flag) {
				len = strlen(rx_buff);
				if (rx_buff[0] != '#' || len != 23 || rx_buff[len-2] != '#' || rx_buff[len-1] != '\r') {
					UART_Send(LPC_UART3, msg, strlen(msg), BLOCKING);
				} else {
					// append the string to new message
					new_msg_len = strlen(new_msg);

					strcat(new_msg, rx_buff);
					new_msg[new_msg_len] = '_';
					combined_len = len+new_msg_len;
					new_msg[combined_len-2] = '\r';
					new_msg[combined_len-1] = '\0';
					UART_Send(LPC_UART3, new_msg, combined_len, BLOCKING);
					//printf("%s\n", rx_buff);
					new_msg[new_msg_len-1] = '\0';
				}

				rx_buff[0] = '\0';
				data_received_flag = FALSE;
				//UART_Send(LPC_UART3, msg , strlen(msg), BLOCKING);
			}
			//Timer0_Wait(1000);
			//UART_Send(LPC_UART3, msg , strlen(msg), BLOCKING);


	}
	return 0;
}

