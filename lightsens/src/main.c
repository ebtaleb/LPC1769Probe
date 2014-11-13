// CMSIS headers required for setting up SysTick Timer
#include "LPC17xx.h"

#include "lpc17xx_pinsel.h"
#include "lpc17xx_i2c.h"
#include "lpc17xx_timer.h"

#include "light.h"

volatile uint32_t msTicks; // counter for 1ms SysTicks

void EINT3_IRQHandler(void)
{
	if ((LPC_GPIOINT->IO2IntStatF >> 5) & 0x1) { // light interrupt, doesnt work
        // Clear GPIO Interrupt P2.5
        LPC_GPIOINT->IO2IntClr |= (1 << 5);
        light_clearIrqStatus();
        printf("light\n");
	}


}

// ****************
//  SysTick_Handler - just increment SysTick counter
void SysTick_Handler(void) {
  msTicks++;
}

// ****************
// systick_delay - creates a delay of the appropriate number of Systicks (happens every 1 ms)
__INLINE static void systick_delay (uint32_t delayTicks) {
  uint32_t currentTicks;

  currentTicks = msTicks;	// read current tick counter
  // Now loop until required number of ticks passes
  while ((msTicks - currentTicks) < delayTicks);
}

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

void init_GPIO(void)
{
//	PINSEL_CFG_Type PinCfg;
//	PinCfg.Funcnum = 0;
//	PinCfg.OpenDrain = 0;
//	PinCfg.Pinmode = 0;
//	PinCfg.Portnum = 2;
//	PinCfg.Pinnum = 5;
//	PINSEL_ConfigPin(&PinCfg);
	GPIO_SetDir(2, 1<<5, 0);

}


int
main(void)
{
	uint32_t lum = 0;
	uint32_t currTicks = 0;

	init_GPIO();

	init_i2c();
	//light_init(); does nothing
	light_enable();
	light_setRange(LIGHT_RANGE_4000);
	light_setHiThreshold(400); // if above 800 lux
	light_setLoThreshold(100);
    light_clearIrqStatus();

    // Enable light interrupt
    LPC_GPIOINT->IO2IntEnF |= (1 << 5);

    // Enable EINT3 interrupt for GPIO
    NVIC_EnableIRQ(EINT3_IRQn);

    SysTick_Config(SystemCoreClock / 1000);

	while (1) {
		if (msTicks - currTicks > 1000) {
			currTicks = msTicks;
			lum = light_read();
			printf("%d\n", lum);
		}
		//Timer0_Wait(1000);
	}
}

