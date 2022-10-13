/***************************************************
 * @brief InitializeUSART1()
 *
 *        This function initializes USART1 with 56,000 baud, 8 data bits, 1 stop
 *        bit, 0 parity
 *
 ***************************************************/
void InitializeUSART1(){ // Sub function which initializes the registers to enable USART1
  RCC_APB2ENR |= 1;                 // Enable clock for Alt. Function. USART1 uses AF for PA9/PA10
  AFIO_MAPR=0X0F000000;             // Do not mask PA9 and PA10 (becaue we are using for USART)
  RCC_APB2ENR |= 1<<2;              // Enable clock for GPIOA
  GPIOA_CRH &= ~(0xFF << 4);        // Clear PA9, PA10
  GPIOA_CRH |= (0x0B << 4);         // USART1 Tx (PA9) output push-pull
  GPIOA_CRH |= (0x04 << 8);         // USART1 Rx (PA10) input floating
  RCC_APB2ENR |= 1<<14;             // enable clock for USART1
  USART1_BRR=0X00000506;            // Set baud rate to 56000
  USART1_CR1 &= ~(1<<12);          // Force 8 data bits. M bit is set to 0.
  USART1_CR2 &= ~(3<<12);          // Force 1 stop bit
  USART1_CR3 &= ~(3<<8);           // Force no flow control and no DMA for USART1
  USART1_CR1 &= ~(3<<9);           // Force no parity and no parity control
  USART1_CR1 |= 3<<2;              // RX, TX enable
  USART1_CR1 |= 1<<13;            // USART1 enable. This is done after configuration is complete
  Delay_ms(100);                  // Wait for USART to complete configuration and enable.
}

/***************************************************
 * @brief Timer3IntConfiguration()
 *
 *        This function initializes Timer3 as a 1 second interrupt enabled count
 *        up timer.
 *
 ***************************************************/
void Timer3IntConfiguration(){
  RCC_APB1ENR |= (1 << 1);// Enable TIMER3 clock. RCC: Clock Configuration Register
  TIM3_CR1 = 0x0000;  	// Disable timer until configuration is complete
  			// If reset value of RCC_CFGR is used, then the 8MHz clock will
  			// be the clock source for timer
  TIM3_PSC = 7999;    	// Clock to TIMx_CNT = 72000000 (clock applied to prescaler register) /
  			//                     7999 (Value in TIMx_PSC) + 1) = 9000
  TIM3_ARR = 9000;	// Reload timer count register with this value when count register resets
  			// to 0 after counting from zero to this value
  NVIC_ISER0.B29 = 1;	// Enable global interrupt for TIMER3 in NVIC
  			// Interrupt set enable register 0. Position of this interrupt in vector
  			// table is 29, so set the corresponding bit in interrupt service enable
  			// register 0. This is a 32 bit register. ISER1 is used for interrupt
  			// numbers greater than 31.
  TIM3_DIER.UIE = 1;  	// Update interrupt enable
  TIM3_CR1 = 0x0001; 		// Enable TIMER3
}

void PinConfiguration(){
	RCC_APB2ENR |= 1 << 5;  	// Enable GPIOD clock
	GPIOD_CRL = 0x33333333;
	GPIOD_CRH = 0x33333333; 	// Configure GPIOD as output for LEDs
	GPIOD_ODR = 0;          	// Initialize all LEDs as OFF
}