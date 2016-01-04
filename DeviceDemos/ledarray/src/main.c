#include "lpc17xx_pinsel.h"
#include "lpc17xx_i2c.h"
#include "lpc17xx_timer.h"

#include "pca9532.h"

static void init_i2c(void)
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

static void ledOn(uint8_t led)
{
	if (led > 15)
		return;

	uint16_t oldState = pca9532_getLedState(0);
	uint16_t newState = oldState | (1 << led);

	pca9532_setLeds(newState, 0xffff);
}

static void ledOff(uint8_t led)
{
	if (led > 15)
		return;

	uint16_t oldState = pca9532_getLedState(0);
	uint16_t newState = oldState & ~(1 << led);

	pca9532_setLeds(newState, 0xffff);

}

static void ledToggle(uint8_t led)
{
	if (led > 15)
		return;

	uint16_t oldState = pca9532_getLedState(0);
	uint16_t newState = oldState ^ (1 << led);

	pca9532_setLeds(newState, 0xffff);
}

int
main(void)
{
	int i = 0;

    init_i2c();
    pca9532_init();

    uint16_t ledState = 0;
    pca9532_setLeds(ledState, 0xffff);

	while (1) {

		for (i = 0; i < 16; i++) {
			ledToggle(i);
			//ledOn(i);
			Timer0_Wait(1000);
			ledToggle(i);
			//ledOff(i);
			Timer0_Wait(1000);
		}

		i = 0;
	}
}

