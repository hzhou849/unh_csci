//**************************************************************************************************
// Project 4 - Serial Communication
// Name: Howard Zhou
// Date: 04/07/9993
// Course: ELEC 6602/3371 Embedded Systems

// Description: 
//		Objective 1: Write a program which communicates with the USART terminal using a baud rate of 
//					 56,000. The program should accept up to 50 single characters from the USART 
//					 terminal until '@' button is pressed. Each character must be displayed on one 
//					 line (sending CR (carriage return) and LF (line feed) after every character 
//					 can do this for you.
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
#include <stdio.h>
#include <stdint.h>
// #include <string.h> 

/// Constants
static const uint32_t EXIT_CHAR 	 = 0x40; // '@'
static const uint32_t TRUE			 = 1;
static const uint32_t FALSE			 = 0;
static const uint32_t MAX_BUFFER_SIZE = 50;
static const uint32_t GPIO_OUTPUT 	= 0x33333333; // CNF output-push-pull 0x00; Mode output 50MHz 0x11;
static const uint32_t CHAR_CR		= 0x0D;
static const uint32_t CHAR_LF		= 0x0A;
static const uint8_t  NO_NEW_LINE 	= 0;
static const uint8_t  NEW_LINE_EN	= 1;
static const uint32_t LED_RESET		= 0;
static const uint32_t ASCII_HEX_0   = 0x30;
int32_t list_len=0;

///================================================================================================================
/// Helper Functions

// Read the incoming serial data 
void read_data(uint32_t *rx_buffer){
	// Check the status register USART_SR bit[5] RXNE - read data reg not empty
	// while RXNE bit is 0 and not 1
	// while (!((USART1_SR & (1<<5))== 0x20)){} // Check RXNE in USART1 Status Register. Negative logic
	while( (USART1_SR & (1 << 5)) == 0 ) {}		// Positive logic

	// // Data is available in the read register for us to retrieve it.
	*rx_buffer = USART1_DR;				// read data from receiver data register

	// While TXE bit[7] Transmit data register empty is not empty, wait until bit[7] == 1
	// Stay in this loop until the Transfer data register finishes transfering to shift register 
	// while ( ! (USART1_SR & (1 << 7)) == 0x80) {}
	while ( (USART1_SR & (1 << 7)) == 0) {}
	Delay_ms(100);
}

// Transmit/write out a single character via USART
void write_data_char(uint32_t *tx_char, uint8_t new_line){

	uint32_t tx_var = *tx_char;
	while ( (USART1_SR & (1 << 7)) == 0) {} // Wait for Transmit data register to be empty

	Delay_ms(100);
	USART1_DR = *tx_char;			// Transmit data out via USART, same data register is used
	// Delay_ms(100);
	// while ( (USART1_SR & (1 << 7)) == 0) {} 

	if (new_line == 1) {
		Delay_ms(100);
		USART1_DR = CHAR_CR;			// Write a Carriage Return 
		Delay_ms(100);
		USART1_DR = CHAR_LF;			// Write a Line Feed
	}
} 

// Transmit/write array buffer
void write_data(uint32_t *arr_buffer) {
	uint32_t i = 0;

	while (arr_buffer[i] != EXIT_CHAR) {
		write_data_char(&arr_buffer[i], NEW_LINE_EN);
		++i;
	}
	Delay_ms(100);
	USART1_DR = CHAR_CR;			// Write a Carriage Return 
	Delay_ms(100);
	USART1_DR = CHAR_LF;			// Write a Line Fee
}

// // Print a list in descending order
// void write_data_reversed(uint32_t *arr_buffer, int32_t list_len) {
	
// 	int32_t i = 0;

// 	for ( i=list_len; i >= 0; i--) {
// 		write_data_char(&arr_buffer[i], NEW_LINE_EN);
// 	}

// 	Delay_ms(100);
// 	USART1_DR = CHAR_CR;			// Write a Carriage Return 
// 	Delay_ms(100);
// 	USART1_DR = CHAR_LF;			// Write a Line Fee
// }

// Update the LEDs to display a number
void update_led(uint32_t counter) { 
	GPIOD_ODR = (counter << 8);
	Delay_ms(100);
}

// Wipe an array buffer
void clear_buffer(uint32_t *arr_buffer, uint32_t size) {
	uint32_t i = 0;

	for (i=0; i < size; i++) {
		if (arr_buffer[i] != 0 ) {
			arr_buffer[i] = 0;
		}
	}
}

// Quicksort algorithm
int q_sort(uint32_t *arr_list, int32_t *pivot_pos, uint32_t *min_pos) {
	uint32_t pivot_val = arr_list[*pivot_pos];
	uint32_t left_cur = 0;
	int32_t right_cur = (*pivot_pos-1);
	int32_t left_found = 0;
	uint32_t right_found = 0;
	uint32_t temp_val = 0;

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
		else if ( (arr_list[left_cur]) < (arr_list[*pivot_pos]) ) {
			left_found = 1;
		}
		else {
			++left_cur;
		}
	}

	// Search right side
	while (right_found == 0) {
		// If right cursor reaches 0, pivot is the smallest number
		if ( (right_cur == *min_pos) && (arr_list[right_cur]) <= (arr_list[*pivot_pos]) ) {
		
			right_found = 1;

			// Swap Lval with Pivot
			temp_val = arr_list[left_cur];
			arr_list[left_cur] = arr_list[*pivot_pos];
			arr_list[*pivot_pos] = temp_val;

			// update the min_pos
			*min_pos = left_cur;
			// *min_pos = 0;

			return q_sort( arr_list, pivot_pos, min_pos );
		} 

		else if ( (arr_list[right_cur]) >= (arr_list[*pivot_pos]) ) {

			right_found =1;
		}
		else
		{
			--right_cur;
		}
	}

	// If either cursor has passed each other during their search, 
	// means no number smaller than pivot and swap with Lval for its correct position
	if (right_cur > left_cur) {
		temp_val = arr_list[left_cur];
		arr_list[left_cur] = arr_list[*pivot_pos];
		arr_list[*pivot_pos] = temp_val;

		// Update the min position
		// *min_pos = left_cur; 
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

// Print header titles
void print_header(uint32_t *header) {
	uint32_t i = 0;

	while (header[i] != '\0') {
		write_data_char( &header[i], NO_NEW_LINE );
		++i;
	}

	// Write carriage returna nd line feed
	Delay_ms(100);
	USART1_DR = CHAR_CR;			
	Delay_ms(100);
	USART1_DR = CHAR_LF;			
}

//
void convert_to_ascii(int32_t *input_dec, uint32_t *ascii_msb, uint32_t *ascii_lsb)
{
	// set the default values to 0
	uint32_t temp_val = 0;
	*ascii_msb = 0;
	*ascii_lsb = 0;

	// number is ranged from 0-50 decimal.
	if (*input_dec > MAX_BUFFER_SIZE ) {
		return; // error code
	}

	// Get the MSB
	temp_val = *input_dec;
	while (temp_val >=10) {
		temp_val /= 10;
		*ascii_msb = temp_val + ASCII_HEX_0;
		// *ascii_msb = "'\\x'+ temp_val'";
		// *ascii_msb = temp_val;


	}

	// Get the LSB
	temp_val = *input_dec;

	temp_val %= 10;
	// *ascii_lsb = "'\\x' +temp_val'";
	*ascii_lsb = temp_val +ASCII_HEX_0;
	
}
///================================================================================================================
/// Main function
void main() {
	
	/* Local Variables */
	uint8_t loop_on = TRUE;
	int32_t min_pos   = 0;
	int32_t pivot_pos = 0;
	int32_t char_counter = 0;
	uint32_t tx_buffer;
	uint32_t rx_buffer[50];
	uint32_t i = 0;
	uint32_t num_ascii = 0;
	uint32_t ascii_msb;
	uint32_t ascii_lsb;
	// uint32_t rx_buffer[6] = {'7','2','1','1','5','\0'};
	// uint32_t rx_buffer[6] = {'g','b','a','a','f','@'};
	// uint32_t rx_buffer[7] = {'2','3','2','1','4', '3','@'};

	// ** NOTEText chars must be 32bit size otherwise USART terminal will not read the data correctly
	uint32_t title_orig[10]= {'O','r','i','g','i','n','a','l',':', '\0'};
	uint32_t title_rev[10]= {'R','e','v','e','r','s','e','d',':','\0'};
	uint32_t title_sorted[]= {'S','o','r','t','e','d',':', '\0'};
	uint32_t title_counter[] = {'N','u','m','.','\x20','S','o','r','t','e','d',':','\0'};
	

	/* Initialization stuff */
	RCC_APB2ENR |= 0x00000001; 	// Alternate function bit AFIOEN bit[0]. USART1 uses AF for PA9/PA10
	AFIO_MAPR    = 0x00000000; 	// Bit[2] USART1 REMAP 0: No Remap (Tx=PA9; Rx=PA10) 

	RCC_APB2ENR |= 1 << 2;		// Enable GPIO Clock - Port A
	RCC_APB2ENR |= 1 << 5;		// Enable GPIO Clock - Port D
	RCC_APB2ENR |= 1 << 14; 	// Enable USART1 Clock 

	GPIOA_CRH &= ~(0xFF << 4);  // Shift 4 bits left to clear bits[9:4] for PA9/PA10 0000 0FF0 -> mask with  FFFF F00F
	GPIOA_CRH |= (0x0B << 4) ;  // USART1 Tx/PA9 set to CNF=AFoutput push-pull b10; MODE= output-50Hz b11;
	GPIOA_CRH |= (0x04 << 8);   // USART1 Rx/PA10 set CNF=Input-floating b01; MODE=Input mode b00;
	GPIOD_CRH = GPIO_OUTPUT;

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

	
	USART1_CR1 |= 1 << 13;			//** NOTE USART1 Enable must be done after configuration is complete
	Delay_ms(100);					// Allow some time for USART to complete initialization.
	// update_led(0xff);

	/* Main loop */
	for (;;) {

		update_led(LED_RESET);
        while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
            read_data(&rx_buffer[char_counter]);

			if (rx_buffer[char_counter] == EXIT_CHAR){
				loop_on = FALSE;
			}
			else if (rx_buffer[char_counter] != 0x0D) {
				++char_counter;	
				update_led(char_counter);

				if (char_counter == MAX_BUFFER_SIZE) {
					rx_buffer[char_counter] = EXIT_CHAR;
				}
			}
		}

		list_len = char_counter;
		pivot_pos = (char_counter - 1);
		
		
		
		// Print original list
		print_header(&title_orig);
		write_data(&rx_buffer);

		// sort the data
		q_sort(&rx_buffer, &pivot_pos, &min_pos);

		// Print sorted
		print_header(&title_sorted);		
		write_data(&rx_buffer);

		print_header(&title_counter);

		convert_to_ascii(&list_len, &ascii_msb, &ascii_lsb);
		write_data_char(&ascii_msb, NO_NEW_LINE);
		write_data_char(&ascii_lsb, NEW_LINE_EN);


		// Reset everything to start all over again
		// clear_buffer(&rx_buffer, MAX_BUFFER_SIZE);
		loop_on = TRUE;
		char_counter = 0;

    

	}




}