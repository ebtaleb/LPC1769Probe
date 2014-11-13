#include "int_handler.h"
#include "constants.h"
#include "light.h"

static uint8_t *regular_str = "REGULAR";
static uint8_t *relay_str = "RELAY";

// EINT3 Interrupt Handler
void EINT3_IRQHandler(void)
{

	// if SW3 is pressed
	if ((LPC_GPIOINT->IO0IntStatF >> 4) & 0x1) {
		//raising edge interrupt on pin 0.4 was fired
		LPC_GPIOINT->IO0IntClr |= (1 << 4); // clear the status

		oled_clearScreen(OLED_COLOR_BLACK);
		if (switch_mode_flag == REGULAR_MODE) {
			switch_mode_flag = RELAY_MODE;
			oled_putString(55, 55, relay_str, OLED_COLOR_WHITE, OLED_COLOR_BLACK);
		} else {
			switch_mode_flag = REGULAR_MODE;
			oled_putString(55, 55, regular_str, OLED_COLOR_WHITE, OLED_COLOR_BLACK);
		}
	}

	if ((LPC_GPIOINT->IO2IntStatF >> 5) & 0x1) { // light interrupt
        // Clear GPIO Interrupt P2.5
        LPC_GPIOINT->IO2IntClr |= (1 << 5);
        light_clearIrqStatus();
		light_threshold_reached = TRUE;
	}

	// accelero handler
	if ((LPC_GPIOINT->IO0IntStatF >> 3) & 0x1) {
		//raising edge interrupt on pin 0.3 was fired
		LPC_GPIOINT->IO0IntClr |= (1 << 3); // clear the status

		printf("accel\n");
	}

      return;
}

void
UART3_IRQHandler(void)
{
	char rx_char;
	static int len = 0;
	while (LPC_UART3->LSR & UART_LSR_RDR) {
		rx_char = UART_ReceiveData(LPC_UART3);

		if (rx_char != '\r') {
			uart_receive_buff[len++] = rx_char;
		} else {
			uart_receive_buff[len] = '\r';
			uart_receive_buff[len+1] = '\0';
			len = 0;
			data_received_flag = TRUE;
		}

	}
}

