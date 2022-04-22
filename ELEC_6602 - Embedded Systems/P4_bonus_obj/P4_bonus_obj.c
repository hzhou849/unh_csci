//**************************************************************************************************
// Project 4 - Serial Communication - BONUS OBJECTIVES
// Name: Howard Zhou
// Date: 04/07/2022
// Course: ELEC 6602/3371 Embedded Systems

// Description:             BONUS OBJECTIVES - Enter up to 23 alphabet characters into the serial
//                          terminal. Then the terminal will return a tally count of each 
//                          individual character as well as a total count of Uppcase, lowercase 
//                          alphabets and non-alphabet characters used. 
//                          *Special characters that are invisible (<0x1F range) will be ignored.
//---------------------------------------------------------------------------------------------------
//		BONUS Objective 1:  Write a program to send a message to the USART terminal asking the 
//                          user to enter characters of the alphabet. After receiving 23 alphabet 
//                          characters, the program must send the number of each character that 
//                          has been received to the USART terminal. Uppercase and lowercase must 
//                          be supported separately. 
//                          
//                            - The number of non-alphabet characters must 
//                          also be displayed, but not part of the 23 alphabet characters. 
//                          The total number of characters for upper case, lower case, and 
//                          non-alphabet characters must be displayed.
//
// 		BONUS Objective 2:  LEDs on the lower half of PORTD must display the number of lower-case 
//                          characters. LEDs on the upper half of PORTD must display the number 
//                          of upper-case letters. LEDs on the upper half of PORTE must display 
//                          the number of non-alphabet letters. Use PA0 to reset the LEDs and 
//                          initiate the next cycle. That is to say after 23 alphabet characters 
//                          have been pressed and the LEDs display the lower/upper and non-alphabet 
//                          values, the program will reset, turn all LEDs off, and prompt the user 
//                          to enter characters again after PA0 is pressed. This process must repeat 
//                          indefinitely.
//**************************************************************************************************
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>


/* Constants */
static const uint8_t FALSE        = 0;
static const uint8_t TRUE         = 1;
static const uint8_t NO_NEW_LINE  = 0;
static const uint8_t NEW_LINE_EN  = 1;
static const uint32_t ASCII_HEX_0 = 0x30;
static const uint32_t CHAR_CR	  = 0x0D;
static const uint32_t CHAR_LF	  = 0x0A;

static const uint32_t GPIO_OUTPUT 	= 0x33333333; // CNF output-push-pull 0x00; Mode output 50MHz 0x11;
static const uint32_t GPIO_INPUT 	= 0x44444444; // CNF INPUT 0x??; Mode INPUT 0x??;
static const uint32_t NULL_BYTE		= 0x00000000;

static const uint32_t MAX_BUFFER_SIZE = 64;
static const uint32_t MAX_ALPHABET_COUNT = 23;

// arr_tally[] address location map:
static const uint32_t tally_upper     = 0;
static const uint32_t tally_lower     = 1;
static const uint32_t tally_non_alpha = 2;
static const uint32_t tally_alpha     = 3;


///===================================================================================================
/* Helper Functions */

/// Read the incoming serial data 
void read_data(uint32_t *rx_buffer) {
	// Check the status register USART_SR bit[5] RXNE - read data reg not empty
	// while RXNE bit is 0 and not 1
	while( (USART1_SR & (1 << 5)) == 0 ) {}		// Positive logic

	// Data is available in the read register for retreival.
	*rx_buffer = USART1_DR;

	// While TXE bit[7] Transmit data register empty is not empty, wait until bit[7] == 1
	while ( (USART1_SR & (1 << 7)) == 0) {}
	Delay_ms(10);
}

/// Transmit/write out a single character via USART
void write_data_char(uint32_t *tx_char, uint8_t new_line) {
	
	// Wait for Transmit data register to be empty
	while ( (USART1_SR & (1 << 7)) == 0) {} 

	// Transmit data out via USART, same data register is used
	Delay_ms(10);
	USART1_DR = *tx_char;			

	// Write a Carriage Return and LineFeed 
	if (new_line == 1) {
		Delay_ms(10);
		USART1_DR = CHAR_CR;			
		Delay_ms(10);
		USART1_DR = CHAR_LF;
	}
} 


/// Transmit/write array buffer
void write_data(uint32_t *arr_buffer, uint8_t new_line_opt) {
	uint32_t i = 0;

	while ( (arr_buffer[i] != '\0') && (i < MAX_BUFFER_SIZE) ) {
		write_data_char(&arr_buffer[i], new_line_opt);
		++i;
	}
	
	// Write a Carriage Return & Line Feed after buffer is dumped
	Delay_ms(10);
	USART1_DR = CHAR_CR;			
	Delay_ms(10);
	USART1_DR = CHAR_LF;
}


/// Update the LEDs to display a number
void update_led(uint32_t counter) { 
	GPIOD_ODR = (counter << 8);
	Delay_ms(100);
}


/// Convert and print string text
// This compiler handles write outputs as 32bit words, since c-compiler chars are 8bit, we have to promote the data
void print_string(uint8_t *arr_string, uint8_t new_line_opt) {
    uint32_t i = 0;
    uint32_t buffer[64];

    while (arr_string[i] != '\0'){
        buffer[i] = (buffer[i] & 0x00000000) | arr_string[i];
        write_data_char(&buffer[i], NO_NEW_LINE);
        i++;
    }

    // Write carriage return and line feed
    if (new_line_opt == NEW_LINE_EN) {
        Delay_ms(10);
        USART1_DR = CHAR_CR;
        Delay_ms(10);
        USART1_DR = CHAR_LF;
    }
}


/// Converts decimal integer number to ascii char and sets the msb and lsb values
void convert_to_ascii(const int32_t *input_dec, uint32_t *ascii_msb, uint32_t *ascii_lsb) {

    // set the default values to 0
    uint32_t temp_val = 0;
    *ascii_msb = 0;
    *ascii_lsb = 0;

    // Max count is the max number of data in the array, exit if over.
    if (*input_dec > MAX_BUFFER_SIZE) {
        return;
    }

    // Extract the MSB, convert and set MSB pointer
    temp_val = *input_dec;
    while (temp_val >= 10) {
        temp_val /= 10;
        *ascii_msb = temp_val + ASCII_HEX_0;
    }

    // Extract the LSB, convert and set LSB pointer
    if (*input_dec > 0) {
        temp_val = (*input_dec % 10);
        *ascii_lsb = temp_val + ASCII_HEX_0; 
    }
}


/// Quicksort algorithm - Ascending order; makes tally easier if sorted
int q_sort(uint32_t *arr_list, int32_t *pivot_pos, uint32_t *min_pos) {
	int32_t right_cur  = (*pivot_pos-1);
	int32_t left_found = 0;
	uint32_t pivot_val = arr_list[*pivot_pos];
	uint32_t temp_val  = 0;
	uint32_t left_cur  = 0;
	uint32_t right_found = 0;

	// Search left 
	while (left_found == 0) {
		// if the left_cur reached pivot, that means pivot is the largest number
		if (left_cur == *pivot_pos) {
			left_found = 1;

			// Pivot is the largest# and sorted, move new to new pivot_pos-1
			--(*pivot_pos);

			// If list is sorted
			if ( (*pivot_pos) <= 0) {
				return 0;
			}
			else {
				// Run sort on the subset of unsorted numbers
				return q_sort(arr_list, pivot_pos, min_pos);
			}
		}
		//We found out Left value
		else if ( (arr_list[left_cur]) > (arr_list[*pivot_pos]) ) {
			left_found = 1;
		}
		else {
			++left_cur;
		}
	}

	// Search right side
	while (right_found == 0) {
		// If right cursor reaches 0, pivot is the smallest number
		if ( (right_cur == *min_pos) && (arr_list[right_cur]) >= (arr_list[*pivot_pos]) ) {
			right_found = 1;

			// Swap Lval with Pivot
			temp_val = arr_list[left_cur];
			arr_list[left_cur] = arr_list[*pivot_pos];
			arr_list[*pivot_pos] = temp_val;

			// update the min_pos
			*min_pos = left_cur;

			return q_sort( arr_list, pivot_pos, min_pos );
		} 
		else if ( (arr_list[right_cur]) <= (arr_list[*pivot_pos]) ) {
			right_found =1;
		}
		else {
			--right_cur;
		}
	}

	// If either cursor has passed each other during their search, 
	// means no number smaller than pivot and swap with Lval for its correct position
	if (right_cur < left_cur) {
		temp_val = arr_list[left_cur];
		arr_list[left_cur] = arr_list[*pivot_pos];
		arr_list[*pivot_pos] = temp_val;
		*min_pos = 0; 
	}
	// We have a proper Lval and Rval, swap them
	else {
		temp_val = arr_list[left_cur];
		arr_list[left_cur] = arr_list[right_cur];
		arr_list[right_cur] = temp_val;
	}

	if (*pivot_pos == 0) {
		return 0;
	}
	else {
		return q_sort(arr_list, pivot_pos, min_pos);
	}
}


/// Tally a pre-sorted list
// Array is [char0, tally0, char1, tally1...char_n, tally_n]
tally(uint32_t *arr_tally, uint32_t size) {

    uint8_t str_colon[] = " : ";
    uint8_t first_run = TRUE;
    uint32_t tally_list[64];
    uint32_t i = 0;
    uint32_t char_pos     = 0;
    uint32_t tally_pos    = 1;
    uint32_t tally_count  = 0;
    uint32_t current_char = 0;
    uint32_t prev_char    = 0;
    uint32_t ascii_msb    = 0;
    uint32_t ascii_lsb    = 0;


    while (i <= size) {

        current_char = arr_tally[i];
        
        if (prev_char == current_char) {
            tally_pos = char_pos + 1;
            tally_list[tally_pos] = ++tally_count;
        } 
        // Check if character has been logged before, if not assign it, don't increment on first run
        else if ( tally_list[char_pos] != current_char) {
            
            // Reset the character tally count to zero
            tally_count = 0;

            if (first_run == TRUE ) {
                tally_list[char_pos] = current_char;
                tally_list[tally_pos] = ++tally_count;
                first_run = FALSE;
            }
            else {
                // Print the character and tally value
                write_data_char(&tally_list[char_pos], NO_NEW_LINE);
                print_string(&str_colon, NO_NEW_LINE);
                convert_to_ascii(&tally_list[tally_pos], &ascii_msb, &ascii_lsb);
                write_data_char(&ascii_msb, NO_NEW_LINE);
                write_data_char(&ascii_lsb, NEW_LINE_EN);

                char_pos +=2;
                tally_list[char_pos] = current_char;
                tally_list[tally_pos] = ++tally_count;
            }
        }  
        prev_char = current_char;
        i++;
    } 
}


///===================================================================================================
/* Main Function */
void main() {

    /* Local Variables */
    uint8_t  loop_on          = TRUE; 
    uint32_t char_counter     = 0;
    uint32_t pivot_pos        = 0;
    uint32_t min_pos          = 0;
    uint32_t rx_buffer[64];
    uint32_t arr_tally[4];
    uint32_t ascii_lsb;
    uint32_t ascii_msb;
    uint32_t list_size = 0;
    
    
    /* Title/Headers strings */
    uint8_t title_divider[]   = "=============================================================";
    uint8_t title_cr_lf[]     = "\x0D\x0A";
    uint8_t title_prompt[]    = "[P4 BONUS] - Please enter up to 23 alphabets to complete sequence:  ";
    uint8_t title_upper[]     = "Upper case: ";
    uint8_t title_lower[]     = "Lower case: ";
    uint8_t title_non_alpha[] = "Non-alphabet: ";
    uint8_t str_tally[]       = "Tally: ";



    /* Initialization */

    /// Configure clock for 72MHz
    // Enables PLL and PLL2 and 8MHz trimming
    RCC_CR = 0x05010081;    
    
    // Sets multiplication factor for PLL to 9, selects diviion factor for clock from PREDIV1 selected
    // as PLL input clock, sets division factor of APB Low speed clock (PCLK1) to 2, no SYSCLK division, select
    // PLL as SYSCLK
    RCC_CFGR = 0x001D8402;

    // Selects PLL2 as PREDIV1SRC:PREDIV1 entry clock source, set PREDV1 to b0100 to divide 25MHz clock by 5MHz
    // to set PLL2 entry to 5MHz. Sets PLL2 multiplication factor to 8 to produce 40MHz clock entry to PLL.
    // PLL uses PREDIV1 to divide this clock to 8MHz and use the multiplication factor to generate 72MHz for
    // SYS Clock   
    RCC_CFGR2 = 0x00010644;

    /// Initialize USART and GPIO
    RCC_APB2ENR |= 0x00000001; 	// Alternate function bit AFIOEN bit[0]. USART1 uses AF for PA9/PA10
	AFIO_MAPR    = 0x00000000; 	// Bit[2] USART1 REMAP 0: No Remap (Tx=PA9; Rx=PA10) 

	RCC_APB2ENR |= 1 << 2;		// Enable GPIO Clock - Port A for USART Pins
	RCC_APB2ENR |= 1 << 5;		// Enable GPIO Clock - Port D for LEDs
	RCC_APB2ENR |= 1 << 14; 	// Enable USART1 Clock 

	GPIOA_CRH &= ~(0xFF << 4);  // Shift 4 bits left to clear bits[9:4] for PA9/PA10 0000 0FF0 -> mask with  FFFF F00F
	GPIOA_CRH |= (0x0B << 4) ;  // USART1 Tx/PA9 set to CNF=AFoutput push-pull b10; MODE= output-50Hz b11;
	GPIOA_CRH |= (0x04 << 8);   // USART1 Rx/PA10 set CNF=Input-floating b01; MODE=Input mode b00;
    GPIOA_CRL |= (0x00000004);  // Set PA0 to input
	GPIOD_CRH = GPIO_OUTPUT;    // Set Port D High bank to GPIO output
    GPIOD_CRL = GPIO_OUTPUT;    // Set Port D Low bank to GPIO output

	/* Configure Baudrate */
	// Clock=72MHz, oversample=16x; 72MHZ/ (16 * 56,000) = 80.357 
	// Mantissa = 80 = 0x50; Fraction = (0.357 * 16) = 5.7 ~ 0x6; Baud Reg value = 0x506
	USART1_BRR = 0x00000506;

	/* USART Control Register configuration */
	// Reset state is 0x0000
	// Per data sheet (pg. 814 STM32_RefManual) USART1_CR1 consists of the following:
	// 13 12   11  10  9    8     7    6      5      4  3  2   1   0
	// UE  M WAKE PCE PS PEIE TXEIE TCIE RXNEIE IDLEIE TE RE RWU SBK
	// 0   0       0   0    0     0   0      0       0  1  1   0   0
	// USART1_CR1 = 0x000C;
	// or we can set each bit individually with masks
	USART1_CR1 &= ~(1<<12);          // Force 8 data bits. M bit is set to 0.
	USART1_CR2 &= ~(3<<12);          // Force 1 stop bit
	USART1_CR3 &= ~(3<<8);           // Force no flow control and no DMA for USART1
	USART1_CR1 &= ~(3<<9);           // Force no parity and no parity control
	USART1_CR1 |= 3<<2;              // RX, TX enable
    Delay_ms(100);					// Allow some time for USART to complete initialization.
	USART1_CR1 |= 1 << 13;			//** NOTE USART1 Enable must be done after configuration is complete

    /* Main loop */
    for (;;) {

        // Zero out tally counts
        arr_tally[tally_upper] = 0;
        arr_tally[tally_lower] = 0;
        arr_tally[tally_non_alpha] = 0;
        arr_tally[tally_alpha] = 0;

        // Print prompt
        print_string(&title_cr_lf, NEW_LINE_EN);
        print_string(&title_divider, NEW_LINE_EN);
        print_string(&title_prompt, NEW_LINE_EN);

        // Loop to capture data input from the user and filter NULL_BYTE.
		// NOTE: Connecting/disconnecting USART cable will cause the RX buffer to receive junk data(NULL_BYTE)
        while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
            read_data( &rx_buffer[char_counter] ); 

            if ( (rx_buffer[char_counter] > 0x1F) && (rx_buffer[char_counter != NULL_BYTE]) ) {
                // Symbols, numbers range: 0x20 to 0x40; 0x5B to 0x60; 0x7B to 0x7F
                // Uppercase range: ascii 0x41 to 0x5A
                // Lowercase range: ascii 0x61 to 0x7A

                // If Uppercase
                if ( (rx_buffer[char_counter] >= 0x41) && (rx_buffer[char_counter] <= 0x5A) ) {
                    arr_tally[tally_upper]++;
                    arr_tally[tally_alpha]++;
                }  // If Lowercase
                else if ( (rx_buffer[char_counter] >= 0x61) && (rx_buffer[char_counter] <= 0x7A) ) {
                    arr_tally[tally_lower]++;
                    arr_tally[tally_alpha]++;
                }  // else non-alpha, range is specifed to avoid unseen special characters    
                else if ( (rx_buffer[char_counter] >=0x20) || (rx_buffer[char_counter] <=0x40) 
                            || (rx_buffer[char_counter] >=0x5B) || (rx_buffer[char_counter] <= 0x60) 
                            || (rx_buffer[char_counter] >=0x7B) || (rx_buffer[char_counter] <= 0x7F)) {
                    
                    arr_tally[tally_non_alpha]++;
                }

                // Increment the actual counter of receved chars
                char_counter++;

                // Finish is we have 23 Alphabits add NULL Terminator for parsing later
                if ( arr_tally[tally_alpha] >= MAX_ALPHABET_COUNT) {
                    loop_on = FALSE;
                    rx_buffer[char_counter] = '\0'; 
                }
            }
        }

        // backup the char_counter number, so we don't lose this number during sorting 
        // Qsort recursive algorithm will require this pointer to be altered.
        list_size = char_counter;

        // Dump the contents of the buffer
        write_data(&rx_buffer, NO_NEW_LINE);

        // Sort the data buffer to make counting the characters easier
        pivot_pos = (char_counter - 1);
        q_sort (&rx_buffer, &pivot_pos, &min_pos); 
        write_data(&rx_buffer, NO_NEW_LINE);

        // Tally the characters
        print_string(title_cr_lf, NO_NEW_LINE);
        print_string(&str_tally, NEW_LINE_EN);
        tally(&rx_buffer, char_counter);

        // Print the uppercase count
        print_string(&title_cr_lf, NO_NEW_LINE);
        print_string(&title_upper, NO_NEW_LINE);
        convert_to_ascii(&arr_tally[tally_upper], &ascii_msb, &ascii_lsb);
        write_data_char(&ascii_msb, NO_NEW_LINE);
        write_data_char(&ascii_lsb, NEW_LINE_EN);
        
        // Print lowercase count
        print_string(&title_lower, NO_NEW_LINE);
        convert_to_ascii(&arr_tally[tally_lower], &ascii_msb, &ascii_lsb);
        write_data_char(&ascii_msb, NO_NEW_LINE);
        write_data_char(&ascii_lsb, NEW_LINE_EN);

        // Print non-alpha count
        print_string(&title_non_alpha, NO_NEW_LINE);
        convert_to_ascii(&arr_tally[tally_non_alpha], &ascii_msb, &ascii_lsb);
        write_data_char(&ascii_msb, NO_NEW_LINE);
        write_data_char(&ascii_lsb, NEW_LINE_EN);

        // Reset for next cycle
        loop_on = TRUE;
        char_counter = 0;
    }
}