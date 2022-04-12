_read_data:
;P4_bonus_obj.c,63 :: 		void read_data(uint32_t *rx_buffer) {
; rx_buffer start address is: 0 (R0)
SUB	SP, SP, #4
; rx_buffer end address is: 0 (R0)
; rx_buffer start address is: 0 (R0)
; rx_buffer end address is: 0 (R0)
;P4_bonus_obj.c,66 :: 		while( (USART1_SR & (1 << 5)) == 0 ) {}		// Positive logic
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
;P4_bonus_obj.c,69 :: 		*rx_buffer = USART1_DR;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
LDR	R1, [R1, #0]
STR	R1, [R0, #0]
; rx_buffer end address is: 0 (R0)
;P4_bonus_obj.c,72 :: 		while ( (USART1_SR & (1 << 7)) == 0) {}
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
;P4_bonus_obj.c,73 :: 		Delay_ms(10);
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
;P4_bonus_obj.c,74 :: 		}
L_end_read_data:
ADD	SP, SP, #4
BX	LR
; end of _read_data
_write_data_char:
;P4_bonus_obj.c,77 :: 		void write_data_char(uint32_t *tx_char, uint8_t new_line) {
; new_line start address is: 4 (R1)
; tx_char start address is: 0 (R0)
SUB	SP, SP, #4
; new_line end address is: 4 (R1)
; tx_char end address is: 0 (R0)
; tx_char start address is: 0 (R0)
; new_line start address is: 4 (R1)
STRB	R1, [SP, #0]
; tx_char end address is: 0 (R0)
; new_line end address is: 4 (R1)
MOV	R1, R0
LDRB	R0, [SP, #0]
;P4_bonus_obj.c,81 :: 		while ( (USART1_SR & (1 << 7)) == 0) {}
L_write_data_char6:
; new_line start address is: 0 (R0)
; tx_char start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_write_data_char7
IT	AL
BAL	L_write_data_char6
L_write_data_char7:
;P4_bonus_obj.c,84 :: 		Delay_ms(10);
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
;P4_bonus_obj.c,85 :: 		USART1_DR = *tx_char;
LDR	R3, [R1, #0]
; tx_char end address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P4_bonus_obj.c,88 :: 		if (new_line == 1) {
CMP	R0, #1
IT	NE
BNE	L_write_data_char10
; new_line end address is: 0 (R0)
;P4_bonus_obj.c,89 :: 		Delay_ms(10);
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
;P4_bonus_obj.c,90 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P4_bonus_obj.c,91 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char13:
SUBS	R7, R7, #1
BNE	L_write_data_char13
NOP
NOP
NOP
;P4_bonus_obj.c,92 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P4_bonus_obj.c,93 :: 		}
L_write_data_char10:
;P4_bonus_obj.c,94 :: 		}
L_end_write_data_char:
ADD	SP, SP, #4
BX	LR
; end of _write_data_char
_write_data:
;P4_bonus_obj.c,98 :: 		void write_data(uint32_t *arr_buffer, uint8_t new_line_opt) {
; new_line_opt start address is: 4 (R1)
; arr_buffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R2, R1
MOV	R1, R0
; new_line_opt end address is: 4 (R1)
; arr_buffer end address is: 0 (R0)
; arr_buffer start address is: 4 (R1)
; new_line_opt start address is: 8 (R2)
;P4_bonus_obj.c,99 :: 		uint32_t i = 0;
; i start address is: 0 (R0)
MOV	R0, #0
; arr_buffer end address is: 4 (R1)
; new_line_opt end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R5, R1
UXTB	R4, R2
MOV	R6, R0
;P4_bonus_obj.c,101 :: 		while ( (arr_buffer[i] != '\0') && (i < MAX_BUFFER_SIZE) ) {
L_write_data15:
; i start address is: 24 (R6)
; new_line_opt start address is: 16 (R4)
; new_line_opt start address is: 16 (R4)
; new_line_opt end address is: 16 (R4)
; arr_buffer start address is: 20 (R5)
LSLS	R2, R6, #2
ADDS	R2, R5, R2
LDR	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L__write_data89
; new_line_opt end address is: 16 (R4)
; new_line_opt start address is: 16 (R4)
CMP	R6, #64
IT	CS
BCS	L__write_data88
L__write_data87:
;P4_bonus_obj.c,102 :: 		write_data_char(&arr_buffer[i], new_line_opt);
LSLS	R2, R6, #2
ADDS	R2, R5, R2
UXTB	R1, R4
MOV	R0, R2
BL	_write_data_char+0
;P4_bonus_obj.c,103 :: 		++i;
ADDS	R6, R6, #1
;P4_bonus_obj.c,104 :: 		}
; new_line_opt end address is: 16 (R4)
; arr_buffer end address is: 20 (R5)
; i end address is: 24 (R6)
IT	AL
BAL	L_write_data15
;P4_bonus_obj.c,101 :: 		while ( (arr_buffer[i] != '\0') && (i < MAX_BUFFER_SIZE) ) {
L__write_data89:
L__write_data88:
;P4_bonus_obj.c,107 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data19:
SUBS	R7, R7, #1
BNE	L_write_data19
NOP
NOP
NOP
;P4_bonus_obj.c,108 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P4_bonus_obj.c,109 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data21:
SUBS	R7, R7, #1
BNE	L_write_data21
NOP
NOP
NOP
;P4_bonus_obj.c,110 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P4_bonus_obj.c,111 :: 		}
L_end_write_data:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _write_data
_update_led:
;P4_bonus_obj.c,114 :: 		void update_led(uint32_t counter) {
; counter start address is: 0 (R0)
SUB	SP, SP, #4
; counter end address is: 0 (R0)
; counter start address is: 0 (R0)
;P4_bonus_obj.c,115 :: 		GPIOD_ODR = (counter << 8);
LSLS	R2, R0, #8
; counter end address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;P4_bonus_obj.c,116 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_update_led23:
SUBS	R7, R7, #1
BNE	L_update_led23
NOP
NOP
NOP
;P4_bonus_obj.c,117 :: 		}
L_end_update_led:
ADD	SP, SP, #4
BX	LR
; end of _update_led
_print_string:
;P4_bonus_obj.c,121 :: 		void print_string(uint8_t *arr_string, uint8_t new_line_opt) {
; new_line_opt start address is: 4 (R1)
; arr_string start address is: 0 (R0)
SUB	SP, SP, #260
STR	LR, [SP, #0]
; new_line_opt end address is: 4 (R1)
; arr_string end address is: 0 (R0)
; arr_string start address is: 0 (R0)
; new_line_opt start address is: 4 (R1)
;P4_bonus_obj.c,122 :: 		uint32_t i = 0;
; i start address is: 36 (R9)
MOV	R9, #0
; arr_string end address is: 0 (R0)
; new_line_opt end address is: 4 (R1)
; i end address is: 36 (R9)
MOV	R8, R0
UXTB	R6, R1
;P4_bonus_obj.c,125 :: 		while (arr_string[i] != '\0'){
L_print_string25:
; i start address is: 36 (R9)
; new_line_opt start address is: 24 (R6)
; arr_string start address is: 32 (R8)
ADD	R2, R8, R9, LSL #0
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_print_string26
;P4_bonus_obj.c,126 :: 		buffer[i] = (buffer[i] & 0x00000000) | arr_string[i];
ADD	R5, SP, #4
LSL	R2, R9, #2
ADDS	R4, R5, R2
LDR	R2, [R4, #0]
AND	R3, R2, #0
ADD	R2, R8, R9, LSL #0
LDRB	R2, [R2, #0]
ORR	R2, R3, R2, LSL #0
STR	R2, [R4, #0]
;P4_bonus_obj.c,127 :: 		write_data_char(&buffer[i], NO_NEW_LINE);
LSL	R2, R9, #2
ADDS	R2, R5, R2
MOVS	R1, #0
MOV	R0, R2
BL	_write_data_char+0
;P4_bonus_obj.c,128 :: 		i++;
ADD	R9, R9, #1
;P4_bonus_obj.c,129 :: 		}
; arr_string end address is: 32 (R8)
; i end address is: 36 (R9)
IT	AL
BAL	L_print_string25
L_print_string26:
;P4_bonus_obj.c,132 :: 		if (new_line_opt == NEW_LINE_EN) {
CMP	R6, #1
IT	NE
BNE	L_print_string27
; new_line_opt end address is: 24 (R6)
;P4_bonus_obj.c,133 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_string28:
SUBS	R7, R7, #1
BNE	L_print_string28
NOP
NOP
NOP
;P4_bonus_obj.c,134 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P4_bonus_obj.c,135 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_string30:
SUBS	R7, R7, #1
BNE	L_print_string30
NOP
NOP
NOP
;P4_bonus_obj.c,136 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P4_bonus_obj.c,137 :: 		}
L_print_string27:
;P4_bonus_obj.c,138 :: 		}
L_end_print_string:
LDR	LR, [SP, #0]
ADD	SP, SP, #260
BX	LR
; end of _print_string
_convert_to_ascii:
;P4_bonus_obj.c,142 :: 		void convert_to_ascii(const int32_t *input_dec, uint32_t *ascii_msb, uint32_t *ascii_lsb) {
; ascii_lsb start address is: 8 (R2)
; ascii_msb start address is: 4 (R1)
; input_dec start address is: 0 (R0)
SUB	SP, SP, #4
STR	R1, [SP, #0]
MOV	R1, R0
LDR	R0, [SP, #0]
; ascii_lsb end address is: 8 (R2)
; ascii_msb end address is: 4 (R1)
; input_dec end address is: 0 (R0)
; input_dec start address is: 4 (R1)
; ascii_msb start address is: 0 (R0)
; ascii_lsb start address is: 8 (R2)
;P4_bonus_obj.c,145 :: 		uint32_t temp_val = 0;
;P4_bonus_obj.c,146 :: 		*ascii_msb = 0;
MOVS	R3, #0
STR	R3, [R0, #0]
;P4_bonus_obj.c,147 :: 		*ascii_lsb = 0;
MOVS	R3, #0
STR	R3, [R2, #0]
;P4_bonus_obj.c,150 :: 		if (*input_dec > MAX_BUFFER_SIZE) {
LDR	R3, [R1, #0]
CMP	R3, #64
IT	LS
BLS	L_convert_to_ascii32
; ascii_msb end address is: 0 (R0)
; ascii_lsb end address is: 8 (R2)
; input_dec end address is: 4 (R1)
;P4_bonus_obj.c,151 :: 		return;
IT	AL
BAL	L_end_convert_to_ascii
;P4_bonus_obj.c,152 :: 		}
L_convert_to_ascii32:
;P4_bonus_obj.c,155 :: 		temp_val = *input_dec;
; input_dec start address is: 4 (R1)
; ascii_lsb start address is: 8 (R2)
; ascii_msb start address is: 0 (R0)
LDR	R4, [R1, #0]
; temp_val start address is: 16 (R4)
; ascii_msb end address is: 0 (R0)
; ascii_lsb end address is: 8 (R2)
; input_dec end address is: 4 (R1)
; temp_val end address is: 16 (R4)
STR	R2, [SP, #0]
MOV	R2, R0
LDR	R0, [SP, #0]
;P4_bonus_obj.c,156 :: 		while (temp_val >= 10) {
L_convert_to_ascii33:
; temp_val start address is: 16 (R4)
; ascii_msb start address is: 8 (R2)
; ascii_lsb start address is: 0 (R0)
; ascii_msb start address is: 8 (R2)
; ascii_msb end address is: 8 (R2)
; input_dec start address is: 4 (R1)
CMP	R4, #10
IT	CC
BCC	L_convert_to_ascii34
; ascii_msb end address is: 8 (R2)
;P4_bonus_obj.c,157 :: 		temp_val /= 10;
; ascii_msb start address is: 8 (R2)
MOVS	R3, #10
UDIV	R3, R4, R3
MOV	R4, R3
;P4_bonus_obj.c,158 :: 		*ascii_msb = temp_val + ASCII_HEX_0;
ADDS	R3, #48
STR	R3, [R2, #0]
;P4_bonus_obj.c,159 :: 		}
; ascii_msb end address is: 8 (R2)
; temp_val end address is: 16 (R4)
IT	AL
BAL	L_convert_to_ascii33
L_convert_to_ascii34:
;P4_bonus_obj.c,162 :: 		if (*input_dec > 0) {
LDR	R3, [R1, #0]
CMP	R3, #0
IT	LE
BLE	L_convert_to_ascii35
;P4_bonus_obj.c,163 :: 		temp_val = (*input_dec % 10);
LDR	R5, [R1, #0]
; input_dec end address is: 4 (R1)
MOVS	R4, #10
SDIV	R3, R5, R4
MLS	R3, R4, R3, R5
;P4_bonus_obj.c,164 :: 		*ascii_lsb = temp_val + ASCII_HEX_0;
ADDS	R3, #48
STR	R3, [R0, #0]
; ascii_lsb end address is: 0 (R0)
;P4_bonus_obj.c,165 :: 		}
L_convert_to_ascii35:
;P4_bonus_obj.c,166 :: 		}
L_end_convert_to_ascii:
ADD	SP, SP, #4
BX	LR
; end of _convert_to_ascii
_q_sort:
;P4_bonus_obj.c,169 :: 		int q_sort(uint32_t *arr_list, int32_t *pivot_pos, uint32_t *min_pos) {
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 4 (R1)
; arr_list start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R4, R2
MOV	R2, R1
MOV	R1, R0
; min_pos end address is: 8 (R2)
; pivot_pos end address is: 4 (R1)
; arr_list end address is: 0 (R0)
; arr_list start address is: 4 (R1)
; pivot_pos start address is: 8 (R2)
; min_pos start address is: 16 (R4)
;P4_bonus_obj.c,170 :: 		int32_t right_cur  = (*pivot_pos-1);
LDR	R3, [R2, #0]
SUBS	R3, R3, #1
; right_cur start address is: 12 (R3)
;P4_bonus_obj.c,171 :: 		int32_t left_found = 0;
; left_found start address is: 32 (R8)
MOV	R8, #0
;P4_bonus_obj.c,173 :: 		uint32_t temp_val  = 0;
;P4_bonus_obj.c,174 :: 		uint32_t left_cur  = 0;
; left_cur start address is: 28 (R7)
MOV	R7, #0
;P4_bonus_obj.c,175 :: 		uint32_t right_found = 0;
; right_found start address is: 0 (R0)
MOV	R0, #0
; arr_list end address is: 4 (R1)
; pivot_pos end address is: 8 (R2)
; min_pos end address is: 16 (R4)
; right_cur end address is: 12 (R3)
; right_found end address is: 0 (R0)
; left_cur end address is: 28 (R7)
; left_found end address is: 32 (R8)
MOV	R6, R1
MOV	R1, R3
MOV	R5, R2
MOV	R2, R4
;P4_bonus_obj.c,178 :: 		while (left_found == 0) {
L_q_sort36:
; right_found start address is: 0 (R0)
; left_cur start address is: 28 (R7)
; left_found start address is: 32 (R8)
; right_cur start address is: 4 (R1)
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 20 (R5)
; arr_list start address is: 24 (R6)
CMP	R8, #0
IT	NE
BNE	L_q_sort37
;P4_bonus_obj.c,180 :: 		if (left_cur == *pivot_pos) {
LDR	R3, [R5, #0]
CMP	R7, R3
IT	NE
BNE	L_q_sort38
; right_found end address is: 0 (R0)
; right_cur end address is: 4 (R1)
; left_cur end address is: 28 (R7)
; left_found end address is: 32 (R8)
;P4_bonus_obj.c,184 :: 		--(*pivot_pos);
LDR	R3, [R5, #0]
SUBS	R3, R3, #1
STR	R3, [R5, #0]
;P4_bonus_obj.c,187 :: 		if ( (*pivot_pos) <= 0) {
LDR	R3, [R5, #0]
CMP	R3, #0
IT	GT
BGT	L_q_sort39
; pivot_pos end address is: 20 (R5)
; arr_list end address is: 24 (R6)
; min_pos end address is: 8 (R2)
;P4_bonus_obj.c,188 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_q_sort
;P4_bonus_obj.c,189 :: 		}
L_q_sort39:
;P4_bonus_obj.c,192 :: 		return q_sort(arr_list, pivot_pos, min_pos);
; min_pos start address is: 8 (R2)
; arr_list start address is: 24 (R6)
; pivot_pos start address is: 20 (R5)
; min_pos end address is: 8 (R2)
MOV	R1, R5
; pivot_pos end address is: 20 (R5)
MOV	R0, R6
; arr_list end address is: 24 (R6)
BL	_q_sort+0
IT	AL
BAL	L_end_q_sort
;P4_bonus_obj.c,194 :: 		}
L_q_sort38:
;P4_bonus_obj.c,196 :: 		else if ( (arr_list[left_cur]) > (arr_list[*pivot_pos]) ) {
; min_pos start address is: 8 (R2)
; left_found start address is: 32 (R8)
; left_cur start address is: 28 (R7)
; arr_list start address is: 24 (R6)
; pivot_pos start address is: 20 (R5)
; right_cur start address is: 4 (R1)
; right_found start address is: 0 (R0)
LSLS	R3, R7, #2
ADDS	R3, R6, R3
LDR	R4, [R3, #0]
LDR	R3, [R5, #0]
LSLS	R3, R3, #2
ADDS	R3, R6, R3
LDR	R3, [R3, #0]
CMP	R4, R3
IT	LS
BLS	L_q_sort42
; left_found end address is: 32 (R8)
;P4_bonus_obj.c,197 :: 		left_found = 1;
; left_found start address is: 12 (R3)
MOVS	R3, #1
;P4_bonus_obj.c,198 :: 		}
MOV	R8, R3
; left_found end address is: 12 (R3)
IT	AL
BAL	L_q_sort43
L_q_sort42:
;P4_bonus_obj.c,200 :: 		++left_cur;
; left_found start address is: 32 (R8)
ADDS	R3, R7, #1
; left_cur end address is: 28 (R7)
; left_cur start address is: 16 (R4)
MOV	R4, R3
; left_cur end address is: 16 (R4)
; left_found end address is: 32 (R8)
MOV	R7, R4
;P4_bonus_obj.c,201 :: 		}
L_q_sort43:
;P4_bonus_obj.c,202 :: 		}
; left_cur start address is: 28 (R7)
; left_found start address is: 32 (R8)
; left_found end address is: 32 (R8)
IT	AL
BAL	L_q_sort36
L_q_sort37:
;P4_bonus_obj.c,205 :: 		while (right_found == 0) {
MOV	R8, R0
; right_cur end address is: 4 (R1)
; pivot_pos end address is: 20 (R5)
; arr_list end address is: 24 (R6)
; left_cur end address is: 28 (R7)
; min_pos end address is: 8 (R2)
MOV	R0, R6
MOV	R6, R7
MOV	R7, R1
MOV	R1, R5
L_q_sort44:
; right_found end address is: 0 (R0)
; arr_list start address is: 0 (R0)
; pivot_pos start address is: 4 (R1)
; min_pos start address is: 8 (R2)
; right_cur start address is: 28 (R7)
; left_cur start address is: 24 (R6)
; right_found start address is: 32 (R8)
CMP	R8, #0
IT	NE
BNE	L_q_sort45
;P4_bonus_obj.c,207 :: 		if ( (right_cur == *min_pos) && (arr_list[right_cur]) >= (arr_list[*pivot_pos]) ) {
LDR	R3, [R2, #0]
CMP	R7, R3
IT	NE
BNE	L__q_sort92
LSLS	R3, R7, #2
ADDS	R5, R0, R3
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R4, [R3, #0]
LDR	R3, [R5, #0]
CMP	R3, R4
IT	CC
BCC	L__q_sort91
; right_cur end address is: 28 (R7)
; right_found end address is: 32 (R8)
L__q_sort90:
;P4_bonus_obj.c,211 :: 		temp_val = arr_list[left_cur];
LSLS	R3, R6, #2
ADDS	R4, R0, R3
LDR	R5, [R4, #0]
; temp_val start address is: 20 (R5)
;P4_bonus_obj.c,212 :: 		arr_list[left_cur] = arr_list[*pivot_pos];
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
STR	R3, [R4, #0]
;P4_bonus_obj.c,213 :: 		arr_list[*pivot_pos] = temp_val;
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
STR	R5, [R3, #0]
; temp_val end address is: 20 (R5)
;P4_bonus_obj.c,216 :: 		*min_pos = left_cur;
STR	R6, [R2, #0]
; left_cur end address is: 24 (R6)
;P4_bonus_obj.c,218 :: 		return q_sort( arr_list, pivot_pos, min_pos );
; min_pos end address is: 8 (R2)
; pivot_pos end address is: 4 (R1)
; arr_list end address is: 0 (R0)
BL	_q_sort+0
IT	AL
BAL	L_end_q_sort
;P4_bonus_obj.c,207 :: 		if ( (right_cur == *min_pos) && (arr_list[right_cur]) >= (arr_list[*pivot_pos]) ) {
L__q_sort92:
; right_found start address is: 32 (R8)
; right_cur start address is: 28 (R7)
; left_cur start address is: 24 (R6)
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 4 (R1)
; arr_list start address is: 0 (R0)
L__q_sort91:
;P4_bonus_obj.c,220 :: 		else if ( (arr_list[right_cur]) <= (arr_list[*pivot_pos]) ) {
LSLS	R3, R7, #2
ADDS	R3, R0, R3
LDR	R4, [R3, #0]
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
CMP	R4, R3
IT	HI
BHI	L_q_sort50
; right_found end address is: 32 (R8)
;P4_bonus_obj.c,221 :: 		right_found =1;
; right_found start address is: 12 (R3)
MOVS	R3, #1
;P4_bonus_obj.c,222 :: 		}
MOV	R8, R3
; right_found end address is: 12 (R3)
IT	AL
BAL	L_q_sort51
L_q_sort50:
;P4_bonus_obj.c,224 :: 		--right_cur;
; right_found start address is: 32 (R8)
SUBS	R3, R7, #1
; right_cur end address is: 28 (R7)
; right_cur start address is: 16 (R4)
MOV	R4, R3
; right_cur end address is: 16 (R4)
; right_found end address is: 32 (R8)
MOV	R7, R4
;P4_bonus_obj.c,225 :: 		}
L_q_sort51:
;P4_bonus_obj.c,226 :: 		}
; right_cur start address is: 28 (R7)
; right_found start address is: 32 (R8)
; right_found end address is: 32 (R8)
IT	AL
BAL	L_q_sort44
L_q_sort45:
;P4_bonus_obj.c,230 :: 		if (right_cur < left_cur) {
CMP	R7, R6
IT	CS
BCS	L_q_sort52
; right_cur end address is: 28 (R7)
;P4_bonus_obj.c,231 :: 		temp_val = arr_list[left_cur];
LSLS	R3, R6, #2
; left_cur end address is: 24 (R6)
ADDS	R4, R0, R3
LDR	R5, [R4, #0]
; temp_val start address is: 20 (R5)
;P4_bonus_obj.c,232 :: 		arr_list[left_cur] = arr_list[*pivot_pos];
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
STR	R3, [R4, #0]
;P4_bonus_obj.c,233 :: 		arr_list[*pivot_pos] = temp_val;
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
STR	R5, [R3, #0]
; temp_val end address is: 20 (R5)
;P4_bonus_obj.c,234 :: 		*min_pos = 0;
MOVS	R3, #0
STR	R3, [R2, #0]
;P4_bonus_obj.c,235 :: 		}
IT	AL
BAL	L_q_sort53
L_q_sort52:
;P4_bonus_obj.c,238 :: 		temp_val = arr_list[left_cur];
; right_cur start address is: 28 (R7)
; left_cur start address is: 24 (R6)
LSLS	R3, R6, #2
; left_cur end address is: 24 (R6)
ADDS	R4, R0, R3
LDR	R3, [R4, #0]
; temp_val start address is: 20 (R5)
MOV	R5, R3
;P4_bonus_obj.c,239 :: 		arr_list[left_cur] = arr_list[right_cur];
LSLS	R3, R7, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
STR	R3, [R4, #0]
;P4_bonus_obj.c,240 :: 		arr_list[right_cur] = temp_val;
LSLS	R3, R7, #2
; right_cur end address is: 28 (R7)
ADDS	R3, R0, R3
STR	R5, [R3, #0]
; temp_val end address is: 20 (R5)
;P4_bonus_obj.c,241 :: 		}
L_q_sort53:
;P4_bonus_obj.c,243 :: 		if (*pivot_pos == 0) {
LDR	R3, [R1, #0]
CMP	R3, #0
IT	NE
BNE	L_q_sort54
; arr_list end address is: 0 (R0)
; pivot_pos end address is: 4 (R1)
; min_pos end address is: 8 (R2)
;P4_bonus_obj.c,244 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_q_sort
;P4_bonus_obj.c,245 :: 		}
L_q_sort54:
;P4_bonus_obj.c,247 :: 		return q_sort(arr_list, pivot_pos, min_pos);
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 4 (R1)
; arr_list start address is: 0 (R0)
; min_pos end address is: 8 (R2)
; pivot_pos end address is: 4 (R1)
; arr_list end address is: 0 (R0)
BL	_q_sort+0
;P4_bonus_obj.c,249 :: 		}
L_end_q_sort:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _q_sort
_tally:
;P4_bonus_obj.c,254 :: 		tally(uint32_t *arr_tally, uint32_t size) {
; size start address is: 4 (R1)
SUB	SP, SP, #296
STR	LR, [SP, #0]
STR	R0, [SP, #288]
; size end address is: 4 (R1)
; size start address is: 4 (R1)
;P4_bonus_obj.c,256 :: 		uint8_t str_colon[] = " : ";
MOVS	R2, #32
STRB	R2, [SP, #260]
MOVS	R2, #58
STRB	R2, [SP, #261]
MOVS	R2, #32
STRB	R2, [SP, #262]
MOVS	R2, #0
STRB	R2, [SP, #263]
MOVS	R2, #1
STRB	R2, [SP, #264]
;P4_bonus_obj.c,257 :: 		uint8_t first_run = TRUE;
;P4_bonus_obj.c,259 :: 		uint32_t i = 0;
; i start address is: 0 (R0)
MOV	R0, #0
;P4_bonus_obj.c,260 :: 		uint32_t char_pos     = 0;
MOV	R2, #0
STR	R2, [SP, #268]
;P4_bonus_obj.c,261 :: 		uint32_t tally_pos    = 1;
; tally_pos start address is: 24 (R6)
MOV	R6, #1
;P4_bonus_obj.c,262 :: 		uint32_t tally_count  = 0;
ADD	R11, SP, #272
ADD	R10, R11, #16
MOVW	R12, #lo_addr(?ICStally_tally_count_L0+0)
MOVT	R12, #hi_addr(?ICStally_tally_count_L0+0)
BL	___CC2DW+0
;P4_bonus_obj.c,263 :: 		uint32_t current_char = 0;
;P4_bonus_obj.c,264 :: 		uint32_t prev_char    = 0;
;P4_bonus_obj.c,265 :: 		uint32_t ascii_msb    = 0;
;P4_bonus_obj.c,266 :: 		uint32_t ascii_lsb    = 0;
; size end address is: 4 (R1)
; tally_pos end address is: 24 (R6)
; i end address is: 0 (R0)
MOV	R12, R1
MOV	R11, R0
MOV	R10, R6
;P4_bonus_obj.c,269 :: 		while (i <= size) {
L_tally56:
; tally_pos start address is: 40 (R10)
; i start address is: 44 (R11)
; size start address is: 48 (R12)
CMP	R11, R12
IT	HI
BHI	L_tally57
;P4_bonus_obj.c,271 :: 		current_char = arr_tally[i];
LSL	R3, R11, #2
LDR	R2, [SP, #288]
ADDS	R2, R2, R3
LDR	R3, [R2, #0]
STR	R3, [SP, #292]
;P4_bonus_obj.c,273 :: 		if (prev_char == current_char) {
LDR	R2, [SP, #276]
CMP	R2, R3
IT	NE
BNE	L_tally58
; tally_pos end address is: 40 (R10)
;P4_bonus_obj.c,274 :: 		tally_pos = char_pos + 1;
LDR	R2, [SP, #268]
ADDS	R2, R2, #1
; tally_pos start address is: 24 (R6)
MOV	R6, R2
;P4_bonus_obj.c,275 :: 		tally_list[tally_pos] = ++tally_count;
ADD	R3, SP, #4
LSLS	R2, R2, #2
ADDS	R3, R3, R2
LDR	R2, [SP, #272]
ADDS	R2, R2, #1
STR	R2, [SP, #272]
STR	R2, [R3, #0]
;P4_bonus_obj.c,276 :: 		}
; tally_pos end address is: 24 (R6)
IT	AL
BAL	L_tally59
L_tally58:
;P4_bonus_obj.c,278 :: 		else if ( tally_list[char_pos] != current_char) {
; tally_pos start address is: 40 (R10)
ADD	R3, SP, #4
LDR	R2, [SP, #268]
LSLS	R2, R2, #2
ADDS	R2, R3, R2
LDR	R3, [R2, #0]
LDR	R2, [SP, #292]
CMP	R3, R2
IT	EQ
BEQ	L_tally60
;P4_bonus_obj.c,281 :: 		tally_count = 0;
MOVS	R2, #0
STR	R2, [SP, #272]
;P4_bonus_obj.c,283 :: 		if (first_run == TRUE ) {
LDRB	R2, [SP, #264]
CMP	R2, #1
IT	NE
BNE	L_tally61
;P4_bonus_obj.c,284 :: 		tally_list[char_pos] = current_char;
ADD	R4, SP, #4
LDR	R2, [SP, #268]
LSLS	R2, R2, #2
ADDS	R3, R4, R2
LDR	R2, [SP, #292]
STR	R2, [R3, #0]
;P4_bonus_obj.c,285 :: 		tally_list[tally_pos] = ++tally_count;
LSL	R2, R10, #2
ADDS	R3, R4, R2
LDR	R2, [SP, #272]
ADDS	R2, R2, #1
STR	R2, [SP, #272]
STR	R2, [R3, #0]
;P4_bonus_obj.c,286 :: 		first_run = FALSE;
MOVS	R2, #0
STRB	R2, [SP, #264]
;P4_bonus_obj.c,287 :: 		}
IT	AL
BAL	L_tally62
L_tally61:
;P4_bonus_obj.c,290 :: 		write_data_char(&tally_list[char_pos], NO_NEW_LINE);
ADD	R3, SP, #4
LDR	R2, [SP, #268]
LSLS	R2, R2, #2
ADDS	R2, R3, R2
MOVS	R1, #0
MOV	R0, R2
BL	_write_data_char+0
;P4_bonus_obj.c,291 :: 		print_string(&str_colon, NO_NEW_LINE);
ADD	R2, SP, #260
MOVS	R1, #0
MOV	R0, R2
BL	_print_string+0
;P4_bonus_obj.c,292 :: 		convert_to_ascii(&tally_list[tally_pos], &ascii_msb, &ascii_lsb);
ADD	R5, SP, #284
ADD	R4, SP, #280
ADD	R3, SP, #4
LSL	R2, R10, #2
ADDS	R2, R3, R2
MOV	R1, R4
MOV	R0, R2
MOV	R2, R5
BL	_convert_to_ascii+0
;P4_bonus_obj.c,293 :: 		write_data_char(&ascii_msb, NO_NEW_LINE);
ADD	R2, SP, #280
MOVS	R1, #0
MOV	R0, R2
BL	_write_data_char+0
;P4_bonus_obj.c,294 :: 		write_data_char(&ascii_lsb, NEW_LINE_EN);
ADD	R2, SP, #284
MOVS	R1, #1
MOV	R0, R2
BL	_write_data_char+0
;P4_bonus_obj.c,296 :: 		char_pos +=2;
LDR	R2, [SP, #268]
ADDS	R2, R2, #2
STR	R2, [SP, #268]
;P4_bonus_obj.c,297 :: 		tally_list[char_pos] = current_char;
ADD	R4, SP, #4
LSLS	R2, R2, #2
ADDS	R3, R4, R2
LDR	R2, [SP, #292]
STR	R2, [R3, #0]
;P4_bonus_obj.c,298 :: 		tally_list[tally_pos] = ++tally_count;
LSL	R2, R10, #2
ADDS	R3, R4, R2
LDR	R2, [SP, #272]
ADDS	R2, R2, #1
STR	R2, [SP, #272]
STR	R2, [R3, #0]
;P4_bonus_obj.c,299 :: 		}
L_tally62:
;P4_bonus_obj.c,300 :: 		}
L_tally60:
MOV	R6, R10
; tally_pos end address is: 40 (R10)
L_tally59:
;P4_bonus_obj.c,301 :: 		prev_char = current_char;
; tally_pos start address is: 24 (R6)
LDR	R2, [SP, #292]
STR	R2, [SP, #276]
;P4_bonus_obj.c,302 :: 		i++;
ADD	R2, R11, #1
; i end address is: 44 (R11)
; i start address is: 0 (R0)
MOV	R0, R2
;P4_bonus_obj.c,303 :: 		}
; size end address is: 48 (R12)
; tally_pos end address is: 24 (R6)
; i end address is: 0 (R0)
MOV	R11, R0
MOV	R10, R6
IT	AL
BAL	L_tally56
L_tally57:
;P4_bonus_obj.c,304 :: 		}
L_end_tally:
LDR	LR, [SP, #0]
ADD	SP, SP, #296
BX	LR
; end of _tally
_main:
;P4_bonus_obj.c,309 :: 		void main() {
SUB	SP, SP, #476
;P4_bonus_obj.c,312 :: 		uint8_t  loop_on          = TRUE;
; loop_on start address is: 8 (R2)
MOVS	R2, #1
;P4_bonus_obj.c,313 :: 		uint32_t char_counter     = 0;
; char_counter start address is: 12 (R3)
MOV	R3, #0
;P4_bonus_obj.c,314 :: 		uint32_t lower_case_count = 0;
;P4_bonus_obj.c,315 :: 		uint32_t upper_case_count = 0;
;P4_bonus_obj.c,316 :: 		uint32_t pivot_pos        = 0;
ADD	R11, SP, #284
ADD	R10, R11, #191
MOVW	R12, #lo_addr(?ICSmain_pivot_pos_L0+0)
MOVT	R12, #hi_addr(?ICSmain_pivot_pos_L0+0)
BL	___CC2DW+0
;P4_bonus_obj.c,317 :: 		uint32_t min_pos          = 0;
;P4_bonus_obj.c,323 :: 		uint32_t list_size = 0;
;P4_bonus_obj.c,327 :: 		uint8_t title_divider[]   = "=============================================================";
;P4_bonus_obj.c,328 :: 		uint8_t title_cr_lf[]     = "\x0D\x0A";
;P4_bonus_obj.c,329 :: 		uint8_t title_prompt[]    = "[P4 BONUS] - Please enter up to 23 alphabets to complete sequence:  ";
;P4_bonus_obj.c,330 :: 		uint8_t title_upper[]     = "Upper case: ";
;P4_bonus_obj.c,331 :: 		uint8_t title_lower[]     = "Lower case: ";
;P4_bonus_obj.c,332 :: 		uint8_t title_non_alpha[] = "Non-alphabet: ";
;P4_bonus_obj.c,333 :: 		uint8_t str_tally[]       = "Tally: ";
;P4_bonus_obj.c,341 :: 		RCC_CR = 0x05010081;
MOVW	R1, #129
MOVT	R1, #1281
MOVW	R0, #lo_addr(RCC_CR+0)
MOVT	R0, #hi_addr(RCC_CR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,346 :: 		RCC_CFGR = 0x001D8402;
MOVW	R1, #33794
MOVT	R1, #29
MOVW	R0, #lo_addr(RCC_CFGR+0)
MOVT	R0, #hi_addr(RCC_CFGR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,352 :: 		RCC_CFGR2 = 0x00010644;
MOVW	R1, #1604
MOVT	R1, #1
MOVW	R0, #lo_addr(RCC_CFGR2+0)
MOVT	R0, #hi_addr(RCC_CFGR2+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,355 :: 		RCC_APB2ENR |= 0x00000001; 	// Alternate function bit AFIOEN bit[0]. USART1 uses AF for PA9/PA10
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,356 :: 		AFIO_MAPR    = 0x00000000; 	// Bit[2] USART1 REMAP 0: No Remap (Tx=PA9; Rx=PA10)
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,358 :: 		RCC_APB2ENR |= 1 << 2;		// Enable GPIO Clock - Port A for USART Pins
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,359 :: 		RCC_APB2ENR |= 1 << 5;		// Enable GPIO Clock - Port D for LEDs
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,360 :: 		RCC_APB2ENR |= 1 << 14; 	// Enable USART1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,362 :: 		GPIOA_CRH &= ~(0xFF << 4);  // Shift 4 bits left to clear bits[9:4] for PA9/PA10 0000 0FF0 -> mask with  FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,363 :: 		GPIOA_CRH |= (0x0B << 4) ;  // USART1 Tx/PA9 set to CNF=AFoutput push-pull b10; MODE= output-50Hz b11;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,364 :: 		GPIOA_CRH |= (0x04 << 8);   // USART1 Rx/PA10 set CNF=Input-floating b01; MODE=Input mode b00;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,365 :: 		GPIOA_CRL |= (0x00000004);  // Set PA0 to input
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,366 :: 		GPIOD_CRH = GPIO_OUTPUT;    // Set Port D High bank to GPIO output
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,367 :: 		GPIOD_CRL = GPIO_OUTPUT;    // Set Port D Low bank to GPIO output
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,372 :: 		USART1_BRR = 0x00000506;
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,382 :: 		USART1_CR1 &= ~(1<<12);          // Force 8 data bits. M bit is set to 0.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,383 :: 		USART1_CR2 &= ~(3<<12);          // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,384 :: 		USART1_CR3 &= ~(3<<8);           // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,385 :: 		USART1_CR1 &= ~(3<<9);           // Force no parity and no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,386 :: 		USART1_CR1 |= 3<<2;              // RX, TX enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P4_bonus_obj.c,387 :: 		Delay_ms(100);					// Allow some time for USART to complete initialization.
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main63:
SUBS	R7, R7, #1
BNE	L_main63
NOP
NOP
NOP
;P4_bonus_obj.c,388 :: 		USART1_CR1 |= 1 << 13;			//** NOTE USART1 Enable must be done after configuration is complete
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
; loop_on end address is: 8 (R2)
; char_counter end address is: 12 (R3)
UXTB	R11, R2
MOV	R10, R3
;P4_bonus_obj.c,391 :: 		for (;;) {
L_main65:
;P4_bonus_obj.c,394 :: 		arr_tally[tally_upper] = 0;
; char_counter start address is: 40 (R10)
; loop_on start address is: 44 (R11)
ADD	R2, SP, #260
MOVS	R0, #0
STR	R0, [R2, #0]
;P4_bonus_obj.c,395 :: 		arr_tally[tally_lower] = 0;
ADDS	R1, R2, #4
MOVS	R0, #0
STR	R0, [R1, #0]
;P4_bonus_obj.c,396 :: 		arr_tally[tally_non_alpha] = 0;
ADDW	R1, R2, #8
MOVS	R0, #0
STR	R0, [R1, #0]
;P4_bonus_obj.c,397 :: 		arr_tally[tally_alpha] = 0;
ADDW	R1, R2, #12
MOVS	R0, #0
STR	R0, [R1, #0]
;P4_bonus_obj.c,400 :: 		print_string(&title_cr_lf, NEW_LINE_EN);
ADD	R0, SP, #354
MOVS	R1, #1
BL	_print_string+0
;P4_bonus_obj.c,401 :: 		print_string(&title_divider, NEW_LINE_EN);
ADD	R0, SP, #292
MOVS	R1, #1
BL	_print_string+0
;P4_bonus_obj.c,402 :: 		print_string(&title_prompt, NEW_LINE_EN);
ADDW	R0, SP, #357
MOVS	R1, #1
BL	_print_string+0
; loop_on end address is: 44 (R11)
; char_counter end address is: 40 (R10)
MOV	R4, R10
UXTB	R3, R11
;P4_bonus_obj.c,406 :: 		while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
L_main68:
; loop_on start address is: 12 (R3)
; char_counter start address is: 16 (R4)
CMP	R4, #64
IT	CS
BCS	L__main111
CMP	R3, #1
IT	NE
BNE	L__main110
L__main97:
;P4_bonus_obj.c,407 :: 		read_data( &rx_buffer[char_counter] );
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
BL	_read_data+0
;P4_bonus_obj.c,409 :: 		if ( (rx_buffer[char_counter] > 0x1F) && (rx_buffer[char_counter != NULL_BYTE]) ) {
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #31
IT	LS
BLS	L__main113
CMP	R4, #0
MOVW	R0, #0
BEQ	L__main124
MOVS	R0, #1
L__main124:
ADD	R1, SP, #4
LSLS	R0, R0, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main114
L__main96:
;P4_bonus_obj.c,415 :: 		if ( (rx_buffer[char_counter] >= 0x41) && (rx_buffer[char_counter] <= 0x5A) ) {
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #65
IT	CC
BCC	L__main99
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #90
IT	HI
BHI	L__main98
L__main95:
;P4_bonus_obj.c,416 :: 		arr_tally[tally_upper]++;
ADD	R1, SP, #260
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;P4_bonus_obj.c,417 :: 		arr_tally[tally_alpha]++;
ADDS	R1, #12
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;P4_bonus_obj.c,418 :: 		}  // If Lowercase
IT	AL
BAL	L_main78
;P4_bonus_obj.c,415 :: 		if ( (rx_buffer[char_counter] >= 0x41) && (rx_buffer[char_counter] <= 0x5A) ) {
L__main99:
L__main98:
;P4_bonus_obj.c,419 :: 		else if ( (rx_buffer[char_counter] >= 0x61) && (rx_buffer[char_counter] <= 0x7A) ) {
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #97
IT	CC
BCC	L__main101
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #122
IT	HI
BHI	L__main100
L__main94:
;P4_bonus_obj.c,420 :: 		arr_tally[tally_lower]++;
ADD	R2, SP, #260
ADDS	R1, R2, #4
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;P4_bonus_obj.c,421 :: 		arr_tally[tally_alpha]++;
ADDW	R1, R2, #12
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;P4_bonus_obj.c,422 :: 		}  // else non-alpha, range is specifed to avoid unseen special characters
IT	AL
BAL	L_main82
;P4_bonus_obj.c,419 :: 		else if ( (rx_buffer[char_counter] >= 0x61) && (rx_buffer[char_counter] <= 0x7A) ) {
L__main101:
L__main100:
;P4_bonus_obj.c,423 :: 		else if ( (rx_buffer[char_counter] >=0x20) || (rx_buffer[char_counter] <=0x40)
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #32
IT	CS
BCS	L__main107
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #64
IT	LS
BLS	L__main106
;P4_bonus_obj.c,424 :: 		|| (rx_buffer[char_counter] >=0x5B) || (rx_buffer[char_counter] <= 0x60)
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #91
IT	CS
BCS	L__main105
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #96
IT	LS
BLS	L__main104
;P4_bonus_obj.c,425 :: 		|| (rx_buffer[char_counter] >=0x7B) || (rx_buffer[char_counter] <= 0x7F)) {
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #123
IT	CS
BCS	L__main103
ADD	R1, SP, #4
LSLS	R0, R4, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #127
IT	LS
BLS	L__main102
IT	AL
BAL	L_main85
;P4_bonus_obj.c,423 :: 		else if ( (rx_buffer[char_counter] >=0x20) || (rx_buffer[char_counter] <=0x40)
L__main107:
L__main106:
;P4_bonus_obj.c,424 :: 		|| (rx_buffer[char_counter] >=0x5B) || (rx_buffer[char_counter] <= 0x60)
L__main105:
L__main104:
;P4_bonus_obj.c,425 :: 		|| (rx_buffer[char_counter] >=0x7B) || (rx_buffer[char_counter] <= 0x7F)) {
L__main103:
L__main102:
;P4_bonus_obj.c,427 :: 		arr_tally[tally_non_alpha]++;
ADD	R0, SP, #260
ADDW	R1, R0, #8
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;P4_bonus_obj.c,428 :: 		}
L_main85:
L_main82:
L_main78:
;P4_bonus_obj.c,431 :: 		char_counter++;
ADDS	R0, R4, #1
; char_counter end address is: 16 (R4)
; char_counter start address is: 8 (R2)
MOV	R2, R0
;P4_bonus_obj.c,434 :: 		if ( arr_tally[tally_alpha] >= MAX_ALPHABET_COUNT) {
ADD	R0, SP, #260
ADDS	R0, #12
LDR	R0, [R0, #0]
CMP	R0, #23
IT	CC
BCC	L__main112
;P4_bonus_obj.c,435 :: 		loop_on = FALSE;
MOVS	R3, #0
;P4_bonus_obj.c,436 :: 		rx_buffer[char_counter] = '\0';
ADD	R1, SP, #4
LSLS	R0, R2, #2
ADDS	R1, R1, R0
MOVS	R0, #0
STR	R0, [R1, #0]
; loop_on end address is: 12 (R3)
UXTB	R0, R3
;P4_bonus_obj.c,437 :: 		}
IT	AL
BAL	L_main86
L__main112:
;P4_bonus_obj.c,434 :: 		if ( arr_tally[tally_alpha] >= MAX_ALPHABET_COUNT) {
UXTB	R0, R3
;P4_bonus_obj.c,437 :: 		}
L_main86:
;P4_bonus_obj.c,409 :: 		if ( (rx_buffer[char_counter] > 0x1F) && (rx_buffer[char_counter != NULL_BYTE]) ) {
; loop_on start address is: 0 (R0)
MOV	R1, R2
; char_counter end address is: 8 (R2)
; loop_on end address is: 0 (R0)
IT	AL
BAL	L__main109
L__main113:
UXTB	R0, R3
MOV	R1, R4
L__main109:
; loop_on start address is: 0 (R0)
; char_counter start address is: 4 (R1)
UXTB	R3, R0
; loop_on end address is: 0 (R0)
; char_counter end address is: 4 (R1)
MOV	R4, R1
IT	AL
BAL	L__main108
L__main114:
L__main108:
;P4_bonus_obj.c,439 :: 		}
; char_counter start address is: 16 (R4)
; loop_on start address is: 12 (R3)
; loop_on end address is: 12 (R3)
IT	AL
BAL	L_main68
;P4_bonus_obj.c,406 :: 		while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
L__main111:
L__main110:
;P4_bonus_obj.c,444 :: 		write_data(&rx_buffer, NO_NEW_LINE);
ADD	R0, SP, #4
STR	R4, [SP, #0]
MOVS	R1, #0
BL	_write_data+0
LDR	R4, [SP, #0]
;P4_bonus_obj.c,447 :: 		pivot_pos = (char_counter - 1);
SUBS	R0, R4, #1
STR	R0, [SP, #284]
;P4_bonus_obj.c,448 :: 		q_sort (&rx_buffer, &pivot_pos, &min_pos);
ADD	R2, SP, #288
ADD	R1, SP, #284
ADD	R0, SP, #4
STR	R4, [SP, #0]
BL	_q_sort+0
;P4_bonus_obj.c,449 :: 		write_data(&rx_buffer, NO_NEW_LINE);
ADD	R0, SP, #4
MOVS	R1, #0
BL	_write_data+0
;P4_bonus_obj.c,453 :: 		print_string(title_cr_lf, NO_NEW_LINE);
ADD	R0, SP, #354
MOVS	R1, #0
BL	_print_string+0
;P4_bonus_obj.c,454 :: 		print_string(&str_tally, NEW_LINE_EN);
ADDW	R0, SP, #467
MOVS	R1, #1
BL	_print_string+0
LDR	R4, [SP, #0]
;P4_bonus_obj.c,455 :: 		tally(&rx_buffer, char_counter);
ADD	R0, SP, #4
MOV	R1, R4
; char_counter end address is: 16 (R4)
BL	_tally+0
;P4_bonus_obj.c,458 :: 		print_string(&title_cr_lf, NO_NEW_LINE);
ADD	R0, SP, #354
MOVS	R1, #0
BL	_print_string+0
;P4_bonus_obj.c,459 :: 		print_string(&title_upper, NO_NEW_LINE);
ADD	R0, SP, #426
MOVS	R1, #0
BL	_print_string+0
;P4_bonus_obj.c,460 :: 		convert_to_ascii(&arr_tally[tally_upper], &ascii_msb, &ascii_lsb);
ADD	R2, SP, #276
ADD	R1, SP, #280
ADD	R0, SP, #260
BL	_convert_to_ascii+0
;P4_bonus_obj.c,461 :: 		write_data_char(&ascii_msb, NO_NEW_LINE);
ADD	R0, SP, #280
MOVS	R1, #0
BL	_write_data_char+0
;P4_bonus_obj.c,462 :: 		write_data_char(&ascii_lsb, NEW_LINE_EN);
ADD	R0, SP, #276
MOVS	R1, #1
BL	_write_data_char+0
;P4_bonus_obj.c,465 :: 		print_string(&title_lower, NO_NEW_LINE);
ADDW	R0, SP, #439
MOVS	R1, #0
BL	_print_string+0
;P4_bonus_obj.c,466 :: 		convert_to_ascii(&arr_tally[tally_lower], &ascii_msb, &ascii_lsb);
ADD	R2, SP, #276
ADD	R1, SP, #280
ADD	R0, SP, #260
ADDS	R0, R0, #4
BL	_convert_to_ascii+0
;P4_bonus_obj.c,467 :: 		write_data_char(&ascii_msb, NO_NEW_LINE);
ADD	R0, SP, #280
MOVS	R1, #0
BL	_write_data_char+0
;P4_bonus_obj.c,468 :: 		write_data_char(&ascii_lsb, NEW_LINE_EN);
ADD	R0, SP, #276
MOVS	R1, #1
BL	_write_data_char+0
;P4_bonus_obj.c,471 :: 		print_string(&title_non_alpha, NO_NEW_LINE);
ADD	R0, SP, #452
MOVS	R1, #0
BL	_print_string+0
;P4_bonus_obj.c,472 :: 		convert_to_ascii(&arr_tally[tally_non_alpha], &ascii_msb, &ascii_lsb);
ADD	R2, SP, #276
ADD	R1, SP, #280
ADD	R0, SP, #260
ADDS	R0, #8
BL	_convert_to_ascii+0
;P4_bonus_obj.c,473 :: 		write_data_char(&ascii_msb, NO_NEW_LINE);
ADD	R0, SP, #280
MOVS	R1, #0
BL	_write_data_char+0
;P4_bonus_obj.c,474 :: 		write_data_char(&ascii_lsb, NEW_LINE_EN);
ADD	R0, SP, #276
MOVS	R1, #1
BL	_write_data_char+0
;P4_bonus_obj.c,477 :: 		loop_on = TRUE;
; loop_on start address is: 44 (R11)
MOVW	R11, #1
;P4_bonus_obj.c,478 :: 		char_counter = 0;
; char_counter start address is: 40 (R10)
MOVW	R10, #0
;P4_bonus_obj.c,479 :: 		}
; loop_on end address is: 44 (R11)
; char_counter end address is: 40 (R10)
IT	AL
BAL	L_main65
;P4_bonus_obj.c,480 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
