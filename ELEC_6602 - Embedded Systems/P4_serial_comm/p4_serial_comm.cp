#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P4_serial_comm/p4_serial_comm.c"
#line 1 "d:/mikroc pro for arm/include/stdio.h"
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
#line 29 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P4_serial_comm/p4_serial_comm.c"
static const uint32_t EXIT_CHAR = 0x40;
static const uint32_t TRUE = 1;
static const uint32_t FALSE = 0;
static const uint32_t MAX_BUFFER_SIZE = 50;
static const uint32_t GPIO_OUTPUT = 0x33333333;
static const uint32_t CHAR_CR = 0x0D;
static const uint32_t CHAR_LF = 0x0A;
static const uint8_t NO_NEW_LINE = 0;
static const uint8_t NEW_LINE_EN = 1;
static const uint32_t LED_RESET = 0;
int32_t list_len=0;




void read_data(uint32_t *rx_buffer){



 while( (USART1_SR & (1 << 5)) == 0 ) {}


 *rx_buffer = USART1_DR;




 while ( (USART1_SR & (1 << 7)) == 0) {}
 Delay_ms(100);
}


void write_data_char(uint32_t *tx_char, uint8_t new_line){

 uint32_t tx_var = *tx_char;
 while ( (USART1_SR & (1 << 7)) == 0) {}

 Delay_ms(100);
 USART1_DR = *tx_char;



 if (new_line == 1) {
 Delay_ms(100);
 USART1_DR = CHAR_CR;
 Delay_ms(100);
 USART1_DR = CHAR_LF;
 }
}
#line 92 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P4_serial_comm/p4_serial_comm.c"
void write_data(uint32_t *arr_buffer) {
 uint32_t i = 0;

 while (arr_buffer[i] != EXIT_CHAR) {
 write_data_char(&arr_buffer[i], 1);
 ++i;
 }
 Delay_ms(100);
 USART1_DR = CHAR_CR;
 Delay_ms(100);
 USART1_DR = CHAR_LF;
}


void write_data_reversed(uint32_t *arr_buffer, int32_t list_len) {
 int32_t i = 0;






 for ( i=list_len; i >= 0; i--) {
 write_data_char(&arr_buffer[i], 1);
 }

 Delay_ms(100);
 USART1_DR = CHAR_CR;
 Delay_ms(100);
 USART1_DR = CHAR_LF;
}







void update_led(uint32_t counter) {
 GPIOD_ODR = (counter << 8);
 Delay_ms(100);
}


void clear_buffer(uint32_t *arr_buffer, uint32_t size) {
 uint32_t i = 0;

 for (i=0; i < size; i++) {
 if (arr_buffer[i] != 0 ) {
 arr_buffer[i] = 0;
 }
 }
}


int q_sort(uint32_t *arr_list, int32_t *pivot_pos, uint32_t *min_pos) {
 uint32_t pivot_val = arr_list[*pivot_pos];
 uint32_t left_cur = 0;
 int32_t right_cur = (*pivot_pos-1);
 int32_t left_found = 0;
 uint32_t right_found = 0;
 uint32_t temp_val = 0;

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
 else
 {

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

void print_header(uint32_t *header) {
 uint32_t i = 0;

 while (header[i] != '\0') {
 write_data_char( &header[i], 0 );
 ++i;
 }

 Delay_ms(100);
 USART1_DR = CHAR_CR;
 Delay_ms(100);
 USART1_DR = CHAR_LF;

}



void main() {


 uint8_t loop_on = TRUE;
 uint32_t tx_buffer;
 uint32_t rx_buffer[50];
 int32_t char_counter = 0;
 uint32_t i=0;
 int32_t min_pos = 0;
 int32_t pivot_pos = 0;










 uint32_t title_orig[10]= {'O','r','i','g','i','n','a','l',':', '\0'};
 uint32_t title_sorted[8]= {'S','o','r','t','e','d',':', '\0'};
 uint32_t title_rev[10]= {'R','e','v','e','r','s','e','d',':','\0'};



 RCC_APB2ENR |= 0x00000001;
 AFIO_MAPR = 0x00000000;

 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 14;

 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4) ;
 GPIOA_CRH |= (0x04 << 8);
 GPIOD_CRH = GPIO_OUTPUT;




 USART1_BRR = 0x00000506;









 USART1_CR1 &= ~(1<<12);
 USART1_CR2 &= ~(3<<12);
 USART1_CR3 &= ~(3<<8);
 USART1_CR1 &= ~(3<<9);
 USART1_CR1 |= 3<<2;


 USART1_CR1 |= 1 << 13;
 Delay_ms(100);
 update_led(0xff);




 for (;;) {

 while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
 read_data(&rx_buffer[char_counter]);

 if (rx_buffer[char_counter] == EXIT_CHAR){
 loop_on = FALSE;
 }
 else if (rx_buffer[char_counter] != 0x0D) {
 ++char_counter;

 if (char_counter == MAX_BUFFER_SIZE) {
 rx_buffer[i] = EXIT_CHAR;
 }
 update_led(char_counter);
 }
 }


 list_len = char_counter;
 pivot_pos = (char_counter - 1);

 update_led(LED_RESET);





 print_header(&title_orig);
 write_data(&rx_buffer);


 q_sort(&rx_buffer, &pivot_pos, &min_pos);

 print_header(&title_sorted);

 write_data(&rx_buffer);

 print_header(&title_rev);
 write_data_reversed(&rx_buffer, (list_len-1) );



 loop_on = TRUE;
 char_counter = 0;



 }




}
