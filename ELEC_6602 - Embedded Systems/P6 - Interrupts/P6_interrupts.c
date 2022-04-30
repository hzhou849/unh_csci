//**************************************************************************************************
// Project 6 - Interrupts
// Name: Howard Zhou
// Due Date: 05/2/2022
// Course: ELEC 6602 - Embedded Systems

// Description: 
//                  Program demonstrates uses of External interrupts PA4 and PA6.
//                  and internal software(SWIER) and TIMER2 interrupts.
//                  PORTD/H LEDs will display counter every 1 sec and can be paused/resumed with PA4
//                  Pressing PB6 will display the current count on the Terminal window.
//                  Keyboard input from the terminal window will increase the count displyed on
//                  PORTE LEDS. A seperate software interrupt will blink the LEDs on PORTD/L
//                  Independantly.
//      
//      Objective 1: - Use Timer 2, PA4 and PA6 on interrupt
//                   - Timer 2 will display the time every 1 second on PORTD/H 
//                     starting at 99, counting down to zero and restart.
//
//      Objective 2: - Every time PA4 is pressed for the first time, timer must stop.
//                   - When pressed a second time, it must start again.
//  
//      Objective 3: - When PB6 is released time must be displayed on USART Terminal (limit 00 to 99)
//                   - THe main program increments the value on PORTR every time a char
//                     is typed on USART terminal and sends the character back to 
//                     the USART terminal.
//
//      Bonus Obj:     Write and additional ISR to blink an LED at a specified frequency.
//**************************************************************************************************
#include <stdint.h>

/* You can redefine special registers like this */
sfr uint32_t volatile*  GPIO_TEST = 0x4001140C;

/* Constants */
static const uint8_t  NO_NEW_LINE               = 0;
static const uint8_t  NEW_LINE_EN               = 1; 
static const uint32_t TIMER_COUNTER_MAX         = 99;
static const uint32_t ASCII_READABLE_CHAR_START = 0x20;
static const uint32_t ASCII_HEX_0               = 0x30;
static const uint32_t CHAR_CR                   = 0x0D;
static const uint32_t CHAR_LF                   = 0x0A;
static const uint32_t SW_INT_DELAY_MS           = 250;

/* Globals */
static volatile uint32_t time_count             = 0;
static volatile uint32_t timer_run_flag         = 1;
static volatile uint32_t usart_count            = 0;
volatile uint32_t rx_buffer;

void convert_int(uint32_t *temp_val);
void write_data_char(uint32_t *tx_char, uint8_t new_line);


//===========================================================================================
/* Interrupt service routines - For external push button interrupt */

/// PB6 Button Interrupt Handler
void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
    
    uint32_t temp_val;

    EXTI_PR.B6 = 1;                                     // Clear pending regsiter interrupt flag for PB6
                                                        // 1 = slected trigger request has occured
    // EXTI_PR |= 1 << 6;                               // PB6 = PR6 Bit
    while (GPIOB_IDR.B6 == 1) {}                        // Wait here until button release

    /* Update LEDs Test*/
    // GPIOE_ODR = ( (time_count-1) << 8) & 0xFF00;     // Update the LEDs on PORTE/H (shift 8 LEDs)
    //                                                  // Subtract one so PortE is not ahead of PortDs
    // usart_count = time_count;                        // Update the USART counter for key presses for PortE for USART1 ISR
    //                                                  // Increment the usart char counter so on next button press, the character
    //                                                  // is not the same number as the timer clock and actually increment the LED 
    temp_val = time_count-1;                            // Subtract 1 because the value timecount will be incremented in TIMER function before next use
    convert_int(&temp_val);
}

/// PA4 Button Interrupt Handler
void EXTIPA4() iv IVT_INT_EXTI4 ics ICS_AUTO {
    EXTI_PR.PA4 = 1;                                    // Clear interrupt pending regsiter
    
    while (GPIOA_IDR.B4 == 1) {}                        // Hold here until button is released
    timer_run_flag = ~timer_run_flag;                   // Flip the flag switch to toggle the timer counter on PORTD

}

/// TIMER 2 Interrupt Handler
void TIMER2_ISR() iv IVT_INT_TIM2 {
    
    TIM2_SR &=  ~(1 << 0);                              // Bit[0] = UIF update intrpt flag. 1 to reset

    if (timer_run_flag == 1) {
        GPIOD_ODR &= 0x00FF;                            // Wipe previous value 
        GPIOD_ODR |= ((time_count++) << 8) & 0xFF00;    // Pass the current timer value (shift 8 for High bank) then increment
   
        if (time_count > TIMER_COUNTER_MAX ) {
            time_count = 0;
        }
    }
}

/// USART1 Rx Interrupt Handler
void USART1_ISR() iv IVT_INT_USART1 {
    
    rx_buffer = USART1_DR;                          // RXNE bit interrupt is reset by reading data register
                                                    // Required to arm the ISR again.

    while ( (USART1_SR & (1 << 7 )) == 0) {}
    Delay_ms(10);                                   
    USART1_DR = rx_buffer;
    Delay_ms(10);

  
    if (rx_buffer >= ASCII_READABLE_CHAR_START) {     // ASCII characters that are not special/invisible
        GPIOE_ODR = (++usart_count) << 8;
    }
}

/// Software Interrupt iv IVT_INT_EXTI4 ics ICS_AUTO; IVT name is from NVIC table
void MY_SWIER_ISR() iv IVT_INT_EXTI15_10 {
    Delay_ms(SW_INT_DELAY_MS);
    EXTI_PR |= 1 << 15;                             // Clear the interrupt pending register.
    GPIOD_ODR = (GPIOD_ODR & 0xFF00)  + ( (~GPIOD_ODR) & 0x00FF);
}



//===========================================================================================
/* Helper Functions */

/// Initial the clock to 72MHz
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

/// Convert an integer number to ascii char and transmit it
void convert_int(uint32_t *int_num) {

    uint32_t temp_val  = 0;
    uint32_t ascii_msb = 0;
    uint32_t ascii_lsb = 0;
    uint32_t new_line_LF = 0xA;

    // Number is ranged from 0-99, quit if larger
    if (*int_num > TIMER_COUNTER_MAX ) {
        return;
    }
   
    // Extract the MSB, convert to ASCII
    temp_val = *int_num;
    while (temp_val >= 10) {
        temp_val /= 10;
        ascii_msb = temp_val + ASCII_HEX_0;;
    }

     // Extract the LSB, convert and set the LSB
    if ( *int_num > 0 ) {                      
        temp_val = (*int_num %10);
        ascii_lsb = temp_val + ASCII_HEX_0;
    }

    Write_data_char (&new_line_LF, NO_NEW_LINE);
    write_data_char (&ascii_msb, NO_NEW_LINE);
    write_data_char (&ascii_lsb, NEW_LINE_EN);
}


/// Printout char to terminal
void write_data_char(uint32_t *tx_char, uint8_t new_line) {

    uint32_t *tx_var;
    
    // Extract the MSB, conver the MSB
    while( (USART1_SR & (1 << 7)) == 0) {}      

    Delay_ms(10);
    USART1_DR = *tx_char;

    if (new_line == NEW_LINE_EN) {
        Delay_ms(10);
        USART1_DR = CHAR_CR;
        Delay_ms(10);
        USART1_DR = CHAR_LF;
    } 
}

/// Main driver function
void main() {

    /* Initialize Clock for 72MHz */
    initClock72MHz();

    /* Initialize GPIO & USART */
    USART1_CR1 &= ~(1 << 13);                  // Diasable USART for configuration

    AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
    RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1


    RCC_APB2ENR |= 1 << 2;                     // Enable GPIO Clock PORT A  Interrupt test
    RCC_APB2ENR |= 1 << 3;                     // Enable GPIO Clock PORT B 
    RCC_APB2ENR |= 1 << 5;                     // Enable GPIO Clock PORT D 
    RCC_APB2ENR |= 1 << 6;                     // Enable GPIO Clock PORT E 
    RCC_APB2ENR |= 1 << 14;                    // Enable USART1 Clock for USART and


    /* Configure port direction & flags */
    GPIOA_CRH &= ~(0xFF << 4);                 // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
    GPIOA_CRH |=  (0x0B << 4);                 // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
    GPIOA_CRH |=  (0x04 << 8);                 // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04

    GPIOA_CRL |=  0x44444444 << 16;            // PA1 input CNF=input-floating b01; MODE: input b00 = 0x0100;
    GPIOB_CRL |= (uint32_t) (0x04 << 24);      // PB6 input CNF=input-floating b01; MODE: input b00 = 0x0100;

    GPIOD_CRL = 0x33333333;                    // PD0:7   CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
    GPIOD_CRH = 0x33333333;                    // PD8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
    GPIOE_CRH = 0x33333333;                    // PE8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;


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


    /* TIMER2 setup configuration */
    RCC_APB1ENR |= 1 << 0;                     // Enable TIMER2 Clock;
                                               // If reset value of RCC_CFGR is used, then the 8MHz clock will
                                               // be the clock source for timer

    TIM2_CR1 = 0x0000;                         // Disable the timer for config/setup

    TIM2_PSC = 7999;                           // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1)    
                                               // We want 72MHz / (7999+1) = 9000 # clk cycles/sec

    TIM2_ARR = 9000;                           // Set the auto-reload register to the value calculated above

    TIM2_DIER |= 1 << 0;                       // Allow timer Update interrupt enable

    TIM2_CR1 = 0x0001;                         // After timer setup, enable TIMER2 bit[1]; bit[4]=0 counting up.            



    /* Interrupt setup and configuration */
    AFIO_EXTICR2 |= 0x00000000;                // PA4 as External interrupt; Pin4/EXTI4[3:0] PortA=b0000
    AFIO_EXTICR2 |= 0x00000100;                // PB6 as Enternal interrupt; Pin6/EXTI6[3:0] PortB=b0001 

    EXTI_RTSR    |= 1 << 4;                    // Set Edge trigger register for interrupt on rising edge for PA4 and PB6                  
    EXTI_RTSR    |= 1 << 6;                    // Mask to enable TR6 and TR4 (EXTI6 and EXTI4) b1=rising trigger enabled
    EXTI_IMR     |= 0x00000050;                // Set interrupt request from TR6 and TR4 to not masked (cpu CANNOT ignore it)



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
     * 
     * ISER0 = IRQ 0-31
     * ISER1 = IRQ 32-63
     * ISER2 = IRQ 64-67
     */
    NVIC_ISER0 |= 1 << 10;                    // Enable NVIC interrupt set enable registers for EXTI1 line zero (PA1)
    NVIC_ISER0 |= (long int) 1 << 23;         // Enable NVIC interrupt set enable registers for EXTI6 PB6
    NVIC_ISER0 |= (uint32_t) 1 << 28;         // Enable NVIC interrupt enable for TIM2 global interrupt vector mapping 28
    NVIC_ISER1   |= 1 << 5;                    // USART1: ISER1 interrupts vector: vector IRQ37 = ISER1; #63-32; 32+5 =37

    /* Software Interrupt SWIER Configuration */
    EXTI_IMR |= 1 << 10;                       // Interrupt mask register - not masked; cpu cannot ignore this IRQ
    NVIC_ISER1.B8 = 1;                         // EXTI-15_10 is position 40 on NVIC table ISER1 63:32 bit[0] is 
                                               // position 32 so  positon40 is bit 8  NVIC

    /* TIMER2 IRQ Priority settings */
    // IRQ28 is for TIMR2 so 28. IPR calculation is <IRQ_position#> % 4 -> 28 % 4 = 7 R0
    // IPRx = 7; R0 = byte offset is 0 
    // 0 = highest priority, we want to make the timer a lower priority vs the button presses
    // NVIC_IPR7 |=  (long int) 0xFF << 0;

    /* PA4 IRQ Priority settings */
    // 10 % 4 = 2 R2; IPRx=2; offset=2=bit[23:16]
    // Set the priority of PA4 to 0xFF d255 the lowest priority level
    // This will allow the timer to keep counting even though button is held down
    // NVIC_IPR2 |= (long int) 0xFF << 16;

    /* SWEIR IRQ Priority settings */
    // Software IRQ = 40 = 40 %4 = 10 R2; IPRx=10; offset=0 bit[7:0] for priority FF=255
    // Priority lowered to not interfere with USART1 interrupt on keyboard input. 
    NVIC_IPR10 |= 0xFF << 0;

    
    // Clear the data register to initialize it.
    rx_buffer = USART1_DR;

    /* Infinite loop - things to do in between interrupts */
    for (;;) {

        // Utilize Software Interrupt ISR
        if  (EXTI_SWIER.B10 != 1) {
            EXTI_SWIER |= 1 << 10;              // ENable SWIER_EXTI line 10 trigger to blink PORTD/L LEDs on differnt interval
        }
        Delay_ms(1);
    }
}