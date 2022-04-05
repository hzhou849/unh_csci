//**************************************************************************************************
// Name: Professor Pellicano
// Date: 12/31/9993
// Course: ELEC3371-00
// Description: This program toggles the LEDs on PORTD and PORTE every one second on an interrupt
//				basis. LEDs on PORTD are initially off and LEDs on PORTE are initially on.
//				creates a clock frequency of 1000 ms, or 1 second. Every second, the status register
//				interrupt flag will trigger, thus allowing an action (LED toggle) to occur.
//**************************************************************************************************

//**************************************************************************************************
//INTERRUPT SERVICE ROUTINE
void TIMER3_ISR () iv IVT_INT_TIM3 {
TIM3_SR.UIF = 0;  			// Reset UIF flag so next interrupt can be recognized when UIF is set
GPIOD_ODR = ~ GPIOD_ODR;	// Toggle PORTD LEDs
GPIOE_ODR = ~ GPIOE_ODR;	// Toggle PORTE LEDs
}

//**************************************************************************************************
//GLOBAL VARIABLES
int counter;
void PinConfiguration();    // Forward declaration of sub function used for pin configuration
void Timer3IntConfiguration(); // Forward declaration of sub function used for TIMER1 configuration

//**************************************************************************************************
//MAIN FUNCTION
void main () {
	PinConfiguration();
	Timer3IntConfiguration();

	GPIOD_ODR=0X0000;		// Initialize GPIOD LEDS as off
	GPIOE_ODR=0XFFFF;		// Initialize GPIOE LEDs as on

	// You can write your main program from this point on. In this example, the program will
	// execute in an endless loop to keep the program active
	for(;;){

	}
}
//**************************************************************************************************
//SUB FUNCTIONS
void PinConfiguration() {
	GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
	GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);
}

void Timer3IntConfiguration(){
	RCC_APB1ENR |= (1 << 1);// Enable TIMER3 clock. RCC: Clock Configuration Register
	TIM3_CR1 = 0x0000;  	// Disable timer until configuration is complete
							// If reset value of RCC_CFGR is used, then the 8MHz clock will
							// be the clock source for timer
	TIM3_PSC = 7999;    	// Clock to TIMx_CNT = 72000000 (clock applied to prescaler register) /
							//                     7999 (Value in TIMx_PSC) + 1) = 9000
	TIM3_ARR = 9000;		// Reload timer count register with this value when count register resets
							// to 0 after counting from zero to this value

	// in 6.2 version of compiler the '<<' shift command can only handle 16-bits

	// NVIC_ISER0 |= (long int) 1<<29;	// we can do a cast to force a 32bit shift
	NVIC_ISER0.B29 = 1;			// Access the board directly

	// NVIC_ISER0 |= 1<<29;	// Enable global interrupt for TIMER3 in NVIC
							// Interrupt set enable register 0. Position of this interrupt in vector
							// table is 29, so set the corresponding bit in interrupt service enable
							// register 0. This is a 32 bit register. ISER1 is used for interrupt
							// numbers greater than 31.
	TIM3_DIER.UIE = 1;  	// Update interrupt enable
	TIM3_CR1 = 0x0001; 		// Enable TIMER3
}
