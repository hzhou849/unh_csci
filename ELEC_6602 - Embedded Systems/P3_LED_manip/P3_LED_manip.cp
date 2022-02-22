#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_manip/P3_LED_manip.c"
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
#line 24 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_manip/P3_LED_manip.c"
void main() {

 asm {
 L_main0:


 MOVW R7, #6911
 MOVT R7, #189
 SUBS R7, R7, #1
 BNE L_main0

 }

 Delay_ms(1000);
 Delay_ms(2000);
 Delay_us(1000000);
}
