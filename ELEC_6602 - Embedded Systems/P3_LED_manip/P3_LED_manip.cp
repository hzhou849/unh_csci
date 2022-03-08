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
#line 44 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_manip/P3_LED_manip.c"
static const uint32_t GPIO_DIR_OUTPUT = 0x33333333;
static const uint32_t GPIO_DIR_INPUT = 0x44444444;

static const uint8_t INCREMENT_MODE = 0x01;
static const uint8_t DECREMENT_MODE = 0x00;

static const uint8_t PE_MODE_HIGH = 0x01;
static const uint8_t PE_MODE_LOW = 0x00;



uint16_t delay_time_ms = 100;
uint8_t PE_display_mode = PE_MODE_LOW;
uint8_t PD_LOW_NUM = 0xFF;
uint8_t PD_HIGH_NUM = 0x33;




void update_PD_LED(uint16_t *target_count) {
 GPIOD_ODR = (*target_count & 0x000000FF);
}


void PC_btn_check(uint8_t *PE_display_mode) {


 if (GPIOC_IDR.B0 == 1) {

 while (GPIOC_IDR.B0 == 1) {
 Delay_ms(1);
 }

 if (*PE_display_mode == PE_MODE_LOW) {
 GPIOE_ODR = PD_HIGH_NUM << 8;
 *PE_display_mode = PE_MODE_HIGH;
 }
 else {
 GPIOE_ODR = PD_LOW_NUM << 8;
 *PE_display_mode = PE_MODE_LOW;
 }
 }


 if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {

 while ( GPIOB_IDR.B0 == 1) {
 Delay_ms(1);
 }

 if (*PE_display_mode == PE_MODE_LOW) {
 --PD_LOW_NUM;
 GPIOE_ODR = PD_LOW_NUM << 8;
 }
 else {
 --PD_HIGH_NUM;
 GPIOE_ODR = PD_HIGH_NUM << 8;
 }
 }

 if ( GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
 {

 while ( GPIOB_IDR.B4 == 1 ) {
 Delay_ms(1);
 }

 if (*PE_display_mode == PE_MODE_LOW) {

 ++PD_LOW_NUM;
 GPIOE_ODR = PD_LOW_NUM << 8;
 }
 else {
 ++PD_HIGH_NUM;
 GPIOE_ODR = PD_HIGH_NUM << 8;
 }
 }
}



void main() {

 uint16_t combined_num = 0;
 uint16_t target_count = 0;
 uint8_t count_mode = INCREMENT_MODE;
 uint8_t temp_num = 0;
 uint8_t PA0_PWM_phase = 0;
 uint32_t i = 0;


 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 4;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;



 GPIOA_CRL = GPIO_DIR_OUTPUT;
 GPIOB_CRL = GPIO_DIR_INPUT;
 GPIOC_CRL = GPIO_DIR_INPUT;

 GPIOD_CRL = GPIO_DIR_OUTPUT;
 GPIOD_CRH = GPIO_DIR_OUTPUT;

 GPIOE_CRL = GPIO_DIR_OUTPUT;
 GPIOE_CRH = GPIO_DIR_OUTPUT;


 if (PD_LOW_NUM > PD_HIGH_NUM) {
 temp_num = PD_LOW_NUM;
 PD_LOW_NUM = PD_HIGH_NUM;
 PD_HIGH_NUM = temp_num;
 }
 else if (PD_LOW_NUM == PD_HIGH_NUM) {


 combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
 GPIOD_ODR = combined_num;
 GPIOE_ODR = combined_num << 8;

 return;
 }




 combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
 GPIOD_ODR = (combined_num & 0x0000FFFF);
 GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF) << 8;


 target_count = PD_LOW_NUM;


 Delay_ms(1000);


 for (;;) {


 if (target_count == PD_HIGH_NUM) {
 count_mode = DECREMENT_MODE;
 }
 else if (target_count == PD_LOW_NUM) {
 count_mode = INCREMENT_MODE;
 }


 if (count_mode == INCREMENT_MODE) {
 ++target_count;
 } else{
 --target_count;
 }


 update_PD_LED(&target_count);




 for (i = 0; i < delay_time_ms; i++) {
 Delay_ms(1);
 PC_btn_check(&PE_display_mode);
 }
 }
}
