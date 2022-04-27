_EXTIPB6:
;PA1_test.c,33 :: 		void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
;PA1_test.c,36 :: 		EXTI_PR |= 1 << 6;     // PB6 = PR6 Bit
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;PA1_test.c,37 :: 		GPIOE_ODR = ~GPIOE_ODR;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;PA1_test.c,38 :: 		}
L_end_EXTIPB6:
BX	LR
; end of _EXTIPB6
_TIMER2_ISR:
;PA1_test.c,56 :: 		void TIMER2_ISR () iv IVT_INT_TIM2 {
;PA1_test.c,57 :: 		TIM2_SR &=  ~(1 << 0);         // Bit[0] = UIF update intrpt flag. 1 to reset
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;PA1_test.c,60 :: 		GPIOD_ODR = ~GPIOD_ODR;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;PA1_test.c,63 :: 		}
L_end_TIMER2_ISR:
BX	LR
; end of _TIMER2_ISR
_initClock72MHz:
;PA1_test.c,68 :: 		void initClock72MHz() {
;PA1_test.c,72 :: 		RCC_CR = 0x05010081;
MOVW	R1, #129
MOVT	R1, #1281
MOVW	R0, #lo_addr(RCC_CR+0)
MOVT	R0, #hi_addr(RCC_CR+0)
STR	R1, [R0, #0]
;PA1_test.c,79 :: 		RCC_CFGR = 0x091D8402; // IDE Scheme
MOVW	R1, #33794
MOVT	R1, #2333
MOVW	R0, #lo_addr(RCC_CFGR+0)
MOVT	R0, #hi_addr(RCC_CFGR+0)
STR	R1, [R0, #0]
;PA1_test.c,86 :: 		RCC_CFGR2 = 0x00010644;
MOVW	R1, #1604
MOVT	R1, #1
MOVW	R0, #lo_addr(RCC_CFGR2+0)
MOVT	R0, #hi_addr(RCC_CFGR2+0)
STR	R1, [R0, #0]
;PA1_test.c,87 :: 		}
L_end_initClock72MHz:
BX	LR
; end of _initClock72MHz
_main:
;PA1_test.c,89 :: 		void main() {
;PA1_test.c,95 :: 		USART1_CR1 &= ~(1 << 13);                  // Diasable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;PA1_test.c,101 :: 		AFIO_MAPR |= 1 << 3;
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;PA1_test.c,102 :: 		AFIO_MAPR |= 1 << 8;
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;PA1_test.c,103 :: 		AFIO_MAPR |= 1 << 9;
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #512
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;PA1_test.c,104 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;PA1_test.c,108 :: 		RCC_APB2ENR |= 1 << 2;                     // Enable GPIO Clock PORT A  Interrupt test
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;PA1_test.c,109 :: 		RCC_APB2ENR |= 1 << 3;                     // Enable GPIO Clock PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;PA1_test.c,110 :: 		RCC_APB2ENR |= 1 << 5;                     // Enable GPIO Clock PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;PA1_test.c,111 :: 		RCC_APB2ENR |= 1 << 6;                     // Enable GPIO Clock PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;PA1_test.c,112 :: 		RCC_APB2ENR |= 1 << 14;                    // Enable USART1 Clock for USART and
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;PA1_test.c,116 :: 		GPIOA_CRH &= ~(0xFF << 4);                 // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;PA1_test.c,117 :: 		GPIOA_CRH |=  (0x0B << 4);                 // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;PA1_test.c,118 :: 		GPIOA_CRH |=  (0x04 << 8);       // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;PA1_test.c,123 :: 		GPIOA_CRL = 0x44444444;                   // PA1 input CNF=input-floating b01; MODE: input b00 = 0x0100;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;PA1_test.c,124 :: 		GPIOB_CRL |= (uint32_t) (0x04 << 24);      // PB6 input CNF=input-floating b01; MODE: input b00 = 0x0100;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;PA1_test.c,126 :: 		GPIOD_CRL = 0x33333333;                    // PD0:7   CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;PA1_test.c,127 :: 		GPIOD_CRH = 0x33333333;                    // PD8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;PA1_test.c,128 :: 		GPIOE_CRH = 0x33333333;                    // PE8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;PA1_test.c,130 :: 		GPIOA_ODR=0xFFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;PA1_test.c,205 :: 		GPIOD_ODR = 0xFFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;PA1_test.c,206 :: 		GPIOE_ODR = 0x00 << 8;                     // PORT E only has a High bank
MOVW	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;PA1_test.c,210 :: 		for (;;) {
L_main0:
;PA1_test.c,212 :: 		while (GPIOA_IDR.B1 == 1) {
L_main3:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main4
;PA1_test.c,213 :: 		GPIOE_ODR = ~GPIOE_ODR;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;PA1_test.c,214 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main5:
SUBS	R7, R7, #1
BNE	L_main5
NOP
NOP
NOP
;PA1_test.c,215 :: 		}
IT	AL
BAL	L_main3
L_main4:
;PA1_test.c,217 :: 		while (GPIOA_IDR.B0 == 1) {
L_main7:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main8
;PA1_test.c,218 :: 		GPIOD_ODR = ~GPIOD_ODR;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;PA1_test.c,219 :: 		}
IT	AL
BAL	L_main7
L_main8:
;PA1_test.c,221 :: 		}
IT	AL
BAL	L_main0
;PA1_test.c,222 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
