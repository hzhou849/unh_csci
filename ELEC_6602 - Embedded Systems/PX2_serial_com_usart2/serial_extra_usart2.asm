_main:
;serial_extra_usart2.c,22 :: 		void main() {
SUB	SP, SP, #4
;serial_extra_usart2.c,30 :: 		RCC_CR = 0x05010081;
MOVW	R1, #129
MOVT	R1, #1281
MOVW	R0, #lo_addr(RCC_CR+0)
MOVT	R0, #hi_addr(RCC_CR+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,35 :: 		RCC_CFGR = 0x001D8402;
MOVW	R1, #33794
MOVT	R1, #29
MOVW	R0, #lo_addr(RCC_CFGR+0)
MOVT	R0, #hi_addr(RCC_CFGR+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,41 :: 		RCC_CFGR2 = 0x00010644;
MOVW	R1, #1604
MOVT	R1, #1
MOVW	R0, #lo_addr(RCC_CFGR2+0)
MOVT	R0, #hi_addr(RCC_CFGR2+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,45 :: 		USART2_CR1 &= ~(1 << 13);              // Disable USART in order to configure it.
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,47 :: 		RCC_APB1RSTR.USART2RST = 0;            // Don't hold USART2 in reset
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1RSTR+0)
MOVT	R0, #hi_addr(RCC_APB1RSTR+0)
_SX	[R0, ByteOffset(RCC_APB1RSTR+0)]
;serial_extra_usart2.c,48 :: 		RCC_APB2ENR.AFIOEN = 1;                // Enable clock for Alt. Function. USART2 uses Alternate pins PD5/PD6
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
_SX	[R0, ByteOffset(RCC_APB2ENR+0)]
;serial_extra_usart2.c,49 :: 		RCC_APB2ENR.IOPDEN = 1;                // Enable clock for GPIOD
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
_SX	[R0, ByteOffset(RCC_APB2ENR+0)]
;serial_extra_usart2.c,50 :: 		RCC_APB2ENR |= 1 << 3;                 // Enable GPIO Clock -> PORT B for LEDs
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,51 :: 		RCC_APB2ENR |= 1 << 5;                 // Enable GPIO Clock -> PORT D for USART2 Pins
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,55 :: 		RCC_APB1ENR.USART2EN = 1;
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;serial_extra_usart2.c,56 :: 		RCC_APB1RSTR &= ~(1 << 5);             // APB1 Peripherial Reset register, ensure Bit is 0 =  USART2 not in reset mode
MOVW	R0, #lo_addr(RCC_APB1RSTR+0)
MOVT	R0, #hi_addr(RCC_APB1RSTR+0)
LDR	R1, [R0, #0]
MVN	R0, #32
ANDS	R1, R0
MOVW	R0, #lo_addr(RCC_APB1RSTR+0)
MOVT	R0, #hi_addr(RCC_APB1RSTR+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,67 :: 		GPIOD_CRL = GPIOD_USART2_EN_MASK;
MOVW	R1, #17476
MOVT	R1, #1204
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,68 :: 		AFIO_MAPR.USART2_REMAP = 1;
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
_SX	[R0, ByteOffset(AFIO_MAPR+0)]
;serial_extra_usart2.c,78 :: 		USART2_BRR = 0x00000F36;
MOVW	R1, #3894
MOVW	R0, #lo_addr(USART2_BRR+0)
MOVT	R0, #hi_addr(USART2_BRR+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,88 :: 		USART2_CR1 &= ~(1 << 12);           // Set to 0 for 8 data bits
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,89 :: 		USART2_CR2 &= ~(3 << 12);           // Force 1 stop bit
MOVW	R0, #lo_addr(USART2_CR2+0)
MOVT	R0, #hi_addr(USART2_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART2_CR2+0)
MOVT	R0, #hi_addr(USART2_CR2+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,90 :: 		USART2_CR1 &= ~(3 << 9);            // Force no parity and no partiy control
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,91 :: 		USART2_CR3 &= ~(3 << 8);            // Force no flow control and DMA for USART2
MOVW	R0, #lo_addr(USART2_CR3+0)
MOVT	R0, #hi_addr(USART2_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART2_CR3+0)
MOVT	R0, #hi_addr(USART2_CR3+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,92 :: 		USART2_CR1 |= 3 << 2;               // Rx, Tx Enable
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,93 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main0:
SUBS	R7, R7, #1
BNE	L_main0
NOP
NOP
NOP
;serial_extra_usart2.c,94 :: 		USART2_CR1 |= 1 << 13;              // **NOTE USART2 Enable must be done after configuration is done
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART2_CR1+0)
MOVT	R0, #hi_addr(USART2_CR1+0)
STR	R1, [R0, #0]
;serial_extra_usart2.c,98 :: 		for (;;) {
L_main2:
;serial_extra_usart2.c,103 :: 		while( (USART2_SR & (1 << 5)) == 0 ) {}		// Positive logic
L_main5:
MOVW	R0, #lo_addr(USART2_SR+0)
MOVT	R0, #hi_addr(USART2_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #0
IT	NE
BNE	L_main6
IT	AL
BAL	L_main5
L_main6:
;serial_extra_usart2.c,106 :: 		rx_buffer = USART2_DR;		// read data from receiver data register
MOVW	R0, #lo_addr(USART2_DR+0)
MOVT	R0, #hi_addr(USART2_DR+0)
; rx_buffer start address is: 4 (R1)
LDR	R1, [R0, #0]
; rx_buffer end address is: 4 (R1)
;serial_extra_usart2.c,112 :: 		while ( (USART2_SR & (1 << 7)) == 0) {}
L_main7:
; rx_buffer start address is: 4 (R1)
MOVW	R0, #lo_addr(USART2_SR+0)
MOVT	R0, #hi_addr(USART2_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	NE
BNE	L_main8
IT	AL
BAL	L_main7
L_main8:
;serial_extra_usart2.c,115 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main9:
SUBS	R7, R7, #1
BNE	L_main9
NOP
NOP
NOP
;serial_extra_usart2.c,117 :: 		USART2_DR = rx_buffer;
MOVW	R0, #lo_addr(USART2_DR+0)
MOVT	R0, #hi_addr(USART2_DR+0)
STR	R1, [R0, #0]
; rx_buffer end address is: 4 (R1)
;serial_extra_usart2.c,119 :: 		}
IT	AL
BAL	L_main2
;serial_extra_usart2.c,120 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
