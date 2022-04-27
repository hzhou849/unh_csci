//**************************************************************************************************
// Project 6 - Interrupts
// Name: Howard Zhou
// Due Date: 05/2/2022
// Course: ELEC 6602 - Embedded Systems

// Description: 
//                     
//    
//      
//      Objective 1: - Use Timer 2, PA1 and PA6 on interrupt
//                   - Timer 2 will display the time every 1 second on PORTD/H 
//                     starting at 99, counting down to zero and restart.
//
//      Objective 2: - Every time PA1 is pressed for the first time, timer must stop.
//                   - When pressed a second time, it must start again.
//  
//      Objective 3: - When PB6 is released time must be displayed on USART Terminal (limit 00 to 99)
//                   - THe main program increments the value on PORTR every time a char
//                      is typed on USART terminal and sends the character back to 
//                      the USART terminal.
//
//      Bonus Obj: 
//                      Write and additional ISR to blink the LED at a specified frequency.
//**************************************************************************************************
#include <stdint.h>

// You can redefine special registers like this
 sfr uint32_t volatile*  GPIO_TEST = 0x4001140C;


/* Interrupt service routines - For external push button interrupt */
void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
    // EXTI_PR.B6 = 1;      // Clear pending regsiter interrupt flag for PB6
                         // 1 = slected trigger request has occured
    EXTI_PR |= 1 << 6;     // PB6 = PR6 Bit
    GPIOE_ODR = ~GPIOE_ODR;
}

void EXTIPA0() iv IVT_INT_EXTI0 ics ICS_AUTO {
    // EXTI_PR.PA0 = 1;     // Clear interrupt pending regsiter
        EXTI_PR |= 1 << 0;      // PA0 == PR0 bit
    // GPIOE_ODR = ~GPIOE_ODR;
    // GPIO_TEST->b13 = 0;
    // *GPIO_TEST = ~(*GPIO_TEST);
            *GPIO_TEST = 0x0000;
    while (GPIOA_IDR.B0 == 1) {
        // if (*GPIO_TEST != 0x0000){

        // }
    }

}

void TIMER2_ISR () iv IVT_INT_TIM2 {
    TIM2_SR &=  ~(1 << 0);         // Bit[0] = UIF update intrpt flag. 1 to reset
    // *GPIO_TEST = ~(*GPIO_TEST);
    // TIM2_SR.UIF = 0;
    GPIOD_ODR = ~GPIOD_ODR;
    // GPIOE_ODR=~GPIOE_ODR;

}


/* Helper Functions */

void initClock72MHz() {
    /* Clock Configuration for 72MHz */
    // Configure clock for 72MHz
    // Enables PLL and PLL2 and 8MHz trimming
    RCC_CR = 0x05010081;


    // Sets the multiplication factor for PLL to 9, selects division factor for clock 
    // from PREDIV1 selected as PLL input clock, sets division factor of 
    // APB Low speed clock (PCLK1) to 2, no SYSCLK division, select
    // PLL as SYSCLK
    RCC_CFGR = 0x091D8402; // IDE Scheme

    // Selects PLL2 as PREDIV1SRC:PREDIV1 entry clock source, set PREDIV1 to b0100 
    // to divide 25MHz by 5MHz to set PLL2 to 5MHz. 
    // Sets PLL2 mulitplication factor to 8 to produce 40MHz clock entry to PLL.
    // PLL uses PREDIV1 to divide this clock to 8MHz and use the multiplication 
    // factor to generate 72MHz for Sys clock
    RCC_CFGR2 = 0x00010644;
}

void main() {

    /* Initialize Clock for 72MHz */
    initClock72MHz();

    /* Initialize GPIO & USART */
    USART1_CR1 &= ~(1 << 13);                  // Diasable USART for configuration

    RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
    AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap

    RCC_APB2ENR |= 1 << 2;                     // Enable GPIO Clock PORT A for USART and Interrupt test
    RCC_APB2ENR |= 1 << 3;                     // Enable GPIO Clock PORT B 
    RCC_APB2ENR |= 1 << 5;                     // Enable GPIO Clock PORT D 
    RCC_APB2ENR |= 1 << 6;                     // Enable GPIO Clock PORT E 
    RCC_APB2ENR |= 1 << 14;                    // Enable USART1 Clock


    /* Configure port direction & flags */
    GPIOA_CRH &= ~(0xFF << 4);                 // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
    GPIOA_CRH |=  (0x0B << 4);                 // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
    GPIOA_CRH |=  (0x04 << 8);                 // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04

    GPIOA_CRL |= (0x04 << 0);                  // PA0 input CNF=input-floating b01; MODE: input b00 = 0x0100;
    GPIOA_CRL |= (0x04 << 6);                  // PA6 input CNF=input-floating b01; MODE: input b00 = 0x0100;

    GPIOD_CRL = 0x33333333;                   // PD0:7   CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
    GPIOD_CRH = 0x33333333;                   // PD8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
    GPIOE_CRH = 0x33333333;                   // PE8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;


    /* Configure USART Baudrate */
    USART1_BRR = 0x00000506;                   // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
                                               // Mantissa=80=0x50; Fraction=(0.357 *16) = 5.7 ~ 0x6; Baud reg = 0x506
    
    /* USART Control register configuration */
    USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
    USART1_CR1 &= ~(1 << 12);                  // Force 8 data bits. Mbit set to 0
    USART1_CR1 &= ~(3 << 9);                   // Force no Parity & no parity control
    USART1_CR2 &= ~(3 << 12);                  // Force 1 stop bit
    USART1_CR3 &= ~(3 << 8);                   // Force no flow control and no DMA for USART1
    USART1_CR1 &= ~(3 << 2);                   // Rx, Tx Enable

    Delay_ms(100);                             // Allow time for USART1 to complete initialization
    USART1_CR1 |= 1 << 13;                     // **NOTE: USART1 Enable must be done after configuration is complete. 

    /* Timer setup configuration */
    RCC_APB1ENR |= 1 << 0;                     // Enable TIMER2 Clock;
                                               // If reset value of RCC_CFGR is used, then the 8MHz clock will
                                                                           // be the clock source for timer

    TIM2_CR1 = 0x0000;                         /// Disable the timer for config/setup.s

    TIM2_PSC = 7999;                           // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1)    
                                               // We want 72MHz / (7999+1) = 9000 # clk cycles/sec

    TIM2_ARR = 9000;                           // Set the auto-reload register to the value calculated above

    TIM2_DIER |= 1 << 0;                       // Allow timer Update interrupt enable

    TIM2_CR1 = 0x0001;                         // After timer setup, enable TIMER2; bit4=0 counting up.            



    /* Interrupt setup and configuration */
    AFIO_EXTICR1  = 0x00000000;                // PA0 as External interrupt
    AFIO_EXTICR2 |= 0x00000100;                // PB6 as Enternal interrupt; Pin6/EXTI6[3:0] PortB=0x0001 
    EXTI_RTSR    |= 0x00000041;                // Set Edge trigger register for interrupt on rising edge for PA0 and PB6                  
                                               // Mask to enable TR6 and TR0 (EXTI6 and EXTI0) b1=rising trigger enabled

    EXTI_IMR     |= 0x00000041;                // Set interrupt request from TR6 and TR0 to not masked (cpu CANNOT ignore it)

    /* See Lecture on Interrupt to see that Interrupt request and NVIC Interpt enable
     * have a low-level and gate so both must be turned on in order for interrupt 
     * to work.
     * 
     * See prgramming manual for this register 
     * *See reference manual 10.1.2 Interrupt and exception vector table
     * for mapping of pins.
     * According to table : 4.3.1 programming manual pg 119.
     *      EXTI0 is position 6  in NVIC table
     *      EXIT6 is postion  23 (EXIT9_5 aka EXTI9 to EXTI5) in NVIC table
     */
    NVIC_ISER0 |= 1 << 6;                     // Enable NVIC interrupt set enable registers for EXTI0 line zero (PA0)
    NVIC_ISER0 |= (long int) 1 << 23;         // Enable NVIC interrupt set enable registers for EXTI6 PB6

    NVIC_ISER0 |= (uint32_t) 1 << 28;       // Enable NVIC interrupt enable for TIM2 global interrupt vector mapping 28

    // IRQ28 is for TIMR2 so 28. IPR calculation is <IRQ_position#> % 4 -> 28 % 4 = 7 R0
    // IPRx = 7; R0 = byte offset is 0 
    // 0 = highest priority, we want to make the timer a lower priority vs the button presses
    // NVIC_IPR7 |=  (long int) 0xFF << 0;

    // 6 % 4 = 1 R2; IPRx=1; offset=2=bit[16]
    // Set the priority of PA0 to 0xFF d255 the lowest priority level
    // This will allow the timer to keep counting even though button is held down
    NVIC_IPR1 |= (long int) 0xFF << 16;



    // GPIOD_ODR = 0xFFFF;                     
    // GPIOE_ODR = 0xFF << 8;                     // PORT E only has a High bank
    GPIOD_ODR = 0x0000;                     
    GPIOE_ODR = 0x00 << 8;                     // PORT E only has a High bank
    

    /* Infinite loop - things to do in between interrupts */
    for (;;) {

    }
}