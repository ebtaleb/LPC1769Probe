
#ifndef INT_HANDLER_H_
#define INT_HANDLER_H_

#include "lpc17xx_gpio.h"
#include "lpc17xx_uart.h"
#include "oled.h"
#include "stdio.h"

enum MODE {
	REGULAR_MODE,
	RELAY_MODE
};

extern enum MODE switch_mode_flag;
extern int32_t curr_acc_st;
extern int32_t curr_ls_st;
extern int32_t curr_ts_st;
extern Bool light_threshold_reached;

extern char uart_receive_buff[32];
extern Bool data_received_flag;

void EINT3_IRQHandler(void);
void UART3_IRQHandler(void);

#endif /* INT_HANDLER_H_ */
