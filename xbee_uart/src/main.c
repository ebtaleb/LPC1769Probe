#include "lpc17xx_pinsel.h"
#include "lpc17xx_uart.h"
//#include "uart2.h"

static char* msg = NULL;

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
}

int
main(void)
{
	uint8_t data = 0;
	uint32_t len = 0;
	uint8_t line[64];

	init_uart();
	//test sending message
	msg = "Welcome to EE2024 \r\n";
	UART_Send(LPC_UART3, (uint8_t *)msg , strlen(msg), BLOCKING);
	//test receiving a letter and sending back to port
	UART_Receive(LPC_UART3, &data, 1, BLOCKING);
	UART_Send(LPC_UART3, &data, 1, BLOCKING);

	//test receiving message without knowing message length
	len = 0;

	//Send a string via UART peripheral
	//UART_SendString(LPC_UART3, uint8_t *txbuf);

	//Receive a block of data via UART peripheral
	//uint32_t UART_Receive(LPC_UART_TypeDef *UARTx, uint8_t *rxbuf, uint32_t buflen, TRANSFER_BLOCK_Type flag);
	while (1) {
	do {
		UART_Receive(LPC_UART3, &data, 1, BLOCKING);

		if (data != '\0') {
			len++;
			line[len++] = data;
		}
	} while ((len<64) && (data != '\r'));

	line[len] = 0;
	UART_SendString(LPC_UART3, &line);
	printf("--%s--\n", line);
	len = 0;
	}

	while (1)
	return 0;
}

