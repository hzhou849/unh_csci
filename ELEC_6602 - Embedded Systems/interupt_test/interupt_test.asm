_TIMER3_ISR:
;interupt_test.c,13 :: 		void TIMER3_ISR () iv IVT_INT_TIM3 {
;interupt_test.c,14 :: 		TIM3_SR.UIF = 0;  			// Reset UIF flag so next interrupt can be recognized when UIF is set
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
_SX	[R0, ByteOffset(TIM3_SR+0)]
;interupt_test.c,15 :: 		GPIOD_ODR = ~ GPIOD_ODR;	// Toggle PORTD LEDs
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;interupt_test.c,16 :: 		GPIOE_ODR = ~ GPIOE_ODR;	// Toggle PORTE LEDs
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;interupt_test.c,17 :: 		}
L_end_TIMER3_ISR:
BX	LR
; end of _TIMER3_ISR
_main:
;interupt_test.c,27 :: 		void main () {
;interupt_test.c,28 :: 		PinConfiguration();
BL	_PinConfiguration+0
;interupt_test.c,29 :: 		Timer3IntConfiguration();
BL	_Timer3IntConfiguration+0
;interupt_test.c,31 :: 		GPIOD_ODR=0X0000;		// Initialize GPIOD LEDS as off
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;interupt_test.c,32 :: 		GPIOE_ODR=0XFFFF;		// Initialize GPIOE LEDs as on
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;interupt_test.c,36 :: 		for(;;){
L_main0:
;interupt_test.c,38 :: 		}
IT	AL
BAL	L_main0
;interupt_test.c,39 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_PinConfiguration:
;interupt_test.c,42 :: 		void PinConfiguration() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;interupt_test.c,43 :: 		GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;interupt_test.c,44 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;interupt_test.c,45 :: 		}
L_end_PinConfiguration:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _PinConfiguration
_Timer3IntConfiguration:
;interupt_test.c,47 :: 		void Timer3IntConfiguration(){
;interupt_test.c,48 :: 		RCC_APB1ENR |= (1 << 1);// Enable TIMER3 clock. RCC: Clock Configuration Register
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;interupt_test.c,49 :: 		TIM3_CR1 = 0x0000;  	// Disable timer until configuration is complete
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;interupt_test.c,52 :: 		TIM3_PSC = 7999;    	// Clock to TIMx_CNT = 72000000 (clock applied to prescaler register) /
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;interupt_test.c,54 :: 		TIM3_ARR = 9000;		// Reload timer count register with this value when count register resets
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;interupt_test.c,60 :: 		NVIC_ISER0.B29 = 1;			// Access the board directly
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ISER0+0)
MOVT	R1, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #29, #1
STR	R0, [R1, #0]
;interupt_test.c,67 :: 		TIM3_DIER.UIE = 1;  	// Update interrupt enable
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
_SX	[R0, ByteOffset(TIM3_DIER+0)]
;interupt_test.c,68 :: 		TIM3_CR1 = 0x0001; 		// Enable TIMER3
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;interupt_test.c,69 :: 		}
L_end_Timer3IntConfiguration:
BX	LR
; end of _Timer3IntConfiguration
