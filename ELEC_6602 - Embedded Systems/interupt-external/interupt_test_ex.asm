_EXTIPB6:
;interupt_test_ex.c,13 :: 		void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
;interupt_test_ex.c,14 :: 		EXTI_PR.B6 = 1;     // Clear pending interrupt flag for PB6
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;interupt_test_ex.c,15 :: 		GPIOD_ODR = ~ GPIOD_ODR;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,16 :: 		}
L_end_EXTIPB6:
BX	LR
; end of _EXTIPB6
_EXTIPA0:
;interupt_test_ex.c,18 :: 		void EXTIPA0 () iv IVT_INT_EXTI0 {
;interupt_test_ex.c,19 :: 		EXTI_PR.B0 = 1;     //Clear pending interrupt flag for PA0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;interupt_test_ex.c,20 :: 		GPIOE_ODR = ~ GPIOE_ODR;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,21 :: 		}
L_end_EXTIPA0:
BX	LR
; end of _EXTIPA0
_main:
;interupt_test_ex.c,31 :: 		void main () {
;interupt_test_ex.c,32 :: 		PinConfiguration();
BL	_PinConfiguration+0
;interupt_test_ex.c,33 :: 		ExternalIntConfiguration();
BL	_ExternalIntConfiguration+0
;interupt_test_ex.c,35 :: 		GPIOD_ODR=0XFF00;		// Initialize GPIOD LEDS as off
MOVW	R1, #65280
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,36 :: 		GPIOE_ODR=0XF000;		// Initialize GPIOE LEDs as on
MOVW	R1, #61440
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,40 :: 		for(;;){
L_main0:
;interupt_test_ex.c,42 :: 		}
IT	AL
BAL	L_main0
;interupt_test_ex.c,43 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_PinConfiguration:
;interupt_test_ex.c,46 :: 		void PinConfiguration() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;interupt_test_ex.c,47 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;interupt_test_ex.c,48 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;interupt_test_ex.c,49 :: 		GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_0);
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Input+0
;interupt_test_ex.c,50 :: 		GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_6);
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;interupt_test_ex.c,51 :: 		}
L_end_PinConfiguration:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _PinConfiguration
_ExternalIntConfiguration:
;interupt_test_ex.c,53 :: 		void ExternalIntConfiguration(){
;interupt_test_ex.c,54 :: 		RCC_APB2ENR.AFIOEN = 1;     // Enable clock for alternate pin function
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
_SX	[R0, ByteOffset(RCC_APB2ENR+0)]
;interupt_test_ex.c,55 :: 		AFIO_EXTICR1  = 0x00000000; // PA0 as External interrupt
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,56 :: 		AFIO_EXTICR2 |= 0x00000100; // PB6 as External interrupt
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,57 :: 		EXTI_RTSR |= 0x00000041;    // Set interrupt on rising edge for PA0 and PB6
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #65
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,58 :: 		EXTI_IMR |= 0x00000041;     // Interrupt on PA0 and PB6 are non-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #65
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,59 :: 		NVIC_ISER0 |= 1<<6;         // Enable NVIC interrupt for EXTI line zero (PA0)
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,61 :: 		NVIC_ISER0 |= (long int)1<<23;        // Enable NVIC interrupt for EXTI9_% (PB6) position 23 in NVIC table
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;interupt_test_ex.c,62 :: 		}
L_end_ExternalIntConfiguration:
BX	LR
; end of _ExternalIntConfiguration
