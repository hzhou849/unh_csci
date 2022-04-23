//**************************************************************************************************
// Name: Professor Pellicano
// Date: 12/31/9993
// Course: ELEC3371-00
// Description: This program toggles the LEDs on PORTD and PORTE on an interrupt basis if either
//				PA0 or PB6 are pressed. This is an example of an external interrupt. Each interrupt
//				is non-maskable, meaning the CPU cannot ignore the interrupt request.
//**************************************************************************************************
//This program toggles LEDs on PORTE and PORTD if PA0 //or PB6 are pressed respectively on an interrupt basis.

//**************************************************************************************************
//INTERRUPT SERVICE ROUTINES
void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
EXTI_PR.B6 = 1;     // Clear pending interrupt flag for PB6
GPIOD_ODR = ~ GPIOD_ODR;
}

void EXTIPA0 () iv IVT_INT_EXTI0 {
EXTI_PR.B0 = 1;     //Clear pending interrupt flag for PA0
GPIOE_ODR = ~ GPIOE_ODR;
}

//**************************************************************************************************
//GLOBAL VARIABLES
int counter;
void PinConfiguration();    // Forward declaration of sub function used for pin configuration
void ExternalIntConfiguration(); // Forward declaration of sub function used for EXTI configuration

//**************************************************************************************************
//MAIN FUNCTION
void main () {
	PinConfiguration();
	ExternalIntConfiguration();

	GPIOD_ODR=0XFF00;		// Initialize GPIOD LEDS as off
	GPIOE_ODR=0XF000;		// Initialize GPIOE LEDs as on

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
	GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_0);
	GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_6);
}

void ExternalIntConfiguration(){
	RCC_APB2ENR.AFIOEN = 1;     // Enable clock for alternate pin function
	AFIO_EXTICR1  = 0x00000000; // PA0 as External interrupt
	AFIO_EXTICR2 |= 0x00000100; // PB6 as External interrupt
	EXTI_RTSR |= 0x00000041;    // Set interrupt on rising edge for PA0 and PB6
	EXTI_IMR |= 0x00000041;     // Interrupt on PA0 and PB6 are non-maskable
	NVIC_ISER0 |= 1<<6;         // Enable NVIC interrupt for EXTI line zero (PA0)
                                // with position 6 in NVIC table

	// Shifting beyond the 16bit positon will cause problems for this compiler
	// Compiler has issues with 32 bit manipulation instructions and will not compile correctly. Casting is used to remedy this. 							
	NVIC_ISER0 |= (long int)1<<23;        // Enable NVIC interrupt for EXTI9_% (PB6) position 23 in NVIC table
}

