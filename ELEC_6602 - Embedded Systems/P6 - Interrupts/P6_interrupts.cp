#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
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
#line 33 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
sfr uint32_t volatile* GPIO_TEST = 0x4001140C;


static const uint8_t NO_NEW_LINE = 0;
static const uint8_t NEW_LINE_EN = 1;
static const uint32_t TIMER_COUNTER_MAX = 99;
static const uint32_t ASCII_READABLE_CHAR_START = 0x20;
static const uint32_t ASCII_HEX_0 = 0x30;
static const uint32_t CHAR_CR = 0x0D;
static const uint32_t CHAR_LF = 0x0A;
static const uint32_t SW_INT_DELAY_MS = 250;


static volatile uint32_t time_count = 0;
static volatile uint32_t timer_run_flag = 1;
static volatile uint32_t usart_count = 0;
volatile uint32_t rx_buffer;

void convert_int(uint32_t *temp_val);
void write_data_char(uint32_t *tx_char, uint8_t new_line);






void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {

 uint32_t temp_val;

 EXTI_PR.B6 = 1;


 while (GPIOB_IDR.B6 == 1) {}







 temp_val = time_count-1;
 convert_int(&temp_val);
}


void EXTIPA4() iv IVT_INT_EXTI4 ics ICS_AUTO {
 EXTI_PR.PA4 = 1;

 while (GPIOA_IDR.B4 == 1) {}
 timer_run_flag = ~timer_run_flag;

}


void TIMER2_ISR() iv IVT_INT_TIM2 {

 TIM2_SR &= ~(1 << 0);

 if (timer_run_flag == 1) {
 GPIOD_ODR &= 0x00FF;
 GPIOD_ODR |= ((time_count++) << 8) & 0xFF00;

 if (time_count > TIMER_COUNTER_MAX ) {
 time_count = 0;
 }
 }
}


void USART1_ISR() iv IVT_INT_USART1 {

 rx_buffer = USART1_DR;


 while ( (USART1_SR & (1 << 7 )) == 0) {}
 Delay_ms(10);
 USART1_DR = rx_buffer;
 Delay_ms(10);


 if (rx_buffer >= ASCII_READABLE_CHAR_START) {
 GPIOE_ODR = (++usart_count) << 8;
 }
}


void MY_SWIER_ISR() iv IVT_INT_EXTI15_10 {
 Delay_ms(SW_INT_DELAY_MS);
 EXTI_PR |= 1 << 15;
 GPIOD_ODR = (GPIOD_ODR & 0xFF00) + ( (~GPIOD_ODR) & 0x00FF);
}







void initClock72MHz() {



 RCC_CR = 0x05010081;






 RCC_CFGR = 0x091D8402;






 RCC_CFGR2 = 0x00010644;
}


void convert_int(uint32_t *int_num) {

 uint32_t temp_val = 0;
 uint32_t ascii_msb = 0;
 uint32_t ascii_lsb = 0;
 uint32_t new_line_LF = 0xA;


 if (*int_num > TIMER_COUNTER_MAX ) {
 return;
 }

 temp_val = *int_num;
 while (temp_val >= 10) {
 temp_val /= 10;
 ascii_msb = temp_val + ASCII_HEX_0;;
 }


 if ( *int_num > 0 ) {
 temp_val = (*int_num %10);
 ascii_lsb = temp_val + ASCII_HEX_0;
 }

 Write_data_char (&new_line_LF, NO_NEW_LINE);
 write_data_char (&ascii_msb, NO_NEW_LINE);
 write_data_char (&ascii_lsb, NEW_LINE_EN);
}



void write_data_char(uint32_t *tx_char, uint8_t new_line) {

 uint32_t *tx_var;

 while( (USART1_SR & (1 << 7)) == 0) {}

 Delay_ms(10);
 USART1_DR = *tx_char;

 if (new_line == NEW_LINE_EN) {
 Delay_ms(10);
 USART1_DR = CHAR_CR;
 Delay_ms(10);
 USART1_DR = CHAR_LF;
 }
}


void main() {


 initClock72MHz();


 USART1_CR1 &= ~(1 << 13);

 AFIO_MAPR = 0x00000000;
 RCC_APB2ENR |= 0x00000001;


 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;
 RCC_APB2ENR |= 1 << 14;



 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4);
 GPIOA_CRH |= (0x04 << 8);

 GPIOA_CRL |= 0x44444444 << 16;
 GPIOB_CRL |= (uint32_t) (0x04 << 24);

 GPIOD_CRL = 0x33333333;
 GPIOD_CRH = 0x33333333;
 GPIOE_CRH = 0x33333333;



 USART1_BRR = 0x00000506;



 USART1_CR1 &= ~(1 << 13);
 USART1_CR1 |= 1 << 5;
 USART1_CR1 &= ~(1 << 12);
 USART1_CR1 &= ~(3 << 9);
 USART1_CR2 &= ~(3 << 12);
 USART1_CR3 &= ~(3 << 8);
 USART1_CR1 |= 3 << 2;

 Delay_ms(100);
 USART1_CR1 |= 1 << 13;



 RCC_APB1ENR |= 1 << 0;



 TIM2_CR1 = 0x0000;

 TIM2_PSC = 7999;


 TIM2_ARR = 9000;

 TIM2_DIER |= 1 << 0;

 TIM2_CR1 = 0x0001;




 AFIO_EXTICR2 |= 0x00000000;
 AFIO_EXTICR2 |= 0x00000100;

 EXTI_RTSR |= 1 << 4;
 EXTI_RTSR |= 1 << 6;
 EXTI_IMR |= 0x00000050;
#line 291 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
 NVIC_ISER0 |= 1 << 10;
 NVIC_ISER0 |= (long int) 1 << 23;
 NVIC_ISER0 |= (uint32_t) 1 << 28;
 NVIC_ISER1 |= 1 << 5;


 EXTI_IMR |= 1 << 10;
 NVIC_ISER1.B8 = 1;
#line 316 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
 NVIC_IPR10 |= 0xFF << 0;



 rx_buffer = USART1_DR;


 for (;;) {


 if (EXTI_SWIER.B10 != 1) {
 EXTI_SWIER |= 1 << 10;
 }
 Delay_ms(1);
 }
}
