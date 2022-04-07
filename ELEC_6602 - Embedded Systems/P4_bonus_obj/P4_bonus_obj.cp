#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P4_bonus_obj/P4_bonus_obj.c"
#line 1 "d:/mikroc pro for arm/include/stdio.h"
#line 1 "d:/mikroc pro for arm/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
long int max(long int a, long int b);
long int min(long int a, long int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 1 "d:/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 37 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P4_bonus_obj/P4_bonus_obj.c"
static const uint8_t FALSE = 0;
static const uint8_t TRUE = 1;
static const uint8_t NO_NEW_LINE = 0;
static const uint8_t NEW_LINE_EN = 1;
static const uint32_t ASCII_HEX_0 = 0x30;
static const uint32_t CHAR_CR = 0x0D;
static const uint32_t CHAR_LF = 0x0A;

static const uint32_t GPIO_OUTPUT = 0x33333333;
static const uint32_t GPIO_INPUT = 0x44444444;
static const uint32_t NULL_BYTE = 0x00000000;

static const uint32_t MAX_BUFFER_SIZE = 64;
static const uint32_t MAX_ALPHABET_COUNT = 23;


static const uint32_t tally_upper = 0;
static const uint32_t tally_lower = 1;
static const uint32_t tally_non_alpha = 2;
static const uint32_t tally_alpha = 3;






void read_data(uint32_t *rx_buffer) {


 while( (USART1_SR & (1 << 5)) == 0 ) {}


 *rx_buffer = USART1_DR;


 while ( (USART1_SR & (1 << 7)) == 0) {}
 Delay_ms(10);
}


void write_data_char(uint32_t *tx_char, uint8_t new_line) {
 uint32_t tx_var = *tx_char;


 while ( (USART1_SR & (1 << 7)) == 0) {}


 Delay_ms(10);
 USART1_DR = *tx_char;


 if (new_line == 1) {
 Delay_ms(10);
 USART1_DR = CHAR_CR;
 Delay_ms(10);
 USART1_DR = CHAR_LF;
 }
}



void write_data(uint32_t *arr_buffer, uint8_t new_line_opt) {
 uint32_t i = 0;

 while ( (arr_buffer[i] != '\0') && (i < MAX_BUFFER_SIZE) ) {
 write_data_char(&arr_buffer[i], new_line_opt);
 ++i;
 }


 Delay_ms(10);
 USART1_DR = CHAR_CR;
 Delay_ms(10);
 USART1_DR = CHAR_LF;
}


void update_led(uint32_t counter) {
 GPIOD_ODR = (counter << 8);
 Delay_ms(100);
}



void print_string(uint8_t *arr_string, uint8_t new_line_opt) {
 uint32_t i = 0;
 uint32_t buffer[64];

 while (arr_string[i] != '\0'){
 buffer[i] = (buffer[i] & 0x00000000) | arr_string[i];
 write_data_char(&buffer[i], NO_NEW_LINE);
 i++;
 }


 if (new_line_opt == NEW_LINE_EN) {
 Delay_ms(10);
 USART1_DR = CHAR_CR;
 Delay_ms(10);
 USART1_DR = CHAR_LF;
 }
}



void convert_to_ascii(const int32_t *input_dec, uint32_t *ascii_msb, uint32_t *ascii_lsb) {


 uint32_t temp_val = 0;
 *ascii_msb = 0;
 *ascii_lsb = 0;


 if (*input_dec > MAX_BUFFER_SIZE) {
 return;
 }


 temp_val = *input_dec;
 while (temp_val >= 10) {
 temp_val /= 10;
 *ascii_msb = temp_val + ASCII_HEX_0;
 }


 if (*input_dec > 0) {
 temp_val = (*input_dec % 10);
 *ascii_lsb = temp_val + ASCII_HEX_0;
 }
}


int q_sort(uint32_t *arr_list, int32_t *pivot_pos, uint32_t *min_pos) {
 int32_t right_cur = (*pivot_pos-1);
 int32_t left_found = 0;
 uint32_t pivot_val = arr_list[*pivot_pos];
 uint32_t temp_val = 0;
 uint32_t left_cur = 0;
 uint32_t right_found = 0;


 while (left_found == 0) {

 if (left_cur == *pivot_pos) {
 left_found = 1;


 --(*pivot_pos);


 if ( (*pivot_pos) <= 0) {
 return 0;
 }
 else {

 return q_sort(arr_list, pivot_pos, min_pos);
 }
 }

 else if ( (arr_list[left_cur]) > (arr_list[*pivot_pos]) ) {
 left_found = 1;
 }
 else {
 ++left_cur;
 }
 }


 while (right_found == 0) {

 if ( (right_cur == *min_pos) && (arr_list[right_cur]) >= (arr_list[*pivot_pos]) ) {
 right_found = 1;


 temp_val = arr_list[left_cur];
 arr_list[left_cur] = arr_list[*pivot_pos];
 arr_list[*pivot_pos] = temp_val;


 *min_pos = left_cur;

 return q_sort( arr_list, pivot_pos, min_pos );
 }
 else if ( (arr_list[right_cur]) <= (arr_list[*pivot_pos]) ) {
 right_found =1;
 }
 else {
 --right_cur;
 }
 }



 if (right_cur < left_cur) {
 temp_val = arr_list[left_cur];
 arr_list[left_cur] = arr_list[*pivot_pos];
 arr_list[*pivot_pos] = temp_val;
 *min_pos = 0;
 }

 else {
 temp_val = arr_list[left_cur];
 arr_list[left_cur] = arr_list[right_cur];
 arr_list[right_cur] = temp_val;
 }

 if (*pivot_pos == 0) {
 return 0;
 }
 else {
 return q_sort(arr_list, pivot_pos, min_pos);
 }
}




tally(uint32_t *arr_tally, uint32_t size) {

 uint8_t str_colon[] = " : ";
 uint8_t first_run = TRUE;
 uint32_t tally_list[64];
 uint32_t i = 0;
 uint32_t char_pos = 0;
 uint32_t tally_pos = 1;
 uint32_t tally_count = 0;
 uint32_t current_char = 0;
 uint32_t prev_char = 0;
 uint32_t ascii_msb = 0;
 uint32_t ascii_lsb = 0;


 while (i <= size) {

 current_char = arr_tally[i];

 if (prev_char == current_char) {
 tally_pos = char_pos + 1;
 tally_list[tally_pos] = ++tally_count;
 }

 else if ( tally_list[char_pos] != current_char) {


 tally_count = 0;

 if (first_run == TRUE ) {
 tally_list[char_pos] = current_char;
 tally_list[tally_pos] = ++tally_count;
 first_run = FALSE;
 }
 else {

 write_data_char(&tally_list[char_pos], NO_NEW_LINE);
 print_string(&str_colon, NO_NEW_LINE);
 convert_to_ascii(&tally_list[tally_pos], &ascii_msb, &ascii_lsb);
 write_data_char(&ascii_msb, NO_NEW_LINE);
 write_data_char(&ascii_lsb, NEW_LINE_EN);

 char_pos +=2;
 tally_list[char_pos] = current_char;
 tally_list[tally_pos] = ++tally_count;
 }
 }
 prev_char = current_char;
 i++;
 }
}




void main() {


 uint8_t loop_on = TRUE;
 uint32_t char_counter = 0;
 uint32_t lower_case_count = 0;
 uint32_t upper_case_count = 0;
 uint32_t pivot_pos = 0;
 uint32_t min_pos = 0;
 uint32_t rx_buffer[64];
 uint32_t arr_tally[4];
 uint32_t ascii_lsb;
 uint32_t ascii_msb;

 uint32_t list_size = 0;



 uint8_t title_divider[] = "=============================================================";
 uint8_t title_cr_lf[] = "\x0D\x0A";
 uint8_t title_prompt[] = "[P4 BONUS] - Please enter up to 23 alphabets to complete sequence:  ";
 uint8_t title_upper[] = "Upper case: ";
 uint8_t title_lower[] = "Lower case: ";
 uint8_t title_non_alpha[] = "Non-alphabet: ";
 uint8_t str_tally[] = "Tally: ";







 RCC_CR = 0x05010081;




 RCC_CFGR = 0x001D8402;





 RCC_CFGR2 = 0x00010644;


 RCC_APB2ENR |= 0x00000001;
 AFIO_MAPR = 0x00000000;

 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 14;

 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4) ;
 GPIOA_CRH |= (0x04 << 8);
 GPIOA_CRL |= (0x00000004);
 GPIOD_CRH = GPIO_OUTPUT;
 GPIOD_CRL = GPIO_OUTPUT;




 USART1_BRR = 0x00000506;









 USART1_CR1 &= ~(1<<12);
 USART1_CR2 &= ~(3<<12);
 USART1_CR3 &= ~(3<<8);
 USART1_CR1 &= ~(3<<9);
 USART1_CR1 |= 3<<2;
 Delay_ms(100);
 USART1_CR1 |= 1 << 13;


 for (;;) {


 arr_tally[tally_upper] = 0;
 arr_tally[tally_lower] = 0;
 arr_tally[tally_non_alpha] = 0;
 arr_tally[tally_alpha] = 0;


 print_string(&title_cr_lf, NEW_LINE_EN);
 print_string(&title_divider, NEW_LINE_EN);
 print_string(&title_prompt, NEW_LINE_EN);



 while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
 read_data( &rx_buffer[char_counter] );

 if ( (rx_buffer[char_counter] > 0x1F) && (rx_buffer[char_counter != NULL_BYTE]) ) {





 if ( (rx_buffer[char_counter] >= 0x41) && (rx_buffer[char_counter] <= 0x5A) ) {
 arr_tally[tally_upper]++;
 arr_tally[tally_alpha]++;
 }
 else if ( (rx_buffer[char_counter] >= 0x61) && (rx_buffer[char_counter] <= 0x7A) ) {
 arr_tally[tally_lower]++;
 arr_tally[tally_alpha]++;
 }
 else if ( (rx_buffer[char_counter] >=0x20) || (rx_buffer[char_counter] <=0x40)
 || (rx_buffer[char_counter] >=0x5B) || (rx_buffer[char_counter] <= 0x60)
 || (rx_buffer[char_counter] >=0x7B) || (rx_buffer[char_counter] <= 0x7F)) {

 arr_tally[tally_non_alpha]++;
 }


 char_counter++;


 if ( arr_tally[tally_alpha] >= MAX_ALPHABET_COUNT) {
 loop_on = FALSE;
 rx_buffer[char_counter] = '\0';
 }
 }
 }

 list_size = char_counter;


 write_data(&rx_buffer, NO_NEW_LINE);


 pivot_pos = (char_counter - 1);
 q_sort (&rx_buffer, &pivot_pos, &min_pos);
 write_data(&rx_buffer, NO_NEW_LINE);



 print_string(title_cr_lf, NO_NEW_LINE);
 print_string(&str_tally, NEW_LINE_EN);
 tally(&rx_buffer, char_counter);


 print_string(&title_cr_lf, NO_NEW_LINE);
 print_string(&title_upper, NO_NEW_LINE);
 convert_to_ascii(&arr_tally[tally_upper], &ascii_msb, &ascii_lsb);
 write_data_char(&ascii_msb, NO_NEW_LINE);
 write_data_char(&ascii_lsb, NEW_LINE_EN);


 print_string(&title_lower, NO_NEW_LINE);
 convert_to_ascii(&arr_tally[tally_lower], &ascii_msb, &ascii_lsb);
 write_data_char(&ascii_msb, NO_NEW_LINE);
 write_data_char(&ascii_lsb, NEW_LINE_EN);


 print_string(&title_non_alpha, NO_NEW_LINE);
 convert_to_ascii(&arr_tally[tally_non_alpha], &ascii_msb, &ascii_lsb);
 write_data_char(&ascii_msb, NO_NEW_LINE);
 write_data_char(&ascii_lsb, NEW_LINE_EN);


 loop_on = TRUE;
 char_counter = 0;
 }
}
