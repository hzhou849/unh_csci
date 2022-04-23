//**************************************************************************************************
// Project 5 - Timers 
// Name: Howard Zhou
// Due Date: 04/18/2022
// Course: ELEC 6602 - Embedded Systems

// Description: 
//
//      This program toggles the LEDs on PORTD and PORTE by default every one second and starts
//      By prompting the user to press R or r key to adjust the time day to values of 1 to 4 seconds
//      Any other value will go back to the default of 1 second. To quit, press Q or q when prompted
//      at the options menu.
//      
//      *NOTE: Professor, I did code a reset sequence to re-sync the LEds and TIMER counter to 0
//             on every time change. 
//
//
//      Objective 1: Timer 1 is used to turn on and off LEDs conneted to PORTB and PORTC
//                   every 1,2,3 or 4 seconds. Timer 4 is used to turn on and off LEDs
//                   connected to PORTD and PORTE every 1,2,3 or 4 seconds. 
//
// 		Objective 2: Program will communicate with user via USART terminal in IDE
//                   Program will send message to user asking for # of seconds for timer1
//                   then timer 4, then configure the timers accordingly.
//                   Two seperate messages sent to terminal specifying the duration
//                   of on/off for each set of LEDs to confirm program has received
//                   the correct number/commands. The reply by the user must be displayed
//                   on the usart terminal. The default for any other answer will set the time
//                   to one second.
//                   
// 		Objective 3:  Program must examine the recieved characters from the USART terminal
//                    to see if char 'R' or 'r' is typed. If so, go back to step and prompt
//                    for user to enter time again. 
//                    If char Q/q is entered, then stop program and exit.
//                    any other character will have no effect on the flow of program execution.
//                    The tasks in step 3 can be done/checked while program is waiting to see
//                    when one of UIF bits is set.
//**************************************************************************************************
#include <stdint.h>

/* Constants */
static const uint8_t  TRUE           = 1;
static const uint8_t  FALSE          = 0;
static const uint8_t  NEW_LINE_EN    = 1;
static const uint8_t  NO_NEW_LINE    = 0;
static const uint32_t ASCII_HEX_O    = 0x30;
static const uint32_t CHAR_CR        = 0x0D;
static const uint32_t CHAR_LF        = 0x0A;
static const uint32_t GPIO_OUTPUT    = 0x33333333;     // CNF:output-push-pull 0x00; Mode:output 50MHz 0x11


/* Helper functions */


/// Takes the serial data recieved and convert the ascii to a useable interger
// Any value other than 1-4 will return default value of 1.
uint32_t serial_to_int(uint32_t *rx_buffer) {
    
    // if input buffer is between 0x30 and 0x34, integer [1:4] we know its an integer
    if ( (*rx_buffer >= ASCII_HEX_O) && (*rx_buffer <= 0x34) ) {     
        return (*rx_buffer - ASCII_HEX_O);
    }
    
    // Everything else default 1 second
    return 1;                                                        
}

/// Transmit/write out single character via USART
void write_data_char(uint32_t *tx_char, uint8_t new_line_opt) {
    
    // Wait for transmit data register to be empty
    while ( (USART1_SR & (1 << 7)) == 0 ) {}                        
    Delay_ms(10);                                                  
    USART1_DR = *tx_char;

    if (new_line_opt == 1) {
        Delay_ms(10);
        USART1_DR = CHAR_CR;
        Delay_ms(10);
        USART1_DR = CHAR_LF;
    } 
}

/// Converts string array and prints the string text
// This compiler handles write output as 32bit words, since c-compiler chars 
// are 8bits, we have to promote the data
void print_string(uint8_t *arr_string, uint8_t new_line_opt) {

    uint32_t i = 0;
    uint32_t buffer[64];

    while (arr_string[i] != '\0') {
        buffer[i] = (buffer[i] & (uint32_t) 0x00000000) | arr_string[i];
        write_data_char ( &buffer[i], new_line_opt);
        i++;
    }

    Delay_ms(10);
    USART1_DR = CHAR_CR;
    Delay_ms(10);
    USART1_DR = CHAR_LF;
}


// Convert an Integer number to ascii char and transmit it
void print_int(uint32_t *int_num) {
    
    uint32_t temp_val = (*int_num + ASCII_HEX_O);
    
    write_data_char(&temp_val, NO_NEW_LINE);

}

void main() {

    uint32_t sequence_count = 0;
    uint8_t ask_time_flag       = FALSE;
    uint8_t r_key_rcvd      = TRUE;



    uint32_t i=0;

    uint32_t tim1_multiplier = 1;
    uint32_t tim2_multiplier = 1;
    uint32_t rx_buffer;

    uint8_t title_divider[]  = "=============================================================";
    uint8_t start_prompt []  = "Press 'R or r' to start or 'Q q' to quit.";
    uint8_t tim1_prompt  []  = "Please enter delay time (1-4) for TIMER1: ";
    uint8_t tim2_prompt  []  = "Please enter delay time (1-4) for TIMER2: ";
    uint8_t title_cr_lf  []  = "\x0D\x0A";
    uint8_t tim1_info[]    = "TIMER1 delay seconds value: ";
    uint8_t tim2_info[]    = "TIMER2 delay seconds value:  ";
    uint8_t goodbye  []    = "TIMER 1 & 4 shutting off, goodbye!";



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

    /* Initialize GPIO & USART*/
    // GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_ALL);
    // GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_ALL);

    USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration


    RCC_APB2ENR |= 0x00000001;                  // Alt. function bit to enable USART1 PA9/PA10
    AFIO_MAPR    = 0x00000000;                  // Bit[2] USART1 REMAP 0: No Remap

    RCC_APB2ENR |= 1 << 2;                      // Enable GPIO Clock - Port A for USART1
    RCC_APB2ENR |= 1 << 3;                      // Enable GPIO Clock - Port B
    RCC_APB2ENR |= 1 << 4;                      // Enable GPIO Clock - Port C
    RCC_APB2ENR |= 1 << 5;                      // Enable GPIO Clock - Port D
    RCC_APB2ENR |= 1 << 6;                      // Enable GPIO Clock - Port E
    RCC_APB2ENR |= 1 << 14;                     // Enable USART1 Clock


    /* Configure port direction & flags */
    GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10->mask with  FFFF F00F
    GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AFoutput push-pull b10; MODE:50Hz
    GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=Input-floating b01; MODE: Input mode b00; 

    GPIOB_CRH = GPIO_OUTPUT;
    GPIOB_CRL = GPIO_OUTPUT;
    GPIOC_CRH = GPIO_OUTPUT;
    GPIOC_CRL = GPIO_OUTPUT;
    GPIOD_CRH = GPIO_OUTPUT;
    GPIOD_CRL = GPIO_OUTPUT;
    GPIOE_CRH = GPIO_OUTPUT;
    GPIOE_CRL = GPIO_OUTPUT;


    /* Configure Baudrate */
     USART1_BRR = 0x00000506;                   // Clock=72MHz, oversample=16x; 72MHz / (16 * 56,000) = 80.357
                                                // Mantissa=80=0x50; Fraction=(0.357 * 16) = 5.7 ~ 0x6; Baud reg= 0x506

    /* USART Control register configuration */
    USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
    USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
    USART1_CR1 &= ~(3 << 9);                    // Force no parity & no parity control
    USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
    USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
    USART1_CR1 |= (3 << 2);                     // Rx, Tx Enable
    Delay_ms(100);                              // Allow time for USART to complete initialization
    USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.


    /* Timer configuration */       
    RCC_APB2ENR |= (1 << 11);                   // Enable TIMER1 Clock
    RCC_APB1ENR |= (1 << 2);                    // Enable TIMER4 Clock
    

    // Disable timer until configuration is complete
    // If reset value of RCC_CFGR is used, then the 8MHz clock will
    // be the clock source for timer
    TIM1_CR1 = 0x0000;
    TIM4_CR1 = 0x0000;        


    // Freq_ck_psc = 72MHz
    // According to datasheet bits [15:0] so 0xABCD = 16bits;  timer_PSC= 7999+1 = 8000Hz or 8MHz 
    // Clock to TIMx_CNT = 72 000 000 (Clock applied to prescaler register) / 
    //                     7999 (Value in TIMx_PSC + 1) = 9000 number of clock cycles per second
    TIM1_PSC = 7999;
    TIM4_PSC = 7999;


    // Set the Reload timer count register with this value when count register resets
    // to 0 after counting from zero to this value 
    // This is the number clock cycles per second
    TIM1_ARR = ( (uint32_t)9000 * tim1_multiplier );
    TIM4_ARR = ( (uint32_t)9000 * tim2_multiplier );              // 2 seconds 

    TIM1_CR1 = 0x0001;                          // Finished configuration, now we can enable TIMER1; BIT4=0 couting up
    TIM4_CR1 = 0x0001;                          // Finished configuration, now we can enable TIMER4; BIT4=0 couting up

    // Set default LED states
    GPIOB_ODR = 0x0000;
    GPIOC_ODR = 0x0000;
    GPIOD_ODR = 0x0000;
    GPIOE_ODR = 0x0000;



    /* Main loop */
    for (;;) {

        // Print headers, putting this one first prevents other ones from prematurely executing
        if (ask_time_flag == FALSE ) {

            if ( sequence_count == 0) {
                print_string(title_cr_lf, NO_NEW_LINE);
                
                print_string(title_divider, NO_NEW_LINE);
                print_string(&start_prompt, NO_NEW_LINE);   // Print start prompt message
                // ask_time_flag = TRUE;
                r_key_rcvd = FALSE;
                sequence_count++;
            }
            else if ( sequence_count == 1  && r_key_rcvd == TRUE ) {
                print_string(title_cr_lf, NO_NEW_LINE);
                print_string(tim1_prompt, NO_NEW_LINE);
                ask_time_flag = TRUE;
            }
            else if (sequence_count == 2  && r_key_rcvd == TRUE ) {
                print_string(title_cr_lf, NO_NEW_LINE);
                print_string(tim2_prompt, NO_NEW_LINE);
                ask_time_flag = TRUE;
            }
        }

        // Processor spins too quickly and cannot register the button press
        // To remedy this, we will dedicate some cpu cycles to register button press
        // Dedicate a few cycle to check for input
        for (i=0; i < 10; i++) {

            if ( (USART1_SR & (1 << 5)) ) {
                rx_buffer = USART1_DR;
                
                while ( (USART1_SR & ( 1 << 7)) == 0 ) {}
                
                // If R=0x52; r=0x72, start the program to ask user for time and set timers.
                if (rx_buffer == 0x52 || rx_buffer == 0x72) {
                    r_key_rcvd = TRUE;

                }   // If Q=0x51; q=0x71, key pressed, quit.
                else if (rx_buffer == 0x51 || rx_buffer == 0x71) {
                    
                    // Turn off LEDs
                    GPIOB_ODR = 0x0000;
                    GPIOC_ODR = 0x0000;
                    GPIOD_ODR = 0x0000;
                    GPIOE_ODR = 0x0000;

                    RCC_APB2ENR |= ~(1 << 11);       // Disable TIMER1 Clock   
                    RCC_APB1ENR |= ~(1 << 2);        // Disable TIMER4 Clock   
                    
                    print_string(&goodbye, NO_NEW_LINE);

                    return; // Quit
                }

                // Filter out special un-seen ascii characters less than 0x20
                if (sequence_count == 1 && ask_time_flag == TRUE  && rx_buffer >=0x20) {

                    // Convert buffer timer multiplier value to an integer
                    tim1_multiplier = serial_to_int(&rx_buffer);

                    // Update the new TIMER1 delay
                    TIM1_ARR = (uint32_t)( 9000 * tim1_multiplier );
                    Delay_ms(100);
                    ask_time_flag = FALSE;
                    sequence_count++;
                    print_string(&tim1_info, NO_NEW_LINE);
                    print_int(&tim1_multiplier);

                }
                else if (sequence_count == 2 && ask_time_flag == TRUE) {

                    // Convert buffer timer multiplier value to an integer
                    tim2_multiplier = serial_to_int(&rx_buffer);

                    // Update the new TIMER1 delay
                    TIM4_ARR = ( (uint32_t)9000 * tim2_multiplier );
                    print_string(&tim2_info, NO_NEW_LINE);
                    print_int(&tim2_multiplier);

                    Delay_ms(100);
                    
                    // Reset the sequence
                    sequence_count = 0;
                    ask_time_flag = FALSE;
                    r_key_rcvd = FALSE;
                }
                    // print_string("RESETTING TIMERS COUNT")
                    // Reset the counter register and LEDs for TIMER1 and TIMER 4 to re-sync the timers
                    GPIOB_ODR = 0x0000;
                    GPIOC_ODR = 0x0000;
                    GPIOD_ODR = 0x0000;
                    GPIOE_ODR = 0x0000;
                    TIM1_CNT = 0;
                    TIM4_CNT = 0;

            }
        }

        // Checking timer status register to perfom an action (p570)
        // Wait until timer update flag is set, meaning the count val was reached.
        // while ( !TIM1_SR.UIF && !TIM4_SR.UIF ) {}   
        // If you have multiple timers, can use if to check status register
        if ( TIM1_SR.UIF == 1 ) {
            // Clear this flag which will reset the timer
            TIM1_SR.UIF = 0;
            GPIOB_ODR = ~GPIOB_ODR;
            GPIOC_ODR = ~GPIOC_ODR;


        } 
        if ( TIM4_SR.UIF == 1 ) {
            // Clear this flag which will reset the timer
            TIM4_SR.UIF = 0;
            GPIOD_ODR = ~GPIOD_ODR;
            GPIOE_ODR = ~GPIOE_ODR;
        } 
    }


}