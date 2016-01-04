/*****************************************************************************
 *   GPIO Speaker & Tone Example + GPIO Interrupt
 *
 *   CK Tham, EE2024
 *
 ******************************************************************************/

#include "stdio.h"
#include "lpc17xx_rit.h"
// for setting up SysTick Timer
#include "LPC17xx.h"

#include "lpc17xx_pinsel.h"
#include "lpc17xx_gpio.h"
#include "temp.h"


volatile uint32_t msTicks; // counter for 1ms SysTicks
uint32_t currTicks = 0;
int32_t t = 0;

uint32_t getTick(void)
{
	return msTicks;
}

//  SysTick_Handler - just increment SysTick counter
void SysTick_Handler(void) {
  msTicks++;
}

void RIT_IRQHandler(void)
{
	   // Clear RI Control register Interrupt
	   LPC_RIT->RICTRL |= 1<<0;

	   currTicks = msTicks;
	   t = temp_read();
	   printf("%d C\n", t/10);
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

static void init_RIT(void)
{
    LPC_SC->PCONP |= 1<<16;               //Power Control for Peripherals register: power up RIT clock

    LPC_RIT->RICOUNTER = 0;               //set counter to zero
    LPC_RIT->RICOMPVAL = 100000000/4;     //interrupt tick every second (clock at 100MHz)
    LPC_RIT->RICTRL |= 1<<1;              // clear timer when counter reaches value
    LPC_RIT->RICTRL |= 1<<3;              // enable timer

   NVIC_EnableIRQ(RIT_IRQn);

}
int main (void)
{
	init_RIT();
	init_GPIO();
	temp_init(getTick);
	SysTick_Config(SystemCoreClock / 1000);

   while(1);
}
