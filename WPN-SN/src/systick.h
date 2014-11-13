/*
 * systick.h
 *
 *  Created on: Oct 30, 2014
 *      Author: jmbto
 */

#ifndef SYSTICK_H_
#define SYSTICK_H_

#include "LPC17xx.h"

volatile uint32_t msTicks; // counter for 1ms SysTicks

uint32_t getTick(void);

#endif /* SYSTICK_H_ */
