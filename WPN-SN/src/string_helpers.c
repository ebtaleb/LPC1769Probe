#include "string_helpers.h"

void
init_report_str(char *s)
{
	char temp_str[5];

	s[0] = 'N';
    sprintf(temp_str, "%d", NODE_ID);
    strcat(s, temp_str);
    strcat(s, "_T");
	s[6] = '\0';
}

void
init_oled_report(oled_report *r)
{
	strcat(r->oled_temp_str, "Temp: ");
	r->oled_temp_str[6] = '\0';
	strcat(r->oled_lum_str, "Lum: ");
	r->oled_lum_str[5] = '\0';
	strcat(r->oled_var_str, "Z-Var: ");
	r->oled_var_str[7] = '\0';
}

void
gen_report_str(double t, uint32_t l, int v, char *s)
{
	char temp_str[5] = {0};

    sprintf(temp_str, "%.1f", t);
    strcat(s, temp_str);

    strcat(s, "_L");
    sprintf(temp_str, "%u", l);
    strcat(s, temp_str);

    strcat(s, "_V");
    sprintf(temp_str, "%03d", v);
    strcat(s, temp_str);

    int len = strlen(s);
    //s[len] = '#';
    s[len] = '\r';
    s[len+1] = '\0';
}
