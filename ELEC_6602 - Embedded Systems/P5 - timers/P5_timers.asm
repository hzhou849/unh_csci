_read_data:
;P5_timers.c,53 :: 		void read_data(uint32_t *rx_buffer) {
; rx_buffer start address is: 0 (R0)
SUB	SP, SP, #4
; rx_buffer end address is: 0 (R0)
; rx_buffer start address is: 0 (R0)
; rx_buffer end address is: 0 (R0)
;P5_timers.c,55 :: 		while ( (USART1_SR & (1 << 5)) == 0 ) {}
L_read_data0:
; rx_buffer start address is: 0 (R0)
MOVW	R1, #lo_addr(USART1_SR+0)
MOVT	R1, #hi_addr(USART1_SR+0)
LDR	R1, [R1, #0]
AND	R1, R1, #32
CMP	R1, #0
IT	NE
BNE	L_read_data1
IT	AL
BAL	L_read_data0
L_read_data1:
;P5_timers.c,57 :: 		*rx_buffer = USART1_DR;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
LDR	R1, [R1, #0]
STR	R1, [R0, #0]
; rx_buffer end address is: 0 (R0)
;P5_timers.c,59 :: 		while ( (USART1_SR & (1 << 7)) == 0) {}
L_read_data2:
MOVW	R1, #lo_addr(USART1_SR+0)
MOVT	R1, #hi_addr(USART1_SR+0)
LDR	R1, [R1, #0]
AND	R1, R1, #128
CMP	R1, #0
IT	NE
BNE	L_read_data3
IT	AL
BAL	L_read_data2
L_read_data3:
;P5_timers.c,60 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_read_data4:
SUBS	R7, R7, #1
BNE	L_read_data4
NOP
NOP
NOP
;P5_timers.c,61 :: 		}
L_end_read_data:
ADD	SP, SP, #4
BX	LR
; end of _read_data
_serial_to_int:
;P5_timers.c,65 :: 		uint32_t serial_to_int(uint32_t *rx_buffer) {
; rx_buffer start address is: 0 (R0)
SUB	SP, SP, #4
; rx_buffer end address is: 0 (R0)
; rx_buffer start address is: 0 (R0)
;P5_timers.c,68 :: 		if ( (*rx_buffer >= ASCII_HEX_O) && (*rx_buffer <= 0x34) ) {
LDR	R1, [R0, #0]
CMP	R1, #48
IT	CC
BCC	L__serial_to_int49
LDR	R1, [R0, #0]
CMP	R1, #52
IT	HI
BHI	L__serial_to_int48
L__serial_to_int47:
;P5_timers.c,69 :: 		return (*rx_buffer - ASCII_HEX_O);
LDR	R1, [R0, #0]
; rx_buffer end address is: 0 (R0)
SUBS	R1, #48
MOV	R0, R1
IT	AL
BAL	L_end_serial_to_int
;P5_timers.c,68 :: 		if ( (*rx_buffer >= ASCII_HEX_O) && (*rx_buffer <= 0x34) ) {
L__serial_to_int49:
L__serial_to_int48:
;P5_timers.c,74 :: 		}
MOVS	R0, #1
L_end_serial_to_int:
ADD	SP, SP, #4
BX	LR
; end of _serial_to_int
_write_data_char:
;P5_timers.c,77 :: 		void write_data_char(uint32_t *tx_char, uint8_t new_line_opt) {
; new_line_opt start address is: 4 (R1)
; tx_char start address is: 0 (R0)
SUB	SP, SP, #4
; new_line_opt end address is: 4 (R1)
; tx_char end address is: 0 (R0)
; tx_char start address is: 0 (R0)
; new_line_opt start address is: 4 (R1)
STRB	R1, [SP, #0]
; tx_char end address is: 0 (R0)
; new_line_opt end address is: 4 (R1)
MOV	R1, R0
LDRB	R0, [SP, #0]
;P5_timers.c,79 :: 		while ( (USART1_SR & (1 << 7)) == 0 ) {}                        // Wait for transmit data register to be empty
L_write_data_char9:
; new_line_opt start address is: 0 (R0)
; tx_char start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_write_data_char10
IT	AL
BAL	L_write_data_char9
L_write_data_char10:
;P5_timers.c,81 :: 		Delay_ms(10);                                                   // Transmit data out via USART1
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char11:
SUBS	R7, R7, #1
BNE	L_write_data_char11
NOP
NOP
NOP
;P5_timers.c,82 :: 		USART1_DR = *tx_char;
LDR	R3, [R1, #0]
; tx_char end address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,84 :: 		if (new_line_opt == 1) {
CMP	R0, #1
IT	NE
BNE	L_write_data_char13
; new_line_opt end address is: 0 (R0)
;P5_timers.c,85 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char14:
SUBS	R7, R7, #1
BNE	L_write_data_char14
NOP
NOP
NOP
;P5_timers.c,86 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,87 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char16:
SUBS	R7, R7, #1
BNE	L_write_data_char16
NOP
NOP
NOP
;P5_timers.c,88 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,89 :: 		}
L_write_data_char13:
;P5_timers.c,90 :: 		}
L_end_write_data_char:
ADD	SP, SP, #4
BX	LR
; end of _write_data_char
_print_string:
;P5_timers.c,95 :: 		void print_string(uint8_t *arr_string, uint8_t new_line_opt) {
; new_line_opt start address is: 4 (R1)
; arr_string start address is: 0 (R0)
SUB	SP, SP, #260
STR	LR, [SP, #0]
; new_line_opt end address is: 4 (R1)
; arr_string end address is: 0 (R0)
; arr_string start address is: 0 (R0)
; new_line_opt start address is: 4 (R1)
;P5_timers.c,97 :: 		uint32_t i = 0;
; i start address is: 36 (R9)
MOV	R9, #0
; arr_string end address is: 0 (R0)
; new_line_opt end address is: 4 (R1)
; i end address is: 36 (R9)
MOV	R8, R0
UXTB	R6, R1
;P5_timers.c,100 :: 		while (arr_string[i] != '\0') {
L_print_string18:
; i start address is: 36 (R9)
; new_line_opt start address is: 24 (R6)
; new_line_opt start address is: 24 (R6)
; new_line_opt end address is: 24 (R6)
; arr_string start address is: 32 (R8)
ADD	R2, R8, R9, LSL #0
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_print_string19
; new_line_opt end address is: 24 (R6)
;P5_timers.c,101 :: 		buffer[i] = (buffer[i] & (uint32_t) 0x00000000) | arr_string[i];
; new_line_opt start address is: 24 (R6)
ADD	R5, SP, #4
LSL	R2, R9, #2
ADDS	R4, R5, R2
LDR	R2, [R4, #0]
AND	R3, R2, #0
ADD	R2, R8, R9, LSL #0
LDRB	R2, [R2, #0]
ORR	R2, R3, R2, LSL #0
STR	R2, [R4, #0]
;P5_timers.c,102 :: 		write_data_char ( &buffer[i], new_line_opt);
LSL	R2, R9, #2
ADDS	R2, R5, R2
UXTB	R1, R6
MOV	R0, R2
BL	_write_data_char+0
;P5_timers.c,103 :: 		i++;
ADD	R9, R9, #1
;P5_timers.c,104 :: 		}
; new_line_opt end address is: 24 (R6)
; arr_string end address is: 32 (R8)
; i end address is: 36 (R9)
IT	AL
BAL	L_print_string18
L_print_string19:
;P5_timers.c,106 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_string20:
SUBS	R7, R7, #1
BNE	L_print_string20
NOP
NOP
NOP
;P5_timers.c,107 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,108 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_string22:
SUBS	R7, R7, #1
BNE	L_print_string22
NOP
NOP
NOP
;P5_timers.c,109 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,110 :: 		}
L_end_print_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #260
BX	LR
; end of _print_string
_main:
;P5_timers.c,112 :: 		void main() {
SUB	SP, SP, #96
;P5_timers.c,114 :: 		uint8_t div_wait_flag  = FALSE;
;P5_timers.c,115 :: 		uint8_t  tim1_wait_flag = FALSE;
;P5_timers.c,116 :: 		uint8_t  tim2_wait_flag = FALSE;
;P5_timers.c,117 :: 		uint8_t wait_flag       = FALSE;
; wait_flag start address is: 8 (R2)
MOVS	R2, #0
;P5_timers.c,121 :: 		uint32_t sequence_count = 0;
;P5_timers.c,123 :: 		uint32_t tim1_multiplier = 1;
; tim1_multiplier start address is: 12 (R3)
MOV	R3, #1
;P5_timers.c,124 :: 		uint32_t tim2_multiplier = 1;
; tim2_multiplier start address is: 16 (R4)
MOV	R4, #1
;P5_timers.c,127 :: 		uint8_t title_divider[]  = "=============================================================";
;P5_timers.c,128 :: 		uint8_t tim1_prompt  []  = "Please enter delay time (1-4) for TIMER1: ";
ADD	R11, SP, #8
ADD	R10, R11, #86
MOVW	R12, #lo_addr(?ICSmain_tim1_prompt_L0+0)
MOVT	R12, #hi_addr(?ICSmain_tim1_prompt_L0+0)
BL	___CC2DW+0
;P5_timers.c,129 :: 		uint8_t tim2_prompt  []  = "Please enter delay time (1-4) for TIMER2: ";
;P5_timers.c,130 :: 		uint8_t title_cr_lf  []  = "\x0D\x0A";
;P5_timers.c,136 :: 		RCC_CR = 0x05010081;
MOVW	R1, #129
MOVT	R1, #1281
MOVW	R0, #lo_addr(RCC_CR+0)
MOVT	R0, #hi_addr(RCC_CR+0)
STR	R1, [R0, #0]
;P5_timers.c,143 :: 		RCC_CFGR = 0x091D8402; // IDE Scheme
MOVW	R1, #33794
MOVT	R1, #2333
MOVW	R0, #lo_addr(RCC_CFGR+0)
MOVT	R0, #hi_addr(RCC_CFGR+0)
STR	R1, [R0, #0]
;P5_timers.c,151 :: 		RCC_CFGR2 = 0x00010644;
MOVW	R1, #1604
MOVT	R1, #1
MOVW	R0, #lo_addr(RCC_CFGR2+0)
MOVT	R0, #hi_addr(RCC_CFGR2+0)
STR	R1, [R0, #0]
;P5_timers.c,157 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,160 :: 		RCC_APB2ENR |= 0x00000001;                  // Alt. function bit to enable USART1 PA9/PA10
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,161 :: 		AFIO_MAPR  = 0x00000000;                    // Bit[2] USART1 REMAP 0: No Remap
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P5_timers.c,163 :: 		RCC_APB2ENR |= 1 << 2;                      // Enable GPIO Clock - Port A for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,164 :: 		RCC_APB2ENR |= 1 << 3;                      // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,165 :: 		RCC_APB2ENR |= 1 << 4;                      // Enable GPIO Clock - Port C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,166 :: 		RCC_APB2ENR |= 1 << 5;                      // Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,167 :: 		RCC_APB2ENR |= 1 << 6;                      // Enable GPIO Clock - Port E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,168 :: 		RCC_APB2ENR |= 1 << 14;                     // Enable USART1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,173 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10->mask with  FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,174 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AFoutput push-pull b10; MODE:50Hz
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,175 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=Input-floating b01; MODE: Input mode b00;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,177 :: 		GPIOB_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,178 :: 		GPIOB_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,179 :: 		GPIOC_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,180 :: 		GPIOC_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,181 :: 		GPIOD_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,182 :: 		GPIOD_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,183 :: 		GPIOE_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,184 :: 		GPIOE_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,187 :: 		USART1_BRR = 0x00000506;                   // Clock=72MHz, oversample=16x; 72MHz / (16 * 56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P5_timers.c,191 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,192 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,193 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,194 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P5_timers.c,195 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P5_timers.c,197 :: 		USART1_CR1 |= (3 << 2);                     // Rx, Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,198 :: 		Delay_ms(100);                              // Allow time for USART to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main24:
SUBS	R7, R7, #1
BNE	L_main24
NOP
NOP
NOP
;P5_timers.c,199 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,203 :: 		RCC_APB2ENR |= (1 << 11);                   // Enable TIMER1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2048
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,204 :: 		RCC_APB1ENR |= (1 << 2);                    // Enable TIMER4 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,210 :: 		TIM1_CR1 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,211 :: 		TIM4_CR1 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM4_CR1+0)
MOVT	R0, #hi_addr(TIM4_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,218 :: 		TIM1_PSC = 7999;
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;P5_timers.c,219 :: 		TIM4_PSC = 7999;
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM4_PSC+0)
MOVT	R0, #hi_addr(TIM4_PSC+0)
STR	R1, [R0, #0]
;P5_timers.c,225 :: 		TIM1_ARR = ( (uint32_t)9000 * tim1_multiplier );
MOVW	R0, #9000
MOVT	R0, #0
MUL	R1, R0, R3
; tim1_multiplier end address is: 12 (R3)
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;P5_timers.c,226 :: 		TIM4_ARR = ( (uint32_t)9000 * tim2_multiplier );              // 2 seconds
MOVW	R0, #9000
MOVT	R0, #0
MUL	R1, R0, R4
; tim2_multiplier end address is: 16 (R4)
MOVW	R0, #lo_addr(TIM4_ARR+0)
MOVT	R0, #hi_addr(TIM4_ARR+0)
STR	R1, [R0, #0]
;P5_timers.c,228 :: 		TIM1_CR1 = 0x0001;                          // Finished configuration, now we can enable TIMER1; BIT4=0 couting up
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,229 :: 		TIM4_CR1 = 0x0001;                          // Finished configuration, now we can enable TIMER4; BIT4=0 couting up
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM4_CR1+0)
MOVT	R0, #hi_addr(TIM4_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,232 :: 		GPIOB_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,233 :: 		GPIOC_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,234 :: 		GPIOD_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,235 :: 		GPIOE_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; wait_flag end address is: 8 (R2)
;P5_timers.c,239 :: 		for (;;) {
L_main26:
;P5_timers.c,242 :: 		if (wait_flag == FALSE) {
; wait_flag start address is: 8 (R2)
CMP	R2, #0
IT	NE
BNE	L__main50
;P5_timers.c,252 :: 		}
L_main30:
;P5_timers.c,253 :: 		else if ( sequence_count = 1 && wait_flag == TRUE ) {
CMP	R2, #1
IT	NE
BNE	L_main35
; wait_flag end address is: 8 (R2)
MOVS	R0, #1
IT	AL
BAL	L_main34
L_main35:
MOVS	R0, #0
L_main34:
; sequence_count start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_main36
; sequence_count end address is: 0 (R0)
;P5_timers.c,254 :: 		print_string(tim1_prompt, NO_NEW_LINE);
ADD	R0, SP, #8
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,256 :: 		wait_flag = TRUE;
; wait_flag start address is: 0 (R0)
MOVS	R0, #1
;P5_timers.c,257 :: 		}
UXTB	R2, R0
; wait_flag end address is: 0 (R0)
IT	AL
BAL	L_main37
L_main36:
;P5_timers.c,259 :: 		print_string(tim2_prompt, NO_NEW_LINE);
ADD	R0, SP, #51
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,260 :: 		wait_flag = TRUE;
; wait_flag start address is: 0 (R0)
MOVS	R0, #1
; wait_flag end address is: 0 (R0)
UXTB	R2, R0
;P5_timers.c,263 :: 		}
L_main37:
;P5_timers.c,264 :: 		}
; wait_flag start address is: 8 (R2)
; wait_flag end address is: 8 (R2)
IT	AL
BAL	L_main29
L__main50:
;P5_timers.c,242 :: 		if (wait_flag == FALSE) {
;P5_timers.c,264 :: 		}
L_main29:
;P5_timers.c,269 :: 		if ( (USART1_SR & (1 << 5))) {
; wait_flag start address is: 8 (R2)
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #0
IT	EQ
BEQ	L__main51
;P5_timers.c,270 :: 		rx_buffer = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
; wait_flag end address is: 8 (R2)
;P5_timers.c,272 :: 		while ( (USART1_SR & ( 1 << 7)) ==0 ) {}
L_main40:
; wait_flag start address is: 8 (R2)
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	NE
BNE	L_main41
IT	AL
BAL	L_main40
L_main41:
;P5_timers.c,273 :: 		USART1_DR = rx_buffer;
LDR	R1, [SP, #4]
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
;P5_timers.c,278 :: 		tim1_multiplier = serial_to_int(&rx_buffer);
ADD	R0, SP, #4
BL	_serial_to_int+0
;P5_timers.c,285 :: 		TIM1_ARR = ( (uint32_t)9000 * tim1_multiplier );
MOVW	R1, #9000
MOVT	R1, #0
MULS	R1, R0, R1
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;P5_timers.c,299 :: 		}
L_main43:
;P5_timers.c,302 :: 		}
IT	AL
BAL	L_main39
; wait_flag end address is: 8 (R2)
L__main51:
;P5_timers.c,269 :: 		if ( (USART1_SR & (1 << 5))) {
;P5_timers.c,302 :: 		}
L_main39:
;P5_timers.c,310 :: 		if ( TIM1_SR.UIF == 1 ) {
; wait_flag start address is: 8 (R2)
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_LX	[R0, ByteOffset(TIM1_SR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main45
;P5_timers.c,313 :: 		TIM1_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_SX	[R0, ByteOffset(TIM1_SR+0)]
;P5_timers.c,314 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,315 :: 		GPIOC_ODR = ~GPIOC_ODR;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,318 :: 		}
L_main45:
;P5_timers.c,319 :: 		if ( TIM4_SR.UIF == 1 ) {
MOVW	R0, #lo_addr(TIM4_SR+0)
MOVT	R0, #hi_addr(TIM4_SR+0)
_LX	[R0, ByteOffset(TIM4_SR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main46
;P5_timers.c,321 :: 		TIM4_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM4_SR+0)
MOVT	R0, #hi_addr(TIM4_SR+0)
_SX	[R0, ByteOffset(TIM4_SR+0)]
;P5_timers.c,322 :: 		GPIOD_ODR = ~GPIOD_ODR;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,323 :: 		GPIOE_ODR = ~GPIOE_ODR;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,324 :: 		}
L_main46:
;P5_timers.c,332 :: 		}
; wait_flag end address is: 8 (R2)
IT	AL
BAL	L_main26
;P5_timers.c,335 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
