#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
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
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/p7_final_project_objects.h"
typedef struct Screen TScreen;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned int ObjectsCount;
};

extern TScreen Screen1;










void DrawScreen(TScreen *aScreen);
void Check_TP();
void Start_TP();
void Process_TP_Press(unsigned int X, unsigned int Y);
void Process_TP_Up(unsigned int X, unsigned int Y);
void Process_TP_Down(unsigned int X, unsigned int Y);
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_screen_ctl.h"
#line 1 "d:/mikroc pro for arm/include/stdint.h"
#line 14 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_screen_ctl.h"
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis);







void load_intro_screen() {

 uint32_t x_axis = 35;

 while (GPIOC_IDR.B13 != 0 ) {
 draw_intro_screen(35, 115);


 }
}



void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
 uint8_t pub_msg[] = "Puddle Producktions presents:";
 uint8_t dev_msg[] = "A Run Hop Games, game.";
 uint8_t intro_msg[] = "Please press Joystick down to start";


 TFT_Fill_Screen(CL_BLACK);

 TFT_Set_Font(TFT_defaultFont, CL_GRAY, FO_HORIZONTAL );


 TFT_Write_Text(&intro_msg, x_axis, y_axis);


}
#line 50 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
static const uint32_t GPIO_INPUT_MASK = 0x44444444;
static const uint8_t PHASE_INTRO = 0;
static const uint8_t PHASE_GAME = 1;
static const uint8_t TRUE = 1;
static const uint8_t FALSE = 0;



static volatile uint8_t _DEV_MODE = FALSE;
static volatile uint8_t _GAME_PHASE = PHASE_INTRO;


void JOYSTICK_EXTI13 iv IVT_INT_EXIT






void init_MCU() {


 USART1_CR1 &= ~(1 << 13);

 AFIO_MAPR = 0x00000000;
 RCC_APB2ENR |= 0x00000001;

 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 4;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;
 RCC_APB2ENR |= 1 << 14;


 GPIOA_CRL = GPIO_INPUT_MASK;
 GPIOE_CRH = 0xFF00;



 GPIOA_CRL |= 4 << 6;
 GPIOB_CRL |= 4 << 5;
 GPIOD_CRL |= 4 << 2;
 GPIOD_CRL |= 4 << 4;
 GPIOC_CRH |= 4 << 5;
}


void config_USART1() {
 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4);
 GPIOA_CRH |= (0x04 << 8);


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
}


void init_timer2() {
 RCC_APB1ENR |= 1 << 0;
 TIM2_CR1 = 0x0000;
 TIM2_PSC = 7999;

 TIM2_ARR = 9000;
 TIME2_DIER |= 1 << 0;
 TIM2_CR1 = 0x0001;
}



void init_interrupt() {



 AFIO_EXTICR2 = 0x0000;
 NVIC_ISER0 = 0x00000000;



 AFIO_EXTICR1 |= 3 << 8;
 AFIO_EXTICR2 |= 3 << 0;
 AFIO_EXTICR2 |= 1 << 4;
 AFIO_EXTICR2 &= ~(0xF << 0);
 AFIO_EXTICR4 |= 2 << 4;




 NVIC_ISER0 |= (uint32_t) 1 << 8;
 NVIC_ISER0 |= (uint32_t) 1 << 10;
 NVIC_ISER0 |= (uint32_t) 1 << 23;
 NVIC_ISER1 |= (uint32_t) 1 << 8;


}



void main() {





 init_MCU();


 config_USART1();




 init_timer2();



 init_interrupt();



 Start_TP();





 load_intro_screen();









 while (1) {
 Check_TP();
 }
}
