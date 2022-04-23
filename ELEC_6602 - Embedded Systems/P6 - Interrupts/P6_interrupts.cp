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



void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {


 EXTI_PR |= 1 << 6;
 GPIOD_ODR = ~GPIOD_ODR;
}

void EXTIPA0() iv IVT_INT_EXTI0 ics ICS_AUTO {

 EXTI_PR |= 1 << 0;

 GPIO_TEST->b13 = 0;
 *GPIO_TEST = ~(*GPIO_TEST);

}

void TIMER2_ISR () iv IVT_INT_TIM2 {
 TIM2_SR |= ~(1 << 0);

 GPIOE_ODR=~GPIOE_ODR;

}




void initClock72MHz() {



 RCC_CR = 0x05010081;






 RCC_CFGR = 0x091D8402;






 RCC_CFGR2 = 0x00010644;
}

void main() {


 initClock72MHz();


 USART1_CR1 &= ~(1 << 13);

 RCC_APB2ENR |= 0x00000001;
 AFIO_MAPR = 0x00000000;

 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;
 RCC_APB2ENR |= 1 << 14;



 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4);
 GPIOA_CRH |= (0x04 << 8);

 GPIOA_CRL |= (0x04 << 0);
 GPIOA_CRL |= (0x04 << 6);

 GPIOD_CRL = 0x33333333;
 GPIOD_CRH = 0x33333333;
 GPIOE_CRH = 0x33333333;



 USART1_BRR = 0x00000506;



 USART1_CR1 &= ~(1 << 13);
 USART1_CR1 &= ~(1 << 12);
 USART1_CR1 &= ~(3 << 9);
 USART1_CR2 &= ~(3 << 12);
 USART1_CR3 &= ~(3 << 8);
 USART1_CR1 &= ~(3 << 2);

 Delay_ms(100);
 USART1_CR1 |= 1 << 13;


 RCC_APB1ENR |= 1 << 0;



 TIM2_CR1 = 0x0000;

 TIM2_PSC = 7999;


 TIM2_ARR = (uint32_t) 9000 *100000;

 TIM2_DIER |= 1 << 0;

 TIM2_CR1 = 0x0001;




 AFIO_EXTICR1 = 0x00000000;
 AFIO_EXTICR2 |= 0x00000100;
 EXTI_RTSR |= 0x00000041;


 EXTI_IMR |= 0x00000041;
#line 163 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P6 - Interrupts/P6_interrupts.c"
 NVIC_ISER0 |= 1 << 6;
 NVIC_ISER0 |= (long int) 1 << 23;

 NVIC_ISER0 |= (uint32_t) 1 << 28;




 GPIOD_ODR = 0x0000;
 GPIOE_ODR = 0x00 << 8;



 for (;;) {

 }
}
