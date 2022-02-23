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
#line 31 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_manip/P3_LED_manip.c"
static const uint32_t GPIO_DIR_OUTPUT = 0x33333333;
static const uint32_t GPIO_DIR_INPUT = 0x44444444;

uint8_t PD_LOW_NUM = 0x00;
static const uint8_t PD_HIGH_NUM = 0x02;




static const uint8_t INCREMENT_MODE = 0x01;
static const uint8_t DECREMENT_MODE = 0x00;

static const uint8_t PE_MODE_HIGH = 0x01;
static const uint8_t PE_MODE_LOW = 0x00;



void update_PD_LED(uint16_t *target_count) {
 GPIOD_ODR = (*target_count & 0x000FFFF);
}


void PC_btn_check(uint8_t *PE_display_mode) {
 if (GPIOC_IDR.B0 == 1)
 {
 while (GPIOC_IDR.B0 == 1)
 {
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
}


void get_PE_display_data(uint8_t *PE_display_mode) {

 if (*PE_display_mode == PE_MODE_LOW) {
 *PE_display_mode = PE_MODE_HIGH;
 }
 else {
 *PE_display_mode = PE_MODE_LOW;
 }
}


 uint8_t PE_display_mode = PE_MODE_LOW;
void main() {

 uint32_t i = 0;
 uint32_t time_ms = 1000;
 uint16_t combined_num = 0;
 uint16_t target_count = PD_LOW_NUM;
 uint8_t count_mode = INCREMENT_MODE;




 combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
#line 137 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_manip/P3_LED_manip.c"
 RCC_APB2ENR |= 1 << 4;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;




 GPIOC_CRL = GPIO_DIR_INPUT;


 GPIOD_CRL = GPIO_DIR_OUTPUT;
 GPIOD_CRH = GPIO_DIR_OUTPUT;


 GPIOE_CRL = GPIO_DIR_OUTPUT;
 GPIOE_CRH = GPIO_DIR_OUTPUT;



 GPIOD_ODR = (combined_num & 0x0000FFFF);
 GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF);


 Delay_ms(100);




 for (;;) {




 if (target_count == combined_num) {
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










 asm {

 MOVW R7, #0x8D7F
 MOVT R7, #0x5E


 MOVW R0, #LO_ADDR(GPIOC_IDR+0)
 MOVT R0, #HI_ADDR(GPIOC_IDR+0)
 MOVW R2, #LO_ADDR(GPIOE_ODR+0)
 MOVT R2, #HI_ADDR(GPIOE_ODR+0)
 MOVW R4, #LO_ADDR(_PE_display_mode+0)
 MOVT R4, #HI_ADDR(_PE_display_mode+0)
 MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
 MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)




 _DELAY_LOOP:
 SUBS R7, R7, #1
 BEQ _EXIT_TIME_LOOP

 LDR R1, [R0]
 AND R6, R1, #0x00000001
 CMP R6, #1
 BEQ _PC0_PRESSED
 BNE _PC0_NOT_PRESSED

 _PC0_PRESSED:
 LDR R5, [R4]
 CMP R5, #1
 BEQ _SET_PE_LOW
 BNE _SET_PE_HI





 _PC0_NOT_PRESSED:
 MOV R8, #0
 B _DELAY_LOOP

 _SET_PE_LOW:

 MOVW R8, #0x3333
 STR R8, [R2]
 MOV R9, #0x00000000
 STR R9, [R4]
 B _DELAY_LOOP

 _SET_PE_HI:
 MOVW R8, #0xFFFF
 STR R8, [R2]
 MOV R9, #0x00000001
 STR R9, [R4]
 B _DELAY_LOOP

 _EXIT_TIME_LOOP:
 NOP



 }
#line 272 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_manip/P3_LED_manip.c"
 }



}
