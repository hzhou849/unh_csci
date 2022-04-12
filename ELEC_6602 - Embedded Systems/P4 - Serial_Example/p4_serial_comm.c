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

# include <stdint.h>

/// Constants
static const uint32_t VAR = 0x00000000;

/// Helper Functions



/// Main function
void main() {
	
	/* Local Variables */
	uint32_t rx_buffer;
	uint32_t tx_buffer;
	uint32_t rx_buffer[50];

	/* Initialization */
	RCC_APB2ENR |= 0x00000001; // Alternate function bit AFIOEN bit[0]. USART1 uses AF for PA9/PA10
	AFIO_MAPR    = 0x00000000; // Bit[2] USART1 REMAP 0: No Remap (Tx=PA9; Rx=PA10) 

	RCC_APB2ENR |= 1 << 2;		// Enable GPIO Clock - Port A
	RCC_APB2ENR |= 1 << 5;		// Enable GPIO Clock - Port D
	RCC_APB2ENR |= 1 << 14; 	// Enable USART1 Clock 

	GPIOA_CRH &= ~(0xFF << 4);  // Shift 4 bits left to clear bits[9:4] for PA9/PA10 0000 0FF0 -> mask with  FFFF F00F
	GPIOA_CRH |= (0x0B << 4) ;  // USART1 Tx/PA9 set to CNF=AFoutput push-pull b10; MODE= output-50Hz b11;
	GPIOA_CRH |= (0x04 << 8);   // USART1 Rx/PA10 set CNF=Input-floating b01; MODE=Input mode b00;

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



	/* Main loop */
	for (;;) {

		// Check the status register USART_SR bit[5] RXNE - read data reg not empty
		// while RXNE bit is 0 and not 1
		// while (!((USART1_SR & (1<<5))== 0x20)){} // Check RXNE in USART1 Status Register. Negative logic
		while( (USART1_SR & (1 << 5)) == 0 ) {}		// Positive logic

		// Data is available in the read register for us to retrieve it.
		rx_buffer = USART1_DR;		// read data from receiver data register

		// While TXE bit[7] Transmit data register empty is not empty, wait until bit[7] == 1
		// Stay in this loop until the Transfer data register finishes transfering to shift register 
		// aka reading is finished 
		// while ( ! (USART1_SR & (1 << 7)) == 0x80) {}
		while ( (USART1_SR & (1 << 7)) == 0) {}

		// Transmit data out via USART, same data register is used
		tx_buffer = rx_buffer;
		USART1_DR = tx_buffer;

	}
}