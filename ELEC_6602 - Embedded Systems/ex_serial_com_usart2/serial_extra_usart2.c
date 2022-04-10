//**************************************************************************************************
// Project Extra - Serial Communication USART 2
// Name: Howard Zhou
// Due Date: 04/11/2022
// Course: ELEC 6602/3371 Embedded Systems

// Description: 
//					 Application used to demonstrate USART 2 connection. Enter data through the serial terminal
//					 to test transmission and receive of data.
//                             USB Serial Connection, in terminal must be set to 9600 baud for this application.
//---------------------------------------------------------------------------------------------------
//		Objective 1:      Configure the following function for USART2 with a Baud rate of 9,600, assuming a 36 MHz clock. 
//                            To test this on your board, plug your second USB cable into USB UART B and on Switch 12 turn 
//                            on position 3 and 4. 
// 		
//**************************************************************************************************

#include <stdint.h>

static const uint32_t GPIOD_USART2_EN_MASK = 0x04B44444;

void main() {

      uint32_t rx_buffer;
      uint32_t tx_buffer;

      
      /* Configure clock for 72MHz */
      //  Enables PLL and PLL2 and 8MHz trimming
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


      /* Initialization  */
      USART2_CR1 &= ~(1 << 13);              // Disable USART in order to configure it.

      RCC_APB1RSTR.USART2RST = 0;            // Don't hold USART2 in reset
      RCC_APB2ENR.AFIOEN = 1;                // Enable clock for Alt. Function. USART2 uses Alternate pins PD5/PD6
      RCC_APB2ENR.IOPDEN = 1;                // Enable clock for GPIOD
      RCC_APB2ENR |= 1 << 3;                 // Enable GPIO Clock -> PORT B for LEDs
      RCC_APB2ENR |= 1 << 5;                 // Enable GPIO Clock -> PORT D for USART2 Pins

      // This bit is > Bit[16] and MikroC compiler cannot set this, must used alternative method
      // RCC_APB1ENR |= 1 << 17;             // USART2 Clock enable
      RCC_APB1ENR.USART2EN = 1;
      RCC_APB1RSTR &= ~(1 << 5);             // APB1 Peripherial Reset register, ensure Bit is 0 =  USART2 not in reset mode

      // MikroC Compiler can't handle 32-bit bitwise operations, will need to set it like below
      // GPIOD_CRL |= (0x0B << 20);          // USART2 Tx/PD5 set CNF=AF-Output push-pull b10; MODE=50MHz b11; b1011 = 0x0B
      // GPIOD_CRL |= (0x04 << 24);          // USART2 Rx/PD6 set CNF=Floating input(reset state)b01; MODE=Input mode b00; b0100=0x04 
      // GPIOD_CRLbits.CNF5= 0x02;
      // GPIOD_CRLbits.MODE5=0x03;
      // GPIOD_CRLbits.CNF6= 0x01;
      // GPIOD_CRLbits.MODE6=0x00;

      // NOTE: USART2_REMAP must be set AFTER GPIO ports are enabled remap to TX/PD5, RX/PD6
      GPIOD_CRL = GPIOD_USART2_EN_MASK;       
      AFIO_MAPR.USART2_REMAP = 1;           

      /* Configure PORT B - LEDs */
      // GPIOB_CRL = 0x33333333; // OUPUT mode
      // GPIOB_ODR = 0xFFFF; 

      /* Configure Baudrate */
      // NOTE: USART2/B will work with 9600baud 
      // Assuming Clock = 36MHz, oversample=16x; 36MHz / (16 * 9600) = 243.375
      // Mantissa = 243 = 0xF3; Fraction = (0.375 * 16) = 6 = 0x6; Baud Reg value = 0xF36
      USART2_BRR = 0x00000F36;


      /* USART Control Register Configuration */
      // Reset state is 0x0000
      // Per data sheet (pg. 814 STM32_RefManual) USART1_CR1 consists of the following:
      // 13 12   11  10  9    8     7    6      5      4  3  2   1   0
      // UE  M WAKE PCE PS PEIE TXEIE TCIE RXNEIE IDLEIE TE RE RWU SBK
      // 1   0       0   0    0     0   0      0       0  1  1   0   0

      USART2_CR1 &= ~(1 << 12);           // Set to 0 for 8 data bits
      USART2_CR2 &= ~(3 << 12);           // Force 1 stop bit
      USART2_CR1 &= ~(3 << 9);            // Force no parity and no partiy control
      USART2_CR3 &= ~(3 << 8);            // Force no flow control and DMA for USART2
      USART2_CR1 |= 3 << 2;               // Rx, Tx Enable
      Delay_ms(100);
      USART2_CR1 |= 1 << 13;              // **NOTE USART2 Enable must be done after configuration is done
      

      /* Main loop */
      for (;;) {

            // Check the status register USART_SR bit[5] RXNE - read data reg not empty
            // while RXNE bit is 0 and not 1
            // while (!((USART1_SR & (1<<5))== 0x20)){} // Check RXNE in USART1 Status Register. Negative logic
            while( (USART2_SR & (1 << 5)) == 0 ) {}		// Positive logic

            // Data is available in the read register for us to retrieve it.
            rx_buffer = USART2_DR;		// read data from receiver data register

            // While TXE bit[7] Transmit data register empty is not empty, wait until bit[7] == 1
            // Stay in this loop until the Transfer data register finishes transfering to shift register 
            // aka reading is finished 
            // while ( ! (USART1_SR & (1 << 7)) == 0x80) {}
            while ( (USART2_SR & (1 << 7)) == 0) {}

            // Transmit data out via USART, same data register is used
            Delay_ms(10);
            tx_buffer = rx_buffer;
            USART2_DR = rx_buffer;

      }
}