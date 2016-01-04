// CMSIS headers required for setting up SysTick Timer
#include "LPC17xx.h"

#include "lpc17xx_pinsel.h"
#include "lpc17xx_i2c.h"
#include "lpc17xx_timer.h"

#include "acc.h"

#define ST_SWITCH_THRESHOLD 800
#define BRIGHT_CONDITION(LUM) lum >= ST_SWITCH_THRESHOLD
#define DIM_CONDITION(lum) lum < ST_SWITCH_THRESHOLD

#define ACC_ST_BRIGHT 50
#define ACC_ST_DIM 100

volatile uint32_t msTicks; // counter for 1ms SysTicks

// ****************
//  SysTick_Handler - just increment SysTick counter, software interrupt
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

int
main(void)
{
	uint32_t currTicks = 0;

    int32_t xoff = 0;
    int32_t yoff = 0;
    int32_t zoff = 0;

    int8_t x = 0;
    int8_t y = 0;
    int8_t z = 0;

    int32_t ST = 0;

	init_i2c();
	acc_init();

    /*
     * Assume base board in zero-g position when reading first value.
     */
    acc_read(&x, &y, &z);
    xoff = 0-x;
    yoff = 0-y;
    zoff = 64-z;

    while (1) {
		if (msTicks - currTicks > 1000) {
			currTicks = msTicks;
			acc_read(&x, &y, &z);
			x = x+xoff;
			y = y+yoff;
			z = z+zoff;

			printf("(%d, %d, %d)\n", x, y, z);
        //Timer0_Wait(1000);
		}
    }
}

