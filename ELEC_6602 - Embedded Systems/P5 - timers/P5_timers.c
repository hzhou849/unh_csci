//**************************************************************************************************
// Project 5 - Timers
// Name: Howard Zhou
// Date: 04/07/9993
// Course: ELEC 6602/3371 Embedded Systems

// Description: 
//
//      This program toggles the LEDs on PORTD and PORTR every one second. This is done by using
//      Timer1, the 8MHz clock, and dividing that clock by an 8000 prescaler. This creates a 
//      clock frequency of 1000 ms, or 1 second. Every second, the status register interrupt 
//      flag will trigger, thus allowing an action (LED toggle) to occur.
//
//
//		Objective 1:
//					  
//					  
//					 
//					 
//
// 		Objective 2: Sort the characters from the terminal in descending order based on the ASCII 
//					 values and return them to the USART terminal to be displayed. The number of 
//					 characters sorted must also be sent to the USART terminal and displayed at the 
//					 bottom of the sorted list.
//
// 		Objective 3: As you enter the characters, the total number of characters entered after 
//					 each key stroke must be displayed on the LED's on PORTD/H. Then, the LED's 
//					 must reset to zero to be ready for the next set of characters. 
//					 This process must repeat indefinitely.
//**************************************************************************************************

/* Globals */
int counter;


void main() {

    GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
    GPIO_Digital_Output(&GPIOE,BASE, _GPIO_PINMASK_ALL);


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
    TIM1_ARR = 9000;     

    TIM1_CR1 = 0x0001;      // Enable TIMER1;

    // Notice: Bit4 of TIM1_CR1 specifies whether the counter count up (BIT4=0) or counts
    // down (BIT4=1). In this configuration, counting up is used.


    /* Main loop */
    for (;;) {

        // Checking timer status register to perfom an action (p570)
        // Wait until timer update flag is set, meaning the count val was reached.
        while ( !TIM1_SR.UIF ) {}   
    }


}