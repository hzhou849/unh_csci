//**************************************************************************************************
// Project 6 - Interrupts
// Name: Howard Zhou
// Due Date: 05/2/2022
// Course: ELEC 6602 - Embedded Systems

// Description: 
//                     
//                  REMAPPED to PA4 for the time being 
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

/* You can redefine special registers like this */
sfr uint32_t volatile*  GPIO_TEST = 0x4001140C;

/* Constants */
static const uint32_t TIMER_COUNTER_MAX  = 99;

/* Globals */
static volatile uint32_t time_count = 0;
static volatile uint32_t timer_run_flag = 1;
static volatile uint32_t usart_count = 0;

/* Interrupt service routines - For external push button interrupt */
void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
    EXTI_PR.B6 = 1;                    // Clear pending regsiter interrupt flag for PB6
                                       // 1 = slected trigger request has occured
    // EXTI_PR |= 1 << 6;                 // PB6 = PR6 Bit
    while (GPIOB_IDR.B6 == 1) {}        // Wait here until button release


    GPIOE_ODR = ( (time_count-1) << 8) & 0xFF00;    // Update the LEDs on PORTE/H (shift 8 LEDs)
                                                    // Subtract one so PortE is not ahead of PortDs
    usart_count = time_count;          // Update the USART counter for key presses for PortE for USART1 ISR
                                        // Increment the usart char counter so on next button press, the character
                                        // is not the same number as the timer clock and actually increment the LED 
}

void EXTIPA4() iv IVT_INT_EXTI4 ics ICS_AUTO {
    EXTI_PR.PA4 = 1;                         // Clear interrupt pending regsiter
    
    timer_run_flag = ~timer_run_flag;        // Flip the flag switch to toggle the timer counter on PORTD
    while (GPIOA_IDR.B4 == 1) {}             // Hold here until button is released

}

void TIMER2_ISR() iv IVT_INT_TIM2 {
    
    TIM2_SR &=  ~(1 << 0);                  // Bit[0] = UIF update intrpt flag. 1 to reset

    if (timer_run_flag == 1) {
        GPIOD_ODR = (time_count++) << 8;    // Pass the current timer value (shift 8 for High bank) then increment
   
        if (time_count > TIMER_COUNTER_MAX ) {
            time_count = 0;
        }
    }

}

void USART1_ISR() iv IVT_INT_USART1 {
    uint32_t rx_buffer;
    rx_buffer = USART1_DR;      // RXNE bit interrupt is reset by reading data register
                                // Required to arm the ISR again.

    while ( (USART1_SR & (1 << 7 )) == 0) {}
    Delay_ms(10);
    USART1_DR = rx_buffer;

    // ASCII characters that are not special/invisible
    if (rx_buffer >= 0x20) { 
        GPIOE_ODR = (usart_count++) << 8;
    }
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

    uint32_t timer_counter = 0;
    uint32_t *rx_buffer = 0;

    /* Initialize Clock for 72MHz */
    initClock72MHz();

    /* Initialize GPIO & USART */
    USART1_CR1 &= ~(1 << 13);                  // Diasable USART for configuration


    AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
    // AFIO_MAPR |= 1 << 3;
    // AFIO_MAPR |= 1 << 8;
    // AFIO_MAPR |= 1 << 9;
    RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1

    // ETH_MACCR = 0x0009000;

    RCC_APB2ENR |= 1 << 2;                     // Enable GPIO Clock PORT A  Interrupt test
    RCC_APB2ENR |= 1 << 3;                     // Enable GPIO Clock PORT B 
    RCC_APB2ENR |= 1 << 5;                     // Enable GPIO Clock PORT D 
    RCC_APB2ENR |= 1 << 6;                     // Enable GPIO Clock PORT E 
    RCC_APB2ENR |= 1 << 14;                    // Enable USART1 Clock for USART and


    /* Configure port direction & flags */
    GPIOA_CRH &= ~(0xFF << 4);                 // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
    GPIOA_CRH |=  (0x0B << 4);                 // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
    GPIOA_CRH |=  (0x04 << 8);                // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04

    // GPIOA_CRL &= ~(0xB << 6);                   // PA1 input CNF=input-floating b01; MODE: input b00 = 0x0100;
    // GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_ALL);

    GPIOA_CRL |=  0x44444444 << 16;                   // PA1 input CNF=input-floating b01; MODE: input b00 = 0x0100;
    GPIOB_CRL |= (uint32_t) (0x04 << 24);      // PB6 input CNF=input-floating b01; MODE: input b00 = 0x0100;

    GPIOD_CRL = 0x33333333;                    // PD0:7   CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
    GPIOD_CRH = 0x33333333;                    // PD8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
    GPIOE_CRH = 0x33333333;                    // PE8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;

    GPIOA_ODR=0xFFFF;

    /* Configure USART Baudrate */
    USART1_BRR = 0x00000506;                   // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
                                               // Mantissa=80=0x50; Fraction=(0.357 *16) = 5.7 ~ 0x6; Baud reg = 0x506
    
    /* USART Control register configuration */
    USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
    USART1_CR1 |= 1 << 5;                      // ENABLE USART1 TXNE interrupt
    USART1_CR1 &= ~(1 << 12);                  // Force 8 data bits. Mbit set to 0
    USART1_CR1 &= ~(3 << 9);                   // Force no Parity & no parity control
    USART1_CR2 &= ~(3 << 12);                  // Force 1 stop bit
    USART1_CR3 &= ~(3 << 8);                   // Force no flow control and no DMA for USART1
    USART1_CR1 |=  3 << 2;                     // Rx, Tx Enable

    Delay_ms(100);                             // Allow time for USART1 to complete initialization
    USART1_CR1 |= 1 << 13;                     // **NOTE: USART1 Enable must be done after configuration is complete. 

    /* Timer setup configuration */
    RCC_APB1ENR |= 1 << 0;                     // Enable TIMER2 Clock;
                                               // If reset value of RCC_CFGR is used, then the 8MHz clock will
                                               // be the clock source for timer

    TIM2_CR1 = 0x0000;                         // Disable the timer for config/setup.s

    TIM2_PSC = 7999;                           // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1)    
                                               // We want 72MHz / (7999+1) = 9000 # clk cycles/sec

    TIM2_ARR = 9000;                           // Set the auto-reload register to the value calculated above

    TIM2_DIER |= 1 << 0;                       // Allow timer Update interrupt enable

    TIM2_CR1 = 0x0001;                         // After timer setup, enable TIMER2; bit4=0 counting up.            



    /* Interrupt setup and configuration */
    AFIO_EXTICR2 |= 0x00000000;                // PA4 as External interrupt; Pin4/EXTI4[3:0] PortA=b0000
    AFIO_EXTICR2 |= 0x00000100;                // PB6 as Enternal interrupt; Pin6/EXTI6[3:0] PortB=b0001 

    EXTI_RTSR    |= 1 << 4;                    // Set Edge trigger register for interrupt on rising edge for PA4 and PB6                  
    EXTI_RTSR    |= 1 << 6;                    // Mask to enable TR6 and TR4 (EXTI6 and EXTI4) b1=rising trigger enabled
    EXTI_IMR     |= 0x00000050;                // Set interrupt request from TR6 and TR4 to not masked (cpu CANNOT ignore it)

    /* USART 1 interrupt  vector IRQ37 = ISER1*/
    NVIC_ISER1   |= 1 << 5;                    // ISER1 interrupts vector #63-32; 32+5 =37


    /* See Lecture on Interrupt to see that Interrupt request and NVIC Interpt enable
     * have a low-level and gate so both must be turned on in order for interrupt 
     * to work.
     * 
     * See prgramming manual for this register 
     * *See reference manual 10.1.2-Interrupt and exception vector table
     * for mapping of pins.
     * According to table : 4.3.1 programming manual pg 119.
     *      EXTI4 is position 10  in NVIC table
     *      EXIT6 is postion  23 (EXIT9_5 aka EXTI9 to EXTI5) in NVIC table
     */
    NVIC_ISER0 |= 1 << 10;                    // Enable NVIC interrupt set enable registers for EXTI1 line zero (PA1)
    NVIC_ISER0 |= (long int) 1 << 23;         // Enable NVIC interrupt set enable registers for EXTI6 PB6

    NVIC_ISER0 |= (uint32_t) 1 << 28;         // Enable NVIC interrupt enable for TIM2 global interrupt vector mapping 28


    /* IRQ Priority settings */
    // IRQ28 is for TIMR2 so 28. IPR calculation is <IRQ_position#> % 4 -> 28 % 4 = 7 R0
    // IPRx = 7; R0 = byte offset is 0 
    // 0 = highest priority, we want to make the timer a lower priority vs the button presses
    // NVIC_IPR7 |=  (long int) 0xFF << 0;

    // 10 % 4 = 2 R2; IPRx=2; offset=2=bit[23:16]
    // Set the priority of PA4 to 0xFF d255 the lowest priority level
    // This will allow the timer to keep counting even though button is held down
    // NVIC_IPR2 |= (long int) 0xFF << 16;



    // EXTI_IMR EXTI_EMR
    // set bit of the EXTI_SWIER

    GPIOD_ODR = 0xFFFF;                     
    GPIOE_ODR = 0x00 << 8;                     // PORT E only has a High bank
    

    /* Infinite loop - things to do in between interrupts */
    for (;;) {
        while( ( USART1_SR & (1 << 5)) == 0 ) {}        // Check RXNE not empty

        rx_buffer = USART1_DR;

        while ( (USART1_SR & (1 << 7 )) == 0) {}
        Delay_ms(10);
        USART1_DR = rx_buffer;

    }
}