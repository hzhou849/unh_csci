_main:
;p4_serial_comm.c,18 :: 		void main() {
SUB	SP, SP, #4
;p4_serial_comm.c,19 :: 		InitializeUSART1();		// Call sub function to initialize USART1
BL	_InitializeUSART1+0
;p4_serial_comm.c,23 :: 		for(;;) {
L_main0:
;p4_serial_comm.c,28 :: 		while (!((USART1_SR & (1<<5))== 0x20)){} // Check RXNE in USART1 Status Register.
L_main3:
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #32
IT	EQ
BEQ	L_main4
IT	AL
BAL	L_main3
L_main4:
;p4_serial_comm.c,35 :: 		rcvrd = USART1_DR;    //read data from receiver data register
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_rcvrd+0)
MOVT	R0, #hi_addr(_rcvrd+0)
STRH	R1, [R0, #0]
;p4_serial_comm.c,37 :: 		while (! (USART1_SR & (1<<7)) == 0x80) {}
L_main5:
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
MOVW	R0, #0
BNE	L__main10
MOVS	R0, #1
L__main10:
UXTB	R0, R0
CMP	R0, #128
IT	NE
BNE	L_main6
IT	AL
BAL	L_main5
L_main6:
;p4_serial_comm.c,39 :: 		USART1_DR = rcvrd;                // transmit the received data
MOVW	R0, #lo_addr(_rcvrd+0)
MOVT	R0, #hi_addr(_rcvrd+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,40 :: 		}
IT	AL
BAL	L_main0
;p4_serial_comm.c,41 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_InitializeUSART1:
;p4_serial_comm.c,44 :: 		void InitializeUSART1(){ // Sub function which initializes the registers to enable USART1
SUB	SP, SP, #4
;p4_serial_comm.c,45 :: 		RCC_APB2ENR |= 1;                 // Enable clock for Alt. Function. USART1 uses AF for PA9/PA10
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,46 :: 		AFIO_MAPR=0X0F000000;             // Do not mask PA9 and PA10 (becaue we are using for USART)
MOV	R1, #251658240
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,47 :: 		RCC_APB2ENR |= 1<<2;              // Enable clock for GPIOA
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,48 :: 		GPIOA_CRH &= ~(0xFF << 4);        // Clear PA9, PA10
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,49 :: 		GPIOA_CRH |= (0x0B << 4);         // USART1 Tx (PA9) output push-pull
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,50 :: 		GPIOA_CRH |= (0x04 << 8);         // USART1 Rx (PA10) input floating
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,51 :: 		RCC_APB2ENR |= 1<<14;             // enable clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,52 :: 		USART1_BRR=0X00000506;            // Set baud rate to 56000
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,57 :: 		USART1_CR1 &= ~(1<<12);          // Force 8 data bits. M bit is set to 0.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,58 :: 		USART1_CR2 &= ~(3<<12);          // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,59 :: 		USART1_CR3 &= ~(3<<8);           // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,60 :: 		USART1_CR1 &= ~(3<<9);           // Force no parity and no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,61 :: 		USART1_CR1 |= 3<<2;              // RX, TX enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,65 :: 		USART1_CR1 |= 1<<13;            // USART1 enable. This is done after configuration is complete
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,66 :: 		Delay_ms(100);                  // Wait for USART to complete configuration and enable. This is
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_InitializeUSART17:
SUBS	R7, R7, #1
BNE	L_InitializeUSART17
NOP
NOP
NOP
;p4_serial_comm.c,68 :: 		}
L_end_InitializeUSART1:
ADD	SP, SP, #4
BX	LR
; end of _InitializeUSART1
