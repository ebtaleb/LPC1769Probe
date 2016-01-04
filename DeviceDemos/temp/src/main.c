#include "lpc17xx_pinsel.h"
#include "lpc17xx_gpio.h"
#include "lpc17xx_timer.h"

// CMSIS headers required for setting up SysTick Timer
#include "LPC17xx.h"

#include "temp.h"

volatile uint32_t msTicks; // counter for 1ms SysTicks

uint32_t getTick(void)
{
	return msTicks;
}

//  SysTick_Handler - just increment SysTick counter
void SysTick_Handler(void) {
  msTicks++;
}

// systick_delay - creates a delay of the appropriate number of Systicks (happens every 1 ms)
__INLINE static void systick_delay (uint32_t delayTicks) {
  uint32_t currentTicks;

  currentTicks = msTicks;	// read current tick counter
  // Now loop until required number of ticks passes
  while ((msTicks - currentTicks) < delayTicks);
}

static void init_GPIO(void)
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
}

int
main(void)
{
	int32_t t = 0;
	uint32_t currTicks = 0;

	init_GPIO();
	temp_init(getTick);
	SysTick_Config(SystemCoreClock / 1000);

	while (1) {
		if (msTicks - currTicks > 1000) {
			currTicks = msTicks;
			t = temp_read();
			printf("%d C\n", t/10);
		}
	}


}

