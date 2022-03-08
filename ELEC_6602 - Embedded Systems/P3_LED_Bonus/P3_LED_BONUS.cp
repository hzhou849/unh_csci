#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_Bonus/P3_LED_BONUS.c"
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
#line 26 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_Bonus/P3_LED_BONUS.c"
static const uint32_t GPIO_DIR_OUTPUT = 0x33333333;
static const uint32_t GPIO_DIR_INPUT = 0x44444444;

static const uint8_t INCREMENT_MODE = 0x01;
static const uint8_t DECREMENT_MODE = 0x00;

static const uint8_t PE_MODE_HIGH = 0x01;
static const uint8_t PE_MODE_LOW = 0x00;



uint8_t PE_display_mode = PE_MODE_LOW;
uint8_t PD_LOW_NUM = 0xFF;
uint8_t PD_HIGH_NUM = 0x33;
uint16_t delay_time_ms = 100;
uint32_t PA0_PWM_phase = 0;





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
}


void main() {

 uint16_t combined_num = 0;
 uint16_t target_count = 0;
 uint8_t count_mode = INCREMENT_MODE;
 uint8_t temp_num = 0;
 uint32_t PA0_led_counter = 0;
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



 PA0_PWM_phase = target_count % 3;



 asm {
#line 189 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P3_LED_Bonus/P3_LED_BONUS.c"
 MOVW R7, #0x2B89
 MOVT R7, #0x1C




 MOVW R0, #LO_ADDR(GPIOC_IDR+0)
 MOVT R0, #HI_ADDR(GPIOC_IDR+0)
 MOVW R3, #LO_ADDR(GPIOA_ODR+0)
 MOVT R3, #HI_ADDR(GPIOA_ODR+0)
 MOVW R2, #LO_ADDR(GPIOE_ODR+0)
 MOVT R2, #HI_ADDR(GPIOE_ODR+0)
 MOVW R4, #LO_ADDR(_PE_display_mode+0)
 MOVT R4, #HI_ADDR(_PE_display_mode+0)
 MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
 MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)
 MOVW R9, #LO_ADDR(_PD_HIGH_NUM+0)
 MOVT R9, #HI_ADDR(_PD_HIGH_NUM+0)

 _DELAY_LOOP:
 SUBS R7, R7, #1
 BEQ _EXIT_TIME_LOOP
 LDR R1, [R0]
 AND R6, R1, #0x00000001
 CMP R6, #1
 BEQ _PC0_BTN_FILTER
 BNE _PC0_NOT_PRESSED




 _PC0_PRESSED:
 LDR R5, [R4]
 CMP R5, #1
 BEQ _SET_PE_LOW
 BNE _SET_PE_HI

 _PC0_BTN_FILTER:
 LDR R1, [R0]
 AND R6, R1, #0x00000001
 CMP R6, #1
 BEQ _PC0_BTN_FILTER
 BNE _PC0_PRESSED






 _PC0_NOT_PRESSED:
 MOVW R5, #LO_ADDR(_PA0_PWM_phase+0)
 MOVT R5, #HI_ADDR(_PA0_PWM_phase+0)
 LDR R10, [R5]
 CMP R10, #0
 BEQ _UPDATE_PWM1_PA
 CMP R10, #1
 BEQ _UPDATE_PWM2_PA
 CMP R10, #2
 BEQ _UPDATE_PWM3_PA

 _SET_PE_LOW:
 LDR R5, [R8]
 LSL R5, #8
 STR R5, [R2]
 MOV R10, #0x00000000
 STR R10, [R4]
 B _DELAY_LOOP

 _SET_PE_HI:
 LDR R5, [R9]
 LSL R5, #8
 STR R5, [R2]
 MOV R10, #0x00000001
 STR R10, [R4]
 B _DELAY_LOOP






 _UPDATE_PWM1_PA:
 MOV R10, #15
 UDIV R5, R7, R10
 MUL R11, R5, R10
 CMP R7, R11

 BEQ _TURN_ON_PA
 BNE _TURN_OFF_PA


 _UPDATE_PWM2_PA:
 MOV R10, #5
 UDIV R5, R7, R10
 MUL R11, R5, R10
 CMP R7, R11
 BEQ _TURN_ON_PA
 BNE _TURN_OFF_PA


 _UPDATE_PWM3_PA:
 MOV R10, #1
 UDIV R5, R7, R10
 MUL R11, R5, R10
 CMP R7, R11
 BEQ _TURN_ON_PA
 BNE _TURN_OFF_PA

 _TURN_ON_PA:
 MOV R5, #00000001
 STR R5, [R3]
 B _DELAY_LOOP
 _TURN_OFF_PA:
 MOV R5, #00000000
 STR R5, [R3]
 B _DELAY_LOOP

 _EXIT_TIME_LOOP:
 NOP
 }
 }
}
