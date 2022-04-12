#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/ex_serial_com_usart2/serial_extra_usart2.c"
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
#line 20 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/ex_serial_com_usart2/serial_extra_usart2.c"
static const uint32_t GPIOD_USART2_EN_MASK = 0x04B44444;

void main() {

 uint32_t rx_buffer;
 uint32_t tx_buffer;




 RCC_CR = 0x05010081;




 RCC_CFGR = 0x001D8402;





 RCC_CFGR2 = 0x00010644;



 USART2_CR1 &= ~(1 << 13);

 RCC_APB1RSTR.USART2RST = 0;
 RCC_APB2ENR.AFIOEN = 1;
 RCC_APB2ENR.IOPDEN = 1;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 5;



 RCC_APB1ENR.USART2EN = 1;
 RCC_APB1RSTR &= ~(1 << 5);










 GPIOD_CRL = GPIOD_USART2_EN_MASK;
 AFIO_MAPR.USART2_REMAP = 1;









 USART2_BRR = 0x00000F36;









 USART2_CR1 &= ~(1 << 12);
 USART2_CR2 &= ~(3 << 12);
 USART2_CR1 &= ~(3 << 9);
 USART2_CR3 &= ~(3 << 8);
 USART2_CR1 |= 3 << 2;
 Delay_ms(100);
 USART2_CR1 |= 1 << 13;



 for (;;) {




 while( (USART2_SR & (1 << 5)) == 0 ) {}


 rx_buffer = USART2_DR;





 while ( (USART2_SR & (1 << 7)) == 0) {}


 Delay_ms(10);
 tx_buffer = rx_buffer;
 USART2_DR = rx_buffer;

 }
}
