_EXTIPB6:
;P6_interrupts.c,40 :: 		void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
;P6_interrupts.c,41 :: 		EXTI_PR.B6 = 1;                    // Clear pending regsiter interrupt flag for PB6
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;P6_interrupts.c,44 :: 		while (GPIOB_IDR.B6 == 1) {}        // Wait here until button release
L_EXTIPB60:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_EXTIPB61
IT	AL
BAL	L_EXTIPB60
L_EXTIPB61:
;P6_interrupts.c,47 :: 		GPIOE_ODR = ( (time_count-1) << 8) & 0xFF00;            // Update the LEDs on PORTE/H (shift 8 LEDs)
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
SUBS	R0, R0, #1
LSLS	R0, R0, #8
AND	R1, R0, #65280
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,48 :: 		usart_count = time_count;          // Update the USART counter for key presses for PortE for USART1 ISR
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(P6_interrupts_usart_count+0)
MOVT	R0, #hi_addr(P6_interrupts_usart_count+0)
STR	R1, [R0, #0]
;P6_interrupts.c,51 :: 		}
L_end_EXTIPB6:
BX	LR
; end of _EXTIPB6
_EXTIPA4:
;P6_interrupts.c,53 :: 		void EXTIPA4() iv IVT_INT_EXTI4 ics ICS_AUTO {
;P6_interrupts.c,54 :: 		EXTI_PR.PA4 = 1;                         // Clear interrupt pending regsiter
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;P6_interrupts.c,56 :: 		timer_run_flag = ~timer_run_flag;        // Flip the flag switch to toggle the timer counter on PORTD
MOVW	R0, #lo_addr(P6_interrupts_timer_run_flag+0)
MOVT	R0, #hi_addr(P6_interrupts_timer_run_flag+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(P6_interrupts_timer_run_flag+0)
MOVT	R0, #hi_addr(P6_interrupts_timer_run_flag+0)
STR	R1, [R0, #0]
;P6_interrupts.c,57 :: 		while (GPIOA_IDR.B4 == 1) {}             // Hold here until button is released
L_EXTIPA42:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_EXTIPA43
IT	AL
BAL	L_EXTIPA42
L_EXTIPA43:
;P6_interrupts.c,59 :: 		}
L_end_EXTIPA4:
BX	LR
; end of _EXTIPA4
_TIMER2_ISR:
;P6_interrupts.c,61 :: 		void TIMER2_ISR() iv IVT_INT_TIM2 {
;P6_interrupts.c,63 :: 		TIM2_SR &=  ~(1 << 0);                  // Bit[0] = UIF update intrpt flag. 1 to reset
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,65 :: 		if (timer_run_flag == 1) {
MOVW	R0, #lo_addr(P6_interrupts_timer_run_flag+0)
MOVT	R0, #hi_addr(P6_interrupts_timer_run_flag+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_TIMER2_ISR4
;P6_interrupts.c,66 :: 		GPIOD_ODR = (time_count++) << 8;    // Pass the current timer value (shift 8 for High bank) then increment
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
LSLS	R1, R0, #8
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
STR	R1, [R0, #0]
;P6_interrupts.c,68 :: 		if (time_count > TIMER_COUNTER_MAX ) {
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
CMP	R0, #99
IT	LS
BLS	L_TIMER2_ISR5
;P6_interrupts.c,69 :: 		time_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
STR	R1, [R0, #0]
;P6_interrupts.c,70 :: 		}
L_TIMER2_ISR5:
;P6_interrupts.c,71 :: 		}
L_TIMER2_ISR4:
;P6_interrupts.c,73 :: 		}
L_end_TIMER2_ISR:
BX	LR
; end of _TIMER2_ISR
_USART1_ISR:
;P6_interrupts.c,75 :: 		void USART1_ISR() iv IVT_INT_USART1 {
;P6_interrupts.c,77 :: 		rx_buffer = USART1_DR;      // RXNE bit interrupt is reset by reading data register
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
; rx_buffer start address is: 4 (R1)
LDR	R1, [R0, #0]
; rx_buffer end address is: 4 (R1)
;P6_interrupts.c,80 :: 		while ( (USART1_SR & (1 << 7 )) == 0) {}
L_USART1_ISR6:
; rx_buffer start address is: 4 (R1)
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	NE
BNE	L_USART1_ISR7
IT	AL
BAL	L_USART1_ISR6
L_USART1_ISR7:
;P6_interrupts.c,81 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_USART1_ISR8:
SUBS	R7, R7, #1
BNE	L_USART1_ISR8
NOP
NOP
NOP
;P6_interrupts.c,82 :: 		USART1_DR = rx_buffer;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,85 :: 		if (rx_buffer >= 0x20) {
CMP	R1, #32
IT	CC
BCC	L_USART1_ISR10
; rx_buffer end address is: 4 (R1)
;P6_interrupts.c,86 :: 		GPIOE_ODR = (usart_count++) << 8;
MOVW	R0, #lo_addr(P6_interrupts_usart_count+0)
MOVT	R0, #hi_addr(P6_interrupts_usart_count+0)
LDR	R0, [R0, #0]
LSLS	R1, R0, #8
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(P6_interrupts_usart_count+0)
MOVT	R0, #hi_addr(P6_interrupts_usart_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P6_interrupts_usart_count+0)
MOVT	R0, #hi_addr(P6_interrupts_usart_count+0)
STR	R1, [R0, #0]
;P6_interrupts.c,87 :: 		}
L_USART1_ISR10:
;P6_interrupts.c,88 :: 		}
L_end_USART1_ISR:
BX	LR
; end of _USART1_ISR
_initClock72MHz:
;P6_interrupts.c,93 :: 		void initClock72MHz() {
SUB	SP, SP, #4
;P6_interrupts.c,97 :: 		RCC_CR = 0x05010081;
MOVW	R1, #129
MOVT	R1, #1281
MOVW	R0, #lo_addr(RCC_CR+0)
MOVT	R0, #hi_addr(RCC_CR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,104 :: 		RCC_CFGR = 0x091D8402; // IDE Scheme
MOVW	R1, #33794
MOVT	R1, #2333
MOVW	R0, #lo_addr(RCC_CFGR+0)
MOVT	R0, #hi_addr(RCC_CFGR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,111 :: 		RCC_CFGR2 = 0x00010644;
MOVW	R1, #1604
MOVT	R1, #1
MOVW	R0, #lo_addr(RCC_CFGR2+0)
MOVT	R0, #hi_addr(RCC_CFGR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,112 :: 		}
L_end_initClock72MHz:
ADD	SP, SP, #4
BX	LR
; end of _initClock72MHz
_main:
;P6_interrupts.c,114 :: 		void main() {
SUB	SP, SP, #4
;P6_interrupts.c,116 :: 		uint32_t timer_counter = 0;
;P6_interrupts.c,117 :: 		uint32_t *rx_buffer = 0;
;P6_interrupts.c,120 :: 		initClock72MHz();
BL	_initClock72MHz+0
;P6_interrupts.c,123 :: 		USART1_CR1 &= ~(1 << 13);                  // Diasable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,126 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,130 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,134 :: 		RCC_APB2ENR |= 1 << 2;                     // Enable GPIO Clock PORT A  Interrupt test
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,135 :: 		RCC_APB2ENR |= 1 << 3;                     // Enable GPIO Clock PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,136 :: 		RCC_APB2ENR |= 1 << 5;                     // Enable GPIO Clock PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,137 :: 		RCC_APB2ENR |= 1 << 6;                     // Enable GPIO Clock PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,138 :: 		RCC_APB2ENR |= 1 << 14;                    // Enable USART1 Clock for USART and
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,142 :: 		GPIOA_CRH &= ~(0xFF << 4);                 // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,143 :: 		GPIOA_CRH |=  (0x0B << 4);                 // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,144 :: 		GPIOA_CRH |=  (0x04 << 8);                // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,149 :: 		GPIOA_CRL |=  0x44444444 << 16;                   // PA1 input CNF=input-floating b01; MODE: input b00 = 0x0100;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17476
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P6_interrupts.c,150 :: 		GPIOB_CRL |= (uint32_t) (0x04 << 24);      // PB6 input CNF=input-floating b01; MODE: input b00 = 0x0100;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P6_interrupts.c,152 :: 		GPIOD_CRL = 0x33333333;                    // PD0:7   CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P6_interrupts.c,153 :: 		GPIOD_CRH = 0x33333333;                    // PD8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,154 :: 		GPIOE_CRH = 0x33333333;                    // PE8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,156 :: 		GPIOA_ODR=0xFFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,159 :: 		USART1_BRR = 0x00000506;                   // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,163 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,164 :: 		USART1_CR1 |= 1 << 5;                      // ENABLE USART1 TXNE interrupt
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,165 :: 		USART1_CR1 &= ~(1 << 12);                  // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,166 :: 		USART1_CR1 &= ~(3 << 9);                   // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,167 :: 		USART1_CR2 &= ~(3 << 12);                  // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,168 :: 		USART1_CR3 &= ~(3 << 8);                   // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P6_interrupts.c,169 :: 		USART1_CR1 |=  3 << 2;                     // Rx, Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,171 :: 		Delay_ms(100);                             // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
;P6_interrupts.c,172 :: 		USART1_CR1 |= 1 << 13;                     // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,175 :: 		RCC_APB1ENR |= 1 << 0;                     // Enable TIMER2 Clock;
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,179 :: 		TIM2_CR1 = 0x0000;                         // Disable the timer for config/setup.s
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,181 :: 		TIM2_PSC = 7999;                           // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1)
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P6_interrupts.c,184 :: 		TIM2_ARR = 9000;                           // Set the auto-reload register to the value calculated above
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,186 :: 		TIM2_DIER |= 1 << 0;                       // Allow timer Update interrupt enable
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P6_interrupts.c,188 :: 		TIM2_CR1 = 0x0001;                         // After timer setup, enable TIMER2; bit4=0 counting up.
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,193 :: 		AFIO_EXTICR2 |= 0x00000000;                // PA4 as External interrupt; Pin4/EXTI4[3:0] PortA=b0000
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,194 :: 		AFIO_EXTICR2 |= 0x00000100;                // PB6 as Enternal interrupt; Pin6/EXTI6[3:0] PortB=b0001
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,196 :: 		EXTI_RTSR    |= 1 << 4;                    // Set Edge trigger register for interrupt on rising edge for PA4 and PB6
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,197 :: 		EXTI_RTSR    |= 1 << 6;                    // Mask to enable TR6 and TR4 (EXTI6 and EXTI4) b1=rising trigger enabled
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,198 :: 		EXTI_IMR     |= 0x00000050;                // Set interrupt request from TR6 and TR4 to not masked (cpu CANNOT ignore it)
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #80
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,201 :: 		NVIC_ISER1   |= 1 << 5;                    // ISER1 interrupts vector #63-32; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,215 :: 		NVIC_ISER0 |= 1 << 10;                    // Enable NVIC interrupt set enable registers for EXTI1 line zero (PA1)
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P6_interrupts.c,216 :: 		NVIC_ISER0 |= (long int) 1 << 23;         // Enable NVIC interrupt set enable registers for EXTI6 PB6
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P6_interrupts.c,218 :: 		NVIC_ISER0 |= (uint32_t) 1 << 28;         // Enable NVIC interrupt enable for TIM2 global interrupt vector mapping 28
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #268435456
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P6_interrupts.c,237 :: 		GPIOD_ODR = 0xFFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,238 :: 		GPIOE_ODR = 0x00 << 8;                     // PORT E only has a High bank
MOVW	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,242 :: 		for (;;) {
L_main13:
;P6_interrupts.c,243 :: 		while( ( USART1_SR & (1 << 5)) == 0 ) {}        // Check RXNE not empty
L_main16:
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #0
IT	NE
BNE	L_main17
IT	AL
BAL	L_main16
L_main17:
;P6_interrupts.c,245 :: 		rx_buffer = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
; rx_buffer start address is: 4 (R1)
LDR	R1, [R0, #0]
; rx_buffer end address is: 4 (R1)
;P6_interrupts.c,247 :: 		while ( (USART1_SR & (1 << 7 )) == 0) {}
L_main18:
; rx_buffer start address is: 4 (R1)
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	NE
BNE	L_main19
IT	AL
BAL	L_main18
L_main19:
;P6_interrupts.c,248 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main20:
SUBS	R7, R7, #1
BNE	L_main20
NOP
NOP
NOP
;P6_interrupts.c,249 :: 		USART1_DR = rx_buffer;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
; rx_buffer end address is: 4 (R1)
;P6_interrupts.c,251 :: 		}
IT	AL
BAL	L_main13
;P6_interrupts.c,252 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
