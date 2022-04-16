_serial_to_int:
;P5_timers.c,69 :: 		uint32_t serial_to_int(uint32_t *rx_buffer) {
; rx_buffer start address is: 0 (R0)
SUB	SP, SP, #4
; rx_buffer end address is: 0 (R0)
; rx_buffer start address is: 0 (R0)
;P5_timers.c,71 :: 		if ( (*rx_buffer >= ASCII_HEX_O) && (*rx_buffer <= 0x34) ) {     // if input buffer is between 0x30 and 0x34, integer [1:4] we know its an integer
LDR	R1, [R0, #0]
CMP	R1, #48
IT	CC
BCC	L__serial_to_int61
LDR	R1, [R0, #0]
CMP	R1, #52
IT	HI
BHI	L__serial_to_int60
L__serial_to_int59:
;P5_timers.c,72 :: 		return (*rx_buffer - ASCII_HEX_O);
LDR	R1, [R0, #0]
; rx_buffer end address is: 0 (R0)
SUBS	R1, #48
MOV	R0, R1
IT	AL
BAL	L_end_serial_to_int
;P5_timers.c,71 :: 		if ( (*rx_buffer >= ASCII_HEX_O) && (*rx_buffer <= 0x34) ) {     // if input buffer is between 0x30 and 0x34, integer [1:4] we know its an integer
L__serial_to_int61:
L__serial_to_int60:
;P5_timers.c,75 :: 		return 1;                                                        // Everything else default 1 second
MOVS	R0, #1
;P5_timers.c,76 :: 		}
L_end_serial_to_int:
ADD	SP, SP, #4
BX	LR
; end of _serial_to_int
_write_data_char:
;P5_timers.c,79 :: 		void write_data_char(uint32_t *tx_char, uint8_t new_line_opt) {
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
;P5_timers.c,82 :: 		while ( (USART1_SR & (1 << 7)) == 0 ) {}                        // Wait for transmit data register to be empty
L_write_data_char3:
; new_line_opt start address is: 0 (R0)
; tx_char start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_write_data_char4
IT	AL
BAL	L_write_data_char3
L_write_data_char4:
;P5_timers.c,83 :: 		Delay_ms(10);                                                   // Transmit data out via USART1
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char5:
SUBS	R7, R7, #1
BNE	L_write_data_char5
NOP
NOP
NOP
;P5_timers.c,84 :: 		USART1_DR = *tx_char;
LDR	R3, [R1, #0]
; tx_char end address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,86 :: 		if (new_line_opt == 1) {
CMP	R0, #1
IT	NE
BNE	L_write_data_char7
; new_line_opt end address is: 0 (R0)
;P5_timers.c,87 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char8:
SUBS	R7, R7, #1
BNE	L_write_data_char8
NOP
NOP
NOP
;P5_timers.c,88 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,89 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char10:
SUBS	R7, R7, #1
BNE	L_write_data_char10
NOP
NOP
NOP
;P5_timers.c,90 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,91 :: 		}
L_write_data_char7:
;P5_timers.c,92 :: 		}
L_end_write_data_char:
ADD	SP, SP, #4
BX	LR
; end of _write_data_char
_print_string:
;P5_timers.c,97 :: 		void print_string(uint8_t *arr_string, uint8_t new_line_opt) {
; new_line_opt start address is: 4 (R1)
; arr_string start address is: 0 (R0)
SUB	SP, SP, #260
STR	LR, [SP, #0]
; new_line_opt end address is: 4 (R1)
; arr_string end address is: 0 (R0)
; arr_string start address is: 0 (R0)
; new_line_opt start address is: 4 (R1)
;P5_timers.c,99 :: 		uint32_t i = 0;
; i start address is: 36 (R9)
MOV	R9, #0
; arr_string end address is: 0 (R0)
; new_line_opt end address is: 4 (R1)
; i end address is: 36 (R9)
MOV	R8, R0
UXTB	R6, R1
;P5_timers.c,102 :: 		while (arr_string[i] != '\0') {
L_print_string12:
; i start address is: 36 (R9)
; new_line_opt start address is: 24 (R6)
; new_line_opt start address is: 24 (R6)
; new_line_opt end address is: 24 (R6)
; arr_string start address is: 32 (R8)
ADD	R2, R8, R9, LSL #0
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_print_string13
; new_line_opt end address is: 24 (R6)
;P5_timers.c,103 :: 		buffer[i] = (buffer[i] & (uint32_t) 0x00000000) | arr_string[i];
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
;P5_timers.c,104 :: 		write_data_char ( &buffer[i], new_line_opt);
LSL	R2, R9, #2
ADDS	R2, R5, R2
UXTB	R1, R6
MOV	R0, R2
BL	_write_data_char+0
;P5_timers.c,105 :: 		i++;
ADD	R9, R9, #1
;P5_timers.c,106 :: 		}
; new_line_opt end address is: 24 (R6)
; arr_string end address is: 32 (R8)
; i end address is: 36 (R9)
IT	AL
BAL	L_print_string12
L_print_string13:
;P5_timers.c,108 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_string14:
SUBS	R7, R7, #1
BNE	L_print_string14
NOP
NOP
NOP
;P5_timers.c,109 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,110 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_string16:
SUBS	R7, R7, #1
BNE	L_print_string16
NOP
NOP
NOP
;P5_timers.c,111 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P5_timers.c,112 :: 		}
L_end_print_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #260
BX	LR
; end of _print_string
_print_int:
;P5_timers.c,114 :: 		void print_int(uint32_t *int_num) {
; int_num start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; int_num end address is: 0 (R0)
; int_num start address is: 0 (R0)
;P5_timers.c,116 :: 		uint32_t temp_val = (*int_num + ASCII_HEX_O);
LDR	R1, [R0, #0]
; int_num end address is: 0 (R0)
ADDS	R1, #48
STR	R1, [SP, #4]
;P5_timers.c,118 :: 		write_data_char(&temp_val, NO_NEW_LINE);
ADD	R1, SP, #4
MOV	R0, R1
MOVS	R1, #0
BL	_write_data_char+0
;P5_timers.c,125 :: 		}
L_end_print_int:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _print_int
_main:
;P5_timers.c,127 :: 		void main() {
SUB	SP, SP, #300
;P5_timers.c,129 :: 		uint32_t sequence_count = 0;
; sequence_count start address is: 8 (R2)
MOV	R2, #0
;P5_timers.c,130 :: 		uint8_t div_ask_time_flag  = FALSE;
;P5_timers.c,131 :: 		uint8_t  tim1_ask_time_flag = FALSE;
;P5_timers.c,132 :: 		uint8_t  tim2_ask_time_flag = FALSE;
;P5_timers.c,133 :: 		uint8_t ask_time_flag       = FALSE;
; ask_time_flag start address is: 12 (R3)
MOVS	R3, #0
;P5_timers.c,134 :: 		uint8_t r_key_rcvd      = TRUE;
; r_key_rcvd start address is: 16 (R4)
MOVS	R4, #1
;P5_timers.c,138 :: 		uint32_t i=0;
;P5_timers.c,140 :: 		uint32_t tim1_multiplier = 1;
ADD	R11, SP, #8
ADDW	R10, R11, #291
MOVW	R12, #lo_addr(?ICSmain_tim1_multiplier_L0+0)
MOVT	R12, #hi_addr(?ICSmain_tim1_multiplier_L0+0)
BL	___CC2DW+0
;P5_timers.c,141 :: 		uint32_t tim2_multiplier = 1;
;P5_timers.c,144 :: 		uint8_t title_divider[]  = "=============================================================";
;P5_timers.c,145 :: 		uint8_t start_prompt []  = "Press 'R or r' to start or 'Q q' to quit.";
;P5_timers.c,146 :: 		uint8_t tim1_prompt  []  = "Please enter delay time (1-4) for TIMER1: ";
;P5_timers.c,147 :: 		uint8_t tim2_prompt  []  = "Please enter delay time (1-4) for TIMER2: ";
;P5_timers.c,148 :: 		uint8_t title_cr_lf  []  = "\x0D\x0A";
;P5_timers.c,149 :: 		uint8_t tim1_info[]    = "TIMER1 delay seconds value: ";
;P5_timers.c,150 :: 		uint8_t tim2_info[]    = "TIMER2 delay seconds value:  ";
;P5_timers.c,151 :: 		uint8_t goodbye  []    = "TIMER 1 & 4 DISABLED, goodbye!";
;P5_timers.c,158 :: 		RCC_CR = 0x05010081;
MOVW	R1, #129
MOVT	R1, #1281
MOVW	R0, #lo_addr(RCC_CR+0)
MOVT	R0, #hi_addr(RCC_CR+0)
STR	R1, [R0, #0]
;P5_timers.c,165 :: 		RCC_CFGR = 0x091D8402; // IDE Scheme
MOVW	R1, #33794
MOVT	R1, #2333
MOVW	R0, #lo_addr(RCC_CFGR+0)
MOVT	R0, #hi_addr(RCC_CFGR+0)
STR	R1, [R0, #0]
;P5_timers.c,173 :: 		RCC_CFGR2 = 0x00010644;
MOVW	R1, #1604
MOVT	R1, #1
MOVW	R0, #lo_addr(RCC_CFGR2+0)
MOVT	R0, #hi_addr(RCC_CFGR2+0)
STR	R1, [R0, #0]
;P5_timers.c,179 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,182 :: 		RCC_APB2ENR |= 0x00000001;                  // Alt. function bit to enable USART1 PA9/PA10
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,183 :: 		AFIO_MAPR    = 0x00000000;                  // Bit[2] USART1 REMAP 0: No Remap
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P5_timers.c,185 :: 		RCC_APB2ENR |= 1 << 2;                      // Enable GPIO Clock - Port A for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,186 :: 		RCC_APB2ENR |= 1 << 3;                      // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,187 :: 		RCC_APB2ENR |= 1 << 4;                      // Enable GPIO Clock - Port C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,188 :: 		RCC_APB2ENR |= 1 << 5;                      // Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,189 :: 		RCC_APB2ENR |= 1 << 6;                      // Enable GPIO Clock - Port E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,190 :: 		RCC_APB2ENR |= 1 << 14;                     // Enable USART1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,194 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10->mask with  FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,195 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AFoutput push-pull b10; MODE:50Hz
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,196 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=Input-floating b01; MODE: Input mode b00;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,198 :: 		GPIOB_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOB_CRH+0)
MOVT	R0, #hi_addr(GPIOB_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,199 :: 		GPIOB_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,200 :: 		GPIOC_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,201 :: 		GPIOC_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,202 :: 		GPIOD_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,203 :: 		GPIOD_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,204 :: 		GPIOE_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P5_timers.c,205 :: 		GPIOE_CRL = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;P5_timers.c,209 :: 		USART1_BRR = 0x00000506;                   // Clock=72MHz, oversample=16x; 72MHz / (16 * 56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P5_timers.c,213 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,214 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,215 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,216 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P5_timers.c,217 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P5_timers.c,218 :: 		USART1_CR1 |= (3 << 2);                     // Rx, Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,219 :: 		Delay_ms(100);                              // Allow time for USART to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main18:
SUBS	R7, R7, #1
BNE	L_main18
NOP
NOP
NOP
;P5_timers.c,220 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,224 :: 		RCC_APB2ENR |= (1 << 11);                   // Enable TIMER1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2048
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,225 :: 		RCC_APB1ENR |= (1 << 2);                    // Enable TIMER4 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,231 :: 		TIM1_CR1 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,232 :: 		TIM4_CR1 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM4_CR1+0)
MOVT	R0, #hi_addr(TIM4_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,239 :: 		TIM1_PSC = 7999;
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM1_PSC+0)
MOVT	R0, #hi_addr(TIM1_PSC+0)
STR	R1, [R0, #0]
;P5_timers.c,240 :: 		TIM4_PSC = 7999;
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM4_PSC+0)
MOVT	R0, #hi_addr(TIM4_PSC+0)
STR	R1, [R0, #0]
;P5_timers.c,246 :: 		TIM1_ARR = ( (uint32_t)9000 * tim1_multiplier );
LDR	R1, [SP, #8]
MOVW	R0, #9000
MOVT	R0, #0
MULS	R1, R0, R1
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;P5_timers.c,247 :: 		TIM4_ARR = ( (uint32_t)9000 * tim2_multiplier );              // 2 seconds
LDR	R1, [SP, #12]
MOVW	R0, #9000
MOVT	R0, #0
MULS	R1, R0, R1
MOVW	R0, #lo_addr(TIM4_ARR+0)
MOVT	R0, #hi_addr(TIM4_ARR+0)
STR	R1, [R0, #0]
;P5_timers.c,249 :: 		TIM1_CR1 = 0x0001;                          // Finished configuration, now we can enable TIMER1; BIT4=0 couting up
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM1_CR1+0)
MOVT	R0, #hi_addr(TIM1_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,250 :: 		TIM4_CR1 = 0x0001;                          // Finished configuration, now we can enable TIMER4; BIT4=0 couting up
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM4_CR1+0)
MOVT	R0, #hi_addr(TIM4_CR1+0)
STR	R1, [R0, #0]
;P5_timers.c,253 :: 		GPIOB_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,254 :: 		GPIOC_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,255 :: 		GPIOD_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,256 :: 		GPIOE_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
; sequence_count end address is: 8 (R2)
; r_key_rcvd end address is: 16 (R4)
; ask_time_flag end address is: 12 (R3)
MOV	R12, R2
UXTB	R11, R3
UXTB	R10, R4
;P5_timers.c,261 :: 		for (;;) {
L_main20:
;P5_timers.c,264 :: 		if (ask_time_flag == FALSE ) {
; r_key_rcvd start address is: 40 (R10)
; ask_time_flag start address is: 44 (R11)
; sequence_count start address is: 48 (R12)
CMP	R11, #0
IT	NE
BNE	L__main83
;P5_timers.c,266 :: 		if ( sequence_count == 0) {
CMP	R12, #0
IT	NE
BNE	L_main24
; r_key_rcvd end address is: 40 (R10)
;P5_timers.c,267 :: 		print_string(title_cr_lf, NO_NEW_LINE);
ADD	R0, SP, #206
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,269 :: 		print_string(title_divider, NO_NEW_LINE);
ADD	R0, SP, #16
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,270 :: 		print_string(&start_prompt, NO_NEW_LINE);   // Print start prompt message
ADD	R0, SP, #78
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,272 :: 		r_key_rcvd = FALSE;
; r_key_rcvd start address is: 4 (R1)
MOVS	R1, #0
;P5_timers.c,273 :: 		sequence_count++;
ADD	R3, R12, #1
; sequence_count end address is: 48 (R12)
; sequence_count start address is: 12 (R3)
;P5_timers.c,274 :: 		}
; r_key_rcvd end address is: 4 (R1)
; sequence_count end address is: 12 (R3)
UXTB	R0, R11
IT	AL
BAL	L_main25
L_main24:
;P5_timers.c,275 :: 		else if ( sequence_count == 1  && r_key_rcvd == TRUE ) {
; sequence_count start address is: 48 (R12)
; r_key_rcvd start address is: 40 (R10)
CMP	R12, #1
IT	NE
BNE	L__main69
CMP	R10, #1
IT	NE
BNE	L__main68
; ask_time_flag end address is: 44 (R11)
L__main67:
;P5_timers.c,276 :: 		print_string(title_cr_lf, NO_NEW_LINE);
ADD	R0, SP, #206
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,277 :: 		print_string(tim1_prompt, NO_NEW_LINE);
ADD	R0, SP, #120
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,278 :: 		ask_time_flag = TRUE;
; ask_time_flag start address is: 0 (R0)
MOVS	R0, #1
;P5_timers.c,279 :: 		}
; ask_time_flag end address is: 0 (R0)
IT	AL
BAL	L_main29
;P5_timers.c,275 :: 		else if ( sequence_count == 1  && r_key_rcvd == TRUE ) {
L__main69:
; ask_time_flag start address is: 44 (R11)
L__main68:
;P5_timers.c,280 :: 		else if (sequence_count == 2  && r_key_rcvd == TRUE ) {
CMP	R12, #2
IT	NE
BNE	L__main81
CMP	R10, #1
IT	NE
BNE	L__main82
; ask_time_flag end address is: 44 (R11)
L__main66:
;P5_timers.c,281 :: 		print_string(title_cr_lf, NO_NEW_LINE);
ADD	R0, SP, #206
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,282 :: 		print_string(tim2_prompt, NO_NEW_LINE);
ADD	R0, SP, #163
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,283 :: 		ask_time_flag = TRUE;
; ask_time_flag start address is: 0 (R0)
MOVS	R0, #1
; ask_time_flag end address is: 0 (R0)
;P5_timers.c,280 :: 		else if (sequence_count == 2  && r_key_rcvd == TRUE ) {
IT	AL
BAL	L__main71
L__main81:
UXTB	R0, R11
L__main71:
; ask_time_flag start address is: 0 (R0)
; ask_time_flag end address is: 0 (R0)
IT	AL
BAL	L__main70
L__main82:
UXTB	R0, R11
L__main70:
;P5_timers.c,284 :: 		}
; ask_time_flag start address is: 0 (R0)
; ask_time_flag end address is: 0 (R0)
L_main29:
; ask_time_flag start address is: 0 (R0)
UXTB	R1, R10
; r_key_rcvd end address is: 40 (R10)
; sequence_count end address is: 48 (R12)
; ask_time_flag end address is: 0 (R0)
MOV	R3, R12
L_main25:
;P5_timers.c,285 :: 		}
; ask_time_flag start address is: 0 (R0)
; sequence_count start address is: 12 (R3)
; r_key_rcvd start address is: 4 (R1)
UXTB	R2, R0
; ask_time_flag end address is: 0 (R0)
; r_key_rcvd end address is: 4 (R1)
; sequence_count end address is: 12 (R3)
UXTB	R0, R1
IT	AL
BAL	L_main23
L__main83:
;P5_timers.c,264 :: 		if (ask_time_flag == FALSE ) {
UXTB	R0, R10
MOV	R3, R12
UXTB	R2, R11
;P5_timers.c,285 :: 		}
L_main23:
;P5_timers.c,292 :: 		for (i=0; i < 10; i++) {
; r_key_rcvd start address is: 0 (R0)
; sequence_count start address is: 12 (R3)
; ask_time_flag start address is: 8 (R2)
; i start address is: 40 (R10)
MOVW	R10, #0
; r_key_rcvd end address is: 0 (R0)
; sequence_count end address is: 12 (R3)
; ask_time_flag end address is: 8 (R2)
; i end address is: 40 (R10)
UXTB	R11, R0
L_main33:
; i start address is: 40 (R10)
; ask_time_flag start address is: 8 (R2)
; sequence_count start address is: 12 (R3)
; r_key_rcvd start address is: 44 (R11)
CMP	R10, #10
IT	CS
BCS	L_main34
;P5_timers.c,294 :: 		if ( (USART1_SR & (1 << 5)) ) {
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #32
CMP	R0, #0
IT	EQ
BEQ	L__main86
;P5_timers.c,295 :: 		rx_buffer = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #4]
; r_key_rcvd end address is: 44 (R11)
; sequence_count end address is: 12 (R3)
; ask_time_flag end address is: 8 (R2)
; i end address is: 40 (R10)
UXTB	R1, R2
;P5_timers.c,297 :: 		while ( (USART1_SR & ( 1 << 7)) == 0 ) {}
L_main37:
; r_key_rcvd start address is: 44 (R11)
; sequence_count start address is: 12 (R3)
; ask_time_flag start address is: 4 (R1)
; i start address is: 40 (R10)
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	NE
BNE	L_main38
IT	AL
BAL	L_main37
L_main38:
;P5_timers.c,303 :: 		if (rx_buffer == 0x52 || rx_buffer == 0x72) {
LDR	R0, [SP, #4]
CMP	R0, #82
IT	EQ
BEQ	L__main73
LDR	R0, [SP, #4]
CMP	R0, #114
IT	EQ
BEQ	L__main72
IT	AL
BAL	L_main41
; r_key_rcvd end address is: 44 (R11)
L__main73:
L__main72:
;P5_timers.c,304 :: 		r_key_rcvd = TRUE;
; r_key_rcvd start address is: 44 (R11)
MOVW	R11, #1
;P5_timers.c,305 :: 		}
IT	AL
BAL	L_main42
L_main41:
;P5_timers.c,306 :: 		else if (rx_buffer == 0x51 || rx_buffer == 0x71) {
LDR	R0, [SP, #4]
CMP	R0, #81
IT	EQ
BEQ	L__main75
LDR	R0, [SP, #4]
CMP	R0, #113
IT	EQ
BEQ	L__main74
IT	AL
BAL	L_main45
; r_key_rcvd end address is: 44 (R11)
; ask_time_flag end address is: 4 (R1)
; sequence_count end address is: 12 (R3)
; i end address is: 40 (R10)
L__main75:
L__main74:
;P5_timers.c,311 :: 		RCC_APB2ENR |= ~(1 << 11);                   // Enable TIMER1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R1, [R0, #0]
MVN	R0, #2048
ORRS	R1, R0
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,312 :: 		RCC_APB1ENR |= ~(1 << 2);                    // Enable TIMER4 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R1, [R0, #0]
MVN	R0, #4
ORRS	R1, R0
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P5_timers.c,313 :: 		print_string(&goodbye, NO_NEW_LINE);
ADD	R0, SP, #268
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,314 :: 		return; // Quit
IT	AL
BAL	L_end_main
;P5_timers.c,315 :: 		}
L_main45:
; i start address is: 40 (R10)
; sequence_count start address is: 12 (R3)
; ask_time_flag start address is: 4 (R1)
; r_key_rcvd start address is: 44 (R11)
L_main42:
; r_key_rcvd end address is: 44 (R11)
;P5_timers.c,318 :: 		if (sequence_count == 1 && ask_time_flag == TRUE  && rx_buffer >=0x20) {
; r_key_rcvd start address is: 44 (R11)
CMP	R3, #1
IT	NE
BNE	L__main78
CMP	R1, #1
IT	NE
BNE	L__main77
LDR	R0, [SP, #4]
CMP	R0, #32
IT	CC
BCC	L__main76
; ask_time_flag end address is: 4 (R1)
L__main63:
;P5_timers.c,321 :: 		tim1_multiplier = serial_to_int(&rx_buffer);
ADD	R0, SP, #4
BL	_serial_to_int+0
STR	R0, [SP, #8]
;P5_timers.c,324 :: 		TIM1_ARR = (uint32_t)( 9000 * tim1_multiplier );
MOVW	R1, #9000
MULS	R1, R0, R1
MOVW	R0, #lo_addr(TIM1_ARR+0)
MOVT	R0, #hi_addr(TIM1_ARR+0)
STR	R1, [R0, #0]
;P5_timers.c,325 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main49:
SUBS	R7, R7, #1
BNE	L_main49
NOP
NOP
NOP
;P5_timers.c,326 :: 		ask_time_flag = FALSE;
; ask_time_flag start address is: 48 (R12)
MOVW	R12, #0
;P5_timers.c,327 :: 		sequence_count++;
ADDS	R0, R3, #1
; sequence_count end address is: 12 (R3)
; sequence_count start address is: 4 (R1)
MOV	R1, R0
;P5_timers.c,328 :: 		print_string(&tim1_info, NO_NEW_LINE);
ADD	R0, SP, #209
STR	R1, [SP, #0]
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,329 :: 		print_int(&tim1_multiplier);
ADD	R0, SP, #8
BL	_print_int+0
LDR	R1, [SP, #0]
;P5_timers.c,331 :: 		}
MOV	R4, R1
; ask_time_flag end address is: 48 (R12)
; sequence_count end address is: 4 (R1)
UXTB	R3, R12
UXTB	R2, R11
IT	AL
BAL	L_main51
;P5_timers.c,318 :: 		if (sequence_count == 1 && ask_time_flag == TRUE  && rx_buffer >=0x20) {
L__main78:
; sequence_count start address is: 12 (R3)
; ask_time_flag start address is: 4 (R1)
L__main77:
L__main76:
;P5_timers.c,332 :: 		else if (sequence_count == 2 && ask_time_flag == TRUE) {
CMP	R3, #2
IT	NE
BNE	L__main84
CMP	R1, #1
IT	NE
BNE	L__main85
; r_key_rcvd end address is: 44 (R11)
; ask_time_flag end address is: 4 (R1)
; sequence_count end address is: 12 (R3)
L__main62:
;P5_timers.c,335 :: 		tim2_multiplier = serial_to_int(&rx_buffer);
ADD	R0, SP, #4
BL	_serial_to_int+0
STR	R0, [SP, #12]
;P5_timers.c,338 :: 		TIM4_ARR = ( (uint32_t)9000 * tim2_multiplier );
MOVW	R1, #9000
MOVT	R1, #0
MULS	R1, R0, R1
MOVW	R0, #lo_addr(TIM4_ARR+0)
MOVT	R0, #hi_addr(TIM4_ARR+0)
STR	R1, [R0, #0]
;P5_timers.c,339 :: 		print_string(&tim2_info, NO_NEW_LINE);
ADD	R0, SP, #238
MOVS	R1, #0
BL	_print_string+0
;P5_timers.c,340 :: 		print_int(&tim2_multiplier);
ADD	R0, SP, #12
BL	_print_int+0
;P5_timers.c,342 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main55:
SUBS	R7, R7, #1
BNE	L_main55
NOP
NOP
NOP
;P5_timers.c,345 :: 		sequence_count = 0;
; sequence_count start address is: 16 (R4)
MOVS	R4, #0
;P5_timers.c,346 :: 		ask_time_flag = FALSE;
; ask_time_flag start address is: 4 (R1)
MOVS	R1, #0
;P5_timers.c,347 :: 		r_key_rcvd = FALSE;
; r_key_rcvd start address is: 0 (R0)
MOVS	R0, #0
; r_key_rcvd end address is: 0 (R0)
; ask_time_flag end address is: 4 (R1)
; sequence_count end address is: 16 (R4)
;P5_timers.c,332 :: 		else if (sequence_count == 2 && ask_time_flag == TRUE) {
IT	AL
BAL	L__main80
L__main84:
UXTB	R0, R11
MOV	R4, R3
L__main80:
; r_key_rcvd start address is: 0 (R0)
; ask_time_flag start address is: 4 (R1)
; sequence_count start address is: 16 (R4)
UXTB	R2, R0
; r_key_rcvd end address is: 0 (R0)
; ask_time_flag end address is: 4 (R1)
; sequence_count end address is: 16 (R4)
UXTB	R3, R1
IT	AL
BAL	L__main79
L__main85:
MOV	R4, R3
UXTB	R3, R1
UXTB	R2, R11
L__main79:
;P5_timers.c,348 :: 		}
; sequence_count start address is: 16 (R4)
; ask_time_flag start address is: 12 (R3)
; r_key_rcvd start address is: 8 (R2)
; r_key_rcvd end address is: 8 (R2)
; ask_time_flag end address is: 12 (R3)
; sequence_count end address is: 16 (R4)
L_main51:
;P5_timers.c,351 :: 		GPIOB_ODR = 0x0000;
; r_key_rcvd start address is: 8 (R2)
; ask_time_flag start address is: 12 (R3)
; sequence_count start address is: 16 (R4)
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,352 :: 		GPIOC_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,353 :: 		GPIOD_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,354 :: 		GPIOE_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,355 :: 		TIM1_CNT = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM1_CNT+0)
MOVT	R0, #hi_addr(TIM1_CNT+0)
STR	R1, [R0, #0]
;P5_timers.c,356 :: 		TIM4_CNT = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM4_CNT+0)
MOVT	R0, #hi_addr(TIM4_CNT+0)
STR	R1, [R0, #0]
; r_key_rcvd end address is: 8 (R2)
; ask_time_flag end address is: 12 (R3)
; sequence_count end address is: 16 (R4)
; i end address is: 40 (R10)
UXTB	R1, R2
UXTB	R2, R3
MOV	R3, R4
MOV	R4, R10
;P5_timers.c,359 :: 		}
IT	AL
BAL	L_main36
L__main86:
;P5_timers.c,294 :: 		if ( (USART1_SR & (1 << 5)) ) {
UXTB	R1, R11
MOV	R4, R10
;P5_timers.c,359 :: 		}
L_main36:
;P5_timers.c,292 :: 		for (i=0; i < 10; i++) {
; r_key_rcvd start address is: 4 (R1)
; sequence_count start address is: 12 (R3)
; ask_time_flag start address is: 8 (R2)
; i start address is: 16 (R4)
ADDS	R0, R4, #1
; i end address is: 16 (R4)
; i start address is: 40 (R10)
MOV	R10, R0
;P5_timers.c,360 :: 		}
UXTB	R11, R1
; r_key_rcvd end address is: 4 (R1)
; i end address is: 40 (R10)
IT	AL
BAL	L_main33
L_main34:
;P5_timers.c,368 :: 		if ( TIM1_SR.UIF == 1 ) {
; r_key_rcvd start address is: 44 (R11)
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_LX	[R0, ByteOffset(TIM1_SR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main57
;P5_timers.c,370 :: 		TIM1_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM1_SR+0)
MOVT	R0, #hi_addr(TIM1_SR+0)
_SX	[R0, ByteOffset(TIM1_SR+0)]
;P5_timers.c,371 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,372 :: 		GPIOC_ODR = ~GPIOC_ODR;
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,375 :: 		}
L_main57:
;P5_timers.c,376 :: 		if ( TIM4_SR.UIF == 1 ) {
MOVW	R0, #lo_addr(TIM4_SR+0)
MOVT	R0, #hi_addr(TIM4_SR+0)
_LX	[R0, ByteOffset(TIM4_SR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main58
;P5_timers.c,378 :: 		TIM4_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM4_SR+0)
MOVT	R0, #hi_addr(TIM4_SR+0)
_SX	[R0, ByteOffset(TIM4_SR+0)]
;P5_timers.c,379 :: 		GPIOD_ODR = ~GPIOD_ODR;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,380 :: 		GPIOE_ODR = ~GPIOE_ODR;
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P5_timers.c,381 :: 		}
L_main58:
;P5_timers.c,382 :: 		}
MOV	R12, R3
; r_key_rcvd end address is: 44 (R11)
; sequence_count end address is: 12 (R3)
; ask_time_flag end address is: 8 (R2)
UXTB	R10, R11
UXTB	R11, R2
IT	AL
BAL	L_main20
;P5_timers.c,385 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
