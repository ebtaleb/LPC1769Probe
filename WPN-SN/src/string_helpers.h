

#ifndef STRING_HELPERS_H_
#define STRING_HELPERS_H_

#include "constants.h"
#include "LPC17xx.h"

typedef struct oled_report {
	char oled_temp_str[15];
	char oled_lum_str[15];
	char oled_var_str[15];
} oled_report;

void init_report_str(char *s);
void init_oled_report(oled_report *r);
void gen_report_str(double t, uint32_t l, int v, char *s);

#endif /* STRING_HELPERS_H_ */
