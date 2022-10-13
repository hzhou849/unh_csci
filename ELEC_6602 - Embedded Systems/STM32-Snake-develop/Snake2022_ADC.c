/***************************************************
 * @brief getAdcReading ()
 *
 *
 *
 ***************************************************/
unsigned int getAdcReading(){
	// Bit 20 is set to start conversion of an external channel, bit 22 starts the conversion
	ADC1_CR2 |= (1 << 22) | (1 << 20);
	while(!(ADC1_SR & 0b10)); 	// Wait until the ADC conversion has ended
	return ADC1_DR;				// Read value from data register. This also clears start bit
}

/***************************************************
 * @brief AdcConfiguration ()
 *
 *
 *
 ***************************************************/
void AdcConfiguration(){   		// ADC for PC0
	RCC_APB2ENR |= 1 << 4; 		// Enable PORTC clock
	RCC_APB2ENR |= 1 << 9 ;     // Enable ADC1 Clock
	GPIOC_CRL &= ~(0xF << 0);	// Configure PC0 as an Analog Input
	ADC1_SQR1 = (0b0000 << 20);	// 1 conversion
	ADC1_SQR3 = 10;				// Select Channel 10 as only one in conversion sequence
	ADC1_SMPR1 = 0b100;			// Set sample time on channel 10
	ADC1_CR2 |= (0b111 << 17); 	// Set software start as external event for regular group conversion
	ADC1_CR2.ADON = 1;			// Enable ADC1
	delay_ms(10);
}
