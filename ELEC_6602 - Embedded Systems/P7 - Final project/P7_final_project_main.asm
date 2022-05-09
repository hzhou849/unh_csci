_set_cur_screen_run_flag:
;cp_const_def.h,84 :: 		void set_cur_screen_run_flag(uint8_t run_flag) {
; run_flag start address is: 0 (R0)
SUB	SP, SP, #4
; run_flag end address is: 0 (R0)
; run_flag start address is: 0 (R0)
;cp_const_def.h,85 :: 		cur_screen_run_flag = run_flag;
MOVW	R1, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R1, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
STRB	R0, [R1, #0]
; run_flag end address is: 0 (R0)
;cp_const_def.h,86 :: 		}
L_end_set_cur_screen_run_flag:
ADD	SP, SP, #4
BX	LR
; end of _set_cur_screen_run_flag
_set_game_phase:
;cp_const_def.h,88 :: 		void set_game_phase(uint8_t game_phase) {
; game_phase start address is: 0 (R0)
SUB	SP, SP, #4
; game_phase end address is: 0 (R0)
; game_phase start address is: 0 (R0)
;cp_const_def.h,89 :: 		g_GAME_PHASE = game_phase;
MOVW	R1, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R0, [R1, #0]
; game_phase end address is: 0 (R0)
;cp_const_def.h,90 :: 		}
L_end_set_game_phase:
ADD	SP, SP, #4
BX	LR
; end of _set_game_phase
_debug:
;cp_const_def.h,111 :: 		void debug(uint32_t value) {
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 0 (R0)
; value start address is: 0 (R0)
;cp_const_def.h,112 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_debug0:
SUBS	R7, R7, #1
BNE	L_debug0
NOP
NOP
NOP
;cp_const_def.h,113 :: 		USART1_DR = 0xD;
MOVS	R2, #13
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,114 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_debug2:
SUBS	R7, R7, #1
BNE	L_debug2
NOP
NOP
NOP
;cp_const_def.h,115 :: 		USART1_DR=0xA;
MOVS	R2, #10
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,116 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_debug4:
SUBS	R7, R7, #1
BNE	L_debug4
NOP
NOP
NOP
;cp_const_def.h,117 :: 		USART1_DR = value;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; value end address is: 0 (R0)
;cp_const_def.h,118 :: 		}
L_end_debug:
ADD	SP, SP, #4
BX	LR
; end of _debug
_init_arr:
;cp_pix_render.h,58 :: 		void init_arr(uint8_t *in_arr, uint32_t a_size) {
; a_size start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R2, R1
MOV	R1, R0
; a_size end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 4 (R1)
; a_size start address is: 8 (R2)
;cp_pix_render.h,59 :: 		uint32_t i=0;
;cp_pix_render.h,61 :: 		for (i=0; i < a_size; i++) {
; i start address is: 0 (R0)
MOVS	R0, #0
; a_size end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R4, R0
MOV	R0, R2
L_init_arr6:
; i start address is: 16 (R4)
; a_size start address is: 0 (R0)
; in_arr start address is: 4 (R1)
; in_arr end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_init_arr7
; in_arr end address is: 4 (R1)
;cp_pix_render.h,62 :: 		in_arr[i]=0xFF;
; in_arr start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
;cp_pix_render.h,61 :: 		for (i=0; i < a_size; i++) {
ADDS	R4, R4, #1
;cp_pix_render.h,63 :: 		}
; a_size end address is: 0 (R0)
; in_arr end address is: 4 (R1)
; i end address is: 16 (R4)
IT	AL
BAL	L_init_arr6
L_init_arr7:
;cp_pix_render.h,64 :: 		}
L_end_init_arr:
ADD	SP, SP, #4
BX	LR
; end of _init_arr
_dump_arr_memory:
;cp_pix_render.h,68 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
;cp_pix_render.h,71 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_pix_render.h,68 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
;cp_pix_render.h,71 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_pix_render.h,68 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 0 (R0)
;cp_pix_render.h,69 :: 		uint32_t i = 0;
;cp_pix_render.h,71 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
L_dump_arr_memory9:
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
CMP	R1, #300
IT	CS
BCS	L_dump_arr_memory10
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
;cp_pix_render.h,74 :: 		while ( (USART1_SR & (1 << 7 )) == 0) {}
L_dump_arr_memory12:
; in_arr start address is: 0 (R0)
; i start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_dump_arr_memory13
IT	AL
BAL	L_dump_arr_memory12
L_dump_arr_memory13:
;cp_pix_render.h,75 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory14:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory14
NOP
NOP
NOP
;cp_pix_render.h,76 :: 		USART1_DR = (uint32_t)in_arr[i];
ADDS	R2, R0, R1
LDRB	R2, [R2, #0]
UXTB	R3, R2
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;cp_pix_render.h,77 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory16:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory16
NOP
NOP
NOP
;cp_pix_render.h,71 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
ADDS	R1, R1, #1
;cp_pix_render.h,79 :: 		}
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_arr_memory9
L_dump_arr_memory10:
;cp_pix_render.h,80 :: 		}
L_end_dump_arr_memory:
ADD	SP, SP, #4
BX	LR
; end of _dump_arr_memory
_set_sprite_offset:
;cp_pix_render.h,85 :: 		void set_sprite_offset(int32_t ofs_x, int32_t ofs_y) {
; ofs_y start address is: 4 (R1)
; ofs_x start address is: 0 (R0)
SUB	SP, SP, #4
; ofs_y end address is: 4 (R1)
; ofs_x end address is: 0 (R0)
; ofs_x start address is: 0 (R0)
; ofs_y start address is: 4 (R1)
;cp_pix_render.h,86 :: 		offset_x = ofs_x;
MOVW	R2, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_x+0)
STR	R0, [R2, #0]
; ofs_x end address is: 0 (R0)
;cp_pix_render.h,87 :: 		offset_y = ofs_y;
MOVW	R2, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_y+0)
STR	R1, [R2, #0]
; ofs_y end address is: 4 (R1)
;cp_pix_render.h,88 :: 		}
L_end_set_sprite_offset:
ADD	SP, SP, #4
BX	LR
; end of _set_sprite_offset
_get_offset_x:
;cp_pix_render.h,90 :: 		int32_t get_offset_x() {
SUB	SP, SP, #4
;cp_pix_render.h,91 :: 		return offset_x;
MOVW	R0, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,92 :: 		}
L_end_get_offset_x:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_x
_get_offset_y:
;cp_pix_render.h,93 :: 		int32_t get_offset_y() {
SUB	SP, SP, #4
;cp_pix_render.h,94 :: 		return offset_y;
MOVW	R0, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,95 :: 		}
L_end_get_offset_y:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_y
_convert_lin_xy:
;cp_pix_render.h,100 :: 		void convert_lin_xy(int32_t *cell_pos, int32_t *x_var, int32_t *y_var ) {
; y_var start address is: 8 (R2)
; x_var start address is: 4 (R1)
; cell_pos start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R4, R0
; y_var end address is: 8 (R2)
; x_var end address is: 4 (R1)
; cell_pos end address is: 0 (R0)
; cell_pos start address is: 16 (R4)
; x_var start address is: 4 (R1)
; y_var start address is: 8 (R2)
;cp_pix_render.h,102 :: 		int32_t row = 0;
; row start address is: 0 (R0)
MOV	R0, #0
;cp_pix_render.h,103 :: 		int32_t col = 0;
;cp_pix_render.h,104 :: 		int32_t temp_val = *cell_pos;
LDR	R3, [R4, #0]
; cell_pos end address is: 16 (R4)
; temp_val start address is: 16 (R4)
MOV	R4, R3
;cp_pix_render.h,106 :: 		if (temp_val > MAX_BLOCK_COUNT) {
CMP	R3, #300
IT	LE
BLE	L__convert_lin_xy348
; temp_val end address is: 16 (R4)
;cp_pix_render.h,107 :: 		temp_val = 300;
; temp_val start address is: 12 (R3)
MOVW	R3, #300
; temp_val end address is: 12 (R3)
;cp_pix_render.h,108 :: 		}
IT	AL
BAL	L_convert_lin_xy18
L__convert_lin_xy348:
;cp_pix_render.h,106 :: 		if (temp_val > MAX_BLOCK_COUNT) {
MOV	R3, R4
;cp_pix_render.h,108 :: 		}
L_convert_lin_xy18:
;cp_pix_render.h,113 :: 		while (temp_val >= (MAX_COL_WIDTH) ) {
; temp_val start address is: 12 (R3)
; y_var end address is: 8 (R2)
; row end address is: 0 (R0)
; x_var end address is: 4 (R1)
; temp_val end address is: 12 (R3)
MOV	R5, R0
MOV	R0, R2
MOV	R2, R3
L_convert_lin_xy19:
; temp_val start address is: 8 (R2)
; row start address is: 20 (R5)
; y_var start address is: 0 (R0)
; x_var start address is: 4 (R1)
CMP	R2, #20
IT	LT
BLT	L_convert_lin_xy20
;cp_pix_render.h,114 :: 		temp_val -= MAX_COL_WIDTH-1;
SUBW	R4, R2, #19
; temp_val end address is: 8 (R2)
; temp_val start address is: 24 (R6)
MOV	R6, R4
;cp_pix_render.h,115 :: 		++row;
ADDS	R3, R5, #1
; row end address is: 20 (R5)
; row start address is: 8 (R2)
MOV	R2, R3
;cp_pix_render.h,117 :: 		if (temp_val > 0 ) {
CMP	R4, #0
IT	LE
BLE	L__convert_lin_xy349
;cp_pix_render.h,118 :: 		--temp_val; // compensate for zero-index of array by subtract 1
SUBS	R3, R6, #1
; temp_val end address is: 24 (R6)
; temp_val start address is: 16 (R4)
MOV	R4, R3
; temp_val end address is: 16 (R4)
MOV	R3, R4
;cp_pix_render.h,119 :: 		}
IT	AL
BAL	L_convert_lin_xy21
L__convert_lin_xy349:
;cp_pix_render.h,117 :: 		if (temp_val > 0 ) {
MOV	R3, R6
;cp_pix_render.h,119 :: 		}
L_convert_lin_xy21:
;cp_pix_render.h,121 :: 		}
; temp_val start address is: 12 (R3)
; row end address is: 8 (R2)
; temp_val end address is: 12 (R3)
MOV	R5, R2
MOV	R2, R3
IT	AL
BAL	L_convert_lin_xy19
L_convert_lin_xy20:
;cp_pix_render.h,125 :: 		if (row <= 0 ) {
; row start address is: 20 (R5)
; temp_val start address is: 8 (R2)
CMP	R5, #0
IT	GT
BGT	L__convert_lin_xy350
; row end address is: 20 (R5)
;cp_pix_render.h,126 :: 		row = 1;
; row start address is: 12 (R3)
MOVS	R3, #1
; row end address is: 12 (R3)
;cp_pix_render.h,127 :: 		}
IT	AL
BAL	L_convert_lin_xy22
L__convert_lin_xy350:
;cp_pix_render.h,125 :: 		if (row <= 0 ) {
MOV	R3, R5
;cp_pix_render.h,127 :: 		}
L_convert_lin_xy22:
;cp_pix_render.h,131 :: 		*x_var = col;
; row start address is: 12 (R3)
STR	R2, [R1, #0]
; temp_val end address is: 8 (R2)
; x_var end address is: 4 (R1)
;cp_pix_render.h,132 :: 		*y_var = row;
STR	R3, [R0, #0]
; y_var end address is: 0 (R0)
; row end address is: 12 (R3)
;cp_pix_render.h,134 :: 		}
L_end_convert_lin_xy:
ADD	SP, SP, #4
BX	LR
; end of _convert_lin_xy
_color_convert_32:
;cp_pix_render.h,138 :: 		int32_t color_convert_32(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #4
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 0 (R0)
;cp_pix_render.h,140 :: 		if (color_8bit == m_YELLOW){
CMP	R0, #1
IT	NE
BNE	L_color_convert_3223
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,141 :: 		return CL_YELLOW;
MOVW	R0, #65504
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,142 :: 		} else if (color_8bit == m_BLACK) {
L_color_convert_3223:
; color_8bit start address is: 0 (R0)
CMP	R0, #0
IT	NE
BNE	L_color_convert_3225
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,143 :: 		return CL_BLACK;
MOVW	R0, #0
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,144 :: 		} else if (color_8bit == m_RED) {
L_color_convert_3225:
; color_8bit start address is: 0 (R0)
CMP	R0, #2
IT	NE
BNE	L_color_convert_3227
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,145 :: 		return CL_RED;
MOVW	R0, #63488
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,146 :: 		} else if (color_8bit == m_NAVY) {
L_color_convert_3227:
; color_8bit start address is: 0 (R0)
CMP	R0, #3
IT	NE
BNE	L_color_convert_3229
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,147 :: 		return CL_NAVY;
MOVW	R0, #16
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,148 :: 		} else if (color_8bit == m_GREEN) {
L_color_convert_3229:
; color_8bit start address is: 0 (R0)
CMP	R0, #5
IT	NE
BNE	L_color_convert_3231
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,149 :: 		return CL_GREEN;
MOVW	R0, #1024
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,150 :: 		} else if (color_8bit == m_FUCHSIA) {
L_color_convert_3231:
; color_8bit start address is: 0 (R0)
CMP	R0, #6
IT	NE
BNE	L_color_convert_3233
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,151 :: 		return CL_FUCHSIA;
MOVW	R0, #63519
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,152 :: 		} else if (color_8bit == m_GRAY) {
L_color_convert_3233:
; color_8bit start address is: 0 (R0)
CMP	R0, #4
IT	NE
BNE	L_color_convert_3235
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,153 :: 		return CL_GRAY;
MOVW	R0, #33808
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,154 :: 		} else {
L_color_convert_3235:
;cp_pix_render.h,155 :: 		return CL_WHITE;
MOVW	R0, #65535
;cp_pix_render.h,157 :: 		}
L_end_color_convert_32:
ADD	SP, SP, #4
BX	LR
; end of _color_convert_32
_set_brush_color:
;cp_pix_render.h,162 :: 		void set_brush_color(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R7, R0
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 28 (R7)
;cp_pix_render.h,164 :: 		px_clr = color_convert_32(color_8bit);
UXTB	R0, R7
BL	_color_convert_32+0
;cp_pix_render.h,166 :: 		TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
MOVS	R2, #0
MOVS	R1, #0
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #0
MOVS	R2, #0
UXTH	R1, R0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_pix_render.h,167 :: 		CUR_BRUSH_COLOUR = color_8bit; // assign the new colour code
MOVW	R1, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R1, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
STRB	R7, [R1, #0]
; color_8bit end address is: 28 (R7)
;cp_pix_render.h,168 :: 		}
L_end_set_brush_color:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_brush_color
_draw_cell_pos:
;cp_pix_render.h,173 :: 		void draw_cell_pos( int32_t *linear_pos, uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; linear_pos start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; linear_pos end address is: 0 (R0)
; linear_pos start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,176 :: 		int32_t cell_pos = *linear_pos;
LDR	R2, [R0, #0]
; linear_pos end address is: 0 (R0)
STR	R2, [SP, #12]
;cp_pix_render.h,179 :: 		if (color_8bit != CUR_BRUSH_COLOUR) {
MOVW	R2, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R2, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
LDRB	R2, [R2, #0]
CMP	R1, R2
IT	EQ
BEQ	L_draw_cell_pos37
;cp_pix_render.h,181 :: 		set_brush_color(color_8bit);
UXTB	R0, R1
; color_8bit end address is: 4 (R1)
BL	_set_brush_color+0
;cp_pix_render.h,182 :: 		}
L_draw_cell_pos37:
;cp_pix_render.h,185 :: 		convert_lin_xy(&cell_pos, &x_var, &y_var );
ADD	R4, SP, #8
ADD	R3, SP, #4
ADD	R2, SP, #12
MOV	R1, R3
MOV	R0, R2
MOV	R2, R4
BL	_convert_lin_xy+0
;cp_pix_render.h,188 :: 		x_var +=offset_x; // right 2 blocks
MOVW	R2, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R3, [R2, #0]
LDR	R2, [SP, #4]
ADDS	R6, R2, R3
STR	R6, [SP, #4]
;cp_pix_render.h,189 :: 		y_var +=offset_y; // down 1 block
MOVW	R2, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R3, [R2, #0]
LDR	R2, [SP, #8]
ADDS	R2, R2, R3
STR	R2, [SP, #8]
;cp_pix_render.h,197 :: 		PX_BLOCK + (PX_BLOCK * y_var)               // Lower-right Y
LSLS	R5, R2, #4
ADDW	R4, R5, #16
;cp_pix_render.h,196 :: 		PX_BLOCK + (PX_BLOCK * x_var),              // Lower-right X
LSLS	R3, R6, #4
ADDW	R2, R3, #16
SXTH	R2, R2
;cp_pix_render.h,195 :: 		(y_var * PX_BLOCK),                         // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,194 :: 		PX_BLOCK * x_var,                           // Upper-left X
SXTH	R0, R3
;cp_pix_render.h,197 :: 		PX_BLOCK + (PX_BLOCK * y_var)               // Lower-right Y
SXTH	R3, R4
BL	_TFT_Rectangle+0
;cp_pix_render.h,199 :: 		}
L_end_draw_cell_pos:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _draw_cell_pos
_draw_cell_xy:
;cp_pix_render.h,204 :: 		void draw_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {
; color_8bit start address is: 8 (R2)
; y_var start address is: 4 (R1)
; x_var start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTH	R8, R0
SXTH	R9, R1
; color_8bit end address is: 8 (R2)
; y_var end address is: 4 (R1)
; x_var end address is: 0 (R0)
; x_var start address is: 32 (R8)
; y_var start address is: 36 (R9)
; color_8bit start address is: 8 (R2)
;cp_pix_render.h,206 :: 		if (color_8bit != CUR_BRUSH_COLOUR) {
MOVW	R3, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R3, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
LDRB	R3, [R3, #0]
CMP	R2, R3
IT	EQ
BEQ	L_draw_cell_xy38
;cp_pix_render.h,207 :: 		set_brush_color(color_8bit);
UXTB	R0, R2
; color_8bit end address is: 8 (R2)
BL	_set_brush_color+0
;cp_pix_render.h,208 :: 		}
L_draw_cell_xy38:
;cp_pix_render.h,212 :: 		x_var +=offset_x; // right 2 blocks
MOVW	R3, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R3, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R3, [R3, #0]
ADD	R4, R8, R3, LSL #0
; x_var end address is: 32 (R8)
;cp_pix_render.h,213 :: 		y_var +=offset_y; // down 1 block
MOVW	R3, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R3, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R3, [R3, #0]
ADD	R3, R9, R3, LSL #0
; y_var end address is: 36 (R9)
;cp_pix_render.h,221 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
SXTH	R3, R3
LSLS	R6, R3, #4
SXTH	R6, R6
ADDW	R5, R6, #16
;cp_pix_render.h,220 :: 		PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
SXTH	R3, R4
LSLS	R4, R3, #4
SXTH	R4, R4
ADDW	R3, R4, #16
SXTH	R2, R3
;cp_pix_render.h,221 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
SXTH	R3, R5
;cp_pix_render.h,219 :: 		(y_var * PX_BLOCK),                 // Upper-left Y
SXTH	R1, R6
;cp_pix_render.h,218 :: 		PX_BLOCK * x_var,                   // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,221 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,223 :: 		}
L_end_draw_cell_xy:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_cell_xy
_draw_ini_cell_xy:
;cp_pix_render.h,227 :: 		void draw_ini_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {
; color_8bit start address is: 8 (R2)
; y_var start address is: 4 (R1)
; x_var start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
SXTH	R8, R0
SXTH	R9, R1
; color_8bit end address is: 8 (R2)
; y_var end address is: 4 (R1)
; x_var end address is: 0 (R0)
; x_var start address is: 32 (R8)
; y_var start address is: 36 (R9)
; color_8bit start address is: 8 (R2)
;cp_pix_render.h,229 :: 		if (color_8bit != CUR_BRUSH_COLOUR) {
MOVW	R3, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R3, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
LDRB	R3, [R3, #0]
CMP	R2, R3
IT	EQ
BEQ	L_draw_ini_cell_xy39
;cp_pix_render.h,230 :: 		set_brush_color(color_8bit);
UXTB	R0, R2
; color_8bit end address is: 8 (R2)
BL	_set_brush_color+0
;cp_pix_render.h,231 :: 		}
L_draw_ini_cell_xy39:
;cp_pix_render.h,235 :: 		x_var +=offset_x; // right 2 blocks
MOVW	R3, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R3, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R3, [R3, #0]
ADD	R4, R8, R3, LSL #0
; x_var end address is: 32 (R8)
;cp_pix_render.h,236 :: 		y_var +=offset_y; // down 1 block
MOVW	R3, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R3, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R3, [R3, #0]
ADD	R3, R9, R3, LSL #0
; y_var end address is: 36 (R9)
;cp_pix_render.h,244 :: 		PX_BLOCK + ( PX_BLOCK * y_var)       // Lower-right Y
SXTH	R3, R3
LSLS	R6, R3, #4
SXTH	R6, R6
ADDW	R5, R6, #16
;cp_pix_render.h,243 :: 		INI_BLOCK + ( INI_BLOCK * x_var),      // Lower-right X reduce this number
SXTH	R4, R4
MOVS	R3, #10
SXTH	R3, R3
MULS	R4, R3, R4
SXTH	R4, R4
ADDW	R3, R4, #10
SXTH	R2, R3
;cp_pix_render.h,244 :: 		PX_BLOCK + ( PX_BLOCK * y_var)       // Lower-right Y
SXTH	R3, R5
;cp_pix_render.h,242 :: 		(y_var *  PX_BLOCK),                 // Upper-left Y
SXTH	R1, R6
;cp_pix_render.h,241 :: 		INI_BLOCK * x_var,                   // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,244 :: 		PX_BLOCK + ( PX_BLOCK * y_var)       // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,246 :: 		}
L_end_draw_ini_cell_xy:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_ini_cell_xy
_render_rect_mask:
;cp_pix_render.h,253 :: 		void render_rect_mask(int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit) {
; lr_y start address is: 12 (R3)
; lr_x start address is: 8 (R2)
; ul_y start address is: 4 (R1)
; ul_x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R8, R0
MOV	R9, R1
MOV	R10, R2
MOV	R11, R3
; lr_y end address is: 12 (R3)
; lr_x end address is: 8 (R2)
; ul_y end address is: 4 (R1)
; ul_x end address is: 0 (R0)
; ul_x start address is: 32 (R8)
; ul_y start address is: 36 (R9)
; lr_x start address is: 40 (R10)
; lr_y start address is: 44 (R11)
; color_8bit start address is: 16 (R4)
LDRB	R4, [SP, #4]
;cp_pix_render.h,256 :: 		set_brush_color(color_8bit);
UXTB	R0, R4
; color_8bit end address is: 16 (R4)
BL	_set_brush_color+0
;cp_pix_render.h,262 :: 		PX_BLOCK * lr_y                // Lower-right Y
LSL	R7, R11, #4
; lr_y end address is: 44 (R11)
;cp_pix_render.h,261 :: 		PX_BLOCK * lr_x,               // Lower-right X
LSL	R6, R10, #4
; lr_x end address is: 40 (R10)
;cp_pix_render.h,260 :: 		PX_BLOCK * ul_y,               // Upper-left Y
LSL	R5, R9, #4
; ul_y end address is: 36 (R9)
;cp_pix_render.h,259 :: 		PX_BLOCK * ul_x,               // Upper-left X
LSL	R4, R8, #4
; ul_x end address is: 32 (R8)
;cp_pix_render.h,262 :: 		PX_BLOCK * lr_y                // Lower-right Y
SXTH	R3, R7
;cp_pix_render.h,261 :: 		PX_BLOCK * lr_x,               // Lower-right X
SXTH	R2, R6
;cp_pix_render.h,260 :: 		PX_BLOCK * ul_y,               // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,259 :: 		PX_BLOCK * ul_x,               // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,262 :: 		PX_BLOCK * lr_y                // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,264 :: 		}
L_end_render_rect_mask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _render_rect_mask
_load_cell_xy:
;cp_pix_render.h,270 :: 		void load_cell_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
; clr_code start address is: 8 (R2)
; y_var start address is: 4 (R1)
; x_var start address is: 0 (R0)
SUB	SP, SP, #4
; clr_code end address is: 8 (R2)
; y_var end address is: 4 (R1)
; x_var end address is: 0 (R0)
; x_var start address is: 0 (R0)
; y_var start address is: 4 (R1)
; clr_code start address is: 8 (R2)
;cp_pix_render.h,271 :: 		int32_t linear_val = 0;
;cp_pix_render.h,283 :: 		linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
MOV	R3, #20
MULS	R3, R1, R3
; y_var end address is: 4 (R1)
ADDS	R4, R3, R0
; x_var end address is: 0 (R0)
;cp_pix_render.h,284 :: 		g_DS_BUFFER[linear_val] = color_8bit;
MOVW	R3, #lo_addr(_g_DS_BUFFER+0)
MOVT	R3, #hi_addr(_g_DS_BUFFER+0)
ADDS	R3, R3, R4
STRB	R2, [R3, #0]
; clr_code end address is: 8 (R2)
;cp_pix_render.h,286 :: 		}
L_end_load_cell_xy:
ADD	SP, SP, #4
BX	LR
; end of _load_cell_xy
_dump_ds_buffer:
;cp_pix_render.h,291 :: 		void dump_ds_buffer() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;cp_pix_render.h,292 :: 		int32_t i=0;
;cp_pix_render.h,294 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; i end address is: 4 (R1)
L_dump_ds_buffer40:
; i start address is: 4 (R1)
CMP	R1, #300
IT	GE
BGE	L_dump_ds_buffer41
;cp_pix_render.h,296 :: 		if (g_DS_BUFFER[i] != 0xFF) {
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	EQ
BEQ	L_dump_ds_buffer43
;cp_pix_render.h,297 :: 		draw_cell_pos(i, g_DS_BUFFER[i]); // pass the colour code
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
STR	R1, [SP, #4]
STR	R1, [SP, #8]
UXTB	R1, R0
LDR	R0, [SP, #8]
BL	_draw_cell_pos+0
LDR	R1, [SP, #4]
;cp_pix_render.h,298 :: 		}
L_dump_ds_buffer43:
;cp_pix_render.h,294 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
ADDS	R1, R1, #1
;cp_pix_render.h,300 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_ds_buffer40
L_dump_ds_buffer41:
;cp_pix_render.h,301 :: 		}
L_end_dump_ds_buffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _dump_ds_buffer
_print_snake:
;cp_pix_render.h,306 :: 		void print_snake(t_node *node, uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; node start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; node end address is: 0 (R0)
; node start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,307 :: 		draw_cell_xy(node->node_x, node->node_y, color_8bit);
ADDS	R2, R0, #2
LDRSH	R2, [R2, #0]
SXTH	R3, R2
LDRSH	R2, [R0, #0]
; node end address is: 0 (R0)
SXTH	R0, R2
; color_8bit end address is: 4 (R1)
UXTB	R2, R1
SXTH	R1, R3
BL	_draw_cell_xy+0
;cp_pix_render.h,308 :: 		}
L_end_print_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _print_snake
_clean_tail:
;cp_pix_render.h,313 :: 		void clean_tail(t_node * node_tail,  uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; node_tail start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; node_tail end address is: 0 (R0)
; node_tail start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,314 :: 		print_snake(node_tail, color_8bit);
; color_8bit end address is: 4 (R1)
; node_tail end address is: 0 (R0)
BL	_print_snake+0
;cp_pix_render.h,315 :: 		}
L_end_clean_tail:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clean_tail
_cleaning_buffer:
;cp_pix_render.h,318 :: 		void cleaning_buffer(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 0 (R0)
;cp_pix_render.h,319 :: 		int32_t i=0;
;cp_pix_render.h,321 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
; i start address is: 8 (R2)
MOVS	R2, #0
; i end address is: 8 (R2)
L_cleaning_buffer44:
; i start address is: 8 (R2)
; color_8bit start address is: 0 (R0)
; color_8bit end address is: 0 (R0)
CMP	R2, #300
IT	GE
BGE	L_cleaning_buffer45
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,323 :: 		if (g_DS_BUFFER[i] != 0xFF) {
; color_8bit start address is: 0 (R0)
MOVW	R1, #lo_addr(_g_DS_BUFFER+0)
MOVT	R1, #hi_addr(_g_DS_BUFFER+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #255
IT	EQ
BEQ	L_cleaning_buffer47
;cp_pix_render.h,324 :: 		draw_cell_pos(i, color_8bit ); // pass the colour code~
STRB	R0, [SP, #4]
STR	R2, [SP, #8]
UXTB	R1, R0
MOV	R0, R2
BL	_draw_cell_pos+0
LDR	R2, [SP, #8]
LDRB	R0, [SP, #4]
;cp_pix_render.h,325 :: 		}
L_cleaning_buffer47:
;cp_pix_render.h,321 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
ADDS	R2, R2, #1
;cp_pix_render.h,327 :: 		}
; color_8bit end address is: 0 (R0)
; i end address is: 8 (R2)
IT	AL
BAL	L_cleaning_buffer44
L_cleaning_buffer45:
;cp_pix_render.h,328 :: 		}
L_end_cleaning_buffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _cleaning_buffer
_load_intro_screen_simple:
;cp_intro_screen_ctl.h,54 :: 		void load_intro_screen_simple() {
SUB	SP, SP, #16
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,57 :: 		uint8_t scroll_dir = 5; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,58 :: 		uint32_t volatile x_axis = 55;
;cp_intro_screen_ctl.h,59 :: 		uint32_t volatile y_axis = 115;
;cp_intro_screen_ctl.h,61 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,62 :: 		uint32_t  prev_val2 = 0;
;cp_intro_screen_ctl.h,67 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,69 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen_simple48:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple49
;cp_intro_screen_ctl.h,72 :: 		draw_rectangle(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_rectangle+0
;cp_intro_screen_ctl.h,74 :: 		if (scroll_dir == 1 ) {
LDRB	R0, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple50
;cp_intro_screen_ctl.h,75 :: 		if (y_axis > (SCREEN_Y_MAX-20) || x_axis > (SCREEN_X_MAX -30) ) {
LDR	R0, [SP, #12]
CMP	R0, #220
IT	HI
BHI	L__load_intro_screen_simple354
LDR	R0, [SP, #8]
CMP	R0, #290
IT	HI
BHI	L__load_intro_screen_simple353
IT	AL
BAL	L_load_intro_screen_simple53
L__load_intro_screen_simple354:
L__load_intro_screen_simple353:
;cp_intro_screen_ctl.h,76 :: 		scroll_dir = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,77 :: 		}
L_load_intro_screen_simple53:
;cp_intro_screen_ctl.h,78 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,79 :: 		y_axis+=SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,81 :: 		}
IT	AL
BAL	L_load_intro_screen_simple54
L_load_intro_screen_simple50:
;cp_intro_screen_ctl.h,84 :: 		if (y_axis < 10 || x_axis < 2) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen_simple356
LDR	R0, [SP, #8]
CMP	R0, #2
IT	CC
BCC	L__load_intro_screen_simple355
IT	AL
BAL	L_load_intro_screen_simple57
L__load_intro_screen_simple356:
L__load_intro_screen_simple355:
;cp_intro_screen_ctl.h,85 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,86 :: 		}
L_load_intro_screen_simple57:
;cp_intro_screen_ctl.h,87 :: 		x_axis-=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
SUBS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,88 :: 		y_axis-=SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,89 :: 		}
L_load_intro_screen_simple54:
;cp_intro_screen_ctl.h,90 :: 		draw_intro_screen(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_intro_screen+0
;cp_intro_screen_ctl.h,92 :: 		}
IT	AL
BAL	L_load_intro_screen_simple48
L_load_intro_screen_simple49:
;cp_intro_screen_ctl.h,93 :: 		}
L_end_load_intro_screen_simple:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _load_intro_screen_simple
_load_intro_screen:
;cp_intro_screen_ctl.h,97 :: 		void load_intro_screen() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,99 :: 		uint8_t rotation = 0;
ADD	R11, SP, #8
ADD	R10, R11, #8
MOVW	R12, #lo_addr(?ICSload_intro_screen_rotation_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_rotation_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,100 :: 		uint8_t scroll_dir = 1; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
;cp_intro_screen_ctl.h,101 :: 		uint32_t volatile x_axis = 35;
;cp_intro_screen_ctl.h,102 :: 		uint32_t volatile y_axis = 115;
; y_axis start address is: 8 (R2)
MOV	R2, #115
;cp_intro_screen_ctl.h,104 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,105 :: 		uint32_t  prev_val2 = 5;
;cp_intro_screen_ctl.h,106 :: 		uint32_t counter = 1;
MOV	R0, #1
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,108 :: 		intro_game_phase = PHASE_INTRO;
MOVS	R1, #0
MOVW	R0, #lo_addr(_intro_game_phase+0)
MOVT	R0, #hi_addr(_intro_game_phase+0)
STRB	R1, [R0, #0]
;cp_intro_screen_ctl.h,109 :: 		cur_screen_run_flag = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
STRB	R1, [R0, #0]
;cp_intro_screen_ctl.h,115 :: 		TFT_Fill_Screen(CL_BLACK);
STR	R2, [SP, #4]
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,117 :: 		draw_info_text( 10,220);
MOVS	R1, #220
MOVS	R0, #10
BL	_draw_info_text+0
; y_axis end address is: 8 (R2)
LDR	R2, [SP, #4]
MOV	R1, R2
;cp_intro_screen_ctl.h,120 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen58:
; y_axis start address is: 4 (R1)
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen59
;cp_intro_screen_ctl.h,123 :: 		draw_rectangle(x_axis, y_axis);
STR	R1, [SP, #4]
LDR	R0, [SP, #12]
BL	_draw_rectangle+0
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,126 :: 		if (scroll_dir == 1){
LDRB	R0, [SP, #9]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen60
;cp_intro_screen_ctl.h,127 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,128 :: 		y_axis+=SCROLL_SPEED;
ADDS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,131 :: 		if ( x_axis > (SCREEN_X_MAX -200) || y_axis > (SCREEN_Y_MAX-42) ) {
LDR	R0, [SP, #12]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen362
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen361
IT	AL
BAL	L_load_intro_screen63
L__load_intro_screen362:
L__load_intro_screen361:
;cp_intro_screen_ctl.h,132 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen64
;cp_intro_screen_ctl.h,133 :: 		scroll_dir = 2;
MOVS	R0, #2
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,134 :: 		}
IT	AL
BAL	L_load_intro_screen65
L_load_intro_screen64:
;cp_intro_screen_ctl.h,136 :: 		scroll_dir = 4;
MOVS	R0, #4
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,137 :: 		}
L_load_intro_screen65:
;cp_intro_screen_ctl.h,138 :: 		}
L_load_intro_screen63:
;cp_intro_screen_ctl.h,140 :: 		}
MOV	R1, R4
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen66
L_load_intro_screen60:
;cp_intro_screen_ctl.h,142 :: 		else if (scroll_dir == 2) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #2
IT	NE
BNE	L_load_intro_screen67
;cp_intro_screen_ctl.h,143 :: 		x_axis += X_SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,144 :: 		y_axis -= SCROLL_SPEED;
SUBS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,147 :: 		if (x_axis > (SCREEN_X_MAX -200) || y_axis <10   ) {
LDR	R0, [SP, #12]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen364
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen363
IT	AL
BAL	L_load_intro_screen70
L__load_intro_screen364:
L__load_intro_screen363:
;cp_intro_screen_ctl.h,148 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen71
;cp_intro_screen_ctl.h,149 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,150 :: 		}
IT	AL
BAL	L_load_intro_screen72
L_load_intro_screen71:
;cp_intro_screen_ctl.h,152 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,153 :: 		}
L_load_intro_screen72:
;cp_intro_screen_ctl.h,154 :: 		}
L_load_intro_screen70:
;cp_intro_screen_ctl.h,155 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen73
L_load_intro_screen67:
;cp_intro_screen_ctl.h,158 :: 		else if (scroll_dir == 3) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #3
IT	NE
BNE	L_load_intro_screen74
;cp_intro_screen_ctl.h,159 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,160 :: 		y_axis -= SCROLL_SPEED;
SUBS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,163 :: 		if ( x_axis < 10 || y_axis < 10 ) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen366
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen365
IT	AL
BAL	L_load_intro_screen77
L__load_intro_screen366:
L__load_intro_screen365:
;cp_intro_screen_ctl.h,165 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen78
;cp_intro_screen_ctl.h,166 :: 		scroll_dir = 4; //4
MOVS	R0, #4
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,167 :: 		}
IT	AL
BAL	L_load_intro_screen79
L_load_intro_screen78:
;cp_intro_screen_ctl.h,169 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,170 :: 		}
L_load_intro_screen79:
;cp_intro_screen_ctl.h,171 :: 		}
L_load_intro_screen77:
;cp_intro_screen_ctl.h,173 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen80
L_load_intro_screen74:
;cp_intro_screen_ctl.h,175 :: 		else if (scroll_dir == 4) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #4
IT	NE
BNE	L__load_intro_screen369
;cp_intro_screen_ctl.h,176 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,177 :: 		y_axis += SCROLL_SPEED;
ADDS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,180 :: 		if ( x_axis < 10 || y_axis > (SCREEN_Y_MAX-42)) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen368
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen367
IT	AL
BAL	L_load_intro_screen84
L__load_intro_screen368:
L__load_intro_screen367:
;cp_intro_screen_ctl.h,182 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen85
;cp_intro_screen_ctl.h,183 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,184 :: 		} else {
IT	AL
BAL	L_load_intro_screen86
L_load_intro_screen85:
;cp_intro_screen_ctl.h,185 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,187 :: 		}
L_load_intro_screen86:
;cp_intro_screen_ctl.h,194 :: 		}
L_load_intro_screen84:
;cp_intro_screen_ctl.h,195 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen81
L__load_intro_screen369:
;cp_intro_screen_ctl.h,175 :: 		else if (scroll_dir == 4) {
MOV	R4, R1
;cp_intro_screen_ctl.h,195 :: 		}
L_load_intro_screen81:
; y_axis start address is: 16 (R4)
; y_axis end address is: 16 (R4)
L_load_intro_screen80:
; y_axis start address is: 16 (R4)
; y_axis end address is: 16 (R4)
L_load_intro_screen73:
; y_axis start address is: 16 (R4)
MOV	R1, R4
; y_axis end address is: 16 (R4)
L_load_intro_screen66:
;cp_intro_screen_ctl.h,197 :: 		counter++;
; y_axis start address is: 4 (R1)
LDR	R0, [SP, #16]
ADDS	R0, R0, #1
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,198 :: 		if (counter == 5) {
CMP	R0, #5
IT	NE
BNE	L_load_intro_screen87
;cp_intro_screen_ctl.h,199 :: 		rotation = ~rotation; // change direction
LDRB	R0, [SP, #8]
MVN	R0, R0
STRB	R0, [SP, #8]
;cp_intro_screen_ctl.h,200 :: 		counter = 0;
MOVS	R0, #0
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,201 :: 		}
L_load_intro_screen87:
;cp_intro_screen_ctl.h,203 :: 		draw_intro_screen(x_axis, y_axis);
STR	R1, [SP, #4]
LDR	R0, [SP, #12]
BL	_draw_intro_screen+0
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,205 :: 		}
; y_axis end address is: 4 (R1)
IT	AL
BAL	L_load_intro_screen58
L_load_intro_screen59:
;cp_intro_screen_ctl.h,206 :: 		}
L_end_load_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _load_intro_screen
_draw_info_text:
;cp_intro_screen_ctl.h,210 :: 		void draw_info_text(uint32_t x_axis, uint32_t y_axis) {
; y_axis start address is: 4 (R1)
; x_axis start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R5, R0
MOV	R6, R1
; y_axis end address is: 4 (R1)
; x_axis end address is: 0 (R0)
; x_axis start address is: 20 (R5)
; y_axis start address is: 24 (R6)
;cp_intro_screen_ctl.h,211 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,212 :: 		TFT_Write_Text(&intro_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_intro_msg+0)
MOVT	R0, #hi_addr(_intro_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,213 :: 		}
L_end_draw_info_text:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_info_text
_draw_rectangle:
;cp_intro_screen_ctl.h,215 :: 		void draw_rectangle(uint32_t x_axis, uint32_t y_axis) {
; y_axis start address is: 4 (R1)
; x_axis start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R7, R0
MOV	R8, R1
; y_axis end address is: 4 (R1)
; x_axis end address is: 0 (R0)
; x_axis start address is: 28 (R7)
; y_axis start address is: 32 (R8)
;cp_intro_screen_ctl.h,217 :: 		TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
MOVS	R3, #0
MOVS	R2, #0
PUSH	(R3)
PUSH	(R2)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_intro_screen_ctl.h,218 :: 		TFT_Rectangle(x_axis, y_axis, x_axis+255, y_axis+17);   // 15 is miny to hide text
ADD	R3, R8, #17
ADDW	R2, R7, #255
SXTH	R3, R3
SXTH	R2, R2
SXTH	R1, R8
; y_axis end address is: 32 (R8)
SXTH	R0, R7
; x_axis end address is: 28 (R7)
BL	_TFT_Rectangle+0
;cp_intro_screen_ctl.h,221 :: 		}
L_end_draw_rectangle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_rectangle
_draw_intro_screen:
;cp_intro_screen_ctl.h,225 :: 		void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
; y_axis start address is: 4 (R1)
; x_axis start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R5, R0
MOV	R6, R1
; y_axis end address is: 4 (R1)
; x_axis end address is: 0 (R0)
; x_axis start address is: 20 (R5)
; y_axis start address is: 24 (R6)
;cp_intro_screen_ctl.h,230 :: 		TFT_Set_Font(TFT_defaultFont, CL_YELLOW, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65504
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,233 :: 		TFT_Write_Text(&pub_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_pub_msg+0)
MOVT	R0, #hi_addr(_pub_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,237 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_draw_intro_screen88:
SUBS	R7, R7, #1
BNE	L_draw_intro_screen88
NOP
NOP
NOP
;cp_intro_screen_ctl.h,239 :: 		}
L_end_draw_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_intro_screen
_load_duck_screen:
;cp_intro_screen_ctl.h,245 :: 		void load_duck_screen() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,246 :: 		uint32_t x_axis = 0;
;cp_intro_screen_ctl.h,247 :: 		uint32_t y_axis = 0;
;cp_intro_screen_ctl.h,248 :: 		uint32_t PX_BLOCK = 16;
MOV	R0, #16
STR	R0, [SP, #4]
;cp_intro_screen_ctl.h,249 :: 		uint32_t i=0;
;cp_intro_screen_ctl.h,251 :: 		uint32_t value = 0;
;cp_intro_screen_ctl.h,253 :: 		intro_game_phase = PHASE_LOGO;
MOVS	R1, #15
MOVW	R0, #lo_addr(_intro_game_phase+0)
MOVT	R0, #hi_addr(_intro_game_phase+0)
STRB	R1, [R0, #0]
;cp_intro_screen_ctl.h,255 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_intro_screen_ctl.h,259 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_intro_screen_ctl.h,263 :: 		TFT_Fill_Screen(CL_NAVY);
MOVW	R0, #16
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,265 :: 		TFT_SET_PEN(m_BLACK, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_TFT_Set_Pen+0
;cp_intro_screen_ctl.h,266 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #4095
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_intro_screen_ctl.h,271 :: 		duck_sprite();
BL	_duck_sprite+0
;cp_intro_screen_ctl.h,272 :: 		set_sprite_offset(0, 6);
MOVS	R1, #6
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_intro_screen_ctl.h,273 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,274 :: 		TFT_Write_Text("A PUDDLE ProDUCKtions ", 6*PX_BLOCK, 13*PX_BLOCK);
LDR	R1, [SP, #4]
MOVS	R0, #13
MUL	R2, R0, R1
LDR	R1, [SP, #4]
MOVS	R0, #6
MULS	R1, R0, R1
MOVW	R0, #lo_addr(?lstr1_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr1_P7_final_project_main+0)
UXTH	R2, R2
UXTH	R1, R1
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,294 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_duck_screen90:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_duck_screen91
IT	AL
BAL	L_load_duck_screen90
L_load_duck_screen91:
;cp_intro_screen_ctl.h,297 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_intro_screen_ctl.h,299 :: 		}
L_end_load_duck_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _load_duck_screen
_duck_sprite:
;cp_intro_screen_ctl.h,305 :: 		void duck_sprite() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,313 :: 		int32_t xfs = 3;
ADD	R11, SP, #4
ADD	R10, R11, #8
MOVW	R12, #lo_addr(?ICSduck_sprite_xfs_L0+0)
MOVT	R12, #hi_addr(?ICSduck_sprite_xfs_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,314 :: 		int32_t yfs = 2;
;cp_intro_screen_ctl.h,317 :: 		draw_cell_xy(8 + xfs,0 + yfs, m_YELLOW);
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
LDR	R1, [SP, #8]
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,318 :: 		draw_cell_xy(9 + xfs,0 + yfs, m_YELLOW);
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #1
LDR	R1, [SP, #8]
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,319 :: 		draw_cell_xy(10 + xfs,0 + yfs, m_YELLOW);
LDR	R0, [SP, #4]
ADDS	R0, #10
MOVS	R2, #1
LDR	R1, [SP, #8]
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,322 :: 		draw_cell_xy(2 + xfs, 2+yfs, m_YELLOW); //face
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, R0, #2
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,323 :: 		draw_cell_xy(3 + xfs, 2+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, R0, #3
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,324 :: 		draw_cell_xy(7 + xfs, 2+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, R0, #7
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,325 :: 		draw_cell_xy(8 + xfs, 2+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,330 :: 		draw_cell_xy(7 + xfs,1+yfs, m_BLACK); // Sunglasses
LDR	R0, [SP, #8]
ADDS	R1, R0, #1
LDR	R0, [SP, #4]
ADDS	R0, R0, #7
MOVS	R2, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,331 :: 		draw_cell_xy(8 + xfs,1+yfs, m_BLACK);
LDR	R0, [SP, #8]
ADDS	R1, R0, #1
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,332 :: 		draw_cell_xy(9 + xfs,1+yfs, m_BLACK);
LDR	R0, [SP, #8]
ADDS	R1, R0, #1
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,333 :: 		draw_cell_xy(10 + xfs, 1+yfs, m_BLACK);
LDR	R0, [SP, #8]
ADDS	R1, R0, #1
LDR	R0, [SP, #4]
ADDS	R0, #10
MOVS	R2, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,334 :: 		draw_cell_xy(11 + xfs, 1+yfs, m_BLACK);
LDR	R0, [SP, #8]
ADDS	R1, R0, #1
LDR	R0, [SP, #4]
ADDS	R0, #11
MOVS	R2, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,335 :: 		draw_cell_xy(9 + xfs,2+yfs, m_BLACK);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,336 :: 		draw_cell_xy(10+xfs,2+yfs, m_BLACK);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, #10
MOVS	R2, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,341 :: 		draw_cell_xy(11+xfs,2+yfs, m_RED);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, #11
MOVS	R2, #2
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,342 :: 		draw_cell_xy(12+xfs,2+yfs, m_RED);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, #12
MOVS	R2, #2
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,343 :: 		draw_cell_xy(13+xfs,2+yfs, m_RED);
LDR	R0, [SP, #8]
ADDS	R1, R0, #2
LDR	R0, [SP, #4]
ADDS	R0, #13
MOVS	R2, #2
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,344 :: 		draw_cell_xy(11+xfs,3+yfs, m_RED);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, #11
MOVS	R2, #2
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,345 :: 		draw_cell_xy(12+xfs,3+yfs, m_RED);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, #12
MOVS	R2, #2
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,348 :: 		draw_cell_xy(1+xfs,3+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,349 :: 		draw_cell_xy(2+xfs,3+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, R0, #2
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,350 :: 		draw_cell_xy(3+xfs,3+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, R0, #3
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,351 :: 		draw_cell_xy(4+xfs,3+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,352 :: 		draw_cell_xy(8+xfs,3+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,353 :: 		draw_cell_xy(9+xfs,3+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,354 :: 		draw_cell_xy(10+xfs,3+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #3
LDR	R0, [SP, #4]
ADDS	R0, #10
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,355 :: 		draw_cell_xy(0+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R0, R0, #4
MOVS	R2, #1
SXTH	R1, R0
LDR	R0, [SP, #4]
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,356 :: 		draw_cell_xy(1+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,357 :: 		draw_cell_xy(2+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #2
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,358 :: 		draw_cell_xy(3+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #3
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,359 :: 		draw_cell_xy(4+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,360 :: 		draw_cell_xy(5+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #5
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,361 :: 		draw_cell_xy(6+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #6
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,362 :: 		draw_cell_xy(7+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, R0, #7
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,363 :: 		draw_cell_xy(8+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,364 :: 		draw_cell_xy(9+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,365 :: 		draw_cell_xy(10+xfs,4+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #4
LDR	R0, [SP, #4]
ADDS	R0, #10
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,366 :: 		draw_cell_xy(1+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,367 :: 		draw_cell_xy(2+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, R0, #2
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,368 :: 		draw_cell_xy(3+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, R0, #3
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,369 :: 		draw_cell_xy(4+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,370 :: 		draw_cell_xy(5+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, R0, #5
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,371 :: 		draw_cell_xy(6+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, R0, #6
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,372 :: 		draw_cell_xy(7+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, R0, #7
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,373 :: 		draw_cell_xy(8+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,374 :: 		draw_cell_xy(9+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,375 :: 		draw_cell_xy(10+xfs,5+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #5
LDR	R0, [SP, #4]
ADDS	R0, #10
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,376 :: 		draw_cell_xy(2+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, R0, #2
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,377 :: 		draw_cell_xy(3+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, R0, #3
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,378 :: 		draw_cell_xy(4+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,379 :: 		draw_cell_xy(5+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, R0, #5
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,380 :: 		draw_cell_xy(6+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, R0, #6
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,381 :: 		draw_cell_xy(7+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, R0, #7
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,382 :: 		draw_cell_xy(8+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,383 :: 		draw_cell_xy(9+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,384 :: 		draw_cell_xy(10+xfs,6+yfs, m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #6
LDR	R0, [SP, #4]
ADDS	R0, #10
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,385 :: 		draw_cell_xy(3+xfs,7+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #7
LDR	R0, [SP, #4]
ADDS	R0, R0, #3
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,386 :: 		draw_cell_xy(4+xfs,7+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #7
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,387 :: 		draw_cell_xy(5+xfs,7+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #7
LDR	R0, [SP, #4]
ADDS	R0, R0, #5
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,388 :: 		draw_cell_xy(6+xfs,7+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #7
LDR	R0, [SP, #4]
ADDS	R0, R0, #6
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,389 :: 		draw_cell_xy(7+xfs,7+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #7
LDR	R0, [SP, #4]
ADDS	R0, R0, #7
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,390 :: 		draw_cell_xy(8+xfs,7+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #7
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,391 :: 		draw_cell_xy(9+xfs,7+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDS	R1, R0, #7
LDR	R0, [SP, #4]
ADDS	R0, #9
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,392 :: 		draw_cell_xy(4+xfs,8+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDW	R1, R0, #8
LDR	R0, [SP, #4]
ADDS	R0, R0, #4
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,393 :: 		draw_cell_xy(5+xfs,8+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDW	R1, R0, #8
LDR	R0, [SP, #4]
ADDS	R0, R0, #5
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,394 :: 		draw_cell_xy(6+xfs,8+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDW	R1, R0, #8
LDR	R0, [SP, #4]
ADDS	R0, R0, #6
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,395 :: 		draw_cell_xy(7+xfs,8+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDW	R1, R0, #8
LDR	R0, [SP, #4]
ADDS	R0, R0, #7
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,396 :: 		draw_cell_xy(8+xfs,8+yfs,m_YELLOW);
LDR	R0, [SP, #8]
ADDW	R1, R0, #8
LDR	R0, [SP, #4]
ADDS	R0, #8
MOVS	R2, #1
SXTH	R1, R1
SXTH	R0, R0
BL	_draw_cell_xy+0
;cp_intro_screen_ctl.h,398 :: 		}
L_end_duck_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _duck_sprite
_scr_debug:
;cp_game_ctl.h,108 :: 		void scr_debug(int32_t value, int32_t value2) {
; value2 start address is: 4 (R1)
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value2 end address is: 4 (R1)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
; value2 start address is: 4 (R1)
;cp_game_ctl.h,109 :: 		g_debug = value;
MOVW	R2, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_debug+0)
STR	R0, [R2, #0]
; value end address is: 0 (R0)
;cp_game_ctl.h,110 :: 		g_debug2 = value2;
MOVW	R2, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_debug2+0)
STR	R1, [R2, #0]
; value2 end address is: 4 (R1)
;cp_game_ctl.h,111 :: 		}
L_end_scr_debug:
ADD	SP, SP, #4
BX	LR
; end of _scr_debug
_reset_game_values:
;cp_game_ctl.h,117 :: 		void reset_game_values () {
SUB	SP, SP, #4
;cp_game_ctl.h,118 :: 		i =0;    // Generic counters
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,119 :: 		j =0;    // Generic counters
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_j+0)
MOVT	R0, #hi_addr(P7_final_project_main_j+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,120 :: 		g_session_count      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,121 :: 		g_game_score         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,122 :: 		g_debug              = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,123 :: 		g_debug2             = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug2+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,124 :: 		g_rand_num           = 999;
MOVW	R1, #999
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,125 :: 		g_food_in_play       = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_food_in_play+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,126 :: 		g_fd_x_val           = NEG_NULL;
MOV	R1, #-1
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_x_val+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,127 :: 		g_fd_y_val           = NEG_NULL;
MOV	R1, #-1
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_y_val+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,128 :: 		init_cur    = init_cursor_start;
MOVS	R1, #65
MOVW	R0, #lo_addr(_init_cur+0)
MOVT	R0, #hi_addr(_init_cur+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,129 :: 		init_cur_pos         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R0, #hi_addr(P7_final_project_main_init_cur_pos+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,131 :: 		hs_cursor_x          = HS_CURSOR_START_X;
MOV	R1, #16
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_x+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,132 :: 		hs_cursor_y          = HS_CURSOR_START_Y;
MOV	R1, #4
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_y+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,134 :: 		user_score_entry[3] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+3)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+3)
STRB	R1, [R0, #0]
;cp_game_ctl.h,135 :: 		user_score_entry[4] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+4)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+4)
STRB	R1, [R0, #0]
;cp_game_ctl.h,136 :: 		user_score_entry[5] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+5)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+5)
STRB	R1, [R0, #0]
;cp_game_ctl.h,137 :: 		user_score_entry[6] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+6)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+6)
STRB	R1, [R0, #0]
;cp_game_ctl.h,139 :: 		}
L_end_reset_game_values:
ADD	SP, SP, #4
BX	LR
; end of _reset_game_values
_update_game_speed:
;cp_game_ctl.h,143 :: 		void update_game_speed(uint32_t gspeed) {
; gspeed start address is: 0 (R0)
SUB	SP, SP, #4
; gspeed end address is: 0 (R0)
; gspeed start address is: 0 (R0)
;cp_game_ctl.h,144 :: 		game_speed = gspeed;
MOVW	R1, #lo_addr(_game_speed+0)
MOVT	R1, #hi_addr(_game_speed+0)
STR	R0, [R1, #0]
; gspeed end address is: 0 (R0)
;cp_game_ctl.h,145 :: 		}
L_end_update_game_speed:
ADD	SP, SP, #4
BX	LR
; end of _update_game_speed
_set_curr_snake_dir:
;cp_game_ctl.h,149 :: 		void set_curr_snake_dir(uint8_t new_dir) {
; new_dir start address is: 0 (R0)
SUB	SP, SP, #4
; new_dir end address is: 0 (R0)
; new_dir start address is: 0 (R0)
;cp_game_ctl.h,150 :: 		g_curr_snake_dir = new_dir;
MOVW	R1, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
STRB	R0, [R1, #0]
; new_dir end address is: 0 (R0)
;cp_game_ctl.h,151 :: 		}
L_end_set_curr_snake_dir:
ADD	SP, SP, #4
BX	LR
; end of _set_curr_snake_dir
_toggle_game_clock_delay:
;cp_game_ctl.h,155 :: 		void toggle_game_clock_delay() {
SUB	SP, SP, #4
;cp_game_ctl.h,156 :: 		g_game_clock_delay_tim3 = ~g_game_clock_delay_tim3;
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
LDRB	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,157 :: 		}
L_end_toggle_game_clock_delay:
ADD	SP, SP, #4
BX	LR
; end of _toggle_game_clock_delay
_update_game_time:
;cp_game_ctl.h,161 :: 		void update_game_time () {
SUB	SP, SP, #4
;cp_game_ctl.h,162 :: 		g_time_count++;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,164 :: 		}
L_end_update_game_time:
ADD	SP, SP, #4
BX	LR
; end of _update_game_time
_set_secret_mode:
;cp_game_ctl.h,166 :: 		void set_secret_mode() {
SUB	SP, SP, #4
;cp_game_ctl.h,167 :: 		g_GAME_MODE = DEV_MODE;
MOVS	R1, #3
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,168 :: 		}
L_end_set_secret_mode:
ADD	SP, SP, #4
BX	LR
; end of _set_secret_mode
_update_session_time:
;cp_game_ctl.h,170 :: 		void update_session_time() {
SUB	SP, SP, #4
;cp_game_ctl.h,171 :: 		g_session_count++;
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,172 :: 		}
L_end_update_session_time:
ADD	SP, SP, #4
BX	LR
; end of _update_session_time
_get_game_phase:
;cp_game_ctl.h,176 :: 		uint8_t get_game_phase() {
SUB	SP, SP, #4
;cp_game_ctl.h,177 :: 		return g_GAME_PHASE;
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
;cp_game_ctl.h,178 :: 		}
L_end_get_game_phase:
ADD	SP, SP, #4
BX	LR
; end of _get_game_phase
_get_initial_cur_pos:
;cp_game_ctl.h,181 :: 		int32_t get_initial_cur_pos () {
SUB	SP, SP, #4
;cp_game_ctl.h,182 :: 		return init_cur_pos;
MOVW	R0, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R0, #hi_addr(P7_final_project_main_init_cur_pos+0)
LDR	R0, [R0, #0]
;cp_game_ctl.h,183 :: 		}
L_end_get_initial_cur_pos:
ADD	SP, SP, #4
BX	LR
; end of _get_initial_cur_pos
_set_food_in_play_flag:
;cp_game_ctl.h,187 :: 		void set_food_in_play_flag (uint8_t state) {
; state start address is: 0 (R0)
SUB	SP, SP, #4
; state end address is: 0 (R0)
; state start address is: 0 (R0)
;cp_game_ctl.h,188 :: 		g_food_in_play = state;
MOVW	R1, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_food_in_play+0)
STRB	R0, [R1, #0]
; state end address is: 0 (R0)
;cp_game_ctl.h,189 :: 		}
L_end_set_food_in_play_flag:
ADD	SP, SP, #4
BX	LR
; end of _set_food_in_play_flag
_set_food_xy:
;cp_game_ctl.h,193 :: 		void set_food_xy(int32_t *x_val, int32_t *y_val) {
; y_val start address is: 4 (R1)
; x_val start address is: 0 (R0)
SUB	SP, SP, #4
; y_val end address is: 4 (R1)
; x_val end address is: 0 (R0)
; x_val start address is: 0 (R0)
; y_val start address is: 4 (R1)
;cp_game_ctl.h,194 :: 		g_fd_x_val = *x_val;
LDR	R3, [R0, #0]
; x_val end address is: 0 (R0)
MOVW	R2, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_fd_x_val+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,195 :: 		g_fd_y_val = *y_val;
LDR	R3, [R1, #0]
; y_val end address is: 4 (R1)
MOVW	R2, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_fd_y_val+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,196 :: 		}
L_end_set_food_xy:
ADD	SP, SP, #4
BX	LR
; end of _set_food_xy
_play_sound1:
;cp_game_ctl.h,200 :: 		void play_sound1( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,202 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sound192:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sound193
;cp_game_ctl.h,203 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,204 :: 		Delay_ms(SFX_FOOD_HIGH);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_play_sound195:
SUBS	R7, R7, #1
BNE	L_play_sound195
NOP
NOP
NOP
;cp_game_ctl.h,202 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,205 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sound192
L_play_sound193:
;cp_game_ctl.h,206 :: 		}
L_end_play_sound1:
ADD	SP, SP, #4
BX	LR
; end of _play_sound1
_play_sound2:
;cp_game_ctl.h,210 :: 		void play_sound2( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,212 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sound297:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sound298
;cp_game_ctl.h,213 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,214 :: 		Delay_ms(SFX_FOOD);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_play_sound2100:
SUBS	R7, R7, #1
BNE	L_play_sound2100
NOP
NOP
NOP
;cp_game_ctl.h,212 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,215 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sound297
L_play_sound298:
;cp_game_ctl.h,216 :: 		}
L_end_play_sound2:
ADD	SP, SP, #4
BX	LR
; end of _play_sound2
_play_sound3:
;cp_game_ctl.h,220 :: 		void play_sound3( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,222 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sound3102:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sound3103
;cp_game_ctl.h,223 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,224 :: 		Delay_ms(SFX_WALL);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_play_sound3105:
SUBS	R7, R7, #1
BNE	L_play_sound3105
NOP
NOP
NOP
;cp_game_ctl.h,222 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,225 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sound3102
L_play_sound3103:
;cp_game_ctl.h,226 :: 		}
L_end_play_sound3:
ADD	SP, SP, #4
BX	LR
; end of _play_sound3
_play_sfx_wall:
;cp_game_ctl.h,230 :: 		void play_sfx_wall( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,232 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_wall107:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_wall108
;cp_game_ctl.h,233 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,234 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_play_sfx_wall110:
SUBS	R7, R7, #1
BNE	L_play_sfx_wall110
NOP
NOP
NOP
;cp_game_ctl.h,232 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,235 :: 		}
IT	AL
BAL	L_play_sfx_wall107
L_play_sfx_wall108:
;cp_game_ctl.h,237 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_wall112:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_wall113
;cp_game_ctl.h,238 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,239 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_play_sfx_wall115:
SUBS	R7, R7, #1
BNE	L_play_sfx_wall115
NOP
NOP
NOP
;cp_game_ctl.h,237 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,240 :: 		}
IT	AL
BAL	L_play_sfx_wall112
L_play_sfx_wall113:
;cp_game_ctl.h,242 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_wall117:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_wall118
;cp_game_ctl.h,243 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,244 :: 		Delay_ms(15);
MOVW	R7, #48927
MOVT	R7, #2
NOP
NOP
L_play_sfx_wall120:
SUBS	R7, R7, #1
BNE	L_play_sfx_wall120
NOP
NOP
NOP
;cp_game_ctl.h,242 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,245 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sfx_wall117
L_play_sfx_wall118:
;cp_game_ctl.h,246 :: 		}
L_end_play_sfx_wall:
ADD	SP, SP, #4
BX	LR
; end of _play_sfx_wall
_play_sfx_food:
;cp_game_ctl.h,251 :: 		void play_sfx_food( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,253 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_food122:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_food123
;cp_game_ctl.h,254 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,255 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_play_sfx_food125:
SUBS	R7, R7, #1
BNE	L_play_sfx_food125
NOP
NOP
NOP
;cp_game_ctl.h,253 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,256 :: 		}
IT	AL
BAL	L_play_sfx_food122
L_play_sfx_food123:
;cp_game_ctl.h,258 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_food127:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_food128
;cp_game_ctl.h,259 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,260 :: 		Delay_ms(3);
MOVW	R7, #35999
MOVT	R7, #0
NOP
NOP
L_play_sfx_food130:
SUBS	R7, R7, #1
BNE	L_play_sfx_food130
NOP
NOP
NOP
;cp_game_ctl.h,258 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,261 :: 		}
IT	AL
BAL	L_play_sfx_food127
L_play_sfx_food128:
;cp_game_ctl.h,263 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_food132:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_food133
;cp_game_ctl.h,264 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,265 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_play_sfx_food135:
SUBS	R7, R7, #1
BNE	L_play_sfx_food135
NOP
NOP
NOP
;cp_game_ctl.h,263 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,266 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sfx_food132
L_play_sfx_food133:
;cp_game_ctl.h,267 :: 		}
L_end_play_sfx_food:
ADD	SP, SP, #4
BX	LR
; end of _play_sfx_food
_game_over:
;cp_game_ctl.h,272 :: 		void game_over() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,276 :: 		TIM3_CR1 = 0; // Kill TIMER3 now
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,277 :: 		play_sfx_wall(20);
MOVS	R0, #20
BL	_play_sfx_wall+0
;cp_game_ctl.h,278 :: 		g_GAME_PHASE = PHASE_QUIT;
MOVS	R1, #3
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,279 :: 		game_cur_screen_run_flag = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,280 :: 		}
L_end_game_over:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _game_over
_move_snake:
;cp_game_ctl.h,290 :: 		void move_snake() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,292 :: 		int16_t temp_x = m_node_head->node_x;
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
LDRSH	R0, [R0, #0]
; temp_x start address is: 12 (R3)
SXTH	R3, R0
;cp_game_ctl.h,293 :: 		int16_t temp_y = m_node_head->node_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
; temp_y start address is: 16 (R4)
SXTH	R4, R0
;cp_game_ctl.h,295 :: 		if (g_curr_snake_dir == MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake137
;cp_game_ctl.h,297 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake138
;cp_game_ctl.h,298 :: 		m_node_start->node_x = ++temp_x;
ADDS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,299 :: 		m_node_start->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,301 :: 		m_node_head = m_node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,302 :: 		} else {
IT	AL
BAL	L_move_snake139
L_move_snake138:
;cp_game_ctl.h,304 :: 		(m_node_head+1)->node_x = ++temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
ADDS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,305 :: 		(m_node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,306 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,307 :: 		}
L_move_snake139:
;cp_game_ctl.h,313 :: 		if (m_node_head->node_x > MAX_COL_WIDTH-1 ) { //0-indexed array
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #19
IT	LE
BLE	L_move_snake140
;cp_game_ctl.h,315 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake141
;cp_game_ctl.h,316 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,318 :: 		} else {
IT	AL
BAL	L_move_snake142
L_move_snake141:
;cp_game_ctl.h,319 :: 		m_node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,320 :: 		}
L_move_snake142:
;cp_game_ctl.h,321 :: 		}
L_move_snake140:
;cp_game_ctl.h,322 :: 		}
IT	AL
BAL	L_move_snake143
L_move_snake137:
;cp_game_ctl.h,323 :: 		else if (g_curr_snake_dir == MOVE_LEFT)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_move_snake144
;cp_game_ctl.h,325 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake145
;cp_game_ctl.h,326 :: 		(m_node_start)->node_x = --temp_x;
SUBS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,327 :: 		(m_node_start)->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,329 :: 		m_node_head = m_node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,330 :: 		} else {
IT	AL
BAL	L_move_snake146
L_move_snake145:
;cp_game_ctl.h,332 :: 		(m_node_head+1)->node_x = --temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
SUBS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,333 :: 		(m_node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,335 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,336 :: 		}
L_move_snake146:
;cp_game_ctl.h,339 :: 		if (m_node_head->node_x < 0) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_move_snake147
;cp_game_ctl.h,340 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake148
;cp_game_ctl.h,341 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,343 :: 		} else {
IT	AL
BAL	L_move_snake149
L_move_snake148:
;cp_game_ctl.h,344 :: 		m_node_head->node_x = 19;
MOVS	R1, #19
SXTH	R1, R1
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,345 :: 		}
L_move_snake149:
;cp_game_ctl.h,346 :: 		}
L_move_snake147:
;cp_game_ctl.h,348 :: 		}
IT	AL
BAL	L_move_snake150
L_move_snake144:
;cp_game_ctl.h,349 :: 		else if (g_curr_snake_dir == MOVE_UP)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_move_snake151
;cp_game_ctl.h,351 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake152
;cp_game_ctl.h,352 :: 		(m_node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_m_node_start+0)
MOVT	R2, #hi_addr(_m_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,353 :: 		(m_node_start)->node_y = --temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,354 :: 		m_node_head = m_node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,355 :: 		} else {
IT	AL
BAL	L_move_snake153
L_move_snake152:
;cp_game_ctl.h,357 :: 		(m_node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,358 :: 		(m_node_head+1)->node_y = --temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,360 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,361 :: 		}
L_move_snake153:
;cp_game_ctl.h,364 :: 		if (m_node_head->node_y < 1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	GE
BGE	L_move_snake154
;cp_game_ctl.h,365 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake155
;cp_game_ctl.h,366 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,368 :: 		} else {
IT	AL
BAL	L_move_snake156
L_move_snake155:
;cp_game_ctl.h,369 :: 		m_node_head->node_y = (MAX_ROW_LENGTH-1);
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVW	R0, #14
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,370 :: 		}
L_move_snake156:
;cp_game_ctl.h,371 :: 		}
L_move_snake154:
;cp_game_ctl.h,372 :: 		}
IT	AL
BAL	L_move_snake157
L_move_snake151:
;cp_game_ctl.h,373 :: 		else if (g_curr_snake_dir == MOVE_DOWN)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_move_snake158
;cp_game_ctl.h,374 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake159
;cp_game_ctl.h,375 :: 		(m_node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_m_node_start+0)
MOVT	R2, #hi_addr(_m_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,376 :: 		(m_node_start)->node_y = ++temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,377 :: 		m_node_head = m_node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,378 :: 		} else {
IT	AL
BAL	L_move_snake160
L_move_snake159:
;cp_game_ctl.h,380 :: 		(m_node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,381 :: 		(m_node_head+1)->node_y = ++temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,384 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,385 :: 		}
L_move_snake160:
;cp_game_ctl.h,388 :: 		if (m_node_head->node_y > MAX_ROW_LENGTH-1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #14
IT	LE
BLE	L_move_snake161
;cp_game_ctl.h,389 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake162
;cp_game_ctl.h,390 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,392 :: 		} else {
IT	AL
BAL	L_move_snake163
L_move_snake162:
;cp_game_ctl.h,393 :: 		m_node_head->node_y = 1;
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,394 :: 		}
L_move_snake163:
;cp_game_ctl.h,395 :: 		}
L_move_snake161:
;cp_game_ctl.h,397 :: 		}
L_move_snake158:
L_move_snake157:
L_move_snake150:
L_move_snake143:
;cp_game_ctl.h,399 :: 		}
L_end_move_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _move_snake
_check_snake_collision:
;cp_game_ctl.h,403 :: 		int32_t check_snake_collision(int16_t x_val, int16_t y_val, t_node * start_pos) {
; start_pos start address is: 8 (R2)
; y_val start address is: 4 (R1)
; x_val start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; start_pos end address is: 8 (R2)
; y_val end address is: 4 (R1)
; x_val end address is: 0 (R0)
; x_val start address is: 0 (R0)
; y_val start address is: 4 (R1)
; start_pos start address is: 8 (R2)
;cp_game_ctl.h,405 :: 		t_node *temp_itr = start_pos;
; temp_itr start address is: 16 (R4)
MOV	R4, R2
;cp_game_ctl.h,407 :: 		if (start_pos > m_node_end) {
MOVW	R3, #lo_addr(_m_node_end+0)
MOVT	R3, #hi_addr(_m_node_end+0)
LDR	R3, [R3, #0]
CMP	R2, R3
IT	LS
BLS	L_check_snake_collision164
; start_pos end address is: 8 (R2)
;cp_game_ctl.h,409 :: 		}
L_check_snake_collision164:
;cp_game_ctl.h,411 :: 		do {
SXTH	R6, R0
; y_val end address is: 4 (R1)
; temp_itr end address is: 16 (R4)
SXTH	R5, R1
MOV	R7, R4
IT	AL
BAL	L_check_snake_collision165
; x_val end address is: 0 (R0)
L__check_snake_collision373:
;cp_game_ctl.h,421 :: 		} while (temp_itr <= m_node_head);
;cp_game_ctl.h,411 :: 		do {
L_check_snake_collision165:
;cp_game_ctl.h,412 :: 		scr_debug(temp_itr->node_x, temp_itr->node_y );
; temp_itr start address is: 28 (R7)
; y_val start address is: 20 (R5)
; y_val start address is: 20 (R5)
; y_val end address is: 20 (R5)
; x_val start address is: 24 (R6)
ADDS	R3, R7, #2
LDRSH	R3, [R3, #0]
SXTH	R4, R3
LDRSH	R3, [R7, #0]
MOV	R1, R4
MOV	R0, R3
BL	_scr_debug+0
;cp_game_ctl.h,415 :: 		if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {
LDRSH	R3, [R7, #0]
CMP	R3, R6
IT	NE
BNE	L__check_snake_collision372
; y_val end address is: 20 (R5)
; y_val start address is: 20 (R5)
ADDS	R3, R7, #2
LDRSH	R3, [R3, #0]
CMP	R3, R5
IT	NE
BNE	L__check_snake_collision371
; y_val end address is: 20 (R5)
; x_val end address is: 24 (R6)
; temp_itr end address is: 28 (R7)
L__check_snake_collision370:
;cp_game_ctl.h,417 :: 		return TRUE; // Collision found
MOVS	R0, #1
IT	AL
BAL	L_end_check_snake_collision
;cp_game_ctl.h,415 :: 		if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {
L__check_snake_collision372:
; temp_itr start address is: 28 (R7)
; x_val start address is: 24 (R6)
; y_val start address is: 20 (R5)
L__check_snake_collision371:
;cp_game_ctl.h,420 :: 		temp_itr = incr_node(temp_itr);
MOV	R0, R7
; temp_itr end address is: 28 (R7)
BL	_incr_node+0
; temp_itr start address is: 28 (R7)
MOV	R7, R0
;cp_game_ctl.h,421 :: 		} while (temp_itr <= m_node_head);
MOVW	R3, #lo_addr(_m_node_head+0)
MOVT	R3, #hi_addr(_m_node_head+0)
LDR	R3, [R3, #0]
CMP	R0, R3
IT	LS
BLS	L__check_snake_collision373
; y_val end address is: 20 (R5)
; x_val end address is: 24 (R6)
; temp_itr end address is: 28 (R7)
;cp_game_ctl.h,423 :: 		return FALSE;
MOVS	R0, #0
;cp_game_ctl.h,424 :: 		}
L_end_check_snake_collision:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_snake_collision
_generate_food:
;cp_game_ctl.h,428 :: 		void generate_food() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_game_ctl.h,432 :: 		int16_t col_ret = TRUE;
;cp_game_ctl.h,435 :: 		int32_t temp_time = TIM3_CNT %33;
MOVW	R0, #lo_addr(TIM3_CNT+0)
MOVT	R0, #hi_addr(TIM3_CNT+0)
LDR	R2, [R0, #0]
MOVS	R1, #33
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
STR	R0, [SP, #12]
;cp_game_ctl.h,439 :: 		do  {
L_generate_food171:
;cp_game_ctl.h,441 :: 		for (i=0; i <= temp_time; i++) {
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
STR	R1, [R0, #0]
L_generate_food174:
LDR	R1, [SP, #12]
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	GT
BGT	L_generate_food175
;cp_game_ctl.h,443 :: 		g_rand_num = (int32_t)  (rand() % MAX_BLOCK_COUNT);// + MAX_COL_WIDTH because row 0 is reserved for info
BL	_rand+0
MOV	R2, #300
SDIV	R1, R0, R2
MLS	R1, R2, R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,441 :: 		for (i=0; i <= temp_time; i++) {
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,444 :: 		}
IT	AL
BAL	L_generate_food174
L_generate_food175:
;cp_game_ctl.h,448 :: 		convert_lin_xy(&g_rand_num, &fd_x_val, &fd_y_val);
ADD	R1, SP, #8
ADD	R0, SP, #4
MOV	R2, R1
MOV	R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
BL	_convert_lin_xy+0
;cp_game_ctl.h,453 :: 		col_ret = check_snake_collision(&fd_x_val, &fd_y_val, m_node_tail);
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R2, [R0, #0]
ADD	R1, SP, #8
ADD	R0, SP, #4
SXTH	R1, R1
SXTH	R0, R0
BL	_check_snake_collision+0
STRH	R0, [SP, #16]
;cp_game_ctl.h,457 :: 		if (col_ret == FALSE) {
SXTH	R0, R0
CMP	R0, #0
IT	NE
BNE	L_generate_food177
;cp_game_ctl.h,459 :: 		draw_cell_pos(&g_rand_num, m_FUCHSIA);
MOVS	R1, #6
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
BL	_draw_cell_pos+0
;cp_game_ctl.h,460 :: 		set_food_in_play_flag(TRUE);
MOVS	R0, #1
BL	_set_food_in_play_flag+0
;cp_game_ctl.h,463 :: 		set_food_xy(&fd_x_val, &fd_y_val);
ADD	R1, SP, #8
ADD	R0, SP, #4
BL	_set_food_xy+0
;cp_game_ctl.h,464 :: 		}
L_generate_food177:
;cp_game_ctl.h,466 :: 		} while (col_ret == TRUE);
LDRSH	R0, [SP, #16]
CMP	R0, #1
IT	EQ
BEQ	L_generate_food171
;cp_game_ctl.h,468 :: 		}
L_end_generate_food:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _generate_food
_incr_snake_head:
;cp_game_ctl.h,473 :: 		void incr_snake_head() {
SUB	SP, SP, #4
;cp_game_ctl.h,475 :: 		if (m_node_head < m_node_end) { // array_size * sizeof(t_node)
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_head178
;cp_game_ctl.h,476 :: 		m_node_head++;
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,477 :: 		} else {
IT	AL
BAL	L_incr_snake_head179
L_incr_snake_head178:
;cp_game_ctl.h,479 :: 		m_node_head = m_node_start; // Wrap around array if end is reached
MOVW	R0, #lo_addr(_m_node_start+0)
MOVT	R0, #hi_addr(_m_node_start+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,480 :: 		}
L_incr_snake_head179:
;cp_game_ctl.h,482 :: 		}
L_end_incr_snake_head:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_head
_incr_node:
;cp_game_ctl.h,486 :: 		t_node* incr_node( t_node *_node) {
; _node start address is: 0 (R0)
SUB	SP, SP, #4
; _node end address is: 0 (R0)
; _node start address is: 0 (R0)
;cp_game_ctl.h,489 :: 		if (_node <= m_node_end) {
MOVW	R1, #lo_addr(_m_node_end+0)
MOVT	R1, #hi_addr(_m_node_end+0)
LDR	R1, [R1, #0]
CMP	R0, R1
IT	HI
BHI	L_incr_node180
;cp_game_ctl.h,490 :: 		_node++;
ADDS	R0, R0, #4
;cp_game_ctl.h,491 :: 		} else {
; _node end address is: 0 (R0)
IT	AL
BAL	L_incr_node181
L_incr_node180:
;cp_game_ctl.h,493 :: 		_node = m_node_start;
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
; _node start address is: 0 (R0)
LDR	R0, [R1, #0]
; _node end address is: 0 (R0)
;cp_game_ctl.h,494 :: 		}
L_incr_node181:
;cp_game_ctl.h,496 :: 		return _node;
; _node start address is: 0 (R0)
; _node end address is: 0 (R0)
;cp_game_ctl.h,497 :: 		}
L_end_incr_node:
ADD	SP, SP, #4
BX	LR
; end of _incr_node
_incr_snake_tail:
;cp_game_ctl.h,502 :: 		void incr_snake_tail() {
SUB	SP, SP, #4
;cp_game_ctl.h,504 :: 		if (m_node_tail != m_node_head) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_incr_snake_tail182
;cp_game_ctl.h,507 :: 		m_node_tail->node_x = 0xFF;
MOVS	R1, #255
SXTH	R1, R1
MOVW	R2, #lo_addr(_m_node_tail+0)
MOVT	R2, #hi_addr(_m_node_tail+0)
LDR	R0, [R2, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,508 :: 		m_node_tail->node_y = 0xFF;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #255
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,511 :: 		if (m_node_tail < m_node_end) {
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R1, [R0, #0]
MOV	R0, R2
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_tail183
;cp_game_ctl.h,512 :: 		m_node_tail++;
MOVW	R1, #lo_addr(_m_node_tail+0)
MOVT	R1, #hi_addr(_m_node_tail+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,513 :: 		} else {
IT	AL
BAL	L_incr_snake_tail184
L_incr_snake_tail183:
;cp_game_ctl.h,515 :: 		m_node_tail = m_node_start;
MOVW	R0, #lo_addr(_m_node_start+0)
MOVT	R0, #hi_addr(_m_node_start+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,516 :: 		}
L_incr_snake_tail184:
;cp_game_ctl.h,517 :: 		}
L_incr_snake_tail182:
;cp_game_ctl.h,519 :: 		}
L_end_incr_snake_tail:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_tail
_load_snake_game:
;cp_game_ctl.h,527 :: 		void load_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,530 :: 		set_game_phase(PHASE1_READY);
MOVS	R0, #1
BL	_set_game_phase+0
;cp_game_ctl.h,536 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,538 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,540 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #4095
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_game_ctl.h,541 :: 		set_brush_color(m_BLACK);
MOVS	R0, #0
BL	_set_brush_color+0
;cp_game_ctl.h,543 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,545 :: 		TFT_Set_Font(TFT_defaultFont, CL_AQUA, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #4095
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,546 :: 		TFT_Write_Text("SNAKE!", 8 * PX_BLOCK, 6 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr2_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr2_P7_final_project_main+0)
MOVW	R2, #96
MOVW	R1, #128
BL	_TFT_Write_Text+0
;cp_game_ctl.h,547 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,548 :: 		TFT_Write_Text("v.1.0", 18* PX_BLOCK, 0 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr3_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr3_P7_final_project_main+0)
MOVW	R2, #0
MOVW	R1, #288
BL	_TFT_Write_Text+0
;cp_game_ctl.h,549 :: 		TFT_Write_Text("By Howard Zhou", 13 * PX_BLOCK, 14 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr4_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr4_P7_final_project_main+0)
MOVW	R2, #224
MOVW	R1, #208
BL	_TFT_Write_Text+0
;cp_game_ctl.h,550 :: 		TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 11*PX_BLOCK);
MOVW	R0, #lo_addr(?lstr5_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr5_P7_final_project_main+0)
MOVW	R2, #176
MOVW	R1, #80
BL	_TFT_Write_Text+0
;cp_game_ctl.h,552 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_snake_game185:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_snake_game186
IT	AL
BAL	L_load_snake_game185
L_load_snake_game186:
;cp_game_ctl.h,554 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,555 :: 		}
L_end_load_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _load_snake_game
_update_stats:
;cp_game_ctl.h,559 :: 		void update_stats() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,560 :: 		sprintf(g_str_buffer, "Score: \x20 %04d", g_game_score);
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_6_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_6_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,561 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,564 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_update_stats187
;cp_game_ctl.h,565 :: 		sprintf(g_str_buffer, "MODE: \x20 NORM" );
MOVW	R1, #lo_addr(?lstr_7_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_7_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,566 :: 		}
IT	AL
BAL	L_update_stats188
L_update_stats187:
;cp_game_ctl.h,568 :: 		sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );       // ****Printout debugger
MOVW	R0, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug2+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_8_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_8_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,569 :: 		}
L_update_stats188:
;cp_game_ctl.h,570 :: 		TFT_Write_Text(&g_str_buffer, 8*PX_BLOCK, 0*PX_BLOCK); // Print mode
MOVW	R2, #0
MOVW	R1, #128
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,571 :: 		sprintf(g_str_buffer, "x: %d", game_speed );
MOVW	R0, #lo_addr(_game_speed+0)
MOVT	R0, #hi_addr(_game_speed+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_9_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_9_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,572 :: 		TFT_Write_Text(&g_str_buffer, 6*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #96
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,573 :: 		}
L_end_update_stats:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_stats
_update_time:
;cp_game_ctl.h,577 :: 		void update_time() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,580 :: 		if (g_TIME_TRACK_MODE == SESSION_TIME) {
MOVW	R0, #lo_addr(P7_final_project_main_g_TIME_TRACK_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_TIME_TRACK_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #31
IT	NE
BNE	L_update_time189
;cp_game_ctl.h,581 :: 		g_t_secs = g_session_count % 60;
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
LDR	R2, [R0, #0]
MOVS	R0, #60
UDIV	R1, R2, R0
MLS	R1, R0, R1, R2
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,583 :: 		if (g_t_secs != 0) {
CMP	R1, #0
IT	EQ
BEQ	L_update_time190
;cp_game_ctl.h,584 :: 		g_t_wait = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,585 :: 		}
L_update_time190:
;cp_game_ctl.h,586 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time377
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time376
L__update_time375:
;cp_game_ctl.h,587 :: 		g_t_mins++;
MOVW	R1, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,588 :: 		g_t_wait = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,586 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
L__update_time377:
L__update_time376:
;cp_game_ctl.h,592 :: 		sprintf(g_str_buffer, "GTIM: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R0, #0]
SUBS	R2, R0, #1
MOVW	R1, #lo_addr(?lstr_10_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_10_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,594 :: 		} else {
IT	AL
BAL	L_update_time194
L_update_time189:
;cp_game_ctl.h,595 :: 		g_t_secs = g_time_count % 60;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R2, [R0, #0]
MOVS	R0, #60
UDIV	R1, R2, R0
MLS	R1, R0, R1, R2
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,597 :: 		if (g_t_secs != 0) {
CMP	R1, #0
IT	EQ
BEQ	L_update_time195
;cp_game_ctl.h,598 :: 		g_t_wait = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,599 :: 		}
L_update_time195:
;cp_game_ctl.h,600 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time379
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time378
L__update_time374:
;cp_game_ctl.h,601 :: 		g_t_mins++;
MOVW	R1, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,602 :: 		g_t_wait = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,600 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
L__update_time379:
L__update_time378:
;cp_game_ctl.h,605 :: 		sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R0, #0]
SUBS	R2, R0, #1
MOVW	R1, #lo_addr(?lstr_11_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_11_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,606 :: 		}
L_update_time194:
;cp_game_ctl.h,609 :: 		TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #240
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,611 :: 		}
L_end_update_time:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_time
_init_snake_game:
;cp_game_ctl.h,615 :: 		void init_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,619 :: 		g_GAME_PHASE = PHASE2_PLAYING;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,622 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,623 :: 		game_cur_screen_run_flag=TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,628 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,631 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #4095
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_game_ctl.h,632 :: 		set_brush_color(m_GREEN);
MOVS	R0, #5
BL	_set_brush_color+0
;cp_game_ctl.h,633 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,634 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,636 :: 		Delay_ms(100);  // Delay to allow screen to get wiped
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_init_snake_game199:
SUBS	R7, R7, #1
BNE	L_init_snake_game199
NOP
NOP
NOP
;cp_game_ctl.h,637 :: 		init_snake_sprite();
BL	_init_snake_sprite+0
;cp_game_ctl.h,638 :: 		}
L_end_init_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_game
_init_snake_sprite:
;cp_game_ctl.h,644 :: 		void init_snake_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,647 :: 		reset_game_values();
BL	_reset_game_values+0
;cp_game_ctl.h,650 :: 		m_node_head = m_node_start;
MOVW	R3, #lo_addr(_m_node_start+0)
MOVT	R3, #hi_addr(_m_node_start+0)
LDR	R0, [R3, #0]
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
STR	R0, [R2, #0]
;cp_game_ctl.h,651 :: 		m_node_tail = m_node_start;
MOV	R0, R3
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,652 :: 		g_curr_snake_dir = MOVE_RIGHT;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,655 :: 		m_node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOV	R0, R3
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,656 :: 		m_node_head->node_y = 1;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,657 :: 		print_snake(m_node_head, m_GREEN);
MOV	R0, R2
LDR	R0, [R0, #0]
MOVS	R1, #5
BL	_print_snake+0
;cp_game_ctl.h,658 :: 		generate_food();
BL	_generate_food+0
;cp_game_ctl.h,661 :: 		g_session_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,662 :: 		}
L_end_init_snake_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_sprite
_start_snake_game:
;cp_game_ctl.h,668 :: 		void start_snake_game() {
SUB	SP, SP, #4
;cp_game_ctl.h,669 :: 		Delay_ms(500); // Allow timers to wind up
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_start_snake_game201:
SUBS	R7, R7, #1
BNE	L_start_snake_game201
NOP
NOP
NOP
;cp_game_ctl.h,673 :: 		while (game_cur_screen_run_flag == TRUE) {
L_start_snake_game203:
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_start_snake_game204
;cp_game_ctl.h,675 :: 		};
IT	AL
BAL	L_start_snake_game203
L_start_snake_game204:
;cp_game_ctl.h,676 :: 		}
L_end_start_snake_game:
ADD	SP, SP, #4
BX	LR
; end of _start_snake_game
_screen_refresh_TIM3:
;cp_game_ctl.h,681 :: 		void screen_refresh_TIM3() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,685 :: 		if ( check_snake_collision((m_node_tail)->node_x, (m_node_tail)->node_y, m_node_tail+1) == FALSE ) {
MOVW	R3, #lo_addr(_m_node_tail+0)
MOVT	R3, #hi_addr(_m_node_tail+0)
LDR	R0, [R3, #0]
ADDS	R2, R0, #4
MOV	R0, R3
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
SXTH	R1, R0
MOV	R0, R3
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
BL	_check_snake_collision+0
CMP	R0, #0
IT	NE
BNE	L_screen_refresh_TIM3205
;cp_game_ctl.h,686 :: 		clean_tail(m_node_tail, m_BLACK);
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R0, [R0, #0]
MOVS	R1, #0
BL	_clean_tail+0
;cp_game_ctl.h,687 :: 		}
L_screen_refresh_TIM3205:
;cp_game_ctl.h,689 :: 		draw_cell_xy(g_fd_x_val, g_fd_y_val, m_FUCHSIA); // refresh food
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_y_val+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_x_val+0)
LDR	R0, [R0, #0]
MOVS	R2, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,690 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_screen_refresh_TIM3206:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3206
NOP
NOP
NOP
;cp_game_ctl.h,691 :: 		move_snake();
BL	_move_snake+0
;cp_game_ctl.h,693 :: 		if (g_GAME_PHASE != PHASE_QUIT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_screen_refresh_TIM3208
;cp_game_ctl.h,695 :: 		print_snake(m_node_head, m_GREEN);
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
MOVS	R1, #5
BL	_print_snake+0
;cp_game_ctl.h,696 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_screen_refresh_TIM3209:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3209
NOP
NOP
NOP
;cp_game_ctl.h,699 :: 		if ( check_snake_collision(g_fd_x_val, g_fd_y_val, m_node_head) == FALSE ) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R2, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_y_val+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_x_val+0)
LDR	R0, [R0, #0]
BL	_check_snake_collision+0
CMP	R0, #0
IT	NE
BNE	L_screen_refresh_TIM3211
;cp_game_ctl.h,700 :: 		incr_snake_tail();
BL	_incr_snake_tail+0
;cp_game_ctl.h,701 :: 		} else {
IT	AL
BAL	L_screen_refresh_TIM3212
L_screen_refresh_TIM3211:
;cp_game_ctl.h,703 :: 		play_sfx_food(20);
MOVS	R0, #20
BL	_play_sfx_food+0
;cp_game_ctl.h,704 :: 		g_game_score++;
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,705 :: 		generate_food();
BL	_generate_food+0
;cp_game_ctl.h,706 :: 		}
L_screen_refresh_TIM3212:
;cp_game_ctl.h,707 :: 		}
L_screen_refresh_TIM3208:
;cp_game_ctl.h,708 :: 		}
L_end_screen_refresh_TIM3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _screen_refresh_TIM3
_game_over_scr:
;cp_game_ctl.h,712 :: 		void game_over_scr() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,715 :: 		update_session_time();
BL	_update_session_time+0
;cp_game_ctl.h,718 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;cp_game_ctl.h,719 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_game_over_scr213:
SUBS	R7, R7, #1
BNE	L_game_over_scr213
NOP
NOP
NOP
;cp_game_ctl.h,723 :: 		update_time();
BL	_update_time+0
;cp_game_ctl.h,726 :: 		update_stats();
BL	_update_stats+0
;cp_game_ctl.h,731 :: 		set_game_phase (PHASE_QUIT);
MOVS	R0, #3
BL	_set_game_phase+0
;cp_game_ctl.h,737 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,743 :: 		set_brush_color(m_BLACK);
MOVS	R0, #0
BL	_set_brush_color+0
;cp_game_ctl.h,745 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,746 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,748 :: 		sprintf(g_str_buffer, "Total Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R0, #0]
SUBS	R2, R0, #1
MOVW	R1, #lo_addr(?lstr_12_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_12_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,749 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);
MOVW	R2, #32
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,751 :: 		sprintf(g_str_buffer, "Final score: \x20 %04d", g_game_score);
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_13_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_13_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,752 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 3*PX_BLOCK);
MOVW	R2, #48
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,755 :: 		while (cur_screen_run_flag == TRUE) {}
L_game_over_scr215:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_game_over_scr216
IT	AL
BAL	L_game_over_scr215
L_game_over_scr216:
;cp_game_ctl.h,758 :: 		}
L_end_game_over_scr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _game_over_scr
_convert_int_ascii:
;cp_game_ctl.h,775 :: 		void convert_int_ascii(uint8_t *in_array, int32_t entry_row ) {
; entry_row start address is: 4 (R1)
; in_array start address is: 0 (R0)
SUB	SP, SP, #4
; entry_row end address is: 4 (R1)
; in_array end address is: 0 (R0)
; in_array start address is: 0 (R0)
; entry_row start address is: 4 (R1)
;cp_game_ctl.h,776 :: 		int32_t temp_score = g_game_score;
MOVW	R2, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_game_score+0)
; temp_score start address is: 28 (R7)
LDR	R7, [R2, #0]
;cp_game_ctl.h,777 :: 		int32_t temp_val = 0;
;cp_game_ctl.h,778 :: 		int32_t temp_dvdnd = 0;
;cp_game_ctl.h,787 :: 		int32_t num_pos_ths = (entry_row * 7) + 3;       // 1000s pos
MOVS	R2, #7
MUL	R3, R1, R2
; entry_row end address is: 4 (R1)
ADDS	R2, R3, #3
; num_pos_ths start address is: 32 (R8)
MOV	R8, R2
;cp_game_ctl.h,788 :: 		int32_t num_pos_hds = (entry_row * 7) + 4;       // 100s
ADDS	R2, R3, #4
; num_pos_hds start address is: 24 (R6)
MOV	R6, R2
;cp_game_ctl.h,789 :: 		int32_t num_pos_ten = (entry_row * 7) + 5;       // 10s
ADDS	R2, R3, #5
; num_pos_ten start address is: 20 (R5)
MOV	R5, R2
;cp_game_ctl.h,790 :: 		int32_t num_pos_one = (entry_row * 7) + 6;       // 10s
ADDS	R2, R3, #6
; num_pos_one start address is: 4 (R1)
MOV	R1, R2
;cp_game_ctl.h,794 :: 		if (temp_score >= 1000 & g_game_score <= 9999) {
CMP	R7, #1000
MOVW	R4, #0
BLT	L__convert_int_ascii452
MOVS	R4, #1
L__convert_int_ascii452:
MOVW	R2, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R3, [R2, #0]
MOVW	R2, #9999
CMP	R3, R2
MOVW	R2, #0
BHI	L__convert_int_ascii453
MOVS	R2, #1
L__convert_int_ascii453:
AND	R2, R4, R2, LSL #0
CMP	R2, #0
IT	EQ
BEQ	L_convert_int_ascii217
;cp_game_ctl.h,795 :: 		temp_dvdnd = (temp_score / 1000);
MOVW	R2, #1000
SDIV	R2, R7, R2
; temp_dvdnd start address is: 16 (R4)
MOV	R4, R2
;cp_game_ctl.h,796 :: 		temp_val = temp_dvdnd +0x30;
ADDW	R3, R2, #48
;cp_game_ctl.h,797 :: 		in_array[num_pos_ths] = temp_val;
ADD	R2, R0, R8, LSL #0
; num_pos_ths end address is: 32 (R8)
STRB	R3, [R2, #0]
;cp_game_ctl.h,800 :: 		temp_score = temp_score - (1000 * temp_dvdnd);
MOVW	R2, #1000
MULS	R2, R4, R2
; temp_dvdnd end address is: 16 (R4)
SUB	R4, R7, R2
; temp_score end address is: 28 (R7)
; temp_score start address is: 16 (R4)
;cp_game_ctl.h,802 :: 		} else {
; temp_score end address is: 16 (R4)
IT	AL
BAL	L_convert_int_ascii218
L_convert_int_ascii217:
;cp_game_ctl.h,803 :: 		in_array[num_pos_ths] = 0x30;  // d0;
; num_pos_ths start address is: 32 (R8)
; temp_score start address is: 28 (R7)
ADD	R3, R0, R8, LSL #0
; num_pos_ths end address is: 32 (R8)
MOVS	R2, #48
STRB	R2, [R3, #0]
; temp_score end address is: 28 (R7)
MOV	R4, R7
;cp_game_ctl.h,804 :: 		}
L_convert_int_ascii218:
;cp_game_ctl.h,807 :: 		if (temp_score >= 100 ) {
; temp_score start address is: 16 (R4)
CMP	R4, #100
IT	LT
BLT	L_convert_int_ascii219
;cp_game_ctl.h,808 :: 		temp_dvdnd = (temp_score / 100);
MOVS	R2, #100
SDIV	R2, R4, R2
; temp_dvdnd start address is: 28 (R7)
MOV	R7, R2
;cp_game_ctl.h,809 :: 		temp_val = temp_dvdnd + 0x30;
ADDW	R3, R2, #48
;cp_game_ctl.h,810 :: 		in_array[num_pos_hds] = temp_val;
ADDS	R2, R0, R6
; num_pos_hds end address is: 24 (R6)
STRB	R3, [R2, #0]
;cp_game_ctl.h,813 :: 		temp_score = temp_score - (100 * temp_dvdnd);
MOVS	R2, #100
MULS	R2, R7, R2
; temp_dvdnd end address is: 28 (R7)
SUB	R4, R4, R2
;cp_game_ctl.h,815 :: 		} else {
IT	AL
BAL	L_convert_int_ascii220
L_convert_int_ascii219:
;cp_game_ctl.h,816 :: 		in_array[num_pos_hds] = 0x30;
; num_pos_hds start address is: 24 (R6)
ADDS	R3, R0, R6
; num_pos_hds end address is: 24 (R6)
MOVS	R2, #48
STRB	R2, [R3, #0]
; temp_score end address is: 16 (R4)
;cp_game_ctl.h,817 :: 		}
L_convert_int_ascii220:
;cp_game_ctl.h,820 :: 		if (temp_score >= 10) {
; temp_score start address is: 16 (R4)
CMP	R4, #10
IT	LT
BLT	L_convert_int_ascii221
;cp_game_ctl.h,821 :: 		temp_dvdnd = (temp_score / 10);
MOVS	R2, #10
SDIV	R2, R4, R2
; temp_dvdnd start address is: 24 (R6)
MOV	R6, R2
;cp_game_ctl.h,822 :: 		temp_val = temp_dvdnd + 0x30;
ADDW	R3, R2, #48
;cp_game_ctl.h,823 :: 		in_array[num_pos_ten] = temp_val;
ADDS	R2, R0, R5
; num_pos_ten end address is: 20 (R5)
STRB	R3, [R2, #0]
;cp_game_ctl.h,826 :: 		temp_score = temp_score - (10 * temp_dvdnd);
MOVS	R2, #10
MULS	R2, R6, R2
; temp_dvdnd end address is: 24 (R6)
SUB	R4, R4, R2
;cp_game_ctl.h,827 :: 		}  else {
IT	AL
BAL	L_convert_int_ascii222
L_convert_int_ascii221:
;cp_game_ctl.h,828 :: 		in_array[num_pos_ten] = 0x30;
; num_pos_ten start address is: 20 (R5)
ADDS	R3, R0, R5
; num_pos_ten end address is: 20 (R5)
MOVS	R2, #48
STRB	R2, [R3, #0]
; temp_score end address is: 16 (R4)
;cp_game_ctl.h,829 :: 		}
L_convert_int_ascii222:
;cp_game_ctl.h,832 :: 		in_array[num_pos_one] = temp_score + 0x30;
; temp_score start address is: 16 (R4)
ADDS	R3, R0, R1
; in_array end address is: 0 (R0)
; num_pos_one end address is: 4 (R1)
ADDW	R2, R4, #48
; temp_score end address is: 16 (R4)
STRB	R2, [R3, #0]
;cp_game_ctl.h,833 :: 		}
L_end_convert_int_ascii:
ADD	SP, SP, #4
BX	LR
; end of _convert_int_ascii
_refresh_hs_scr:
;cp_game_ctl.h,838 :: 		void refresh_hs_scr(uint8_t cur_dir) {
; cur_dir start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; cur_dir end address is: 0 (R0)
; cur_dir start address is: 0 (R0)
;cp_game_ctl.h,849 :: 		TFT_Fill_Screen(CL_BLACK);
STRB	R0, [SP, #4]
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
LDRB	R0, [SP, #4]
;cp_game_ctl.h,850 :: 		switch(cur_dir) {
IT	AL
BAL	L_refresh_hs_scr223
; cur_dir end address is: 0 (R0)
;cp_game_ctl.h,851 :: 		case MOVE_UP:
L_refresh_hs_scr225:
;cp_game_ctl.h,853 :: 		if (init_cur > 0x5A) {
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R1, [R1, #0]
CMP	R1, #90
IT	LS
BLS	L_refresh_hs_scr226
;cp_game_ctl.h,854 :: 		init_cur = init_cursor_start;
MOVS	R2, #65
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
STRB	R2, [R1, #0]
;cp_game_ctl.h,855 :: 		}
L_refresh_hs_scr226:
;cp_game_ctl.h,856 :: 		++init_cur;
MOVW	R2, #lo_addr(_init_cur+0)
MOVT	R2, #hi_addr(_init_cur+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
STRB	R1, [R2, #0]
;cp_game_ctl.h,857 :: 		break;
IT	AL
BAL	L_refresh_hs_scr224
;cp_game_ctl.h,859 :: 		case MOVE_DOWN:
L_refresh_hs_scr227:
;cp_game_ctl.h,860 :: 		if (init_cur < init_cursor_start) {
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R1, [R1, #0]
CMP	R1, #65
IT	CS
BCS	L_refresh_hs_scr228
;cp_game_ctl.h,861 :: 		init_cur = 0x5A;
MOVS	R2, #90
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
STRB	R2, [R1, #0]
;cp_game_ctl.h,862 :: 		} else {
IT	AL
BAL	L_refresh_hs_scr229
L_refresh_hs_scr228:
;cp_game_ctl.h,863 :: 		--init_cur;
MOVW	R2, #lo_addr(_init_cur+0)
MOVT	R2, #hi_addr(_init_cur+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
STRB	R1, [R2, #0]
;cp_game_ctl.h,864 :: 		}
L_refresh_hs_scr229:
;cp_game_ctl.h,865 :: 		break;
IT	AL
BAL	L_refresh_hs_scr224
;cp_game_ctl.h,866 :: 		case JBTN_DOWN:
L_refresh_hs_scr230:
;cp_game_ctl.h,868 :: 		user_score_entry[get_initial_cur_pos()] = init_cur;
BL	_get_initial_cur_pos+0
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+0)
ADDS	R2, R1, R0
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;cp_game_ctl.h,869 :: 		++init_cur_pos;
MOVW	R2, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R2, #hi_addr(P7_final_project_main_init_cur_pos+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,870 :: 		++hs_cursor_x;
MOVW	R2, #lo_addr(P7_final_project_main_hs_cursor_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_hs_cursor_x+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,872 :: 		}
IT	AL
BAL	L_refresh_hs_scr224
L_refresh_hs_scr223:
; cur_dir start address is: 0 (R0)
CMP	R0, #2
IT	EQ
BEQ	L_refresh_hs_scr225
CMP	R0, #3
IT	EQ
BEQ	L_refresh_hs_scr227
CMP	R0, #4
IT	EQ
BEQ	L_refresh_hs_scr230
; cur_dir end address is: 0 (R0)
L_refresh_hs_scr224:
;cp_game_ctl.h,875 :: 		if (init_cur_pos >= 3) {
MOVW	R1, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R1, #hi_addr(P7_final_project_main_init_cur_pos+0)
LDR	R1, [R1, #0]
CMP	R1, #3
IT	LT
BLT	L_refresh_hs_scr231
;cp_game_ctl.h,878 :: 		convert_int_ascii(&user_score_entry, 0);
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+0)
BL	_convert_int_ascii+0
;cp_game_ctl.h,881 :: 		set_cur_screen_run_flag(FALSE); // exit this phase move to show top score list
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,882 :: 		set_game_phase(PHASE_PRINT_TOP_TEN);
MOVS	R0, #5
BL	_set_game_phase+0
;cp_game_ctl.h,883 :: 		} else {
IT	AL
BAL	L_refresh_hs_scr232
L_refresh_hs_scr231:
;cp_game_ctl.h,884 :: 		draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY);
MOVW	R1, #lo_addr(P7_final_project_main_hs_cursor_y+0)
MOVT	R1, #hi_addr(P7_final_project_main_hs_cursor_y+0)
LDR	R2, [R1, #0]
MOVW	R1, #lo_addr(P7_final_project_main_hs_cursor_x+0)
MOVT	R1, #hi_addr(P7_final_project_main_hs_cursor_x+0)
LDR	R1, [R1, #0]
SXTH	R0, R1
SXTH	R1, R2
MOVS	R2, #4
BL	_draw_ini_cell_xy+0
;cp_game_ctl.h,885 :: 		sprintf(g_str_buffer, "Enter high score: \x20 ");
MOVW	R2, #lo_addr(?lstr_14_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_14_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,886 :: 		TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #32
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,888 :: 		if (get_initial_cur_pos() == 0) {
BL	_get_initial_cur_pos+0
CMP	R0, #0
IT	NE
BNE	L_refresh_hs_scr233
;cp_game_ctl.h,889 :: 		sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R4, [R1, #0]
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_15_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_15_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,890 :: 		} else if (get_initial_cur_pos() == 1) {
IT	AL
BAL	L_refresh_hs_scr234
L_refresh_hs_scr233:
BL	_get_initial_cur_pos+0
CMP	R0, #1
IT	NE
BNE	L_refresh_hs_scr235
;cp_game_ctl.h,891 :: 		sprintf(g_str_buffer, "%c\x20%c\x20_: \x20 %04d", user_score_entry[0], init_cur, g_game_score);
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R5, [R1, #0]
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R4, [R1, #0]
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_16_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_16_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #20
;cp_game_ctl.h,892 :: 		} else if (get_initial_cur_pos() == 2) {
IT	AL
BAL	L_refresh_hs_scr236
L_refresh_hs_scr235:
BL	_get_initial_cur_pos+0
CMP	R0, #2
IT	NE
BNE	L_refresh_hs_scr237
;cp_game_ctl.h,893 :: 		sprintf(g_str_buffer, "%c\x20%c\x20%c: \x20 %04d", user_score_entry[0], user_score_entry[1], init_cur, g_game_score);
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R6, [R1, #0]
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R5, [R1, #0]
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+1)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+1)
LDRB	R4, [R1, #0]
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_17_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_17_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R6)
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #24
;cp_game_ctl.h,894 :: 		} else {
IT	AL
BAL	L_refresh_hs_scr238
L_refresh_hs_scr237:
;cp_game_ctl.h,895 :: 		sprintf(g_str_buffer, "FINISHED");
MOVW	R2, #lo_addr(?lstr_18_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_18_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,896 :: 		}
L_refresh_hs_scr238:
L_refresh_hs_scr236:
L_refresh_hs_scr234:
;cp_game_ctl.h,898 :: 		TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #160
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,899 :: 		Delay_ms(200); // Small wait for the user experience
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_refresh_hs_scr239:
SUBS	R7, R7, #1
BNE	L_refresh_hs_scr239
NOP
NOP
NOP
;cp_game_ctl.h,900 :: 		}
L_refresh_hs_scr232:
;cp_game_ctl.h,904 :: 		}
L_end_refresh_hs_scr:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _refresh_hs_scr
_game_high_score_scr:
;cp_game_ctl.h,908 :: 		void game_high_score_scr() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,910 :: 		set_game_phase(PHASE_HSCORE);
MOVS	R0, #4
BL	_set_game_phase+0
;cp_game_ctl.h,914 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,917 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,920 :: 		draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY);
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_y+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_x+0)
LDR	R0, [R0, #0]
MOVS	R2, #4
BL	_draw_ini_cell_xy+0
;cp_game_ctl.h,921 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_game_high_score_scr241:
SUBS	R7, R7, #1
BNE	L_game_high_score_scr241
NOP
NOP
NOP
;cp_game_ctl.h,922 :: 		sprintf(g_str_buffer, "Enter high score: \x20 ");
MOVW	R1, #lo_addr(?lstr_19_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_19_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,923 :: 		TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #32
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,924 :: 		sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(_init_cur+0)
MOVT	R0, #hi_addr(_init_cur+0)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_20_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_20_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,925 :: 		TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #160
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,927 :: 		while (cur_screen_run_flag == TRUE) {}
L_game_high_score_scr243:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_game_high_score_scr244
IT	AL
BAL	L_game_high_score_scr243
L_game_high_score_scr244:
;cp_game_ctl.h,931 :: 		set_game_phase(PHASE_PRINT_TOP_TEN); // change to restart game
MOVS	R0, #5
BL	_set_game_phase+0
;cp_game_ctl.h,933 :: 		}
L_end_game_high_score_scr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _game_high_score_scr
_EE_write:
;cp_game_ctl.h,935 :: 		void EE_write(uint8_t row, uint8_t *tx_data_in, uint32_t tx_size) {
; row start address is: 0 (R0)
; tx_size start address is: 8 (R2)
; tx_data_in start address is: 4 (R1)
SUB	SP, SP, #16
STR	LR, [SP, #0]
;cp_game_ctl.h,938 :: 		row =0;
;cp_game_ctl.h,935 :: 		void EE_write(uint8_t row, uint8_t *tx_data_in, uint32_t tx_size) {
;cp_game_ctl.h,938 :: 		row =0;
;cp_game_ctl.h,935 :: 		void EE_write(uint8_t row, uint8_t *tx_data_in, uint32_t tx_size) {
MOV	R0, R2
; row end address is: 0 (R0)
; tx_size end address is: 8 (R2)
; tx_data_in end address is: 4 (R1)
; tx_data_in start address is: 4 (R1)
; tx_size start address is: 0 (R0)
;cp_game_ctl.h,937 :: 		uint8_t reg_addr=0;
;cp_game_ctl.h,938 :: 		row =0;
; row start address is: 8 (R2)
MOVS	R2, #0
;cp_game_ctl.h,941 :: 		switch (row) {
IT	AL
BAL	L_EE_write245
; row end address is: 8 (R2)
;cp_game_ctl.h,942 :: 		case 0:
L_EE_write247:
;cp_game_ctl.h,944 :: 		break;
IT	AL
BAL	L_EE_write246
;cp_game_ctl.h,945 :: 		case 1:
L_EE_write248:
;cp_game_ctl.h,947 :: 		break;
IT	AL
BAL	L_EE_write246
;cp_game_ctl.h,948 :: 		case 2:
L_EE_write249:
;cp_game_ctl.h,950 :: 		break;
IT	AL
BAL	L_EE_write246
;cp_game_ctl.h,951 :: 		case 3:
L_EE_write250:
;cp_game_ctl.h,953 :: 		break;
IT	AL
BAL	L_EE_write246
;cp_game_ctl.h,954 :: 		case 4:
L_EE_write251:
;cp_game_ctl.h,956 :: 		break;
IT	AL
BAL	L_EE_write246
;cp_game_ctl.h,957 :: 		case 4:
L_EE_write252:
;cp_game_ctl.h,959 :: 		break;
IT	AL
BAL	L_EE_write246
;cp_game_ctl.h,960 :: 		default:
L_EE_write253:
;cp_game_ctl.h,961 :: 		break;
IT	AL
BAL	L_EE_write246
;cp_game_ctl.h,962 :: 		}
L_EE_write245:
; row start address is: 8 (R2)
CMP	R2, #0
IT	EQ
BEQ	L_EE_write247
CMP	R2, #1
IT	EQ
BEQ	L_EE_write248
CMP	R2, #2
IT	EQ
BEQ	L_EE_write249
CMP	R2, #3
IT	EQ
BEQ	L_EE_write250
CMP	R2, #4
IT	EQ
BEQ	L_EE_write251
CMP	R2, #4
IT	EQ
BEQ	L_EE_write252
; row end address is: 8 (R2)
IT	AL
BAL	L_EE_write253
L_EE_write246:
;cp_game_ctl.h,965 :: 		tx_data_[0] = 0; // reserved
ADD	R5, SP, #8
MOVS	R3, #0
STRB	R3, [R5, #0]
;cp_game_ctl.h,972 :: 		tx_data_[1] = tx_data_in[0];    // Initial 1
ADDS	R4, R5, #1
LDRB	R3, [R1, #0]
STRB	R3, [R4, #0]
;cp_game_ctl.h,973 :: 		tx_data_[2] = tx_data_in[1];    // Initial 2
ADDS	R4, R5, #2
ADDS	R3, R1, #1
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;cp_game_ctl.h,974 :: 		tx_data_[3] = tx_data_in[2];    // Initial 3
ADDS	R4, R5, #3
ADDS	R3, R1, #2
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;cp_game_ctl.h,975 :: 		tx_data_[4] = tx_data_in[3];    // Score 1000s
ADDS	R4, R5, #4
ADDS	R3, R1, #3
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;cp_game_ctl.h,976 :: 		tx_data_[5] = tx_data_in[4];    // Score 100s
ADDS	R4, R5, #5
ADDS	R3, R1, #4
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;cp_game_ctl.h,977 :: 		tx_data_[6] = tx_data_in[5];    // Score 10s
ADDS	R4, R5, #6
ADDS	R3, R1, #5
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;cp_game_ctl.h,978 :: 		tx_data_[7] = tx_data_in[6];    // Score 1s
ADDS	R4, R5, #7
ADDS	R3, R1, #6
; tx_data_in end address is: 4 (R1)
LDRB	R3, [R3, #0]
STRB	R3, [R4, #0]
;cp_game_ctl.h,988 :: 		I2C1_Start();
STR	R0, [SP, #4]
BL	_I2C1_Start+0
LDR	R0, [SP, #4]
;cp_game_ctl.h,989 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_EE_write254:
SUBS	R7, R7, #1
BNE	L_EE_write254
NOP
NOP
NOP
;cp_game_ctl.h,992 :: 		I2C1_Write(0x50, tx_data_, tx_size+1, END_MODE_STOP);
ADDS	R4, R0, #1
; tx_size end address is: 0 (R0)
ADD	R3, SP, #8
MOV	R2, R4
MOV	R1, R3
MOVW	R3, #1
MOVS	R0, #80
BL	_I2C1_Write+0
;cp_game_ctl.h,993 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_EE_write256:
SUBS	R7, R7, #1
BNE	L_EE_write256
NOP
NOP
NOP
;cp_game_ctl.h,995 :: 		}
L_end_EE_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _EE_write
_EE_read:
;cp_game_ctl.h,1012 :: 		void EE_read(uint8_t reg_addr, uint8_t *read_buffer, uint32_t rx_size) {
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STR	R1, [SP, #8]
STR	R2, [SP, #12]
;cp_game_ctl.h,1016 :: 		I2C1_Start();
BL	_I2C1_Start+0
;cp_game_ctl.h,1017 :: 		I2C1_Write(0x50, reg_addr, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
LDRB	R1, [SP, #4]
MOVS	R0, #80
BL	_I2C1_Write+0
;cp_game_ctl.h,1018 :: 		I2C1_Read(0x50, read_buffer, rx_size +4, END_MODE_STOP);
LDR	R3, [SP, #12]
ADDS	R3, R3, #4
MOV	R2, R3
MOVW	R3, #1
LDR	R1, [SP, #8]
MOVS	R0, #80
BL	_I2C1_Read+0
;cp_game_ctl.h,1021 :: 		}
L_end_EE_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _EE_read
_sort_score:
;cp_game_ctl.h,1027 :: 		int32_t sort_score(uint8_t *in_arr) {
SUB	SP, SP, #28
STR	LR, [SP, #0]
STR	R0, [SP, #24]
;cp_game_ctl.h,1028 :: 		int32_t cell_pos = 0;
;cp_game_ctl.h,1029 :: 		int32_t row_found = -1;
MOV	R1, #-1
STR	R1, [SP, #20]
;cp_game_ctl.h,1043 :: 		for (i=0; i < 15; i++ ) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
L_sort_score258:
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, #15
IT	GE
BGE	L_sort_score259
;cp_game_ctl.h,1053 :: 		temp_ee_score[0] = in_arr[(i*7) + 7];
ADD	R5, SP, #4
MOVW	R4, #lo_addr(P7_final_project_main_i+0)
MOVT	R4, #hi_addr(P7_final_project_main_i+0)
LDR	R2, [R4, #0]
MOVS	R1, #7
MULS	R1, R2, R1
ADDS	R2, R1, #7
LDR	R1, [SP, #24]
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
STRB	R1, [R5, #0]
;cp_game_ctl.h,1054 :: 		temp_ee_score[1] = in_arr[(i*7) + 8];
ADDS	R3, R5, #1
MOV	R1, R4
LDR	R2, [R1, #0]
MOVS	R1, #7
MULS	R1, R2, R1
ADDW	R2, R1, #8
LDR	R1, [SP, #24]
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
STRB	R1, [R3, #0]
;cp_game_ctl.h,1055 :: 		temp_ee_score[2] = in_arr[(i*7) + 9];
ADDS	R3, R5, #2
MOV	R1, R4
LDR	R2, [R1, #0]
MOVS	R1, #7
MULS	R1, R2, R1
ADDW	R2, R1, #9
LDR	R1, [SP, #24]
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
STRB	R1, [R3, #0]
;cp_game_ctl.h,1056 :: 		temp_ee_score[3] = in_arr[(i*7) + 10];
ADDS	R3, R5, #3
MOV	R1, R4
LDR	R2, [R1, #0]
MOVS	R1, #7
MULS	R1, R2, R1
ADDW	R2, R1, #10
LDR	R1, [SP, #24]
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
STRB	R1, [R3, #0]
;cp_game_ctl.h,1059 :: 		temp_player_score[0] = user_score_entry[3];
ADD	R3, SP, #8
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+3)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+3)
LDRB	R1, [R1, #0]
STRB	R1, [R3, #0]
;cp_game_ctl.h,1060 :: 		temp_player_score[1] = user_score_entry[4];
ADDS	R2, R3, #1
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+4)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+4)
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;cp_game_ctl.h,1061 :: 		temp_player_score[2] = user_score_entry[5];
ADDS	R2, R3, #2
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+5)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+5)
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;cp_game_ctl.h,1062 :: 		temp_player_score[3] = user_score_entry[7];
ADDS	R2, R3, #3
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+7)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+7)
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;cp_game_ctl.h,1065 :: 		eeprom_score = atoi(temp_ee_score);
MOV	R0, R5
BL	_atoi+0
STR	R0, [SP, #12]
;cp_game_ctl.h,1066 :: 		player_score = atoi(temp_player_score);
ADD	R1, SP, #8
MOV	R0, R1
BL	_atoi+0
STR	R0, [SP, #16]
;cp_game_ctl.h,1071 :: 		sprintf(g_str_buffer, "atoi[%d]:\x20  %s \x20 | \x20 %c", i, user_score_entry, temp_ee_score[i]);
ADD	R3, SP, #4
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R3, R1
LDRB	R1, [R1, #0]
UXTB	R5, R1
MOVW	R4, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R4, #hi_addr(P7_final_project_main_user_score_entry+0)
MOV	R1, R2
LDR	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_21_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_21_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #20
;cp_game_ctl.h,1072 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, (i+1)*PX_BLOCK);
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #1
LSLS	R1, R1, #4
UXTH	R2, R1
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1075 :: 		if (player_score > eeprom_score || temp_ee_score[0] > 0x39 ) {
LDR	R2, [SP, #12]
LDR	R1, [SP, #16]
CMP	R1, R2
IT	GT
BGT	L__sort_score382
ADD	R1, SP, #4
LDRB	R1, [R1, #0]
CMP	R1, #57
IT	HI
BHI	L__sort_score381
IT	AL
BAL	L_sort_score263
L__sort_score382:
L__sort_score381:
;cp_game_ctl.h,1076 :: 		row_found = i;
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
STR	R1, [SP, #20]
;cp_game_ctl.h,1077 :: 		sprintf(g_str_buffer, "found i [%d]", i);
MOV	R1, R2
LDR	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_22_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_22_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,1078 :: 		TFT_Write_Text(&g_str_buffer, 13*PX_BLOCK, (i+1)*PX_BLOCK);
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #1
LSLS	R1, R1, #4
UXTH	R2, R1
MOVW	R1, #208
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1079 :: 		i = 999;
MOVW	R2, #999
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
;cp_game_ctl.h,1080 :: 		} else if (i==15) {
IT	AL
BAL	L_sort_score264
L_sort_score263:
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, #15
IT	NE
BNE	L_sort_score265
;cp_game_ctl.h,1081 :: 		return -1; // nothing found
MOV	R0, #-1
IT	AL
BAL	L_end_sort_score
;cp_game_ctl.h,1082 :: 		}
L_sort_score265:
L_sort_score264:
;cp_game_ctl.h,1084 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_sort_score266:
SUBS	R7, R7, #1
BNE	L_sort_score266
NOP
NOP
NOP
;cp_game_ctl.h,1043 :: 		for (i=0; i < 15; i++ ) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,1085 :: 		}
IT	AL
BAL	L_sort_score258
L_sort_score259:
;cp_game_ctl.h,1089 :: 		return row_found;
LDR	R0, [SP, #20]
;cp_game_ctl.h,1090 :: 		}
L_end_sort_score:
LDR	LR, [SP, #0]
ADD	SP, SP, #28
BX	LR
; end of _sort_score
_print_top_score_list:
;cp_game_ctl.h,1094 :: 		void print_top_score_list() {
SUB	SP, SP, #152
STR	LR, [SP, #0]
;cp_game_ctl.h,1095 :: 		uint32_t tx_count = 0;
;cp_game_ctl.h,1106 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,1110 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,1113 :: 		I2C1_Init();
BL	_I2C1_Init+0
;cp_game_ctl.h,1116 :: 		EE_read(0, &hs_buffer, 71);
ADD	R0, SP, #8
MOVS	R2, #71
MOV	R1, R0
MOVS	R0, #0
BL	_EE_read+0
;cp_game_ctl.h,1119 :: 		row_to_write = sort_score(&hs_buffer);
ADD	R0, SP, #8
BL	_sort_score+0
; row_to_write start address is: 4 (R1)
MOV	R1, R0
;cp_game_ctl.h,1121 :: 		if (row_to_write >=0 ) {
CMP	R0, #0
IT	LT
BLT	L_print_top_score_list268
;cp_game_ctl.h,1122 :: 		EE_write( (uint8_t) row_to_write, &user_score_entry,7 );
MOVS	R2, #7
UXTB	R0, R1
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+0)
; row_to_write end address is: 4 (R1)
BL	_EE_write+0
;cp_game_ctl.h,1123 :: 		}
L_print_top_score_list268:
;cp_game_ctl.h,1126 :: 		sprintf(g_str_buffer, "TOP SCORES:");
MOVW	R1, #lo_addr(?lstr_23_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_23_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,1127 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);
MOVW	R2, #32
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1130 :: 		sprintf(g_str_buffer, "test: %s", user_score_entry);
MOVW	R2, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R2, #hi_addr(P7_final_project_main_user_score_entry+0)
MOVW	R1, #lo_addr(?lstr_24_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_24_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,1131 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1133 :: 		user_score_entry[3] = 0x30+5;
MOVS	R1, #53
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+3)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+3)
STRB	R1, [R0, #0]
;cp_game_ctl.h,1134 :: 		atest[0] = user_score_entry[3];
ADD	R2, SP, #136
MOVS	R0, #53
STRB	R0, [R2, #0]
;cp_game_ctl.h,1135 :: 		atest[1] = user_score_entry[4];
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+4)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+4)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;cp_game_ctl.h,1136 :: 		atest[2] = user_score_entry[5];
ADDS	R1, R2, #2
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+5)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+5)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;cp_game_ctl.h,1137 :: 		atest[3] = user_score_entry[6];
ADDS	R1, R2, #3
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+6)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+6)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;cp_game_ctl.h,1139 :: 		test_num = atoi(atest);
MOV	R0, R2
BL	_atoi+0
; test_num start address is: 12 (R3)
SXTH	R3, R0
;cp_game_ctl.h,1140 :: 		sprintf(g_str_buffer, "atoi: %d", test_num);
MOV	R2, R3
MOVW	R1, #lo_addr(?lstr_25_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_25_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
STR	R3, [SP, #4]
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,1141 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 5*PX_BLOCK);
MOVW	R2, #80
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
LDR	R3, [SP, #4]
;cp_game_ctl.h,1143 :: 		if (test_num > 999) {
MOVW	R0, #999
CMP	R3, R0
IT	LE
BLE	L_print_top_score_list269
; test_num end address is: 12 (R3)
;cp_game_ctl.h,1144 :: 		sprintf(g_str_buffer, "test num is greater");
MOVW	R1, #lo_addr(?lstr_26_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_26_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,1145 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 6*PX_BLOCK);
MOVW	R2, #96
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1146 :: 		}
L_print_top_score_list269:
;cp_game_ctl.h,1148 :: 		GPIOB_ODR |= 0xFF00; // PB6 PB7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #65280
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,1149 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_top_score_list270:
SUBS	R7, R7, #1
BNE	L_print_top_score_list270
NOP
NOP
NOP
;cp_game_ctl.h,1151 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_print_top_score_list272:
SUBS	R7, R7, #1
BNE	L_print_top_score_list272
NOP
NOP
NOP
;cp_game_ctl.h,1155 :: 		EE_read(0, &hs_buffer, 71);
ADD	R0, SP, #8
MOVS	R2, #71
MOV	R1, R0
MOVS	R0, #0
BL	_EE_read+0
;cp_game_ctl.h,1157 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 9*PX_BLOCK);
MOVW	R2, #144
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1166 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,1167 :: 		sprintf(g_str_buffer, "TOP SCORES:\x20  %s | \x20 %c",hs_buffer, hs_buffer[0]);
ADD	R3, SP, #8
LDRB	R0, [R3, #0]
UXTB	R2, R0
MOVW	R1, #lo_addr(?lstr_27_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_27_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R3)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,1168 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 1*PX_BLOCK);
MOVW	R2, #16
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1169 :: 		for (i=0; i < 5; i++ ) {
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
STR	R1, [R0, #0]
L_print_top_score_list274:
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
LDR	R0, [R0, #0]
CMP	R0, #5
IT	GE
BGE	L_print_top_score_list275
;cp_game_ctl.h,1177 :: 		temp_score[0] = hs_buffer[(i*7) + 2];
ADD	R11, SP, #140
MOVW	R10, #lo_addr(P7_final_project_main_i+0)
MOVT	R10, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R10, #0]
MOVS	R0, #7
MULS	R0, R1, R0
ADDS	R0, R0, #2
ADD	R3, SP, #8
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
STRB	R0, [R11, #0]
;cp_game_ctl.h,1178 :: 		temp_score[1] = hs_buffer[(i*7) + 3];
ADD	R2, R11, #1
MOV	R0, R10
LDR	R1, [R0, #0]
MOVS	R0, #7
MULS	R0, R1, R0
ADDS	R0, R0, #3
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;cp_game_ctl.h,1179 :: 		temp_score[2] = hs_buffer[(i*7) + 4];
ADD	R2, R11, #2
MOV	R0, R10
LDR	R1, [R0, #0]
MOVS	R0, #7
MULS	R0, R1, R0
ADDS	R0, R0, #4
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;cp_game_ctl.h,1180 :: 		temp_score[3] = hs_buffer[(i*7) + 5];
ADD	R2, R11, #3
MOV	R0, R10
LDR	R1, [R0, #0]
MOVS	R0, #7
MULS	R0, R1, R0
ADDS	R0, R0, #5
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;cp_game_ctl.h,1181 :: 		temp_score[4] = hs_buffer[(i*7) + 6];
ADD	R2, R11, #4
MOV	R0, R10
LDR	R1, [R0, #0]
MOVS	R0, #7
MULS	R0, R1, R0
ADDS	R0, R0, #6
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;cp_game_ctl.h,1182 :: 		temp_score[5] = hs_buffer[(i*7) + 7];
ADD	R2, R11, #5
MOV	R0, R10
LDR	R1, [R0, #0]
MOVS	R0, #7
MULS	R0, R1, R0
ADDS	R0, R0, #7
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;cp_game_ctl.h,1183 :: 		temp_score[6] = hs_buffer[(i*7) + 8];
ADD	R2, R11, #6
MOV	R0, R10
LDR	R1, [R0, #0]
MOVS	R0, #7
MULS	R0, R1, R0
ADDS	R0, #8
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
STRB	R0, [R2, #0]
;cp_game_ctl.h,1195 :: 		hs_buffer[(i*7) + 8]
MOV	R0, R10
LDR	R1, [R0, #0]
MOVS	R0, #7
MULS	R1, R0, R1
ADDW	R0, R1, #8
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
UXTB	R9, R0
;cp_game_ctl.h,1194 :: 		hs_buffer[(i*7) + 7],
ADDS	R0, R1, #7
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
UXTB	R8, R0
;cp_game_ctl.h,1193 :: 		hs_buffer[(i*7) + 6],
ADDS	R0, R1, #6
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
UXTB	R7, R0
;cp_game_ctl.h,1192 :: 		hs_buffer[(i*7) + 5],
ADDS	R0, R1, #5
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
UXTB	R6, R0
;cp_game_ctl.h,1191 :: 		hs_buffer[(i*7) + 4],
ADDS	R0, R1, #4
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
UXTB	R5, R0
;cp_game_ctl.h,1190 :: 		hs_buffer[(i*7) + 3],
ADDS	R0, R1, #3
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
UXTB	R4, R0
;cp_game_ctl.h,1189 :: 		hs_buffer[(i*7) + 2],
ADDS	R0, R1, #2
ADDS	R0, R3, R0
LDRB	R0, [R0, #0]
UXTB	R3, R0
;cp_game_ctl.h,1188 :: 		sprintf(g_str_buffer, "score[%d]:\x20  %s | \x20 %c%c%c%c%c%c%c", i , temp_score,
MOV	R0, R10
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_28_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_28_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
;cp_game_ctl.h,1195 :: 		hs_buffer[(i*7) + 8]
PUSH	36
;cp_game_ctl.h,1194 :: 		hs_buffer[(i*7) + 7],
PUSH	32
;cp_game_ctl.h,1193 :: 		hs_buffer[(i*7) + 6],
PUSH	(R7)
;cp_game_ctl.h,1192 :: 		hs_buffer[(i*7) + 5],
PUSH	(R6)
;cp_game_ctl.h,1191 :: 		hs_buffer[(i*7) + 4],
PUSH	(R5)
;cp_game_ctl.h,1190 :: 		hs_buffer[(i*7) + 3],
PUSH	(R4)
;cp_game_ctl.h,1189 :: 		hs_buffer[(i*7) + 2],
PUSH	(R3)
;cp_game_ctl.h,1188 :: 		sprintf(g_str_buffer, "score[%d]:\x20  %s | \x20 %c%c%c%c%c%c%c", i , temp_score,
PUSH	44
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
;cp_game_ctl.h,1195 :: 		hs_buffer[(i*7) + 8]
BL	_sprintf+0
ADD	SP, SP, #44
;cp_game_ctl.h,1199 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, (i+2)*PX_BLOCK);
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LSLS	R0, R0, #4
UXTH	R2, R0
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1202 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_print_top_score_list277:
SUBS	R7, R7, #1
BNE	L_print_top_score_list277
NOP
NOP
NOP
;cp_game_ctl.h,1169 :: 		for (i=0; i < 5; i++ ) {
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,1203 :: 		}
IT	AL
BAL	L_print_top_score_list274
L_print_top_score_list275:
;cp_game_ctl.h,1208 :: 		while (cur_screen_run_flag == TRUE) {}
L_print_top_score_list279:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_print_top_score_list280
IT	AL
BAL	L_print_top_score_list279
L_print_top_score_list280:
;cp_game_ctl.h,1212 :: 		set_game_phase(PHASE1_READY); // change to restart game
MOVS	R0, #1
BL	_set_game_phase+0
;cp_game_ctl.h,1214 :: 		}
L_end_print_top_score_list:
LDR	LR, [SP, #0]
ADD	SP, SP, #152
BX	LR
; end of _print_top_score_list
_EXTI15_10:
;P7_final_project_main.c,86 :: 		void EXTI15_10() iv IVT_INT_EXTI15_10  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,88 :: 		EXTI_PR |= 1 << 13;     // Rearm interrupt
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,89 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,91 :: 		while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }
L_EXTI15_10281:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_10282
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTI15_10281
L_EXTI15_10282:
;P7_final_project_main.c,93 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,95 :: 		switch (g_cur_game_phase)
IT	AL
BAL	L_EXTI15_10283
;P7_final_project_main.c,97 :: 		case PHASE_LOGO:
L_EXTI15_10285:
;P7_final_project_main.c,98 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,99 :: 		g_cur_game_phase = PHASE_INTRO; // load_duck
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,100 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,102 :: 		case PHASE_INTRO:
L_EXTI15_10286:
;P7_final_project_main.c,103 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,104 :: 		g_cur_game_phase = PHASE1_READY; // load_snake_game
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,105 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,107 :: 		case PHASE1_READY:
L_EXTI15_10287:
;P7_final_project_main.c,108 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,109 :: 		g_cur_game_phase = PHASE2_PLAYING;    // Start snake game
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,110 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,112 :: 		case PHASE2_PLAYING:
L_EXTI15_10288:
;P7_final_project_main.c,113 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_EXTI15_10289:
SUBS	R7, R7, #1
BNE	L_EXTI15_10289
NOP
NOP
NOP
;P7_final_project_main.c,117 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,119 :: 		case PHASE_QUIT:
L_EXTI15_10291:
;P7_final_project_main.c,120 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,121 :: 		g_cur_game_phase = PHASE_HSCORE;
MOVS	R1, #4
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,122 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,124 :: 		case PHASE_HSCORE:
L_EXTI15_10292:
;P7_final_project_main.c,126 :: 		refresh_hs_scr(JBTN_DOWN);
MOVS	R0, #4
BL	_refresh_hs_scr+0
;P7_final_project_main.c,127 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,129 :: 		case PHASE_PRINT_TOP_TEN:
L_EXTI15_10293:
;P7_final_project_main.c,130 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,131 :: 		g_cur_game_phase = PHASE1_READY; // PHASE1_ready? seems to cause problems
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,132 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,141 :: 		default:
L_EXTI15_10294:
;P7_final_project_main.c,142 :: 		break;
IT	AL
BAL	L_EXTI15_10284
;P7_final_project_main.c,143 :: 		}
L_EXTI15_10283:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #15
IT	EQ
BEQ	L_EXTI15_10285
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTI15_10286
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTI15_10287
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTI15_10288
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_EXTI15_10291
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_EXTI15_10292
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_EXTI15_10293
IT	AL
BAL	L_EXTI15_10294
L_EXTI15_10284:
;P7_final_project_main.c,144 :: 		}
L_end_EXTI15_10:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10
_EXTIPA0:
;P7_final_project_main.c,148 :: 		void EXTIPA0() iv IVT_INT_EXTI0  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,149 :: 		EXTI_PR |= 1 << 2;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,151 :: 		while (GPIOA_IDR.B0 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPA0295:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA0296
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA0295
L_EXTIPA0296:
;P7_final_project_main.c,152 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,154 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
CMP	R0, #2
IT	NE
BNE	L_EXTIPA0297
;P7_final_project_main.c,155 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,156 :: 		game_cur_screen_run_flag = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,157 :: 		g_cur_game_phase = PHASE_QUIT;
MOVS	R1, #3
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,161 :: 		TIM3_CR1 = 0; // Start TIMER3 now
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,162 :: 		}
IT	AL
BAL	L_EXTIPA0298
L_EXTIPA0297:
;P7_final_project_main.c,163 :: 		else if (g_cur_game_phase == PHASE_QUIT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_EXTIPA0299
;P7_final_project_main.c,164 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,165 :: 		g_cur_game_phase = PHASE_HSCORE;
MOVS	R1, #4
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,166 :: 		}
L_EXTIPA0299:
L_EXTIPA0298:
;P7_final_project_main.c,169 :: 		}
L_end_EXTIPA0:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPA0
_EXTIPA6:
;P7_final_project_main.c,172 :: 		void EXTIPA6() iv IVT_INT_EXTI9_5  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,173 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,176 :: 		if (GPIOB_IDR.B5 == 0) {
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6300
;P7_final_project_main.c,177 :: 		while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
L_EXTIPA6301:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6302
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6301
L_EXTIPA6302:
;P7_final_project_main.c,178 :: 		EXTI_PR |= 1 << 5;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,180 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_EXTIPA6303
;P7_final_project_main.c,181 :: 		if (g_curr_snake_dir != MOVE_UP) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTIPA6304
;P7_final_project_main.c,182 :: 		set_curr_snake_dir(MOVE_DOWN);
MOVS	R0, #3
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,183 :: 		}
L_EXTIPA6304:
;P7_final_project_main.c,184 :: 		} else if (g_cur_game_phase == PHASE_HSCORE) {
IT	AL
BAL	L_EXTIPA6305
L_EXTIPA6303:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_EXTIPA6306
;P7_final_project_main.c,185 :: 		refresh_hs_scr(MOVE_DOWN);
MOVS	R0, #3
BL	_refresh_hs_scr+0
;P7_final_project_main.c,186 :: 		}
L_EXTIPA6306:
L_EXTIPA6305:
;P7_final_project_main.c,187 :: 		}
L_EXTIPA6300:
;P7_final_project_main.c,190 :: 		if (GPIOA_IDR.B6 == 0) {
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6307
;P7_final_project_main.c,191 :: 		while(GPIOA_IDR.B6 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
L_EXTIPA6308:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6309
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6308
L_EXTIPA6309:
;P7_final_project_main.c,192 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,194 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
CMP	R0, #2
IT	NE
BNE	L_EXTIPA6310
;P7_final_project_main.c,196 :: 		EXTI_PR |= 1 << 6;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,197 :: 		while (GPIOA_IDR.B6 == 0) {
L_EXTIPA6311:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6312
;P7_final_project_main.c,198 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,199 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_EXTIPA6313:
SUBS	R7, R7, #1
BNE	L_EXTIPA6313
NOP
NOP
NOP
;P7_final_project_main.c,200 :: 		}
IT	AL
BAL	L_EXTIPA6311
L_EXTIPA6312:
;P7_final_project_main.c,201 :: 		if (g_curr_snake_dir != MOVE_LEFT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTIPA6315
;P7_final_project_main.c,202 :: 		set_curr_snake_dir(MOVE_RIGHT);
MOVS	R0, #0
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,203 :: 		}
L_EXTIPA6315:
;P7_final_project_main.c,204 :: 		}
L_EXTIPA6310:
;P7_final_project_main.c,205 :: 		}
L_EXTIPA6307:
;P7_final_project_main.c,208 :: 		}
L_end_EXTIPA6:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPA6
_EXTIPD2:
;P7_final_project_main.c,213 :: 		void EXTIPD2() iv IVT_INT_EXTI2  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,214 :: 		EXTI_PR |= 1 << 2;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,215 :: 		while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD2316:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD2317
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD2316
L_EXTIPD2317:
;P7_final_project_main.c,216 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,218 :: 		if (g_cur_game_phase == PHASE1_READY && dev_position == 1) {
CMP	R0, #1
IT	NE
BNE	L__EXTIPD2386
MOVW	R0, #lo_addr(_dev_position+0)
MOVT	R0, #hi_addr(_dev_position+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__EXTIPD2385
L__EXTIPD2384:
;P7_final_project_main.c,219 :: 		dev_position++;
MOVW	R1, #lo_addr(_dev_position+0)
MOVT	R1, #hi_addr(_dev_position+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
;P7_final_project_main.c,220 :: 		}else if (g_cur_game_phase == PHASE1_READY && dev_position == 2) {
IT	AL
BAL	L_EXTIPD2321
;P7_final_project_main.c,218 :: 		if (g_cur_game_phase == PHASE1_READY && dev_position == 1) {
L__EXTIPD2386:
L__EXTIPD2385:
;P7_final_project_main.c,220 :: 		}else if (g_cur_game_phase == PHASE1_READY && dev_position == 2) {
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__EXTIPD2388
MOVW	R0, #lo_addr(_dev_position+0)
MOVT	R0, #hi_addr(_dev_position+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L__EXTIPD2387
L__EXTIPD2383:
;P7_final_project_main.c,221 :: 		TFT_Write_Text("DEV MODE ENABLED!", 7*PX_BLOCK, 3*PX_BLOCK);
MOVW	R0, #lo_addr(?lstr29_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr29_P7_final_project_main+0)
MOVW	R2, #48
MOVW	R1, #112
BL	_TFT_Write_Text+0
;P7_final_project_main.c,222 :: 		set_secret_mode(); // set developer mode
BL	_set_secret_mode+0
;P7_final_project_main.c,220 :: 		}else if (g_cur_game_phase == PHASE1_READY && dev_position == 2) {
L__EXTIPD2388:
L__EXTIPD2387:
;P7_final_project_main.c,223 :: 		}
L_EXTIPD2321:
;P7_final_project_main.c,225 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_EXTIPD2325
;P7_final_project_main.c,226 :: 		if (g_curr_snake_dir != MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTIPD2326
;P7_final_project_main.c,227 :: 		set_curr_snake_dir(MOVE_LEFT);
MOVS	R0, #1
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,228 :: 		}
L_EXTIPD2326:
;P7_final_project_main.c,229 :: 		}
L_EXTIPD2325:
;P7_final_project_main.c,232 :: 		}
L_end_EXTIPD2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD2
_EXTIPD4:
;P7_final_project_main.c,237 :: 		void EXTIPD4() iv IVT_INT_EXTI4  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,238 :: 		EXTI_PR |= 1 << 4;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,239 :: 		while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD4327:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD4328
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD4327
L_EXTIPD4328:
;P7_final_project_main.c,240 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,242 :: 		if (g_cur_game_phase == PHASE1_READY && dev_position == 0) {
CMP	R0, #1
IT	NE
BNE	L__EXTIPD4391
MOVW	R0, #lo_addr(_dev_position+0)
MOVT	R0, #hi_addr(_dev_position+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__EXTIPD4390
L__EXTIPD4389:
;P7_final_project_main.c,243 :: 		dev_position++;
MOVW	R1, #lo_addr(_dev_position+0)
MOVT	R1, #hi_addr(_dev_position+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
;P7_final_project_main.c,242 :: 		if (g_cur_game_phase == PHASE1_READY && dev_position == 0) {
L__EXTIPD4391:
L__EXTIPD4390:
;P7_final_project_main.c,246 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_EXTIPD4332
;P7_final_project_main.c,248 :: 		if (g_curr_snake_dir != MOVE_DOWN) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_EXTIPD4333
;P7_final_project_main.c,249 :: 		set_curr_snake_dir(MOVE_UP);
MOVS	R0, #2
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,250 :: 		}
L_EXTIPD4333:
;P7_final_project_main.c,251 :: 		} else if (g_cur_game_phase == PHASE_HSCORE) {
IT	AL
BAL	L_EXTIPD4334
L_EXTIPD4332:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_EXTIPD4335
;P7_final_project_main.c,252 :: 		refresh_hs_scr(MOVE_UP);
MOVS	R0, #2
BL	_refresh_hs_scr+0
;P7_final_project_main.c,253 :: 		}
L_EXTIPD4335:
L_EXTIPD4334:
;P7_final_project_main.c,254 :: 		}
L_end_EXTIPD4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD4
_TIMER2_ISR:
;P7_final_project_main.c,257 :: 		void TIMER2_ISR() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,258 :: 		TIM2_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,259 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,261 :: 		update_game_time();
BL	_update_game_time+0
;P7_final_project_main.c,263 :: 		if (g_GAME_PHASE == PHASE2_PLAYING) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_TIMER2_ISR336
;P7_final_project_main.c,266 :: 		update_session_time();
BL	_update_session_time+0
;P7_final_project_main.c,269 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;P7_final_project_main.c,270 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_TIMER2_ISR337:
SUBS	R7, R7, #1
BNE	L_TIMER2_ISR337
NOP
NOP
NOP
;P7_final_project_main.c,274 :: 		update_time();
BL	_update_time+0
;P7_final_project_main.c,277 :: 		update_stats();
BL	_update_stats+0
;P7_final_project_main.c,284 :: 		if (adc_val != ADC1_Read(3)) {
MOVS	R0, #3
BL	_ADC1_Read+0
MOVW	R1, #lo_addr(_adc_val+0)
MOVT	R1, #hi_addr(_adc_val+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	EQ
BEQ	L_TIMER2_ISR339
;P7_final_project_main.c,285 :: 		adc_val = ADC1_Read(3);
MOVS	R0, #3
BL	_ADC1_Read+0
MOVW	R2, #lo_addr(_adc_val+0)
MOVT	R2, #hi_addr(_adc_val+0)
STR	R0, [R2, #0]
;P7_final_project_main.c,286 :: 		adc_val = adc_val/ 215;  // 9000/500 = 18 @ 500ticks  steps so (3883-6)/18 215
MOV	R0, R2
LDR	R1, [R0, #0]
MOVS	R0, #215
UDIV	R0, R1, R0
STR	R0, [R2, #0]
;P7_final_project_main.c,289 :: 		update_game_speed(adc_val);
BL	_update_game_speed+0
;P7_final_project_main.c,291 :: 		if (adc_val <= 0 ) {
MOVW	R0, #lo_addr(_adc_val+0)
MOVT	R0, #hi_addr(_adc_val+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	HI
BHI	L_TIMER2_ISR340
;P7_final_project_main.c,292 :: 		TIM3_ARR = 500;
MOVW	R1, #500
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,293 :: 		} else {
IT	AL
BAL	L_TIMER2_ISR341
L_TIMER2_ISR340:
;P7_final_project_main.c,294 :: 		TIM3_ARR =  (adc_val * 500);
MOVW	R0, #lo_addr(_adc_val+0)
MOVT	R0, #hi_addr(_adc_val+0)
LDR	R1, [R0, #0]
MOVW	R0, #500
MULS	R1, R0, R1
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,295 :: 		}
L_TIMER2_ISR341:
;P7_final_project_main.c,296 :: 		TIM3_CNT = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CNT+0)
MOVT	R0, #hi_addr(TIM3_CNT+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,297 :: 		}
L_TIMER2_ISR339:
;P7_final_project_main.c,302 :: 		}
L_TIMER2_ISR336:
;P7_final_project_main.c,303 :: 		}
L_end_TIMER2_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER2_ISR
_TIMER3_ISR:
;P7_final_project_main.c,306 :: 		void TIMER3_ISR() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,307 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,308 :: 		TIM3_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,310 :: 		toggle_game_clock_delay();
BL	_toggle_game_clock_delay+0
;P7_final_project_main.c,317 :: 		screen_refresh_TIM3();
BL	_screen_refresh_TIM3+0
;P7_final_project_main.c,318 :: 		}
L_end_TIMER3_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER3_ISR
_init_cfg_M_CTL:
;P7_final_project_main.c,328 :: 		void init_cfg_M_CTL() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,331 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,333 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,334 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,336 :: 		RCC_APB2ENR |= 1 << 2;                    // Enable GPIO clock for PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,337 :: 		RCC_APB2ENR |= 1 << 3;                    // Enable GPIO clock for PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,338 :: 		RCC_APB2ENR |= 1 << 4;                    // Enable GPIO clock for PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,339 :: 		RCC_APB2ENR |= 1 << 5;                    // Enable GPIO clock for PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,340 :: 		RCC_APB2ENR |= 1 << 6;                    // Enable GPIO clock for PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,341 :: 		RCC_APB2ENR |= 1 << 14;                   // Enable GPIO clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,342 :: 		RCC_APB2ENR |= 1 << 9;                   // Enable ADC1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #512
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,344 :: 		RCC_APB1ENR |= (uint32_t) 1 << 21;          // Enable I2C1 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2097152
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,347 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_14); // added here to enabed PE14 for piezo buzzer
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;P7_final_project_main.c,348 :: 		GPIOE_CRH &= (long int) ~(0xF << 24);
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R0, [R0, #0]
AND	R1, R0, #-1
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,349 :: 		GPIOE_CRH &= (uint32_t) ~(0xC <<  24) ;                    // PE14 output for Piezo buzzer 0xc inverse of 0x3
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R0, [R0, #0]
AND	R1, R0, #-1
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,351 :: 		GPIOA_CRL &= ~(0xF << 12);                 // PA3 - Analog input mode b0000 bit[15:12]
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MVN	R0, #61440
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,354 :: 		GPIOA_CRL |= 4 << 0;                       // Enable PA0;  Quit button
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,355 :: 		GPIOC_CRL |= 4 << 4;                       // Enable PB0;  Extra button
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,357 :: 		GPIOA_CRL |= 4 << 4;                       // Enable PA4;  Game TIMER3 control
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,358 :: 		GPIOA_CRL |= 4 << 6;                       // Enable PA6;  joystick=RIGHT
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,359 :: 		GPIOB_CRL |= 4 << 5;                       // Enable PB5;  joystick=DOWN
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,360 :: 		GPIOD_CRL |= 4 << 2;                       // Enable PD2;  joystick=LEFT
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,361 :: 		GPIOD_CRL |= 4 << 4;                       // Enable PD4;  joystick=UP
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,362 :: 		GPIOC_CRH |= 4 << 5;                       // Enable PC13; joystick=PUSH BUTTON
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,396 :: 		}
L_end_init_cfg_M_CTL:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_cfg_M_CTL
_config_USART1:
;P7_final_project_main.c,399 :: 		void config_USART1() {
SUB	SP, SP, #4
;P7_final_project_main.c,400 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,401 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,402 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,405 :: 		USART1_BRR = 0x00000506;                    // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,409 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,411 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,412 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,413 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,414 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,416 :: 		USART1_CR1 |=   1 << 3;                     // Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,417 :: 		USART1_CR1 |=   1 << 2;                     // Rx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,419 :: 		Delay_ms(100);                              // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_config_USART1342:
SUBS	R7, R7, #1
BNE	L_config_USART1342
NOP
NOP
NOP
;P7_final_project_main.c,420 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,423 :: 		}
L_end_config_USART1:
ADD	SP, SP, #4
BX	LR
; end of _config_USART1
_init_timer2:
;P7_final_project_main.c,429 :: 		void init_timer2() {
SUB	SP, SP, #4
;P7_final_project_main.c,430 :: 		RCC_APB1ENR |= 1 << 0;                      // Enable Clock for TIMER2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,431 :: 		TIM2_CR1     = 0x0000;                      // Disable the timer for config setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,432 :: 		TIM2_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,434 :: 		TIM2_ARR     = 9000;                        // Set the auto-reload register to calclated value
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,435 :: 		TIM2_DIER   |= 1 << 0;                      // Enable TIMER2 Interrupt
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,437 :: 		}
L_end_init_timer2:
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_timer3:
;P7_final_project_main.c,441 :: 		void init_timer3() {
SUB	SP, SP, #4
;P7_final_project_main.c,442 :: 		RCC_APB1ENR |= (1 << 1);                    // Enable TIMER3 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,443 :: 		TIM3_CR1     = 0x0000;                      // Disable time for setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,444 :: 		TIM3_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,446 :: 		TIM3_ARR     = g_game_speed;                // auto-reload reg. 2 seconds so  double it = 9000*2 = 18000
MOVW	R0, #lo_addr(P7_final_project_main_g_game_speed+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_speed+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,447 :: 		TIM3_DIER   |= 1 << 0;                      // Enable interrupt
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,450 :: 		}
L_end_init_timer3:
ADD	SP, SP, #4
BX	LR
; end of _init_timer3
_init_interrupt:
;P7_final_project_main.c,454 :: 		void init_interrupt() {
SUB	SP, SP, #4
;P7_final_project_main.c,457 :: 		AFIO_EXTICR2 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,458 :: 		NVIC_ISER0   = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,462 :: 		AFIO_EXTICR1 &= ~(0xF << 0);                // PD2 = EXTI0[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,463 :: 		AFIO_EXTICR1 |= 3 << 8;                     // PD2 = EXTI2[11:8]; PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,464 :: 		AFIO_EXTICR2 |= 3 << 0;                     // PD4 = EXTI4[3:0];  PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,465 :: 		AFIO_EXTICR2 |= 1 << 4;                     // PB5 = EXTI5[7:4];  PortB = b0001;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,466 :: 		AFIO_EXTICR2 &= ~(0xF << 8);                // PA6 = EXTI6[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MVN	R0, #3840
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,467 :: 		AFIO_EXTICR4 |= 2 << 4;                     // PC13  EXTI13[7:4]; PortC = b0010;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,471 :: 		EXTI_FTSR |= 1 << 2;                        // EXTI2 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,472 :: 		EXTI_FTSR |= 1 << 4;                        // EXTI4 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,473 :: 		EXTI_FTSR |= 1 << 5;                        // EXTI5 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,474 :: 		EXTI_FTSR |= 1 << 6;                        // EXTI6 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,475 :: 		EXTI_FTSR |= 1 << 13;                       // EXTI13 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,476 :: 		EXTI_RTSR |= 1 << 0;                        // EXIT0 is RISING Edge
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,477 :: 		EXTI_IMR  |= 0x00002075;                    // Set EXTI 0,2,4,5,6,13 to not-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R1, [R0, #0]
MOVW	R0, #8309
ORRS	R1, R0
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,482 :: 		NVIC_ISER0 |= (uint32_t) 1 << 6;            // EXTI0  NVIC Pos=6:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,483 :: 		NVIC_ISER0 |= (uint32_t) 1 << 8;            // EXTI2  NVIC Pos=8:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,484 :: 		NVIC_ISER0 |= (uint32_t) 1 << 10;           // EXTI4  NVIC Pos=10:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,485 :: 		NVIC_ISER0 |= (uint32_t) 1 << 23;           // EXTI5  NVIC Pos=23: EXTI9_5
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,486 :: 		NVIC_ISER0 |= (uint32_t) 1 << 28;           // TIMER2  NVIC Pos=28
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #268435456
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,487 :: 		NVIC_ISER0 |= (uint32_t) 1 << 29;           // TIMER3  NVIC Pos=29
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #536870912
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,488 :: 		NVIC_ISER1 |= (uint32_t) 1 << 8;            // EXTI13 NVIC Pos=40: EXTI15_10
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,489 :: 		NVIC_ISER1 |= (uint32_t) 1 << 5;            // USART1 NVIC Pos=37: ISER1[63:32]; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,500 :: 		}
L_end_init_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _init_interrupt
_main:
;P7_final_project_main.c,505 :: 		void main() {
SUB	SP, SP, #4
;P7_final_project_main.c,509 :: 		int num =0;
;P7_final_project_main.c,512 :: 		init_cfg_M_CTL();
BL	_init_cfg_M_CTL+0
;P7_final_project_main.c,515 :: 		config_USART1();
BL	_config_USART1+0
;P7_final_project_main.c,520 :: 		init_timer2();
BL	_init_timer2+0
;P7_final_project_main.c,521 :: 		init_timer3();
BL	_init_timer3+0
;P7_final_project_main.c,525 :: 		init_interrupt();
BL	_init_interrupt+0
;P7_final_project_main.c,541 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,554 :: 		load_duck_screen();
BL	_load_duck_screen+0
;P7_final_project_main.c,557 :: 		load_intro_screen();
BL	_load_intro_screen+0
;P7_final_project_main.c,571 :: 		while (1) {
L_main344:
;P7_final_project_main.c,573 :: 		dev_position = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_dev_position+0)
MOVT	R0, #hi_addr(_dev_position+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,574 :: 		load_snake_game();
BL	_load_snake_game+0
;P7_final_project_main.c,578 :: 		init_snake_game();
BL	_init_snake_game+0
;P7_final_project_main.c,579 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;P7_final_project_main.c,580 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_main346:
SUBS	R7, R7, #1
BNE	L_main346
NOP
NOP
NOP
;P7_final_project_main.c,583 :: 		update_time();
BL	_update_time+0
;P7_final_project_main.c,586 :: 		update_stats();
BL	_update_stats+0
;P7_final_project_main.c,588 :: 		TIM2_CR1     = 0x0001; // Start TIMER2 for game time
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,589 :: 		TIM3_CR1    = 0x0001; // Start TIMER3 now
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,590 :: 		start_snake_game();
BL	_start_snake_game+0
;P7_final_project_main.c,591 :: 		g_GAME_PHASE = PHASE_QUIT;
MOVS	R1, #3
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,592 :: 		set_game_phase (PHASE_QUIT);
MOVS	R0, #3
BL	_set_game_phase+0
;P7_final_project_main.c,594 :: 		game_over_scr();
BL	_game_over_scr+0
;P7_final_project_main.c,595 :: 		game_high_score_scr();
BL	_game_high_score_scr+0
;P7_final_project_main.c,596 :: 		print_top_score_list();
BL	_print_top_score_list+0
;P7_final_project_main.c,598 :: 		}
IT	AL
BAL	L_main344
;P7_final_project_main.c,599 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
