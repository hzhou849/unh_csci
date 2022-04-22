//**************************************************************************************************
// Project 5 - Timers EXAMPLE
// Name: Howard Zhou
// Date: 04/07/9993
// Course: ELEC 6602/3371 Embedded Systems

// Description: 

//      Attempted to set the RCC_CR, RCC_CFG, RCC_CFG2 to 72MHz, without 
//      changing it on the edit_projects UI load scheme. Does not work.
//      It seems the default is 10MHz clock unless 72MHz scheme is loaded.
//      But still a good breakdown to show how registers get divided
//
//      This program toggles the LEDs on PORTD and PORTR every one second. This is done by using
//      Timer1, the 8MHz clock, and dividing that clock by an 8000 prescaler. This creates a 
//      clock frequency of 1000 ms, or 1 second. Every second, the status register interrupt 
//      flag will trigger, thus allowing an action (LED toggle) to occur.
//
//**************************************************************************************************

/* Globals */
int counter;





void main() {

    RCC_CR    = 0x00000000;
    RCC_CFGR  = 0x00000000;
    RCC_CFGR2 = 0x00000000;

    /* Clock Configuration for 72MHz */

    // // Configure clock for 72MHz
    // // Enables PLL and PLL2 and 8MHz trimming
    // // RESERVED PLL3RDRY PLL3ON PLL2RDY PLL2ON   PLLRDY  PLLON RESERVED  CSSON  HSEBY HSERDY  HSEON
    // // 00       0        0      0       1        0       1      0000     0      0      0      1 
    // //
    // // HSICAL        HSITRIM         RES.        HSIRDY  HSION
    // //00000000       1000 0           0          0       1
    // RCC_CR = 0x05010081;
    // RCC_CR = 0x15010081; // IDE scheme
    RCC_CR = 0x00000081; // IDE scheme


    // Sets the multiplication factor for PLL to 9, selects division factor for clock 
    // from PREDIV1 selected as PLL input clock, sets division factor of 
    // APB Low speed clock (PCLK1) to 2, no SYSCLK division, select
    // PLL as SYSCLK

    //  RES. MCO RES. USBPRE PLLMUL PLLXTPRE PLLSRC ADCPRE PPRES2 PRRE1 HPRE SWS SW
    // 0000  0000 0   0      0111   0        1      10     000    100   0000 00  10
    // IDE   1001

    // MC0    = 1001: PLL3 clock divided by 2 selected
    // USBPRE - PLL clock divide by 1.5 48MHz/1.5 = 32MHz
    // PLLMUL = PLL input clock x 9
    // PLLSRC = HSE Oscillator clock selected as PLL input clock
    // ADCPRE = 10: PCLK divided by 6
    // PPRES2 = 000: HCLK not divided
    // PPRES1 = 100: HCLK divided by 2
    // HPRE   = 0000: SYSCLK not divided
    // SWS    = 00: HSI oscilator used as system clock -HSI is interal 8MHz Oscillator
    // SW     = 10: PLL selected as system clock
    // RCC_CFGR = 0x001D8402;
    RCC_CFGR = 0x091D8402; // IDE Scheme

    // Selects PLL2 as PREDIV1SRC:PREDIV1 entry clock source, set PREDIV1 to b0100 
    // to divide 25MHz by 5MHz to set PLL2 to 5MHz. 
    // Sets PLL2 mulitplication factor to 8 to produce 40MHz clock entry to PLL.
    // PLL uses PREDIV1 to divide this clock to 8MHz and use the multiplication 
    // factor to generate 72MHz for Sys clock

    //        RES.     I2S3SRC I2S2SRC PREDIV1SRC PLL3MUL PLL2MUL PREDIV2 PREDIV1
    // 0000 0000 00000 0       0       1          0000    0110    0100    0100

    // I2S3SRC = 0: System (SYSCLK) selected as I2S3 Clock entry. 
    // I2S2SRC = 0: System (SYSCLK) selected as I2S2 clock entry.
    // PREDIV1SRC = 1: PLL2 selected as PREDIV1 clock entry.
    // PLL3MUL = 00xx: reserved
    // PLL2MUL = 0110: PLL2 multiplication factor - clock entry x 8 
    // PREDIV2 = 0100: PREDIV2 input clock divided by 5
    // PREDIV1 = 0100: PREDIV1 input clock divided by 5
    // RCC_CFGR2 = 0x00010644;
    RCC_CFGR2 = 0x0001F644; // IDE scheme
    RCC_CR |= 0x15010000;


    /* GPIO Initialization */
    GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
    GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);


    // Enable TIMER1 clock. RCC Clock configuration register
    // Different clocks may use different registers.
    // Ex. TIMER4 users RCC_APB1_ENR
    RCC_APB2ENR |= (1 << 11); 

    // Disable timer until configuration is complete
    // If reset value of RCC_CFGR is used, then the 8MHz clock will
    // be the clock source for timer
    TIM1_CR1 = 0x0000;        

    // Clock to TIMx_CNT = 72 000 000 (Clock applied to prescaler register) / 
    //                     7999 (Value in TIMx_PSC + 1) = 9000
    TIM1_PSC = 7999;

    // Reload timer count register with this value when count register resets
    // to 0 after counting from zero to this value
    TIM1_ARR = 9000;     // clock cycles in 1 second.

    TIM1_CR1 = 0x0001;      // Enable TIMER1;

    // Notice: Bit4 of TIM1_CR1 specifies whether the counter count up (BIT4=0) or counts
    // down (BIT4=1). In this configuration, counting up is used.


    /* Main loop */
    for (;;) {

        // Checking timer status register to perfom an action (p570)
        // Wait until timer update flag is set, meaning the count val was reached.
        while ( !TIM1_SR.UIF ) {}   // optional loop to hold

        
            // If you have multiple timers, can use if to check status register
            if ( TIM1_SR.UIF == 1 ) {
                
                // Clear this flad which will reset the timer
                TIM1_SR.UIF = 0;
                GPIOD_ODR = ~GPIOD_ODR;
                GPIOE_ODR = ~GPIOE_ODR;

            } 
    }


}