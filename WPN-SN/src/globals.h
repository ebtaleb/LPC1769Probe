int32_t curr_acc_st = ACC_ST_DIM;
int32_t curr_ls_st = LS_ST_DIM;
int32_t curr_ts_st = TS_ST_DIM;

double curr_temp = 0.0;
uint32_t curr_lum = 0;
int curr_variance = 0;
int mean = 0;

char uart_receive_buff[32];
Bool data_received_flag = FALSE;

enum MODE switch_mode_flag = REGULAR_MODE;

int8_t x = 0;
int8_t y = 0;
int8_t z = 0;
int32_t zoff = 0;

Bool light_threshold_reached = FALSE;

oled_report oled_strings = { {0}, {0}, {0} };
