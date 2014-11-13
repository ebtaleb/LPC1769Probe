
#ifndef INIT_DEVICES_H_
#define INIT_DEVICES_H_

#include "lpc17xx_pinsel.h"
#include "lpc17xx_ssp.h"
#include "lpc17xx_timer.h"
#include "lpc17xx_gpio.h"
#include "lpc17xx_i2c.h"
#include "lpc17xx_uart.h"

#include "oled.h"
#include "light.h"
#include "constants.h"

void init_ssp(void);
void init_GPIO(void);
void init_i2c(void);
void pinsel_uart3(void);
void init_uart(void);

void prepare_7seg(void);
void prepare_oled(void);
void prepare_irqs(void);
void prepare_light(void);
void prepare_acc(void);

extern int8_t x;
extern int8_t y;
extern int8_t z;
extern int32_t xoff;
extern int32_t yoff;
extern int32_t zoff;
extern int mean;

#endif /* INIT_DEVICES_H_ */
