#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/PA1_test/PA1_test.c"
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
#line 29 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/PA1_test/PA1_test.c"
 sfr uint32_t volatile* GPIO_TEST = 0x4001140C;



void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {


 EXTI_PR |= 1 << 6;
 GPIOE_ODR = ~GPIOE_ODR;
}
#line 56 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/PA1_test/PA1_test.c"
void TIMER2_ISR () iv IVT_INT_TIM2 {
 TIM2_SR &= ~(1 << 0);


 GPIOD_ODR = ~GPIOD_ODR;


}




void initClock72MHz() {



 RCC_CR = 0x05010081;






 RCC_CFGR = 0x091D8402;






 RCC_CFGR2 = 0x00010644;
}

void main() {





 USART1_CR1 &= ~(1 << 13);





 AFIO_MAPR |= 1 << 3;
 AFIO_MAPR |= 1 << 8;
 AFIO_MAPR |= 1 << 9;
 RCC_APB2ENR |= 0x00000001;



 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;
 RCC_APB2ENR |= 1 << 14;



 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4);
 GPIOA_CRH |= (0x04 << 8);




 GPIOA_CRL = 0x44444444;
 GPIOB_CRL |= (uint32_t) (0x04 << 24);

 GPIOD_CRL = 0x33333333;
 GPIOD_CRH = 0x33333333;
 GPIOE_CRH = 0x33333333;

 GPIOA_ODR=0xFFFF;
#line 205 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/PA1_test/PA1_test.c"
 GPIOD_ODR = 0xFFFF;
 GPIOE_ODR = 0x00 << 8;



 for (;;) {

 while (GPIOA_IDR.B1 == 1) {
 GPIOE_ODR = ~GPIOE_ODR;
 Delay_ms(100);
 }

 while (GPIOA_IDR.B0 == 1) {
 GPIOD_ODR = ~GPIOD_ODR;
 }

 }
}
