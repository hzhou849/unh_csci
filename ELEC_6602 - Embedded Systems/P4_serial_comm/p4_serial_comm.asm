_read_data:
;p4_serial_comm.c,44 :: 		void read_data(uint32_t *rx_buffer){
; rx_buffer start address is: 0 (R0)
SUB	SP, SP, #4
; rx_buffer end address is: 0 (R0)
; rx_buffer start address is: 0 (R0)
; rx_buffer end address is: 0 (R0)
;p4_serial_comm.c,48 :: 		while( (USART1_SR & (1 << 5)) == 0 ) {}		// Positive logic
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
;p4_serial_comm.c,51 :: 		*rx_buffer = USART1_DR;				// read data from receiver data register
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
LDR	R1, [R1, #0]
STR	R1, [R0, #0]
; rx_buffer end address is: 0 (R0)
;p4_serial_comm.c,56 :: 		while ( (USART1_SR & (1 << 7)) == 0) {}
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
;p4_serial_comm.c,57 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_read_data4:
SUBS	R7, R7, #1
BNE	L_read_data4
NOP
NOP
NOP
;p4_serial_comm.c,58 :: 		}
L_end_read_data:
ADD	SP, SP, #4
BX	LR
; end of _read_data
_write_data_char:
;p4_serial_comm.c,61 :: 		void write_data_char(uint32_t *tx_char, uint8_t new_line){
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
;p4_serial_comm.c,64 :: 		while ( (USART1_SR & (1 << 7)) == 0) {} // Wait for Transmit data register to be empty
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
;p4_serial_comm.c,66 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_write_data_char8:
SUBS	R7, R7, #1
BNE	L_write_data_char8
NOP
NOP
NOP
;p4_serial_comm.c,67 :: 		USART1_DR = *tx_char;			// Transmit data out via USART, same data register is used
LDR	R3, [R1, #0]
; tx_char end address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;p4_serial_comm.c,71 :: 		if (new_line == 1) {
CMP	R0, #1
IT	NE
BNE	L_write_data_char10
; new_line end address is: 0 (R0)
;p4_serial_comm.c,72 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_write_data_char11:
SUBS	R7, R7, #1
BNE	L_write_data_char11
NOP
NOP
NOP
;p4_serial_comm.c,73 :: 		USART1_DR = CHAR_CR;			// Write a Carriage Return
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;p4_serial_comm.c,74 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_write_data_char13:
SUBS	R7, R7, #1
BNE	L_write_data_char13
NOP
NOP
NOP
;p4_serial_comm.c,75 :: 		USART1_DR = CHAR_LF;			// Write a Line Feed
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;p4_serial_comm.c,76 :: 		}
L_write_data_char10:
;p4_serial_comm.c,77 :: 		}
L_end_write_data_char:
ADD	SP, SP, #4
BX	LR
; end of _write_data_char
_write_data:
;p4_serial_comm.c,92 :: 		void write_data(uint32_t *arr_buffer) {
; arr_buffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R1, R0
; arr_buffer end address is: 0 (R0)
; arr_buffer start address is: 4 (R1)
;p4_serial_comm.c,93 :: 		uint32_t i = 0;
; i start address is: 0 (R0)
MOV	R0, #0
; arr_buffer end address is: 4 (R1)
; i end address is: 0 (R0)
MOV	R4, R1
MOV	R5, R0
;p4_serial_comm.c,95 :: 		while (arr_buffer[i] != EXIT_CHAR) {
L_write_data15:
; i start address is: 20 (R5)
; arr_buffer start address is: 16 (R4)
LSLS	R1, R5, #2
ADDS	R1, R4, R1
LDR	R1, [R1, #0]
CMP	R1, #64
IT	EQ
BEQ	L_write_data16
;p4_serial_comm.c,96 :: 		write_data_char(&arr_buffer[i], 1);
LSLS	R1, R5, #2
ADDS	R1, R4, R1
MOV	R0, R1
MOVS	R1, #1
BL	_write_data_char+0
;p4_serial_comm.c,97 :: 		++i;
ADDS	R5, R5, #1
;p4_serial_comm.c,98 :: 		}
; arr_buffer end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_write_data15
L_write_data16:
;p4_serial_comm.c,99 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_write_data17:
SUBS	R7, R7, #1
BNE	L_write_data17
NOP
NOP
NOP
;p4_serial_comm.c,100 :: 		USART1_DR = CHAR_CR;			// Write a Carriage Return
MOV	R2, #13
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;p4_serial_comm.c,101 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_write_data19:
SUBS	R7, R7, #1
BNE	L_write_data19
NOP
NOP
NOP
;p4_serial_comm.c,102 :: 		USART1_DR = CHAR_LF;			// Write a Line Fee
MOV	R2, #10
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;p4_serial_comm.c,103 :: 		}
L_end_write_data:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _write_data
_write_data_reversed:
;p4_serial_comm.c,106 :: 		void write_data_reversed(uint32_t *arr_buffer, int32_t list_len) {
; list_len start address is: 4 (R1)
; arr_buffer start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R2, R1
MOV	R1, R0
; list_len end address is: 4 (R1)
; arr_buffer end address is: 0 (R0)
; arr_buffer start address is: 4 (R1)
; list_len start address is: 8 (R2)
;p4_serial_comm.c,107 :: 		int32_t i = 0;
;p4_serial_comm.c,114 :: 		for ( i=list_len; i >= 0; i--) {
; i start address is: 0 (R0)
MOV	R0, R2
; arr_buffer end address is: 4 (R1)
; list_len end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R4, R1
MOV	R5, R0
L_write_data_reversed21:
; i start address is: 20 (R5)
; arr_buffer start address is: 16 (R4)
; arr_buffer start address is: 16 (R4)
; arr_buffer end address is: 16 (R4)
CMP	R5, #0
IT	LT
BLT	L_write_data_reversed22
; arr_buffer end address is: 16 (R4)
;p4_serial_comm.c,115 :: 		write_data_char(&arr_buffer[i], 1);
; arr_buffer start address is: 16 (R4)
LSLS	R2, R5, #2
ADDS	R2, R4, R2
MOVS	R1, #1
MOV	R0, R2
BL	_write_data_char+0
;p4_serial_comm.c,114 :: 		for ( i=list_len; i >= 0; i--) {
SUBS	R5, R5, #1
;p4_serial_comm.c,116 :: 		}
; arr_buffer end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_write_data_reversed21
L_write_data_reversed22:
;p4_serial_comm.c,118 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_write_data_reversed24:
SUBS	R7, R7, #1
BNE	L_write_data_reversed24
NOP
NOP
NOP
;p4_serial_comm.c,119 :: 		USART1_DR = CHAR_CR;			// Write a Carriage Return
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;p4_serial_comm.c,120 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_write_data_reversed26:
SUBS	R7, R7, #1
BNE	L_write_data_reversed26
NOP
NOP
NOP
;p4_serial_comm.c,121 :: 		USART1_DR = CHAR_LF;			// Write a Line Fee
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;p4_serial_comm.c,122 :: 		}
L_end_write_data_reversed:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _write_data_reversed
_update_led:
;p4_serial_comm.c,130 :: 		void update_led(uint32_t counter) {
; counter start address is: 0 (R0)
SUB	SP, SP, #4
; counter end address is: 0 (R0)
; counter start address is: 0 (R0)
;p4_serial_comm.c,131 :: 		GPIOD_ODR = (counter << 8);
LSLS	R2, R0, #8
; counter end address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;p4_serial_comm.c,132 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_update_led28:
SUBS	R7, R7, #1
BNE	L_update_led28
NOP
NOP
NOP
;p4_serial_comm.c,133 :: 		}
L_end_update_led:
ADD	SP, SP, #4
BX	LR
; end of _update_led
_clear_buffer:
;p4_serial_comm.c,136 :: 		void clear_buffer(uint32_t *arr_buffer, uint32_t size) {
; size start address is: 4 (R1)
; arr_buffer start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R2, R1
MOV	R1, R0
; size end address is: 4 (R1)
; arr_buffer end address is: 0 (R0)
; arr_buffer start address is: 4 (R1)
; size start address is: 8 (R2)
;p4_serial_comm.c,137 :: 		uint32_t i = 0;
;p4_serial_comm.c,139 :: 		for (i=0; i < size; i++) {
; i start address is: 0 (R0)
MOVS	R0, #0
; size end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R4, R0
MOV	R0, R2
L_clear_buffer30:
; i start address is: 16 (R4)
; size start address is: 0 (R0)
; arr_buffer start address is: 4 (R1)
; arr_buffer end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_clear_buffer31
; arr_buffer end address is: 4 (R1)
;p4_serial_comm.c,140 :: 		if (arr_buffer[i] != 0 ) {
; arr_buffer start address is: 4 (R1)
LSLS	R2, R4, #2
ADDS	R2, R1, R2
LDR	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_clear_buffer33
;p4_serial_comm.c,141 :: 		arr_buffer[i] = 0;
LSLS	R2, R4, #2
ADDS	R3, R1, R2
MOVS	R2, #0
STR	R2, [R3, #0]
;p4_serial_comm.c,142 :: 		}
L_clear_buffer33:
;p4_serial_comm.c,139 :: 		for (i=0; i < size; i++) {
ADDS	R4, R4, #1
;p4_serial_comm.c,143 :: 		}
; size end address is: 0 (R0)
; arr_buffer end address is: 4 (R1)
; i end address is: 16 (R4)
IT	AL
BAL	L_clear_buffer30
L_clear_buffer31:
;p4_serial_comm.c,144 :: 		}
L_end_clear_buffer:
ADD	SP, SP, #4
BX	LR
; end of _clear_buffer
_q_sort:
;p4_serial_comm.c,147 :: 		int q_sort(uint32_t *arr_list, int32_t *pivot_pos, uint32_t *min_pos) {
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 4 (R1)
; arr_list start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; min_pos end address is: 8 (R2)
; pivot_pos end address is: 4 (R1)
; arr_list end address is: 0 (R0)
; arr_list start address is: 0 (R0)
; pivot_pos start address is: 4 (R1)
; min_pos start address is: 8 (R2)
;p4_serial_comm.c,149 :: 		uint32_t left_cur = 0;
; left_cur start address is: 32 (R8)
MOV	R8, #0
;p4_serial_comm.c,150 :: 		int32_t right_cur = (*pivot_pos-1);
LDR	R3, [R1, #0]
SUBS	R3, R3, #1
; right_cur start address is: 12 (R3)
;p4_serial_comm.c,151 :: 		int32_t left_found = 0;
; left_found start address is: 28 (R7)
MOV	R7, #0
;p4_serial_comm.c,152 :: 		uint32_t right_found = 0;
; right_found start address is: 16 (R4)
MOV	R4, #0
;p4_serial_comm.c,153 :: 		uint32_t temp_val = 0;
MOV	R6, R0
; right_cur end address is: 12 (R3)
; right_found end address is: 16 (R4)
; left_cur end address is: 32 (R8)
; left_found end address is: 28 (R7)
; arr_list end address is: 0 (R0)
; pivot_pos end address is: 4 (R1)
; min_pos end address is: 8 (R2)
MOV	R0, R4
MOV	R5, R1
MOV	R1, R3
;p4_serial_comm.c,155 :: 		while (left_found == 0) {
L_q_sort34:
; right_found start address is: 0 (R0)
; left_found start address is: 28 (R7)
; right_cur start address is: 4 (R1)
; left_cur start address is: 32 (R8)
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 20 (R5)
; arr_list start address is: 24 (R6)
CMP	R7, #0
IT	NE
BNE	L_q_sort35
;p4_serial_comm.c,160 :: 		if (left_cur == *pivot_pos) {
LDR	R3, [R5, #0]
CMP	R8, R3
IT	NE
BNE	L_q_sort36
; right_found end address is: 0 (R0)
; right_cur end address is: 4 (R1)
; left_cur end address is: 32 (R8)
; left_found end address is: 28 (R7)
;p4_serial_comm.c,164 :: 		--(*pivot_pos);
LDR	R3, [R5, #0]
SUBS	R3, R3, #1
STR	R3, [R5, #0]
;p4_serial_comm.c,167 :: 		if ( (*pivot_pos) <= 0) {
LDR	R3, [R5, #0]
CMP	R3, #0
IT	GT
BGT	L_q_sort37
; pivot_pos end address is: 20 (R5)
; arr_list end address is: 24 (R6)
; min_pos end address is: 8 (R2)
;p4_serial_comm.c,168 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_q_sort
;p4_serial_comm.c,169 :: 		}
L_q_sort37:
;p4_serial_comm.c,172 :: 		return q_sort(arr_list, pivot_pos, min_pos);
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
;p4_serial_comm.c,174 :: 		}
L_q_sort36:
;p4_serial_comm.c,176 :: 		else if ( (arr_list[left_cur]) > (arr_list[*pivot_pos]) ) {
; min_pos start address is: 8 (R2)
; left_found start address is: 28 (R7)
; left_cur start address is: 32 (R8)
; arr_list start address is: 24 (R6)
; pivot_pos start address is: 20 (R5)
; right_cur start address is: 4 (R1)
; right_found start address is: 0 (R0)
LSL	R3, R8, #2
ADDS	R3, R6, R3
LDR	R4, [R3, #0]
LDR	R3, [R5, #0]
LSLS	R3, R3, #2
ADDS	R3, R6, R3
LDR	R3, [R3, #0]
CMP	R4, R3
IT	LS
BLS	L_q_sort40
; left_found end address is: 28 (R7)
;p4_serial_comm.c,177 :: 		left_found = 1;
; left_found start address is: 12 (R3)
MOVS	R3, #1
;p4_serial_comm.c,178 :: 		}
MOV	R7, R3
; left_found end address is: 12 (R3)
IT	AL
BAL	L_q_sort41
L_q_sort40:
;p4_serial_comm.c,180 :: 		++left_cur;
; left_found start address is: 28 (R7)
ADD	R3, R8, #1
; left_cur end address is: 32 (R8)
; left_cur start address is: 16 (R4)
MOV	R4, R3
; left_cur end address is: 16 (R4)
; left_found end address is: 28 (R7)
MOV	R8, R4
;p4_serial_comm.c,181 :: 		}
L_q_sort41:
;p4_serial_comm.c,182 :: 		}
; left_cur start address is: 32 (R8)
; left_found start address is: 28 (R7)
; left_found end address is: 28 (R7)
IT	AL
BAL	L_q_sort34
L_q_sort35:
;p4_serial_comm.c,187 :: 		while (right_found == 0) {
STR	R6, [SP, #4]
; right_cur end address is: 4 (R1)
; pivot_pos end address is: 20 (R5)
; arr_list end address is: 24 (R6)
; left_cur end address is: 32 (R8)
; min_pos end address is: 8 (R2)
MOV	R6, R8
MOV	R8, R0
MOV	R7, R1
MOV	R1, R5
LDR	R0, [SP, #4]
L_q_sort42:
; right_found end address is: 0 (R0)
; arr_list start address is: 0 (R0)
; pivot_pos start address is: 4 (R1)
; min_pos start address is: 8 (R2)
; left_cur start address is: 24 (R6)
; right_cur start address is: 28 (R7)
; right_found start address is: 32 (R8)
CMP	R8, #0
IT	NE
BNE	L_q_sort43
;p4_serial_comm.c,190 :: 		if ( (right_cur == *min_pos) && (arr_list[right_cur]) >= (arr_list[*pivot_pos]) ) {
LDR	R3, [R2, #0]
CMP	R7, R3
IT	NE
BNE	L__q_sort75
LSLS	R3, R7, #2
ADDS	R5, R0, R3
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R4, [R3, #0]
LDR	R3, [R5, #0]
CMP	R3, R4
IT	CC
BCC	L__q_sort74
; right_cur end address is: 28 (R7)
; right_found end address is: 32 (R8)
L__q_sort73:
;p4_serial_comm.c,195 :: 		temp_val = arr_list[left_cur];
LSLS	R3, R6, #2
ADDS	R4, R0, R3
LDR	R5, [R4, #0]
; temp_val start address is: 20 (R5)
;p4_serial_comm.c,196 :: 		arr_list[left_cur] = arr_list[*pivot_pos];
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
STR	R3, [R4, #0]
;p4_serial_comm.c,197 :: 		arr_list[*pivot_pos] = temp_val;
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
STR	R5, [R3, #0]
; temp_val end address is: 20 (R5)
;p4_serial_comm.c,200 :: 		*min_pos = left_cur;
STR	R6, [R2, #0]
; left_cur end address is: 24 (R6)
;p4_serial_comm.c,203 :: 		return q_sort( arr_list, pivot_pos, min_pos );
; min_pos end address is: 8 (R2)
; pivot_pos end address is: 4 (R1)
; arr_list end address is: 0 (R0)
BL	_q_sort+0
IT	AL
BAL	L_end_q_sort
;p4_serial_comm.c,190 :: 		if ( (right_cur == *min_pos) && (arr_list[right_cur]) >= (arr_list[*pivot_pos]) ) {
L__q_sort75:
; right_found start address is: 32 (R8)
; right_cur start address is: 28 (R7)
; left_cur start address is: 24 (R6)
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 4 (R1)
; arr_list start address is: 0 (R0)
L__q_sort74:
;p4_serial_comm.c,208 :: 		else if ( (arr_list[right_cur]) <= (arr_list[*pivot_pos]) ) {
LSLS	R3, R7, #2
ADDS	R3, R0, R3
LDR	R4, [R3, #0]
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
CMP	R4, R3
IT	HI
BHI	L_q_sort48
; right_found end address is: 32 (R8)
;p4_serial_comm.c,210 :: 		right_found =1;
; right_found start address is: 12 (R3)
MOVS	R3, #1
;p4_serial_comm.c,211 :: 		}
MOV	R8, R3
; right_found end address is: 12 (R3)
IT	AL
BAL	L_q_sort49
L_q_sort48:
;p4_serial_comm.c,215 :: 		--right_cur;
; right_found start address is: 32 (R8)
SUBS	R3, R7, #1
; right_cur end address is: 28 (R7)
; right_cur start address is: 16 (R4)
MOV	R4, R3
; right_cur end address is: 16 (R4)
; right_found end address is: 32 (R8)
MOV	R7, R4
;p4_serial_comm.c,216 :: 		}
L_q_sort49:
;p4_serial_comm.c,217 :: 		}
; right_cur start address is: 28 (R7)
; right_found start address is: 32 (R8)
; right_found end address is: 32 (R8)
IT	AL
BAL	L_q_sort42
L_q_sort43:
;p4_serial_comm.c,221 :: 		if (right_cur < left_cur) {
CMP	R7, R6
IT	CS
BCS	L_q_sort50
; right_cur end address is: 28 (R7)
;p4_serial_comm.c,222 :: 		temp_val = arr_list[left_cur];
LSLS	R3, R6, #2
; left_cur end address is: 24 (R6)
ADDS	R4, R0, R3
LDR	R5, [R4, #0]
; temp_val start address is: 20 (R5)
;p4_serial_comm.c,223 :: 		arr_list[left_cur] = arr_list[*pivot_pos];
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
STR	R3, [R4, #0]
;p4_serial_comm.c,224 :: 		arr_list[*pivot_pos] = temp_val;
LDR	R3, [R1, #0]
LSLS	R3, R3, #2
ADDS	R3, R0, R3
STR	R5, [R3, #0]
; temp_val end address is: 20 (R5)
;p4_serial_comm.c,228 :: 		*min_pos = 0;
MOVS	R3, #0
STR	R3, [R2, #0]
;p4_serial_comm.c,229 :: 		}
IT	AL
BAL	L_q_sort51
L_q_sort50:
;p4_serial_comm.c,232 :: 		temp_val = arr_list[left_cur];
; right_cur start address is: 28 (R7)
; left_cur start address is: 24 (R6)
LSLS	R3, R6, #2
; left_cur end address is: 24 (R6)
ADDS	R4, R0, R3
LDR	R3, [R4, #0]
; temp_val start address is: 20 (R5)
MOV	R5, R3
;p4_serial_comm.c,233 :: 		arr_list[left_cur] = arr_list[right_cur];
LSLS	R3, R7, #2
ADDS	R3, R0, R3
LDR	R3, [R3, #0]
STR	R3, [R4, #0]
;p4_serial_comm.c,234 :: 		arr_list[right_cur] = temp_val;
LSLS	R3, R7, #2
; right_cur end address is: 28 (R7)
ADDS	R3, R0, R3
STR	R5, [R3, #0]
; temp_val end address is: 20 (R5)
;p4_serial_comm.c,235 :: 		}
L_q_sort51:
;p4_serial_comm.c,237 :: 		if (*pivot_pos == 0) {
LDR	R3, [R1, #0]
CMP	R3, #0
IT	NE
BNE	L_q_sort52
; arr_list end address is: 0 (R0)
; pivot_pos end address is: 4 (R1)
; min_pos end address is: 8 (R2)
;p4_serial_comm.c,238 :: 		return 0;
MOVS	R0, #0
SXTH	R0, R0
IT	AL
BAL	L_end_q_sort
;p4_serial_comm.c,239 :: 		}
L_q_sort52:
;p4_serial_comm.c,241 :: 		return q_sort(arr_list, pivot_pos, min_pos);
; min_pos start address is: 8 (R2)
; pivot_pos start address is: 4 (R1)
; arr_list start address is: 0 (R0)
; min_pos end address is: 8 (R2)
; pivot_pos end address is: 4 (R1)
; arr_list end address is: 0 (R0)
BL	_q_sort+0
;p4_serial_comm.c,244 :: 		}
L_end_q_sort:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _q_sort
_print_header:
;p4_serial_comm.c,246 :: 		void print_header(uint32_t *header) {
; header start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R1, R0
; header end address is: 0 (R0)
; header start address is: 4 (R1)
;p4_serial_comm.c,247 :: 		uint32_t i = 0;
; i start address is: 0 (R0)
MOV	R0, #0
; header end address is: 4 (R1)
; i end address is: 0 (R0)
MOV	R4, R1
MOV	R5, R0
;p4_serial_comm.c,249 :: 		while (header[i] != '\0') {
L_print_header54:
; i start address is: 20 (R5)
; header start address is: 16 (R4)
LSLS	R1, R5, #2
ADDS	R1, R4, R1
LDR	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_print_header55
;p4_serial_comm.c,250 :: 		write_data_char( &header[i], 0 );
LSLS	R1, R5, #2
ADDS	R1, R4, R1
MOV	R0, R1
MOVS	R1, #0
BL	_write_data_char+0
;p4_serial_comm.c,251 :: 		++i;
ADDS	R5, R5, #1
;p4_serial_comm.c,252 :: 		}
; header end address is: 16 (R4)
; i end address is: 20 (R5)
IT	AL
BAL	L_print_header54
L_print_header55:
;p4_serial_comm.c,254 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_print_header56:
SUBS	R7, R7, #1
BNE	L_print_header56
NOP
NOP
NOP
;p4_serial_comm.c,255 :: 		USART1_DR = CHAR_CR;			// Write a Carriage Return
MOV	R2, #13
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;p4_serial_comm.c,256 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_print_header58:
SUBS	R7, R7, #1
BNE	L_print_header58
NOP
NOP
NOP
;p4_serial_comm.c,257 :: 		USART1_DR = CHAR_LF;			// Write a Line Feed
MOV	R2, #10
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;p4_serial_comm.c,259 :: 		}
L_end_print_header:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _print_header
_main:
;p4_serial_comm.c,263 :: 		void main() {
SUB	SP, SP, #332
;p4_serial_comm.c,266 :: 		uint8_t loop_on = TRUE;
MOVS	R0, #1
STRB	R0, [SP, #204]
;p4_serial_comm.c,269 :: 		int32_t char_counter = 0;
; char_counter start address is: 12 (R3)
MOV	R3, #0
;p4_serial_comm.c,270 :: 		uint32_t i=0;
ADD	R11, SP, #208
ADD	R10, R11, #124
MOVW	R12, #lo_addr(?ICSmain_i_L0+0)
MOVT	R12, #hi_addr(?ICSmain_i_L0+0)
BL	___CC2DW+0
;p4_serial_comm.c,271 :: 		int32_t min_pos = 0;
;p4_serial_comm.c,272 :: 		int32_t pivot_pos = 0;
;p4_serial_comm.c,283 :: 		uint32_t title_orig[10]= {'O','r','i','g','i','n','a','l',':', '\0'};
;p4_serial_comm.c,284 :: 		uint32_t title_sorted[8]= {'S','o','r','t','e','d',':', '\0'};
;p4_serial_comm.c,285 :: 		uint32_t title_rev[10]= {'R','e','v','e','r','s','e','d',':','\0'};
;p4_serial_comm.c,289 :: 		RCC_APB2ENR |= 0x00000001; 	// Alternate function bit AFIOEN bit[0]. USART1 uses AF for PA9/PA10
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,290 :: 		AFIO_MAPR    = 0x00000000; 	// Bit[2] USART1 REMAP 0: No Remap (Tx=PA9; Rx=PA10)
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,292 :: 		RCC_APB2ENR |= 1 << 2;		// Enable GPIO Clock - Port A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,293 :: 		RCC_APB2ENR |= 1 << 5;		// Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,294 :: 		RCC_APB2ENR |= 1 << 14; 	// Enable USART1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,296 :: 		GPIOA_CRH &= ~(0xFF << 4);  // Shift 4 bits left to clear bits[9:4] for PA9/PA10 0000 0FF0 -> mask with  FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,297 :: 		GPIOA_CRH |= (0x0B << 4) ;  // USART1 Tx/PA9 set to CNF=AFoutput push-pull b10; MODE= output-50Hz b11;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,298 :: 		GPIOA_CRH |= (0x04 << 8);   // USART1 Rx/PA10 set CNF=Input-floating b01; MODE=Input mode b00;
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,299 :: 		GPIOD_CRH = GPIO_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,304 :: 		USART1_BRR = 0x00000506;
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,314 :: 		USART1_CR1 &= ~(1<<12);          // Force 8 data bits. M bit is set to 0.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,315 :: 		USART1_CR2 &= ~(3<<12);          // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,316 :: 		USART1_CR3 &= ~(3<<8);           // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,317 :: 		USART1_CR1 &= ~(3<<9);           // Force no parity and no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,318 :: 		USART1_CR1 |= 3<<2;              // RX, TX enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,321 :: 		USART1_CR1 |= 1 << 13;			//** NOTE USART1 Enable must be done after configuration is complete
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;p4_serial_comm.c,322 :: 		Delay_ms(100);					// Allow some time for USART to complete initialization.
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main60:
SUBS	R7, R7, #1
BNE	L_main60
NOP
NOP
NOP
;p4_serial_comm.c,323 :: 		update_led(0xff);
MOVS	R0, #255
BL	_update_led+0
; char_counter end address is: 12 (R3)
MOV	R2, R3
;p4_serial_comm.c,328 :: 		for (;;) {
L_main62:
;p4_serial_comm.c,330 :: 		while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
; char_counter start address is: 8 (R2)
; char_counter end address is: 8 (R2)
L_main65:
; char_counter start address is: 8 (R2)
CMP	R2, #50
IT	CS
BCS	L__main78
LDRB	R0, [SP, #204]
CMP	R0, #1
IT	NE
BNE	L__main77
L__main76:
;p4_serial_comm.c,331 :: 		read_data(&rx_buffer[char_counter]);
ADD	R1, SP, #4
LSLS	R0, R2, #2
ADDS	R0, R1, R0
BL	_read_data+0
;p4_serial_comm.c,333 :: 		if (rx_buffer[char_counter] == EXIT_CHAR){
ADD	R1, SP, #4
LSLS	R0, R2, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #64
IT	NE
BNE	L_main69
;p4_serial_comm.c,334 :: 		loop_on = FALSE;
MOVS	R0, #0
STRB	R0, [SP, #204]
;p4_serial_comm.c,335 :: 		}
MOV	R0, R2
IT	AL
BAL	L_main70
L_main69:
;p4_serial_comm.c,336 :: 		else if (rx_buffer[char_counter] != 0x0D) {
ADD	R1, SP, #4
LSLS	R0, R2, #2
ADDS	R0, R1, R0
LDR	R0, [R0, #0]
CMP	R0, #13
IT	EQ
BEQ	L__main79
;p4_serial_comm.c,337 :: 		++char_counter;
ADDS	R0, R2, #1
; char_counter end address is: 8 (R2)
; char_counter start address is: 12 (R3)
MOV	R3, R0
;p4_serial_comm.c,339 :: 		if (char_counter == MAX_BUFFER_SIZE) {
CMP	R0, #50
IT	NE
BNE	L_main72
;p4_serial_comm.c,340 :: 		rx_buffer[i] = EXIT_CHAR;
ADD	R1, SP, #4
LDR	R0, [SP, #208]
LSLS	R0, R0, #2
ADDS	R1, R1, R0
MOV	R0, #64
STR	R0, [R1, #0]
;p4_serial_comm.c,341 :: 		}
L_main72:
;p4_serial_comm.c,342 :: 		update_led(char_counter);
MOV	R0, R3
BL	_update_led+0
; char_counter end address is: 12 (R3)
MOV	R0, R3
;p4_serial_comm.c,343 :: 		}
IT	AL
BAL	L_main71
L__main79:
;p4_serial_comm.c,336 :: 		else if (rx_buffer[char_counter] != 0x0D) {
MOV	R0, R2
;p4_serial_comm.c,343 :: 		}
L_main71:
; char_counter start address is: 0 (R0)
; char_counter end address is: 0 (R0)
L_main70:
;p4_serial_comm.c,344 :: 		}
; char_counter start address is: 0 (R0)
MOV	R2, R0
; char_counter end address is: 0 (R0)
IT	AL
BAL	L_main65
;p4_serial_comm.c,330 :: 		while ( (char_counter < MAX_BUFFER_SIZE) && (loop_on == TRUE) ) {
L__main78:
; char_counter start address is: 8 (R2)
L__main77:
;p4_serial_comm.c,347 :: 		list_len = char_counter;
MOVW	R0, #lo_addr(_list_len+0)
MOVT	R0, #hi_addr(_list_len+0)
STR	R2, [R0, #0]
;p4_serial_comm.c,348 :: 		pivot_pos = (char_counter - 1);
SUBS	R0, R2, #1
; char_counter end address is: 8 (R2)
STR	R0, [SP, #216]
;p4_serial_comm.c,350 :: 		update_led(LED_RESET);
MOV	R0, #0
BL	_update_led+0
;p4_serial_comm.c,356 :: 		print_header(&title_orig);		// Print title heading
ADD	R0, SP, #220
BL	_print_header+0
;p4_serial_comm.c,357 :: 		write_data(&rx_buffer);
ADD	R0, SP, #4
BL	_write_data+0
;p4_serial_comm.c,360 :: 		q_sort(&rx_buffer, &pivot_pos, &min_pos);
ADD	R2, SP, #212
ADD	R1, SP, #216
ADD	R0, SP, #4
BL	_q_sort+0
;p4_serial_comm.c,362 :: 		print_header(&title_sorted);		// Print title heading
ADD	R0, SP, #260
BL	_print_header+0
;p4_serial_comm.c,364 :: 		write_data(&rx_buffer);
ADD	R0, SP, #4
BL	_write_data+0
;p4_serial_comm.c,366 :: 		print_header(&title_rev); 	// Print reversed title
ADD	R0, SP, #292
BL	_print_header+0
;p4_serial_comm.c,367 :: 		write_data_reversed(&rx_buffer, (list_len-1) );		// Print reversed is (listSize -1)
MOVW	R0, #lo_addr(_list_len+0)
MOVT	R0, #hi_addr(_list_len+0)
LDR	R0, [R0, #0]
SUBS	R1, R0, #1
ADD	R0, SP, #4
BL	_write_data_reversed+0
;p4_serial_comm.c,371 :: 		loop_on = TRUE;
MOVS	R0, #1
STRB	R0, [SP, #204]
;p4_serial_comm.c,372 :: 		char_counter = 0;
; char_counter start address is: 8 (R2)
MOVS	R2, #0
;p4_serial_comm.c,376 :: 		}
; char_counter end address is: 8 (R2)
IT	AL
BAL	L_main62
;p4_serial_comm.c,381 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
