
void
print_to_oled(double t, uint32_t l, int v, oled_report *r)
{
	char temp_str[7] = {0};

    sprintf(temp_str, "%.1f", t);
    strcat(r->oled_temp_str, temp_str);
    sprintf(temp_str, "%04u", l);
    strcat(r->oled_lum_str, temp_str);
    sprintf(temp_str, "%04d", v);
    strcat(r->oled_var_str, temp_str);

    oled_putString(0, 0, r->oled_temp_str, OLED_COLOR_WHITE, OLED_COLOR_BLACK);
    oled_putString(0, 10, r->oled_lum_str, OLED_COLOR_WHITE, OLED_COLOR_BLACK);
    oled_putString(0, 20, r->oled_var_str, OLED_COLOR_WHITE, OLED_COLOR_BLACK);

    r->oled_temp_str[5] = ' ';
    r->oled_temp_str[6] = '\0';

    r->oled_lum_str[4] = ' ';
    r->oled_lum_str[5] = '\0';

    r->oled_var_str[7] = '\0';
}
