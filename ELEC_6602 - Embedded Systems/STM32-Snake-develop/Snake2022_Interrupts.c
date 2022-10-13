#include "Snake2022_resources.h"

//Direction snakeDir = NO_CHANGE;
extern snakeDir;
extern timerFlag;

/***************************************************
 * @brief joyStickLeft ()
 *
 *        This is the ISR for Left Button on JoyStick.
 *
 ***************************************************/
void joyStickLeft() iv IVT_INT_EXTI2
{
    EXTI_PR.B2 = 1;
    //snakeDir   = LEFT;
    if(snakeDir != 3){
      snakeDir = 0;
    }
}

/***************************************************
 * @brief joyStickUp ()
 *
 *        This is the ISR for Up Button on JoyStick.
 *
 ***************************************************/
void joyStickUp() iv IVT_INT_EXTI4
{
    EXTI_PR.B4 = 1;
    //snakeDir   = UP;
    if(snakeDir != 2){
      snakeDir = 1;
    }
}

/***************************************************
 * @brief joyStickRightAndDown ()
 *
 *        This is the ISR for Right/Down Button on JoyStick.
 *
 ***************************************************/
void joyStickRightAndDown() iv IVT_INT_EXTI9_5 ics ICS_AUTO
{
    if ((EXTI_PR & 0x0020) != 0) {
        EXTI_PR.B5 = 1;
        //snakeDir   = DOWN;
        if(snakeDir != 1){
          snakeDir = 2;
        }
    }
    else if ((EXTI_PR & 0x0040) != 0) {
        EXTI_PR.B6 = 1;
        //snakeDir   = RIGHT;
        if(snakeDir != 0){
          snakeDir = 3;
        }
    }
}

/***************************************************
 * @brief JoyStickConfiguration ()
 *
 *        This is the function to initialize the joystick as an interrupt
 *
 ***************************************************/
void JoyStickConfiguration()
{
    GPIO_Digital_Input(&GPIOD_IDR, _GPIO_PINMASK_2 | _GPIO_PINMASK_4);  // Set Up and Left as digital input
    GPIO_Digital_Input(&GPIOB_IDR, _GPIO_PINMASK_5);                    // Set Down as digital input
    GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_6);                    // Set Right as digital input

    RCC_APB2ENR.AFIOEN = 1;
    AFIO_EXTICR1       = 0x0300;      // PD2 as External interrupt
    AFIO_EXTICR2       = 0x0013;      // PD4/PB5/PA6 as External interrupt
    EXTI_FTSR          = 0x0074;      // Enable falling edge trigger
    EXTI_IMR           = 0x0074;      // Enable interrupt mask
    NVIC_IntEnable(IVT_INT_EXTI2);    // PD2
    NVIC_IntEnable(IVT_INT_EXTI4);    // PD4
    NVIC_IntEnable(IVT_INT_EXTI9_5);  // PB5 and PB6
    NVIC_ISER0.B7 = 1;
    NVIC_ISER0.B8 = 1;

    Delay_100ms();
}

/***************************************************
 * @brief Timer3_ISR()
 *
 *        Interrupt Service Routine for Timer 3 for RTC
 *
 ***************************************************/
void TIMER3_ISR () iv IVT_INT_TIM3 {
TIM3_SR.UIF = 0;                          // Reset UIF flag so next interrupt can be recognized when UIF is set
timerFlag = 1;
}