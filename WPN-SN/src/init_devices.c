#include "init_devices.h"

void init_ssp(void)
{
	SSP_CFG_Type SSP_ConfigStruct;
	PINSEL_CFG_Type PinCfg;

	/*
	 * Initialize SPI pin connect
	 * P0.7 - SCK;
	 * P0.8 - MISO
	 * P0.9 - MOSI
	 * P2.2 - SSEL - used as GPIO
	 */
	PinCfg.Funcnum = 2;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 0;
	PinCfg.Pinnum = 7;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 8;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 9;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Funcnum = 0;
	PinCfg.Portnum = 2;
	PinCfg.Pinnum = 2;
	PINSEL_ConfigPin(&PinCfg);

	SSP_ConfigStructInit(&SSP_ConfigStruct);

	// Initialize SSP peripheral with parameter given in structure above
	SSP_Init(LPC_SSP1, &SSP_ConfigStruct);

	// Enable SSP peripheral
	SSP_Cmd(LPC_SSP1, ENABLE);

}

void init_GPIO(void)
{
	// Initialize temp sensor
	PINSEL_CFG_Type PinCfg;
	PinCfg.Funcnum = 0;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 0;
	PinCfg.Pinnum = 6;
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(0, 1<<6, 0);

	// Initialize SW3
	PinCfg.Funcnum = 0;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 0;
	PinCfg.Pinnum = 4;
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(1, 1<<4, 0);

	// Initialize SW4
	PinCfg.Funcnum = 0;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 1;
	PinCfg.Pinnum = 31;
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(1, 1<<31, 0);

	// light sensor interrupt
	PinCfg.Funcnum = 0;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 2;
	PinCfg.Pinnum = 5;
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(2, 1<<5, 0);

	// accel int
	PinCfg.Funcnum = 0;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 0;
	PinCfg.Pinnum = 3;
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(0, 1<<3, 0);

    /* ---- Speaker ------> */
    GPIO_SetDir(2, 1<<0, 1);
    GPIO_SetDir(2, 1<<1, 1);

    GPIO_SetDir(0, 1<<27, 1);
    GPIO_SetDir(0, 1<<28, 1);
    GPIO_SetDir(2, 1<<13, 1);

    // Main tone signal : P0.26
    GPIO_SetDir(0, 1<<26, 1);

    GPIO_ClearValue(0, 1<<27); //LM4811-clk
    GPIO_ClearValue(0, 1<<28); //LM4811-up/dn
    GPIO_ClearValue(2, 1<<13); //LM4811-shutdn
    /* <---- Speaker ------ */
}

void init_i2c(void)
{
	PINSEL_CFG_Type PinCfg;

	/* Initialize I2C2 pin connect */
	PinCfg.Funcnum = 2;
	PinCfg.Pinnum = 10;
	PinCfg.Portnum = 0;
	PINSEL_ConfigPin(&PinCfg);
	PinCfg.Pinnum = 11;
	PINSEL_ConfigPin(&PinCfg);

	// Initialize I2C peripheral
	I2C_Init(LPC_I2C2, 100000);

	/* Enable I2C1 operation */
	I2C_Cmd(LPC_I2C2, ENABLE);
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

	UART_IntConfig(LPC_UART3, UART_INTCFG_RBR, ENABLE);

	/* Enable Interrupt for UART3 */
	NVIC_EnableIRQ(UART3_IRQn);
}

void
prepare_7seg(void)
{
	init_ssp();
	led7seg_init();
}

void
prepare_oled(void)
{
	oled_init();
	oled_clearScreen(OLED_COLOR_BLACK);
	oled_putString(55, 55, (uint8_t *)"REGULAR", OLED_COLOR_WHITE, OLED_COLOR_BLACK);
}

void
prepare_light(void)
{
	light_enable();
	light_setRange(LIGHT_RANGE_1000);
	light_setHiThreshold(ST_SWITCH_THRESHOLD); // if above 800 lux
    light_clearIrqStatus();
}

void
prepare_acc(void)
{
	acc_init();

    // Assume base board in zero-g position when reading first value.
    acc_read(&x, &y, &z);
    zoff = 64-z;

	int i = 0;

	for (i = 0; i < 9; ++i) {
		acc_read(&x, &y, &z);
		z = z+zoff;
		mean += z;
	}
	mean = mean / 9;
	asm_variance(0, mean, 1);
}

void
prepare_irqs(void)
{
    // Enable interrupt for SW3
    LPC_GPIOINT->IO0IntEnF |= (1 << 4);

    // Enable accelerometer interrupt
    LPC_GPIOINT->IO0IntEnF |= (1 << 3);

    // Enable light interrupt
    LPC_GPIOINT->IO2IntEnF |= (1 << 5);

    // Enable EINT3 interrupt for GPIO
    NVIC_EnableIRQ(EINT3_IRQn);

}
