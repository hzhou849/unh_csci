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
#line 29 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
sfr uint32_t volatile* GPIO_TEST = 0x4001140C;


static const uint32_t TIMER_COUNTER_MAX = 99;


static volatile uint32_t time_count = 0;
static volatile uint32_t timer_run_flag = 1;
static volatile uint32_t usart_count = 0;


void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
 EXTI_PR.B6 = 1;


 while (GPIOB_IDR.B6 == 1) {}


 GPIOE_ODR = ( (time_count-1) << 8) & 0xFF00;
 usart_count = time_count;


}

void EXTIPA4() iv IVT_INT_EXTI4 ics ICS_AUTO {
 EXTI_PR.PA4 = 1;

 timer_run_flag = ~timer_run_flag;
 while (GPIOA_IDR.B4 == 1) {}

}

void TIMER2_ISR() iv IVT_INT_TIM2 {

 TIM2_SR &= ~(1 << 0);

 if (timer_run_flag == 1) {
 GPIOD_ODR = (time_count++) << 8;

 if (time_count > TIMER_COUNTER_MAX ) {
 time_count = 0;
 }
 }

}

void USART1_ISR() iv IVT_INT_USART1 {
 uint32_t rx_buffer;
 rx_buffer = USART1_DR;


 while ( (USART1_SR & (1 << 7 )) == 0) {}
 Delay_ms(10);
 USART1_DR = rx_buffer;


 if (rx_buffer >= 0x20) {
 GPIOE_ODR = (usart_count++) << 8;
 }
}




void initClock72MHz() {



 RCC_CR = 0x05010081;






 RCC_CFGR = 0x091D8402;






 RCC_CFGR2 = 0x00010644;
}

void main() {

 uint32_t timer_counter = 0;
 uint32_t *rx_buffer = 0;


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

 GPIOA_ODR=0xFFFF;


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


 NVIC_ISER1 |= 1 << 5;
#line 215 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
 NVIC_ISER0 |= 1 << 10;
 NVIC_ISER0 |= (long int) 1 << 23;

 NVIC_ISER0 |= (uint32_t) 1 << 28;
#line 237 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
 GPIOD_ODR = 0xFFFF;
 GPIOE_ODR = 0x00 << 8;



 for (;;) {
 while( ( USART1_SR & (1 << 5)) == 0 ) {}

 rx_buffer = USART1_DR;

 while ( (USART1_SR & (1 << 7 )) == 0) {}
 Delay_ms(10);
 USART1_DR = rx_buffer;

 }
}
