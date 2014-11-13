#include "lpc17xx_pinsel.h"
#include "lpc17xx_ssp.h"
#include "lpc17xx_timer.h"
#include "lpc17xx_gpio.h"

#include "oled.h"

static void init_GPIO(void)
{
	// Initialize button SW4 (not really necessary since default configuration)
	PINSEL_CFG_Type PinCfg;
	PinCfg.Funcnum = 0;
	PinCfg.OpenDrain = 0;
	PinCfg.Pinmode = 0;
	PinCfg.Portnum = 1;
	PinCfg.Pinnum = 31;
	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(1, 1<<31, 0);
}

static void init_ssp(void)
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

int
main(void)
{
	int btn1 = 1;
	Bool playFlag = FALSE;

	uint8_t *regular_str = "REGULAR";
	uint8_t *relay_str = "RELAY";

	init_GPIO();
	init_ssp();
	oled_init();
	oled_clearScreen(OLED_COLOR_BLACK);

	while (1) {

		btn1 = (GPIO_ReadValue(1) >> 31) & 0x01;
		if (btn1 == 0) {
			playFlag = !playFlag;
		}
		oled_clearScreen(OLED_COLOR_BLACK);
		if (playFlag) {

			oled_putString(4, 4, relay_str, OLED_COLOR_WHITE, OLED_COLOR_BLACK);
			Timer0_Wait(1000);
		} else {
			//oled_clearScreen(OLED_COLOR_BLACK);
			oled_putString(4, 4, regular_str, OLED_COLOR_WHITE, OLED_COLOR_BLACK);
			Timer0_Wait(1000);
		}
	}
	return 0;
}

