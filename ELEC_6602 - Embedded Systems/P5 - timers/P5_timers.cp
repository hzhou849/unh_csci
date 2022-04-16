#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P5 - timers/P5_timers.c"
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
#line 42 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P5 - timers/P5_timers.c"
static const uint8_t TRUE = 1;
static const uint8_t FALSE = 0;
static const uint8_t NEW_LINE_EN = 1;
static const uint8_t NO_NEW_LINE = 0;
static const uint32_t ASCII_HEX_O = 0x30;
static const uint32_t CHAR_CR = 0x0D;
static const uint32_t CHAR_LF = 0x0A;
static const uint32_t GPIO_OUTPUT = 0x33333333;
#line 69 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P5 - timers/P5_timers.c"
uint32_t serial_to_int(uint32_t *rx_buffer) {

 if ( (*rx_buffer >= ASCII_HEX_O) && (*rx_buffer <= 0x34) ) {
 return (*rx_buffer - ASCII_HEX_O);
 }

 return 1;
}


void write_data_char(uint32_t *tx_char, uint8_t new_line_opt) {


 while ( (USART1_SR & (1 << 7)) == 0 ) {}
 Delay_ms(10);
 USART1_DR = *tx_char;

 if (new_line_opt == 1) {
 Delay_ms(10);
 USART1_DR = CHAR_CR;
 Delay_ms(10);
 USART1_DR = CHAR_LF;
 }
}




void print_string(uint8_t *arr_string, uint8_t new_line_opt) {

 uint32_t i = 0;
 uint32_t buffer[64];

 while (arr_string[i] != '\0') {
 buffer[i] = (buffer[i] & (uint32_t) 0x00000000) | arr_string[i];
 write_data_char ( &buffer[i], new_line_opt);
 i++;
 }

 Delay_ms(10);
 USART1_DR = CHAR_CR;
 Delay_ms(10);
 USART1_DR = CHAR_LF;
}

void print_int(uint32_t *int_num) {

 uint32_t temp_val = (*int_num + ASCII_HEX_O);

 write_data_char(&temp_val, NO_NEW_LINE);






}

void main() {

 uint32_t sequence_count = 0;
 uint8_t div_ask_time_flag = FALSE;
 uint8_t tim1_ask_time_flag = FALSE;
 uint8_t tim2_ask_time_flag = FALSE;
 uint8_t ask_time_flag = FALSE;
 uint8_t r_key_rcvd = TRUE;



 uint32_t i=0;

 uint32_t tim1_multiplier = 1;
 uint32_t tim2_multiplier = 1;
 uint32_t rx_buffer;

 uint8_t title_divider[] = "=============================================================";
 uint8_t start_prompt [] = "Press 'R or r' to start or 'Q q' to quit.";
 uint8_t tim1_prompt [] = "Please enter delay time (1-4) for TIMER1: ";
 uint8_t tim2_prompt [] = "Please enter delay time (1-4) for TIMER2: ";
 uint8_t title_cr_lf [] = "\x0D\x0A";
 uint8_t tim1_info[] = "TIMER1 delay seconds value: ";
 uint8_t tim2_info[] = "TIMER2 delay seconds value:  ";
 uint8_t goodbye [] = "TIMER 1 & 4 DISABLED, goodbye!";






 RCC_CR = 0x05010081;






 RCC_CFGR = 0x091D8402;







 RCC_CFGR2 = 0x00010644;





 USART1_CR1 &= ~(1 << 13);


 RCC_APB2ENR |= 0x00000001;
 AFIO_MAPR = 0x00000000;

 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 4;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;
 RCC_APB2ENR |= 1 << 14;



 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4);
 GPIOA_CRH |= (0x04 << 8);

 GPIOB_CRH = GPIO_OUTPUT;
 GPIOB_CRL = GPIO_OUTPUT;
 GPIOC_CRH = GPIO_OUTPUT;
 GPIOC_CRL = GPIO_OUTPUT;
 GPIOD_CRH = GPIO_OUTPUT;
 GPIOD_CRL = GPIO_OUTPUT;
 GPIOE_CRH = GPIO_OUTPUT;
 GPIOE_CRL = GPIO_OUTPUT;



 USART1_BRR = 0x00000506;



 USART1_CR1 &= ~(1 << 13);
 USART1_CR1 &= ~(1 << 12);
 USART1_CR1 &= ~(3 << 9);
 USART1_CR2 &= ~(3 << 12);
 USART1_CR3 &= ~(3 << 8);
 USART1_CR1 |= (3 << 2);
 Delay_ms(100);
 USART1_CR1 |= 1 << 13;



 RCC_APB2ENR |= (1 << 11);
 RCC_APB1ENR |= (1 << 2);





 TIM1_CR1 = 0x0000;
 TIM4_CR1 = 0x0000;






 TIM1_PSC = 7999;
 TIM4_PSC = 7999;





 TIM1_ARR = ( (uint32_t)9000 * tim1_multiplier );
 TIM4_ARR = ( (uint32_t)9000 * tim2_multiplier );

 TIM1_CR1 = 0x0001;
 TIM4_CR1 = 0x0001;


 GPIOB_ODR = 0x0000;
 GPIOC_ODR = 0x0000;
 GPIOD_ODR = 0x0000;
 GPIOE_ODR = 0x0000;




 for (;;) {


 if (ask_time_flag == FALSE ) {

 if ( sequence_count == 0) {
 print_string(title_cr_lf, NO_NEW_LINE);

 print_string(title_divider, NO_NEW_LINE);
 print_string(&start_prompt, NO_NEW_LINE);

 r_key_rcvd = FALSE;
 sequence_count++;
 }
 else if ( sequence_count == 1 && r_key_rcvd == TRUE ) {
 print_string(title_cr_lf, NO_NEW_LINE);
 print_string(tim1_prompt, NO_NEW_LINE);
 ask_time_flag = TRUE;
 }
 else if (sequence_count == 2 && r_key_rcvd == TRUE ) {
 print_string(title_cr_lf, NO_NEW_LINE);
 print_string(tim2_prompt, NO_NEW_LINE);
 ask_time_flag = TRUE;
 }
 }






 for (i=0; i < 10; i++) {

 if ( (USART1_SR & (1 << 5)) ) {
 rx_buffer = USART1_DR;

 while ( (USART1_SR & ( 1 << 7)) == 0 ) {}





 if (rx_buffer == 0x52 || rx_buffer == 0x72) {
 r_key_rcvd = TRUE;
 }
 else if (rx_buffer == 0x51 || rx_buffer == 0x71) {




 RCC_APB2ENR |= ~(1 << 11);
 RCC_APB1ENR |= ~(1 << 2);
 print_string(&goodbye, NO_NEW_LINE);
 return;
 }


 if (sequence_count == 1 && ask_time_flag == TRUE && rx_buffer >=0x20) {


 tim1_multiplier = serial_to_int(&rx_buffer);


 TIM1_ARR = (uint32_t)( 9000 * tim1_multiplier );
 Delay_ms(100);
 ask_time_flag = FALSE;
 sequence_count++;
 print_string(&tim1_info, NO_NEW_LINE);
 print_int(&tim1_multiplier);

 }
 else if (sequence_count == 2 && ask_time_flag == TRUE) {


 tim2_multiplier = serial_to_int(&rx_buffer);


 TIM4_ARR = ( (uint32_t)9000 * tim2_multiplier );
 print_string(&tim2_info, NO_NEW_LINE);
 print_int(&tim2_multiplier);

 Delay_ms(100);


 sequence_count = 0;
 ask_time_flag = FALSE;
 r_key_rcvd = FALSE;
 }


 GPIOB_ODR = 0x0000;
 GPIOC_ODR = 0x0000;
 GPIOD_ODR = 0x0000;
 GPIOE_ODR = 0x0000;
 TIM1_CNT = 0;
 TIM4_CNT = 0;


 }
 }







 if ( TIM1_SR.UIF == 1 ) {

 TIM1_SR.UIF = 0;
 GPIOB_ODR = ~GPIOB_ODR;
 GPIOC_ODR = ~GPIOC_ODR;


 }
 if ( TIM4_SR.UIF == 1 ) {

 TIM4_SR.UIF = 0;
 GPIOD_ODR = ~GPIOD_ODR;
 GPIOE_ODR = ~GPIOE_ODR;
 }
 }


}
