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
BLE	L__convert_lin_xy309
; temp_val end address is: 16 (R4)
;cp_pix_render.h,107 :: 		temp_val = 300;
; temp_val start address is: 12 (R3)
MOVW	R3, #300
; temp_val end address is: 12 (R3)
;cp_pix_render.h,108 :: 		}
IT	AL
BAL	L_convert_lin_xy18
L__convert_lin_xy309:
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
BLE	L__convert_lin_xy310
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
L__convert_lin_xy310:
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
BGT	L__convert_lin_xy311
; row end address is: 20 (R5)
;cp_pix_render.h,126 :: 		row = 1;
; row start address is: 12 (R3)
MOVS	R3, #1
; row end address is: 12 (R3)
;cp_pix_render.h,127 :: 		}
IT	AL
BAL	L_convert_lin_xy22
L__convert_lin_xy311:
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
_load_intro_screen_simple:
;cp_intro_screen_ctl.h,51 :: 		void load_intro_screen_simple() {
SUB	SP, SP, #16
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,54 :: 		uint8_t scroll_dir = 5; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,55 :: 		uint32_t volatile x_axis = 55;
;cp_intro_screen_ctl.h,56 :: 		uint32_t volatile y_axis = 115;
;cp_intro_screen_ctl.h,58 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,59 :: 		uint32_t  prev_val2 = 0;
;cp_intro_screen_ctl.h,64 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,66 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen_simple44:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple45
;cp_intro_screen_ctl.h,69 :: 		draw_rectangle(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_rectangle+0
;cp_intro_screen_ctl.h,71 :: 		if (scroll_dir == 1 ) {
LDRB	R0, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple46
;cp_intro_screen_ctl.h,72 :: 		if (y_axis > (SCREEN_Y_MAX-20) || x_axis > (SCREEN_X_MAX -30) ) {
LDR	R0, [SP, #12]
CMP	R0, #220
IT	HI
BHI	L__load_intro_screen_simple315
LDR	R0, [SP, #8]
CMP	R0, #290
IT	HI
BHI	L__load_intro_screen_simple314
IT	AL
BAL	L_load_intro_screen_simple49
L__load_intro_screen_simple315:
L__load_intro_screen_simple314:
;cp_intro_screen_ctl.h,73 :: 		scroll_dir = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,74 :: 		}
L_load_intro_screen_simple49:
;cp_intro_screen_ctl.h,75 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,76 :: 		y_axis+=SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,78 :: 		}
IT	AL
BAL	L_load_intro_screen_simple50
L_load_intro_screen_simple46:
;cp_intro_screen_ctl.h,81 :: 		if (y_axis < 10 || x_axis < 2) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen_simple317
LDR	R0, [SP, #8]
CMP	R0, #2
IT	CC
BCC	L__load_intro_screen_simple316
IT	AL
BAL	L_load_intro_screen_simple53
L__load_intro_screen_simple317:
L__load_intro_screen_simple316:
;cp_intro_screen_ctl.h,82 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,83 :: 		}
L_load_intro_screen_simple53:
;cp_intro_screen_ctl.h,84 :: 		x_axis-=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
SUBS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,85 :: 		y_axis-=SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,86 :: 		}
L_load_intro_screen_simple50:
;cp_intro_screen_ctl.h,87 :: 		draw_intro_screen(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_intro_screen+0
;cp_intro_screen_ctl.h,89 :: 		}
IT	AL
BAL	L_load_intro_screen_simple44
L_load_intro_screen_simple45:
;cp_intro_screen_ctl.h,90 :: 		}
L_end_load_intro_screen_simple:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _load_intro_screen_simple
_load_intro_screen:
;cp_intro_screen_ctl.h,94 :: 		void load_intro_screen() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,96 :: 		uint8_t rotation = 0;
ADD	R11, SP, #8
ADD	R10, R11, #8
MOVW	R12, #lo_addr(?ICSload_intro_screen_rotation_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_rotation_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,97 :: 		uint8_t scroll_dir = 1; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
;cp_intro_screen_ctl.h,98 :: 		uint32_t volatile x_axis = 35;
;cp_intro_screen_ctl.h,99 :: 		uint32_t volatile y_axis = 115;
; y_axis start address is: 4 (R1)
MOV	R1, #115
;cp_intro_screen_ctl.h,101 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,102 :: 		uint32_t  prev_val2 = 5;
;cp_intro_screen_ctl.h,103 :: 		uint32_t counter = 1;
MOV	R0, #1
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,110 :: 		TFT_Fill_Screen(CL_BLACK);
STR	R1, [SP, #4]
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,112 :: 		draw_info_text( 10,220);
MOVS	R1, #220
MOVS	R0, #10
BL	_draw_info_text+0
; y_axis end address is: 4 (R1)
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,115 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen54:
; y_axis start address is: 4 (R1)
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen55
;cp_intro_screen_ctl.h,118 :: 		draw_rectangle(x_axis, y_axis);
STR	R1, [SP, #4]
LDR	R0, [SP, #12]
BL	_draw_rectangle+0
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,121 :: 		if (scroll_dir == 1){
LDRB	R0, [SP, #9]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen56
;cp_intro_screen_ctl.h,122 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,123 :: 		y_axis+=SCROLL_SPEED;
ADDS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,126 :: 		if ( x_axis > (SCREEN_X_MAX -200) || y_axis > (SCREEN_Y_MAX-42) ) {
LDR	R0, [SP, #12]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen323
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen322
IT	AL
BAL	L_load_intro_screen59
L__load_intro_screen323:
L__load_intro_screen322:
;cp_intro_screen_ctl.h,127 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen60
;cp_intro_screen_ctl.h,128 :: 		scroll_dir = 2;
MOVS	R0, #2
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,129 :: 		}
IT	AL
BAL	L_load_intro_screen61
L_load_intro_screen60:
;cp_intro_screen_ctl.h,131 :: 		scroll_dir = 4;
MOVS	R0, #4
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,132 :: 		}
L_load_intro_screen61:
;cp_intro_screen_ctl.h,133 :: 		}
L_load_intro_screen59:
;cp_intro_screen_ctl.h,135 :: 		}
MOV	R1, R4
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen62
L_load_intro_screen56:
;cp_intro_screen_ctl.h,137 :: 		else if (scroll_dir == 2) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #2
IT	NE
BNE	L_load_intro_screen63
;cp_intro_screen_ctl.h,138 :: 		x_axis += X_SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,139 :: 		y_axis -= SCROLL_SPEED;
SUBS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,142 :: 		if (x_axis > (SCREEN_X_MAX -200) || y_axis <10   ) {
LDR	R0, [SP, #12]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen325
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen324
IT	AL
BAL	L_load_intro_screen66
L__load_intro_screen325:
L__load_intro_screen324:
;cp_intro_screen_ctl.h,143 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen67
;cp_intro_screen_ctl.h,144 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,145 :: 		}
IT	AL
BAL	L_load_intro_screen68
L_load_intro_screen67:
;cp_intro_screen_ctl.h,147 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,148 :: 		}
L_load_intro_screen68:
;cp_intro_screen_ctl.h,149 :: 		}
L_load_intro_screen66:
;cp_intro_screen_ctl.h,150 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen69
L_load_intro_screen63:
;cp_intro_screen_ctl.h,153 :: 		else if (scroll_dir == 3) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #3
IT	NE
BNE	L_load_intro_screen70
;cp_intro_screen_ctl.h,154 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,155 :: 		y_axis -= SCROLL_SPEED;
SUBS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,158 :: 		if ( x_axis < 10 || y_axis < 10 ) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen327
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen326
IT	AL
BAL	L_load_intro_screen73
L__load_intro_screen327:
L__load_intro_screen326:
;cp_intro_screen_ctl.h,160 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen74
;cp_intro_screen_ctl.h,161 :: 		scroll_dir = 4; //4
MOVS	R0, #4
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,162 :: 		}
IT	AL
BAL	L_load_intro_screen75
L_load_intro_screen74:
;cp_intro_screen_ctl.h,164 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,165 :: 		}
L_load_intro_screen75:
;cp_intro_screen_ctl.h,166 :: 		}
L_load_intro_screen73:
;cp_intro_screen_ctl.h,168 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen76
L_load_intro_screen70:
;cp_intro_screen_ctl.h,170 :: 		else if (scroll_dir == 4) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #4
IT	NE
BNE	L__load_intro_screen330
;cp_intro_screen_ctl.h,171 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,172 :: 		y_axis += SCROLL_SPEED;
ADDS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,175 :: 		if ( x_axis < 10 || y_axis > (SCREEN_Y_MAX-42)) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen329
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen328
IT	AL
BAL	L_load_intro_screen80
L__load_intro_screen329:
L__load_intro_screen328:
;cp_intro_screen_ctl.h,177 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen81
;cp_intro_screen_ctl.h,178 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,179 :: 		} else {
IT	AL
BAL	L_load_intro_screen82
L_load_intro_screen81:
;cp_intro_screen_ctl.h,180 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,182 :: 		}
L_load_intro_screen82:
;cp_intro_screen_ctl.h,189 :: 		}
L_load_intro_screen80:
;cp_intro_screen_ctl.h,190 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen77
L__load_intro_screen330:
;cp_intro_screen_ctl.h,170 :: 		else if (scroll_dir == 4) {
MOV	R4, R1
;cp_intro_screen_ctl.h,190 :: 		}
L_load_intro_screen77:
; y_axis start address is: 16 (R4)
; y_axis end address is: 16 (R4)
L_load_intro_screen76:
; y_axis start address is: 16 (R4)
; y_axis end address is: 16 (R4)
L_load_intro_screen69:
; y_axis start address is: 16 (R4)
MOV	R1, R4
; y_axis end address is: 16 (R4)
L_load_intro_screen62:
;cp_intro_screen_ctl.h,192 :: 		counter++;
; y_axis start address is: 4 (R1)
LDR	R0, [SP, #16]
ADDS	R0, R0, #1
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,193 :: 		if (counter == 5) {
CMP	R0, #5
IT	NE
BNE	L_load_intro_screen83
;cp_intro_screen_ctl.h,194 :: 		rotation = ~rotation; // change direction
LDRB	R0, [SP, #8]
MVN	R0, R0
STRB	R0, [SP, #8]
;cp_intro_screen_ctl.h,195 :: 		counter = 0;
MOVS	R0, #0
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,196 :: 		}
L_load_intro_screen83:
;cp_intro_screen_ctl.h,198 :: 		draw_intro_screen(x_axis, y_axis);
STR	R1, [SP, #4]
LDR	R0, [SP, #12]
BL	_draw_intro_screen+0
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,200 :: 		}
; y_axis end address is: 4 (R1)
IT	AL
BAL	L_load_intro_screen54
L_load_intro_screen55:
;cp_intro_screen_ctl.h,201 :: 		}
L_end_load_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _load_intro_screen
_draw_info_text:
;cp_intro_screen_ctl.h,205 :: 		void draw_info_text(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,206 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,207 :: 		TFT_Write_Text(&intro_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_intro_msg+0)
MOVT	R0, #hi_addr(_intro_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,208 :: 		}
L_end_draw_info_text:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_info_text
_draw_rectangle:
;cp_intro_screen_ctl.h,210 :: 		void draw_rectangle(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,212 :: 		TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
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
;cp_intro_screen_ctl.h,213 :: 		TFT_Rectangle(x_axis, y_axis, x_axis+255, y_axis+15);   // 15 is miny to hide text
ADD	R3, R8, #15
ADDW	R2, R7, #255
SXTH	R3, R3
SXTH	R2, R2
SXTH	R1, R8
; y_axis end address is: 32 (R8)
SXTH	R0, R7
; x_axis end address is: 28 (R7)
BL	_TFT_Rectangle+0
;cp_intro_screen_ctl.h,216 :: 		}
L_end_draw_rectangle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_rectangle
_draw_intro_screen:
;cp_intro_screen_ctl.h,220 :: 		void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,225 :: 		TFT_Set_Font(TFT_defaultFont, CL_YELLOW, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65504
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,228 :: 		TFT_Write_Text(&pub_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_pub_msg+0)
MOVT	R0, #hi_addr(_pub_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,232 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_draw_intro_screen84:
SUBS	R7, R7, #1
BNE	L_draw_intro_screen84
NOP
NOP
NOP
;cp_intro_screen_ctl.h,234 :: 		}
L_end_draw_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_intro_screen
_load_duck_screen:
;cp_intro_screen_ctl.h,240 :: 		void load_duck_screen() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,241 :: 		uint32_t x_axis = 0;
;cp_intro_screen_ctl.h,242 :: 		uint32_t y_axis = 0;
;cp_intro_screen_ctl.h,243 :: 		uint32_t PX_BLOCK = 16;
;cp_intro_screen_ctl.h,244 :: 		uint32_t i=0;
;cp_intro_screen_ctl.h,246 :: 		uint32_t value = 0;
;cp_intro_screen_ctl.h,250 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_intro_screen_ctl.h,254 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_intro_screen_ctl.h,258 :: 		TFT_Fill_Screen(CL_NAVY);
MOVW	R0, #16
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,260 :: 		TFT_SET_PEN(m_BLACK, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_TFT_Set_Pen+0
;cp_intro_screen_ctl.h,261 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_intro_screen_ctl.h,265 :: 		duck_sprite();
BL	_duck_sprite+0
;cp_intro_screen_ctl.h,270 :: 		for (i=0; i< 20; i++) {
MOVS	R0, #0
STR	R0, [SP, #4]
L_load_duck_screen86:
LDR	R0, [SP, #4]
CMP	R0, #20
IT	CS
BCS	L_load_duck_screen87
;cp_intro_screen_ctl.h,276 :: 		cleaning_buffer(m_NAVY);
MOVS	R0, #3
BL	_cleaning_buffer+0
;cp_intro_screen_ctl.h,279 :: 		set_sprite_offset(i, 6);
MOVS	R1, #6
LDR	R0, [SP, #4]
BL	_set_sprite_offset+0
;cp_intro_screen_ctl.h,280 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_intro_screen_ctl.h,270 :: 		for (i=0; i< 20; i++) {
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
STR	R0, [SP, #4]
;cp_intro_screen_ctl.h,281 :: 		}
IT	AL
BAL	L_load_duck_screen86
L_load_duck_screen87:
;cp_intro_screen_ctl.h,285 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_duck_screen89:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_duck_screen90
IT	AL
BAL	L_load_duck_screen89
L_load_duck_screen90:
;cp_intro_screen_ctl.h,288 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_intro_screen_ctl.h,290 :: 		}
L_end_load_duck_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _load_duck_screen
_duck_sprite:
;cp_intro_screen_ctl.h,297 :: 		void duck_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,307 :: 		load_cell_xy(8,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,308 :: 		load_cell_xy(9,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,309 :: 		load_cell_xy(10,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,312 :: 		load_cell_xy(2,2,m_YELLOW); //face
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,313 :: 		load_cell_xy(3,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,314 :: 		load_cell_xy(7,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,315 :: 		load_cell_xy(8,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,320 :: 		load_cell_xy(7,1, m_BLACK); // Sunglasses
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,321 :: 		load_cell_xy(8,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,322 :: 		load_cell_xy(9,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,323 :: 		load_cell_xy(10,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,324 :: 		load_cell_xy(11,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,325 :: 		load_cell_xy(9,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,326 :: 		load_cell_xy(10,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,331 :: 		load_cell_xy(11,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,332 :: 		load_cell_xy(12,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,333 :: 		load_cell_xy(13,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #13
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,334 :: 		load_cell_xy(11,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,335 :: 		load_cell_xy(12,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,338 :: 		load_cell_xy(1,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,339 :: 		load_cell_xy(2,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,340 :: 		load_cell_xy(3,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,341 :: 		load_cell_xy(4,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,342 :: 		load_cell_xy(8,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,343 :: 		load_cell_xy(9,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,344 :: 		load_cell_xy(10,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,345 :: 		load_cell_xy(0,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #0
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,346 :: 		load_cell_xy(1,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,347 :: 		load_cell_xy(2,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,348 :: 		load_cell_xy(3,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,349 :: 		load_cell_xy(4,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,350 :: 		load_cell_xy(5,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,351 :: 		load_cell_xy(6,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,352 :: 		load_cell_xy(7,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,353 :: 		load_cell_xy(8,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,354 :: 		load_cell_xy(9,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,355 :: 		load_cell_xy(10,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,356 :: 		load_cell_xy(1,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,357 :: 		load_cell_xy(2,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,358 :: 		load_cell_xy(3,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,359 :: 		load_cell_xy(4,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,360 :: 		load_cell_xy(5,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,361 :: 		load_cell_xy(6,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,362 :: 		load_cell_xy(7,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,363 :: 		load_cell_xy(8,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,364 :: 		load_cell_xy(9,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,365 :: 		load_cell_xy(10,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,366 :: 		load_cell_xy(2,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,367 :: 		load_cell_xy(3,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,368 :: 		load_cell_xy(4,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,369 :: 		load_cell_xy(5,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,370 :: 		load_cell_xy(6,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,371 :: 		load_cell_xy(7,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,372 :: 		load_cell_xy(8,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,373 :: 		load_cell_xy(9,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,374 :: 		load_cell_xy(10,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,375 :: 		load_cell_xy(3,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,376 :: 		load_cell_xy(4,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,377 :: 		load_cell_xy(5,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,378 :: 		load_cell_xy(6,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,379 :: 		load_cell_xy(7,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,380 :: 		load_cell_xy(8,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,381 :: 		load_cell_xy(9,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,382 :: 		load_cell_xy(4,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,383 :: 		load_cell_xy(5,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,384 :: 		load_cell_xy(6,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,385 :: 		load_cell_xy(7,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,386 :: 		load_cell_xy(8,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_intro_screen_ctl.h,387 :: 		}
L_end_duck_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _duck_sprite
_scr_debug:
;cp_game_ctl.h,104 :: 		void scr_debug(int32_t value, int32_t value2) {
; value2 start address is: 4 (R1)
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value2 end address is: 4 (R1)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
; value2 start address is: 4 (R1)
;cp_game_ctl.h,105 :: 		g_debug = value;
MOVW	R2, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_debug+0)
STR	R0, [R2, #0]
; value end address is: 0 (R0)
;cp_game_ctl.h,106 :: 		g_debug2 = value2;
MOVW	R2, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_debug2+0)
STR	R1, [R2, #0]
; value2 end address is: 4 (R1)
;cp_game_ctl.h,107 :: 		}
L_end_scr_debug:
ADD	SP, SP, #4
BX	LR
; end of _scr_debug
_reset_game_values:
;cp_game_ctl.h,113 :: 		void reset_game_values () {
SUB	SP, SP, #4
;cp_game_ctl.h,114 :: 		i =0;    // Generic counters
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,115 :: 		j =0;    // Generic counters
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_j+0)
MOVT	R0, #hi_addr(P7_final_project_main_j+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,116 :: 		g_session_count      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,117 :: 		g_game_score         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,118 :: 		g_debug              = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,119 :: 		g_debug2             = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug2+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,120 :: 		g_rand_num           = 999;
MOVW	R1, #999
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,121 :: 		g_food_in_play       = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_food_in_play+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,122 :: 		g_fd_x_val           = NEG_NULL;
MOV	R1, #-1
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_x_val+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,123 :: 		g_fd_y_val           = NEG_NULL;
MOV	R1, #-1
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_y_val+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,124 :: 		init_cur    = init_cursor_start;
MOVS	R1, #65
MOVW	R0, #lo_addr(_init_cur+0)
MOVT	R0, #hi_addr(_init_cur+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,125 :: 		init_cur_pos         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R0, #hi_addr(P7_final_project_main_init_cur_pos+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,127 :: 		hs_cursor_x          = HS_CURSOR_START_X;
MOV	R1, #16
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_x+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,128 :: 		hs_cursor_y          = HS_CURSOR_START_Y;
MOV	R1, #4
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_y+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,130 :: 		}
L_end_reset_game_values:
ADD	SP, SP, #4
BX	LR
; end of _reset_game_values
_set_curr_snake_dir:
;cp_game_ctl.h,134 :: 		void set_curr_snake_dir(uint8_t new_dir) {
; new_dir start address is: 0 (R0)
SUB	SP, SP, #4
; new_dir end address is: 0 (R0)
; new_dir start address is: 0 (R0)
;cp_game_ctl.h,135 :: 		g_curr_snake_dir = new_dir;
MOVW	R1, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
STRB	R0, [R1, #0]
; new_dir end address is: 0 (R0)
;cp_game_ctl.h,136 :: 		}
L_end_set_curr_snake_dir:
ADD	SP, SP, #4
BX	LR
; end of _set_curr_snake_dir
_toggle_game_clock_delay:
;cp_game_ctl.h,140 :: 		void toggle_game_clock_delay() {
SUB	SP, SP, #4
;cp_game_ctl.h,141 :: 		g_game_clock_delay_tim3 = ~g_game_clock_delay_tim3;
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
LDRB	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,142 :: 		}
L_end_toggle_game_clock_delay:
ADD	SP, SP, #4
BX	LR
; end of _toggle_game_clock_delay
_update_game_time:
;cp_game_ctl.h,146 :: 		void update_game_time () {
SUB	SP, SP, #4
;cp_game_ctl.h,147 :: 		g_time_count++;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,149 :: 		}
L_end_update_game_time:
ADD	SP, SP, #4
BX	LR
; end of _update_game_time
_update_session_time:
;cp_game_ctl.h,151 :: 		void update_session_time() {
SUB	SP, SP, #4
;cp_game_ctl.h,152 :: 		g_session_count++;
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,153 :: 		}
L_end_update_session_time:
ADD	SP, SP, #4
BX	LR
; end of _update_session_time
_get_game_phase:
;cp_game_ctl.h,157 :: 		uint8_t get_game_phase() {
SUB	SP, SP, #4
;cp_game_ctl.h,158 :: 		return g_GAME_PHASE;
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
;cp_game_ctl.h,159 :: 		}
L_end_get_game_phase:
ADD	SP, SP, #4
BX	LR
; end of _get_game_phase
_get_initial_cur_pos:
;cp_game_ctl.h,162 :: 		int32_t get_initial_cur_pos () {
SUB	SP, SP, #4
;cp_game_ctl.h,163 :: 		return init_cur_pos;
MOVW	R0, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R0, #hi_addr(P7_final_project_main_init_cur_pos+0)
LDR	R0, [R0, #0]
;cp_game_ctl.h,164 :: 		}
L_end_get_initial_cur_pos:
ADD	SP, SP, #4
BX	LR
; end of _get_initial_cur_pos
_set_food_in_play_flag:
;cp_game_ctl.h,168 :: 		void set_food_in_play_flag (uint8_t state) {
; state start address is: 0 (R0)
SUB	SP, SP, #4
; state end address is: 0 (R0)
; state start address is: 0 (R0)
;cp_game_ctl.h,169 :: 		g_food_in_play = state;
MOVW	R1, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_food_in_play+0)
STRB	R0, [R1, #0]
; state end address is: 0 (R0)
;cp_game_ctl.h,170 :: 		}
L_end_set_food_in_play_flag:
ADD	SP, SP, #4
BX	LR
; end of _set_food_in_play_flag
_set_food_xy:
;cp_game_ctl.h,174 :: 		void set_food_xy(int32_t *x_val, int32_t *y_val) {
; y_val start address is: 4 (R1)
; x_val start address is: 0 (R0)
SUB	SP, SP, #4
; y_val end address is: 4 (R1)
; x_val end address is: 0 (R0)
; x_val start address is: 0 (R0)
; y_val start address is: 4 (R1)
;cp_game_ctl.h,175 :: 		g_fd_x_val = *x_val;
LDR	R3, [R0, #0]
; x_val end address is: 0 (R0)
MOVW	R2, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_fd_x_val+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,176 :: 		g_fd_y_val = *y_val;
LDR	R3, [R1, #0]
; y_val end address is: 4 (R1)
MOVW	R2, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_fd_y_val+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,177 :: 		}
L_end_set_food_xy:
ADD	SP, SP, #4
BX	LR
; end of _set_food_xy
_play_sound1:
;cp_game_ctl.h,181 :: 		void play_sound1( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,183 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sound191:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sound192
;cp_game_ctl.h,184 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,185 :: 		Delay_ms(SFX_FOOD_HIGH);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_play_sound194:
SUBS	R7, R7, #1
BNE	L_play_sound194
NOP
NOP
NOP
;cp_game_ctl.h,183 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,186 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sound191
L_play_sound192:
;cp_game_ctl.h,187 :: 		}
L_end_play_sound1:
ADD	SP, SP, #4
BX	LR
; end of _play_sound1
_play_sound2:
;cp_game_ctl.h,191 :: 		void play_sound2( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,193 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sound296:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sound297
;cp_game_ctl.h,194 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,195 :: 		Delay_ms(SFX_FOOD);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_play_sound299:
SUBS	R7, R7, #1
BNE	L_play_sound299
NOP
NOP
NOP
;cp_game_ctl.h,193 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,196 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sound296
L_play_sound297:
;cp_game_ctl.h,197 :: 		}
L_end_play_sound2:
ADD	SP, SP, #4
BX	LR
; end of _play_sound2
_play_sound3:
;cp_game_ctl.h,201 :: 		void play_sound3( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,203 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sound3101:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sound3102
;cp_game_ctl.h,204 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,205 :: 		Delay_ms(SFX_WALL);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_play_sound3104:
SUBS	R7, R7, #1
BNE	L_play_sound3104
NOP
NOP
NOP
;cp_game_ctl.h,203 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,206 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sound3101
L_play_sound3102:
;cp_game_ctl.h,207 :: 		}
L_end_play_sound3:
ADD	SP, SP, #4
BX	LR
; end of _play_sound3
_play_sfx_wall:
;cp_game_ctl.h,211 :: 		void play_sfx_wall( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,213 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_wall106:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_wall107
;cp_game_ctl.h,214 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,215 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_play_sfx_wall109:
SUBS	R7, R7, #1
BNE	L_play_sfx_wall109
NOP
NOP
NOP
;cp_game_ctl.h,213 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,216 :: 		}
IT	AL
BAL	L_play_sfx_wall106
L_play_sfx_wall107:
;cp_game_ctl.h,218 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_wall111:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_wall112
;cp_game_ctl.h,219 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,220 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_play_sfx_wall114:
SUBS	R7, R7, #1
BNE	L_play_sfx_wall114
NOP
NOP
NOP
;cp_game_ctl.h,218 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,221 :: 		}
IT	AL
BAL	L_play_sfx_wall111
L_play_sfx_wall112:
;cp_game_ctl.h,223 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_wall116:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_wall117
;cp_game_ctl.h,224 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,225 :: 		Delay_ms(15);
MOVW	R7, #48927
MOVT	R7, #2
NOP
NOP
L_play_sfx_wall119:
SUBS	R7, R7, #1
BNE	L_play_sfx_wall119
NOP
NOP
NOP
;cp_game_ctl.h,223 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,226 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sfx_wall116
L_play_sfx_wall117:
;cp_game_ctl.h,227 :: 		}
L_end_play_sfx_wall:
ADD	SP, SP, #4
BX	LR
; end of _play_sfx_wall
_play_sfx_food:
;cp_game_ctl.h,232 :: 		void play_sfx_food( uint32_t duration) {
; duration start address is: 0 (R0)
SUB	SP, SP, #4
; duration end address is: 0 (R0)
; duration start address is: 0 (R0)
;cp_game_ctl.h,234 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_food121:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_food122
;cp_game_ctl.h,235 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,236 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_play_sfx_food124:
SUBS	R7, R7, #1
BNE	L_play_sfx_food124
NOP
NOP
NOP
;cp_game_ctl.h,234 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,237 :: 		}
IT	AL
BAL	L_play_sfx_food121
L_play_sfx_food122:
;cp_game_ctl.h,239 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_food126:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_food127
;cp_game_ctl.h,240 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,241 :: 		Delay_ms(3);
MOVW	R7, #35999
MOVT	R7, #0
NOP
NOP
L_play_sfx_food129:
SUBS	R7, R7, #1
BNE	L_play_sfx_food129
NOP
NOP
NOP
;cp_game_ctl.h,239 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,242 :: 		}
IT	AL
BAL	L_play_sfx_food126
L_play_sfx_food127:
;cp_game_ctl.h,244 :: 		for (i=0; i < duration; i++) {
MOVS	R2, #0
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
STR	R2, [R1, #0]
; duration end address is: 0 (R0)
L_play_sfx_food131:
; duration start address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R1, #0]
CMP	R1, R0
IT	CS
BCS	L_play_sfx_food132
;cp_game_ctl.h,245 :: 		GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_LX	[R1, ByteOffset(GPIOE_ODRbits+0)]
EOR	R2, R1, #1
UXTB	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODRbits+0)
MOVT	R1, #hi_addr(GPIOE_ODRbits+0)
_SX	[R1, ByteOffset(GPIOE_ODRbits+0)]
;cp_game_ctl.h,246 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_play_sfx_food134:
SUBS	R7, R7, #1
BNE	L_play_sfx_food134
NOP
NOP
NOP
;cp_game_ctl.h,244 :: 		for (i=0; i < duration; i++) {
MOVW	R2, #lo_addr(P7_final_project_main_i+0)
MOVT	R2, #hi_addr(P7_final_project_main_i+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,247 :: 		}
; duration end address is: 0 (R0)
IT	AL
BAL	L_play_sfx_food131
L_play_sfx_food132:
;cp_game_ctl.h,248 :: 		}
L_end_play_sfx_food:
ADD	SP, SP, #4
BX	LR
; end of _play_sfx_food
_game_over:
;cp_game_ctl.h,253 :: 		void game_over() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,257 :: 		TIM3_CR1 = 0; // Kill TIMER3 now
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,258 :: 		play_sfx_wall(20);
MOVS	R0, #20
BL	_play_sfx_wall+0
;cp_game_ctl.h,259 :: 		g_GAME_PHASE = PHASE_QUIT;
MOVS	R1, #3
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,260 :: 		game_cur_screen_run_flag = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,261 :: 		}
L_end_game_over:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _game_over
_move_snake:
;cp_game_ctl.h,271 :: 		void move_snake() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,273 :: 		int16_t temp_x = m_node_head->node_x;
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
LDRSH	R0, [R0, #0]
; temp_x start address is: 12 (R3)
SXTH	R3, R0
;cp_game_ctl.h,274 :: 		int16_t temp_y = m_node_head->node_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
; temp_y start address is: 16 (R4)
SXTH	R4, R0
;cp_game_ctl.h,276 :: 		if (g_curr_snake_dir == MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake136
;cp_game_ctl.h,278 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake137
;cp_game_ctl.h,279 :: 		m_node_start->node_x = ++temp_x;
ADDS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,280 :: 		m_node_start->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,282 :: 		m_node_head = m_node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,283 :: 		} else {
IT	AL
BAL	L_move_snake138
L_move_snake137:
;cp_game_ctl.h,285 :: 		(m_node_head+1)->node_x = ++temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
ADDS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,286 :: 		(m_node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,287 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,288 :: 		}
L_move_snake138:
;cp_game_ctl.h,294 :: 		if (m_node_head->node_x > MAX_COL_WIDTH-1 ) { //0-indexed array
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #19
IT	LE
BLE	L_move_snake139
;cp_game_ctl.h,296 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake140
;cp_game_ctl.h,297 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,299 :: 		} else {
IT	AL
BAL	L_move_snake141
L_move_snake140:
;cp_game_ctl.h,300 :: 		m_node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,301 :: 		}
L_move_snake141:
;cp_game_ctl.h,302 :: 		}
L_move_snake139:
;cp_game_ctl.h,303 :: 		}
IT	AL
BAL	L_move_snake142
L_move_snake136:
;cp_game_ctl.h,304 :: 		else if (g_curr_snake_dir == MOVE_LEFT)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_move_snake143
;cp_game_ctl.h,306 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake144
;cp_game_ctl.h,307 :: 		(m_node_start)->node_x = --temp_x;
SUBS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,308 :: 		(m_node_start)->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,310 :: 		m_node_head = m_node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,311 :: 		} else {
IT	AL
BAL	L_move_snake145
L_move_snake144:
;cp_game_ctl.h,313 :: 		(m_node_head+1)->node_x = --temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
SUBS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,314 :: 		(m_node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,316 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,317 :: 		}
L_move_snake145:
;cp_game_ctl.h,320 :: 		if (m_node_head->node_x < 0) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_move_snake146
;cp_game_ctl.h,321 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake147
;cp_game_ctl.h,322 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,324 :: 		} else {
IT	AL
BAL	L_move_snake148
L_move_snake147:
;cp_game_ctl.h,325 :: 		m_node_head->node_x = 19;
MOVS	R1, #19
SXTH	R1, R1
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,326 :: 		}
L_move_snake148:
;cp_game_ctl.h,327 :: 		}
L_move_snake146:
;cp_game_ctl.h,329 :: 		}
IT	AL
BAL	L_move_snake149
L_move_snake143:
;cp_game_ctl.h,330 :: 		else if (g_curr_snake_dir == MOVE_UP)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_move_snake150
;cp_game_ctl.h,332 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake151
;cp_game_ctl.h,333 :: 		(m_node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_m_node_start+0)
MOVT	R2, #hi_addr(_m_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,334 :: 		(m_node_start)->node_y = --temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,335 :: 		m_node_head = m_node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,336 :: 		} else {
IT	AL
BAL	L_move_snake152
L_move_snake151:
;cp_game_ctl.h,338 :: 		(m_node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,339 :: 		(m_node_head+1)->node_y = --temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,341 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,342 :: 		}
L_move_snake152:
;cp_game_ctl.h,345 :: 		if (m_node_head->node_y < 1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	GE
BGE	L_move_snake153
;cp_game_ctl.h,346 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake154
;cp_game_ctl.h,347 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,349 :: 		} else {
IT	AL
BAL	L_move_snake155
L_move_snake154:
;cp_game_ctl.h,350 :: 		m_node_head->node_y = (MAX_ROW_LENGTH-1);
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVW	R0, #14
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,351 :: 		}
L_move_snake155:
;cp_game_ctl.h,352 :: 		}
L_move_snake153:
;cp_game_ctl.h,353 :: 		}
IT	AL
BAL	L_move_snake156
L_move_snake150:
;cp_game_ctl.h,354 :: 		else if (g_curr_snake_dir == MOVE_DOWN)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_move_snake157
;cp_game_ctl.h,355 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake158
;cp_game_ctl.h,356 :: 		(m_node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_m_node_start+0)
MOVT	R2, #hi_addr(_m_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,357 :: 		(m_node_start)->node_y = ++temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,358 :: 		m_node_head = m_node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,359 :: 		} else {
IT	AL
BAL	L_move_snake159
L_move_snake158:
;cp_game_ctl.h,361 :: 		(m_node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,362 :: 		(m_node_head+1)->node_y = ++temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,365 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,366 :: 		}
L_move_snake159:
;cp_game_ctl.h,369 :: 		if (m_node_head->node_y > MAX_ROW_LENGTH-1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #14
IT	LE
BLE	L_move_snake160
;cp_game_ctl.h,370 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake161
;cp_game_ctl.h,371 :: 		game_over();
BL	_game_over+0
;cp_game_ctl.h,373 :: 		} else {
IT	AL
BAL	L_move_snake162
L_move_snake161:
;cp_game_ctl.h,374 :: 		m_node_head->node_y = 1;
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,375 :: 		}
L_move_snake162:
;cp_game_ctl.h,376 :: 		}
L_move_snake160:
;cp_game_ctl.h,378 :: 		}
L_move_snake157:
L_move_snake156:
L_move_snake149:
L_move_snake142:
;cp_game_ctl.h,380 :: 		}
L_end_move_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _move_snake
_check_snake_collision:
;cp_game_ctl.h,384 :: 		int32_t check_snake_collision(int16_t x_val, int16_t y_val, t_node * start_pos) {
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
;cp_game_ctl.h,386 :: 		t_node *temp_itr = start_pos;
; temp_itr start address is: 16 (R4)
MOV	R4, R2
;cp_game_ctl.h,388 :: 		if (start_pos > m_node_end) {
MOVW	R3, #lo_addr(_m_node_end+0)
MOVT	R3, #hi_addr(_m_node_end+0)
LDR	R3, [R3, #0]
CMP	R2, R3
IT	LS
BLS	L_check_snake_collision163
; start_pos end address is: 8 (R2)
;cp_game_ctl.h,390 :: 		}
L_check_snake_collision163:
;cp_game_ctl.h,392 :: 		do {
SXTH	R6, R0
; y_val end address is: 4 (R1)
; temp_itr end address is: 16 (R4)
SXTH	R5, R1
MOV	R7, R4
IT	AL
BAL	L_check_snake_collision164
; x_val end address is: 0 (R0)
L__check_snake_collision334:
;cp_game_ctl.h,402 :: 		} while (temp_itr <= m_node_head);
;cp_game_ctl.h,392 :: 		do {
L_check_snake_collision164:
;cp_game_ctl.h,393 :: 		scr_debug(temp_itr->node_x, temp_itr->node_y );
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
;cp_game_ctl.h,396 :: 		if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {
LDRSH	R3, [R7, #0]
CMP	R3, R6
IT	NE
BNE	L__check_snake_collision333
; y_val end address is: 20 (R5)
; y_val start address is: 20 (R5)
ADDS	R3, R7, #2
LDRSH	R3, [R3, #0]
CMP	R3, R5
IT	NE
BNE	L__check_snake_collision332
; y_val end address is: 20 (R5)
; x_val end address is: 24 (R6)
; temp_itr end address is: 28 (R7)
L__check_snake_collision331:
;cp_game_ctl.h,398 :: 		return TRUE; // Collision found
MOVS	R0, #1
IT	AL
BAL	L_end_check_snake_collision
;cp_game_ctl.h,396 :: 		if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {
L__check_snake_collision333:
; temp_itr start address is: 28 (R7)
; x_val start address is: 24 (R6)
; y_val start address is: 20 (R5)
L__check_snake_collision332:
;cp_game_ctl.h,401 :: 		temp_itr = incr_node(temp_itr);
MOV	R0, R7
; temp_itr end address is: 28 (R7)
BL	_incr_node+0
; temp_itr start address is: 28 (R7)
MOV	R7, R0
;cp_game_ctl.h,402 :: 		} while (temp_itr <= m_node_head);
MOVW	R3, #lo_addr(_m_node_head+0)
MOVT	R3, #hi_addr(_m_node_head+0)
LDR	R3, [R3, #0]
CMP	R0, R3
IT	LS
BLS	L__check_snake_collision334
; y_val end address is: 20 (R5)
; x_val end address is: 24 (R6)
; temp_itr end address is: 28 (R7)
;cp_game_ctl.h,404 :: 		return FALSE;
MOVS	R0, #0
;cp_game_ctl.h,405 :: 		}
L_end_check_snake_collision:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_snake_collision
_generate_food:
;cp_game_ctl.h,409 :: 		void generate_food() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_game_ctl.h,413 :: 		int16_t col_ret = TRUE;
;cp_game_ctl.h,416 :: 		int32_t temp_time = TIM3_CNT %33;
MOVW	R0, #lo_addr(TIM3_CNT+0)
MOVT	R0, #hi_addr(TIM3_CNT+0)
LDR	R2, [R0, #0]
MOVS	R1, #33
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
STR	R0, [SP, #12]
;cp_game_ctl.h,420 :: 		do  {
L_generate_food170:
;cp_game_ctl.h,422 :: 		for (i=0; i <= temp_time; i++) {
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
STR	R1, [R0, #0]
L_generate_food173:
LDR	R1, [SP, #12]
MOVW	R0, #lo_addr(P7_final_project_main_i+0)
MOVT	R0, #hi_addr(P7_final_project_main_i+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	GT
BGT	L_generate_food174
;cp_game_ctl.h,424 :: 		g_rand_num = (int32_t)  (rand() % MAX_BLOCK_COUNT);// + MAX_COL_WIDTH because row 0 is reserved for info
BL	_rand+0
MOV	R2, #300
SDIV	R1, R0, R2
MLS	R1, R2, R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,422 :: 		for (i=0; i <= temp_time; i++) {
MOVW	R1, #lo_addr(P7_final_project_main_i+0)
MOVT	R1, #hi_addr(P7_final_project_main_i+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,425 :: 		}
IT	AL
BAL	L_generate_food173
L_generate_food174:
;cp_game_ctl.h,429 :: 		convert_lin_xy(&g_rand_num, &fd_x_val, &fd_y_val);
ADD	R1, SP, #8
ADD	R0, SP, #4
MOV	R2, R1
MOV	R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
BL	_convert_lin_xy+0
;cp_game_ctl.h,434 :: 		col_ret = check_snake_collision(&fd_x_val, &fd_y_val, m_node_tail);
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R2, [R0, #0]
ADD	R1, SP, #8
ADD	R0, SP, #4
SXTH	R1, R1
SXTH	R0, R0
BL	_check_snake_collision+0
STRH	R0, [SP, #16]
;cp_game_ctl.h,438 :: 		if (col_ret == FALSE) {
SXTH	R0, R0
CMP	R0, #0
IT	NE
BNE	L_generate_food176
;cp_game_ctl.h,440 :: 		draw_cell_pos(&g_rand_num, m_FUCHSIA);
MOVS	R1, #6
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
BL	_draw_cell_pos+0
;cp_game_ctl.h,441 :: 		set_food_in_play_flag(TRUE);
MOVS	R0, #1
BL	_set_food_in_play_flag+0
;cp_game_ctl.h,444 :: 		set_food_xy(&fd_x_val, &fd_y_val);
ADD	R1, SP, #8
ADD	R0, SP, #4
BL	_set_food_xy+0
;cp_game_ctl.h,445 :: 		}
L_generate_food176:
;cp_game_ctl.h,447 :: 		} while (col_ret == TRUE);
LDRSH	R0, [SP, #16]
CMP	R0, #1
IT	EQ
BEQ	L_generate_food170
;cp_game_ctl.h,449 :: 		}
L_end_generate_food:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _generate_food
_incr_snake_head:
;cp_game_ctl.h,454 :: 		void incr_snake_head() {
SUB	SP, SP, #4
;cp_game_ctl.h,456 :: 		if (m_node_head < m_node_end) { // array_size * sizeof(t_node)
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_head177
;cp_game_ctl.h,457 :: 		m_node_head++;
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,458 :: 		} else {
IT	AL
BAL	L_incr_snake_head178
L_incr_snake_head177:
;cp_game_ctl.h,460 :: 		m_node_head = m_node_start; // Wrap around array if end is reached
MOVW	R0, #lo_addr(_m_node_start+0)
MOVT	R0, #hi_addr(_m_node_start+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,461 :: 		}
L_incr_snake_head178:
;cp_game_ctl.h,463 :: 		}
L_end_incr_snake_head:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_head
_incr_node:
;cp_game_ctl.h,467 :: 		t_node* incr_node( t_node *_node) {
; _node start address is: 0 (R0)
SUB	SP, SP, #4
; _node end address is: 0 (R0)
; _node start address is: 0 (R0)
;cp_game_ctl.h,470 :: 		if (_node <= m_node_end) {
MOVW	R1, #lo_addr(_m_node_end+0)
MOVT	R1, #hi_addr(_m_node_end+0)
LDR	R1, [R1, #0]
CMP	R0, R1
IT	HI
BHI	L_incr_node179
;cp_game_ctl.h,471 :: 		_node++;
ADDS	R0, R0, #4
;cp_game_ctl.h,472 :: 		} else {
; _node end address is: 0 (R0)
IT	AL
BAL	L_incr_node180
L_incr_node179:
;cp_game_ctl.h,474 :: 		_node = m_node_start;
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
; _node start address is: 0 (R0)
LDR	R0, [R1, #0]
; _node end address is: 0 (R0)
;cp_game_ctl.h,475 :: 		}
L_incr_node180:
;cp_game_ctl.h,477 :: 		return _node;
; _node start address is: 0 (R0)
; _node end address is: 0 (R0)
;cp_game_ctl.h,478 :: 		}
L_end_incr_node:
ADD	SP, SP, #4
BX	LR
; end of _incr_node
_incr_snake_tail:
;cp_game_ctl.h,483 :: 		void incr_snake_tail() {
SUB	SP, SP, #4
;cp_game_ctl.h,485 :: 		if (m_node_tail != m_node_head) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_incr_snake_tail181
;cp_game_ctl.h,488 :: 		m_node_tail->node_x = 0xFF;
MOVS	R1, #255
SXTH	R1, R1
MOVW	R2, #lo_addr(_m_node_tail+0)
MOVT	R2, #hi_addr(_m_node_tail+0)
LDR	R0, [R2, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,489 :: 		m_node_tail->node_y = 0xFF;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #255
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,492 :: 		if (m_node_tail < m_node_end) {
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R1, [R0, #0]
MOV	R0, R2
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_tail182
;cp_game_ctl.h,493 :: 		m_node_tail++;
MOVW	R1, #lo_addr(_m_node_tail+0)
MOVT	R1, #hi_addr(_m_node_tail+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,494 :: 		} else {
IT	AL
BAL	L_incr_snake_tail183
L_incr_snake_tail182:
;cp_game_ctl.h,496 :: 		m_node_tail = m_node_start;
MOVW	R0, #lo_addr(_m_node_start+0)
MOVT	R0, #hi_addr(_m_node_start+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,497 :: 		}
L_incr_snake_tail183:
;cp_game_ctl.h,498 :: 		}
L_incr_snake_tail181:
;cp_game_ctl.h,500 :: 		}
L_end_incr_snake_tail:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_tail
_load_snake_game:
;cp_game_ctl.h,508 :: 		void load_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,511 :: 		set_game_phase(PHASE1_READY);
MOVS	R0, #1
BL	_set_game_phase+0
;cp_game_ctl.h,517 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,519 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,521 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,522 :: 		set_brush_color(m_BLACK);
MOVS	R0, #0
BL	_set_brush_color+0
;cp_game_ctl.h,524 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,526 :: 		TFT_Set_Font(TFT_defaultFont, CL_AQUA, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #4095
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,527 :: 		TFT_Write_Text("SNAKE!", 8 * PX_BLOCK, 6 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr1_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr1_P7_final_project_main+0)
MOVW	R2, #96
MOVW	R1, #128
BL	_TFT_Write_Text+0
;cp_game_ctl.h,528 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,529 :: 		TFT_Write_Text("v.1.0", 18* PX_BLOCK, 0 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr2_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr2_P7_final_project_main+0)
MOVW	R2, #0
MOVW	R1, #288
BL	_TFT_Write_Text+0
;cp_game_ctl.h,530 :: 		TFT_Write_Text("By Howard Zhou", 13 * PX_BLOCK, 14 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr3_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr3_P7_final_project_main+0)
MOVW	R2, #224
MOVW	R1, #208
BL	_TFT_Write_Text+0
;cp_game_ctl.h,531 :: 		TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 11*PX_BLOCK);
MOVW	R0, #lo_addr(?lstr4_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr4_P7_final_project_main+0)
MOVW	R2, #176
MOVW	R1, #80
BL	_TFT_Write_Text+0
;cp_game_ctl.h,533 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_snake_game184:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_snake_game185
IT	AL
BAL	L_load_snake_game184
L_load_snake_game185:
;cp_game_ctl.h,535 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,536 :: 		}
L_end_load_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _load_snake_game
_update_stats:
;cp_game_ctl.h,540 :: 		void update_stats() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,541 :: 		sprintf(g_str_buffer, "Score: \x20 %04d", g_game_score);
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_5_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_5_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,542 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,545 :: 		if (g_GAME_MODE == NORMAL_MODE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_update_stats186
;cp_game_ctl.h,546 :: 		sprintf(g_str_buffer, "MODE: \x20 Normal" );
MOVW	R1, #lo_addr(?lstr_6_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_6_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,547 :: 		}
IT	AL
BAL	L_update_stats187
L_update_stats186:
;cp_game_ctl.h,549 :: 		sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );       // ****Printout debugger
MOVW	R0, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug2+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_7_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_7_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,550 :: 		}
L_update_stats187:
;cp_game_ctl.h,551 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,552 :: 		}
L_end_update_stats:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_stats
_update_time:
;cp_game_ctl.h,556 :: 		void update_time() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,559 :: 		if (g_TIME_TRACK_MODE == SESSION_TIME) {
MOVW	R0, #lo_addr(P7_final_project_main_g_TIME_TRACK_MODE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_TIME_TRACK_MODE+0)
LDRB	R0, [R0, #0]
CMP	R0, #31
IT	NE
BNE	L_update_time188
;cp_game_ctl.h,560 :: 		g_t_secs = g_session_count % 60;
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
LDR	R2, [R0, #0]
MOVS	R0, #60
UDIV	R1, R2, R0
MLS	R1, R0, R1, R2
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,562 :: 		if (g_t_secs != 0) {
CMP	R1, #0
IT	EQ
BEQ	L_update_time189
;cp_game_ctl.h,563 :: 		g_t_wait = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,564 :: 		}
L_update_time189:
;cp_game_ctl.h,565 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time338
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time337
L__update_time336:
;cp_game_ctl.h,566 :: 		g_t_mins++;
MOVW	R1, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,567 :: 		g_t_wait = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,565 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
L__update_time338:
L__update_time337:
;cp_game_ctl.h,571 :: 		sprintf(g_str_buffer, "GTIM: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R0, #0]
SUBS	R2, R0, #1
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
;cp_game_ctl.h,573 :: 		} else {
IT	AL
BAL	L_update_time193
L_update_time188:
;cp_game_ctl.h,574 :: 		g_t_secs = g_time_count % 60;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R2, [R0, #0]
MOVS	R0, #60
UDIV	R1, R2, R0
MLS	R1, R0, R1, R2
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,576 :: 		if (g_t_secs != 0) {
CMP	R1, #0
IT	EQ
BEQ	L_update_time194
;cp_game_ctl.h,577 :: 		g_t_wait = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,578 :: 		}
L_update_time194:
;cp_game_ctl.h,579 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time340
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time339
L__update_time335:
;cp_game_ctl.h,580 :: 		g_t_mins++;
MOVW	R1, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,581 :: 		g_t_wait = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,579 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
L__update_time340:
L__update_time339:
;cp_game_ctl.h,584 :: 		sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R0, #0]
SUBS	R2, R0, #1
MOVW	R1, #lo_addr(?lstr_9_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_9_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,585 :: 		}
L_update_time193:
;cp_game_ctl.h,588 :: 		TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #240
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,590 :: 		}
L_end_update_time:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_time
_init_snake_game:
;cp_game_ctl.h,594 :: 		void init_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,598 :: 		g_GAME_PHASE = PHASE2_PLAYING;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,601 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,602 :: 		game_cur_screen_run_flag=TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,607 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,610 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,611 :: 		set_brush_color(m_GREEN);
MOVS	R0, #5
BL	_set_brush_color+0
;cp_game_ctl.h,612 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,613 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,615 :: 		Delay_ms(100);  // Delay to allow screen to get wiped
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_init_snake_game198:
SUBS	R7, R7, #1
BNE	L_init_snake_game198
NOP
NOP
NOP
;cp_game_ctl.h,616 :: 		init_snake_sprite();
BL	_init_snake_sprite+0
;cp_game_ctl.h,617 :: 		}
L_end_init_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_game
_init_snake_sprite:
;cp_game_ctl.h,623 :: 		void init_snake_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,626 :: 		reset_game_values();
BL	_reset_game_values+0
;cp_game_ctl.h,629 :: 		m_node_head = m_node_start;
MOVW	R3, #lo_addr(_m_node_start+0)
MOVT	R3, #hi_addr(_m_node_start+0)
LDR	R0, [R3, #0]
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
STR	R0, [R2, #0]
;cp_game_ctl.h,630 :: 		m_node_tail = m_node_start;
MOV	R0, R3
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,631 :: 		g_curr_snake_dir = MOVE_RIGHT;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,634 :: 		m_node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOV	R0, R3
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,635 :: 		m_node_head->node_y = 1;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,636 :: 		print_snake(m_node_head, m_GREEN);
MOV	R0, R2
LDR	R0, [R0, #0]
MOVS	R1, #5
BL	_print_snake+0
;cp_game_ctl.h,637 :: 		generate_food();
BL	_generate_food+0
;cp_game_ctl.h,640 :: 		g_session_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_session_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_session_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,641 :: 		}
L_end_init_snake_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_sprite
_start_snake_game:
;cp_game_ctl.h,647 :: 		void start_snake_game() {
SUB	SP, SP, #4
;cp_game_ctl.h,648 :: 		Delay_ms(500); // Allow timers to wind up
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_start_snake_game200:
SUBS	R7, R7, #1
BNE	L_start_snake_game200
NOP
NOP
NOP
;cp_game_ctl.h,652 :: 		while (game_cur_screen_run_flag == TRUE) {
L_start_snake_game202:
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_start_snake_game203
;cp_game_ctl.h,654 :: 		};
IT	AL
BAL	L_start_snake_game202
L_start_snake_game203:
;cp_game_ctl.h,655 :: 		}
L_end_start_snake_game:
ADD	SP, SP, #4
BX	LR
; end of _start_snake_game
_screen_refresh_TIM3:
;cp_game_ctl.h,660 :: 		void screen_refresh_TIM3() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,664 :: 		if ( check_snake_collision((m_node_tail)->node_x, (m_node_tail)->node_y, m_node_tail+1) == FALSE ) {
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
BNE	L_screen_refresh_TIM3204
;cp_game_ctl.h,665 :: 		clean_tail(m_node_tail, m_BLACK);
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R0, [R0, #0]
MOVS	R1, #0
BL	_clean_tail+0
;cp_game_ctl.h,666 :: 		}
L_screen_refresh_TIM3204:
;cp_game_ctl.h,668 :: 		draw_cell_xy(g_fd_x_val, g_fd_y_val, m_FUCHSIA); // refresh food
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_y_val+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_x_val+0)
LDR	R0, [R0, #0]
MOVS	R2, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,669 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_screen_refresh_TIM3205:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3205
NOP
NOP
NOP
;cp_game_ctl.h,670 :: 		move_snake();
BL	_move_snake+0
;cp_game_ctl.h,672 :: 		if (g_GAME_PHASE != PHASE_QUIT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_screen_refresh_TIM3207
;cp_game_ctl.h,674 :: 		print_snake(m_node_head, m_GREEN);
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
MOVS	R1, #5
BL	_print_snake+0
;cp_game_ctl.h,675 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_screen_refresh_TIM3208:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3208
NOP
NOP
NOP
;cp_game_ctl.h,678 :: 		if ( check_snake_collision(g_fd_x_val, g_fd_y_val, m_node_head) == FALSE ) {
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
BNE	L_screen_refresh_TIM3210
;cp_game_ctl.h,679 :: 		incr_snake_tail();
BL	_incr_snake_tail+0
;cp_game_ctl.h,680 :: 		} else {
IT	AL
BAL	L_screen_refresh_TIM3211
L_screen_refresh_TIM3210:
;cp_game_ctl.h,682 :: 		play_sfx_food(20);
MOVS	R0, #20
BL	_play_sfx_food+0
;cp_game_ctl.h,683 :: 		g_game_score++;
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,684 :: 		generate_food();
BL	_generate_food+0
;cp_game_ctl.h,685 :: 		}
L_screen_refresh_TIM3211:
;cp_game_ctl.h,686 :: 		}
L_screen_refresh_TIM3207:
;cp_game_ctl.h,687 :: 		}
L_end_screen_refresh_TIM3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _screen_refresh_TIM3
_game_over_scr:
;cp_game_ctl.h,691 :: 		void game_over_scr() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,694 :: 		update_session_time();
BL	_update_session_time+0
;cp_game_ctl.h,697 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;cp_game_ctl.h,698 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_game_over_scr212:
SUBS	R7, R7, #1
BNE	L_game_over_scr212
NOP
NOP
NOP
;cp_game_ctl.h,702 :: 		update_time();
BL	_update_time+0
;cp_game_ctl.h,705 :: 		update_stats();
BL	_update_stats+0
;cp_game_ctl.h,710 :: 		set_game_phase (PHASE_QUIT);
MOVS	R0, #3
BL	_set_game_phase+0
;cp_game_ctl.h,716 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,722 :: 		set_brush_color(m_BLACK);
MOVS	R0, #0
BL	_set_brush_color+0
;cp_game_ctl.h,724 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,725 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,727 :: 		sprintf(g_str_buffer, "Total Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
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
;cp_game_ctl.h,728 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);
MOVW	R2, #32
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,730 :: 		sprintf(g_str_buffer, "Final score: \x20 %04d", g_game_score);
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_11_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_11_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,731 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 3*PX_BLOCK);
MOVW	R2, #48
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,734 :: 		while (cur_screen_run_flag == TRUE) {}
L_game_over_scr214:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_game_over_scr215
IT	AL
BAL	L_game_over_scr214
L_game_over_scr215:
;cp_game_ctl.h,737 :: 		}
L_end_game_over_scr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _game_over_scr
_convert_int_ascii:
;cp_game_ctl.h,753 :: 		void convert_int_ascii(uint8_t in_array) {
SUB	SP, SP, #4
;cp_game_ctl.h,754 :: 		int32_t temp_score = g_game_score;
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
; temp_score start address is: 0 (R0)
LDR	R0, [R1, #0]
;cp_game_ctl.h,755 :: 		int32_t temp_val = 0;
;cp_game_ctl.h,756 :: 		int32_t temp_dvdnd = 0;
;cp_game_ctl.h,766 :: 		if (temp_score >= 1000 & g_game_score <= 9999) {
CMP	R0, #1000
MOVW	R3, #0
BLT	L__convert_int_ascii398
MOVS	R3, #1
L__convert_int_ascii398:
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R2, [R1, #0]
MOVW	R1, #9999
CMP	R2, R1
MOVW	R1, #0
BHI	L__convert_int_ascii399
MOVS	R1, #1
L__convert_int_ascii399:
AND	R1, R3, R1, LSL #0
CMP	R1, #0
IT	EQ
BEQ	L_convert_int_ascii216
;cp_game_ctl.h,767 :: 		temp_dvdnd = (temp_score / 1000);
MOVW	R1, #1000
SDIV	R3, R0, R1
;cp_game_ctl.h,768 :: 		temp_val = temp_dvdnd +0x30;
ADDW	R2, R3, #48
;cp_game_ctl.h,769 :: 		user_score_entry[3] = temp_val;
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+3)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+3)
STRB	R2, [R1, #0]
;cp_game_ctl.h,772 :: 		temp_score = temp_score - (1000 * temp_dvdnd);
MOVW	R1, #1000
MULS	R1, R3, R1
SUB	R0, R0, R1
;cp_game_ctl.h,774 :: 		} else {
IT	AL
BAL	L_convert_int_ascii217
L_convert_int_ascii216:
;cp_game_ctl.h,775 :: 		user_score_entry[3] = 0x30;  // d0;
MOVS	R2, #48
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+3)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+3)
STRB	R2, [R1, #0]
; temp_score end address is: 0 (R0)
;cp_game_ctl.h,776 :: 		}
L_convert_int_ascii217:
;cp_game_ctl.h,779 :: 		if (temp_score >= 100 ) {
; temp_score start address is: 0 (R0)
CMP	R0, #100
IT	LT
BLT	L_convert_int_ascii218
;cp_game_ctl.h,780 :: 		temp_dvdnd = (temp_score / 100);
MOVS	R1, #100
SDIV	R3, R0, R1
;cp_game_ctl.h,781 :: 		temp_val = temp_dvdnd + 0x30;
ADDW	R2, R3, #48
;cp_game_ctl.h,782 :: 		user_score_entry[4] = temp_val;
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+4)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+4)
STRB	R2, [R1, #0]
;cp_game_ctl.h,785 :: 		temp_score = temp_score - (100 * temp_dvdnd);
MOVS	R1, #100
MULS	R1, R3, R1
SUB	R0, R0, R1
;cp_game_ctl.h,787 :: 		} else {
IT	AL
BAL	L_convert_int_ascii219
L_convert_int_ascii218:
;cp_game_ctl.h,788 :: 		user_score_entry[4] = 0x30;
MOVS	R2, #48
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+4)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+4)
STRB	R2, [R1, #0]
; temp_score end address is: 0 (R0)
;cp_game_ctl.h,789 :: 		}
L_convert_int_ascii219:
;cp_game_ctl.h,792 :: 		if (temp_score >= 10) {
; temp_score start address is: 0 (R0)
CMP	R0, #10
IT	LT
BLT	L_convert_int_ascii220
;cp_game_ctl.h,793 :: 		temp_dvdnd = (temp_score / 10);
MOVS	R1, #10
SDIV	R3, R0, R1
;cp_game_ctl.h,794 :: 		temp_val = temp_dvdnd + 0x30;
ADDW	R2, R3, #48
;cp_game_ctl.h,795 :: 		user_score_entry[5] = temp_val;
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+5)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+5)
STRB	R2, [R1, #0]
;cp_game_ctl.h,798 :: 		temp_score = temp_score - (10 * temp_dvdnd);
MOVS	R1, #10
MULS	R1, R3, R1
SUB	R0, R0, R1
;cp_game_ctl.h,799 :: 		}  else {
IT	AL
BAL	L_convert_int_ascii221
L_convert_int_ascii220:
;cp_game_ctl.h,800 :: 		user_score_entry[5] = 0x30;
MOVS	R2, #48
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+5)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+5)
STRB	R2, [R1, #0]
; temp_score end address is: 0 (R0)
;cp_game_ctl.h,801 :: 		}
L_convert_int_ascii221:
;cp_game_ctl.h,804 :: 		user_score_entry[6] = temp_score + 0x30;
; temp_score start address is: 0 (R0)
ADDW	R2, R0, #48
; temp_score end address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+6)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+6)
STRB	R2, [R1, #0]
;cp_game_ctl.h,805 :: 		}
L_end_convert_int_ascii:
ADD	SP, SP, #4
BX	LR
; end of _convert_int_ascii
_refresh_hs_scr:
;cp_game_ctl.h,807 :: 		void refresh_hs_scr(uint8_t cur_dir) {
; cur_dir start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; cur_dir end address is: 0 (R0)
; cur_dir start address is: 0 (R0)
;cp_game_ctl.h,812 :: 		TFT_Fill_Screen(CL_BLACK);
STRB	R0, [SP, #4]
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
LDRB	R0, [SP, #4]
;cp_game_ctl.h,813 :: 		switch(cur_dir) {
IT	AL
BAL	L_refresh_hs_scr222
; cur_dir end address is: 0 (R0)
;cp_game_ctl.h,814 :: 		case MOVE_UP:
L_refresh_hs_scr224:
;cp_game_ctl.h,816 :: 		if (init_cur > 0x5A) {
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R1, [R1, #0]
CMP	R1, #90
IT	LS
BLS	L_refresh_hs_scr225
;cp_game_ctl.h,817 :: 		init_cur = init_cursor_start;
MOVS	R2, #65
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
STRB	R2, [R1, #0]
;cp_game_ctl.h,818 :: 		}
L_refresh_hs_scr225:
;cp_game_ctl.h,819 :: 		++init_cur;
MOVW	R2, #lo_addr(_init_cur+0)
MOVT	R2, #hi_addr(_init_cur+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
STRB	R1, [R2, #0]
;cp_game_ctl.h,820 :: 		break;
IT	AL
BAL	L_refresh_hs_scr223
;cp_game_ctl.h,822 :: 		case MOVE_DOWN:
L_refresh_hs_scr226:
;cp_game_ctl.h,823 :: 		if (init_cur < init_cursor_start) {
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R1, [R1, #0]
CMP	R1, #65
IT	CS
BCS	L_refresh_hs_scr227
;cp_game_ctl.h,824 :: 		init_cur = 0x5A;
MOVS	R2, #90
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
STRB	R2, [R1, #0]
;cp_game_ctl.h,825 :: 		} else {
IT	AL
BAL	L_refresh_hs_scr228
L_refresh_hs_scr227:
;cp_game_ctl.h,826 :: 		--init_cur;
MOVW	R2, #lo_addr(_init_cur+0)
MOVT	R2, #hi_addr(_init_cur+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
STRB	R1, [R2, #0]
;cp_game_ctl.h,827 :: 		}
L_refresh_hs_scr228:
;cp_game_ctl.h,828 :: 		break;
IT	AL
BAL	L_refresh_hs_scr223
;cp_game_ctl.h,829 :: 		case JBTN_DOWN:
L_refresh_hs_scr229:
;cp_game_ctl.h,831 :: 		user_score_entry[get_initial_cur_pos()] = init_cur;
BL	_get_initial_cur_pos+0
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+0)
ADDS	R2, R1, R0
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R1, [R1, #0]
STRB	R1, [R2, #0]
;cp_game_ctl.h,832 :: 		++init_cur_pos;
MOVW	R2, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R2, #hi_addr(P7_final_project_main_init_cur_pos+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,833 :: 		++hs_cursor_x;
MOVW	R2, #lo_addr(P7_final_project_main_hs_cursor_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_hs_cursor_x+0)
LDR	R1, [R2, #0]
ADDS	R1, R1, #1
STR	R1, [R2, #0]
;cp_game_ctl.h,835 :: 		}
IT	AL
BAL	L_refresh_hs_scr223
L_refresh_hs_scr222:
; cur_dir start address is: 0 (R0)
CMP	R0, #2
IT	EQ
BEQ	L_refresh_hs_scr224
CMP	R0, #3
IT	EQ
BEQ	L_refresh_hs_scr226
CMP	R0, #4
IT	EQ
BEQ	L_refresh_hs_scr229
; cur_dir end address is: 0 (R0)
L_refresh_hs_scr223:
;cp_game_ctl.h,838 :: 		if (init_cur_pos >= 3) {
MOVW	R1, #lo_addr(P7_final_project_main_init_cur_pos+0)
MOVT	R1, #hi_addr(P7_final_project_main_init_cur_pos+0)
LDR	R1, [R1, #0]
CMP	R1, #3
IT	LT
BLT	L_refresh_hs_scr230
;cp_game_ctl.h,841 :: 		convert_int_ascii(&user_score_entry);
MOVS	R0, #lo_addr(P7_final_project_main_user_score_entry+0)
BL	_convert_int_ascii+0
;cp_game_ctl.h,844 :: 		set_cur_screen_run_flag(FALSE); // exit this phase move to show top score list
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,845 :: 		set_game_phase(PHASE_PRINT_TOP_TEN);
MOVS	R0, #5
BL	_set_game_phase+0
;cp_game_ctl.h,846 :: 		} else {
IT	AL
BAL	L_refresh_hs_scr231
L_refresh_hs_scr230:
;cp_game_ctl.h,847 :: 		draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY);
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
;cp_game_ctl.h,848 :: 		sprintf(g_str_buffer, "Enter high score: \x20 ");
MOVW	R2, #lo_addr(?lstr_12_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_12_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,849 :: 		TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #32
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,851 :: 		if (get_initial_cur_pos() == 0) {
BL	_get_initial_cur_pos+0
CMP	R0, #0
IT	NE
BNE	L_refresh_hs_scr232
;cp_game_ctl.h,852 :: 		sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R4, [R1, #0]
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_13_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_13_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,853 :: 		} else if (get_initial_cur_pos() == 1) {
IT	AL
BAL	L_refresh_hs_scr233
L_refresh_hs_scr232:
BL	_get_initial_cur_pos+0
CMP	R0, #1
IT	NE
BNE	L_refresh_hs_scr234
;cp_game_ctl.h,854 :: 		sprintf(g_str_buffer, "%c\x20%c\x20_: \x20 %04d", user_score_entry[0], init_cur, g_game_score);
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R5, [R1, #0]
MOVW	R1, #lo_addr(_init_cur+0)
MOVT	R1, #hi_addr(_init_cur+0)
LDRB	R4, [R1, #0]
MOVW	R1, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R1, #hi_addr(P7_final_project_main_user_score_entry+0)
LDRB	R3, [R1, #0]
MOVW	R2, #lo_addr(?lstr_14_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_14_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R5)
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #20
;cp_game_ctl.h,855 :: 		} else if (get_initial_cur_pos() == 2) {
IT	AL
BAL	L_refresh_hs_scr235
L_refresh_hs_scr234:
BL	_get_initial_cur_pos+0
CMP	R0, #2
IT	NE
BNE	L_refresh_hs_scr236
;cp_game_ctl.h,856 :: 		sprintf(g_str_buffer, "%c\x20%c\x20%c: \x20 %04d", user_score_entry[0], user_score_entry[1], init_cur, g_game_score);
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
MOVW	R2, #lo_addr(?lstr_15_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_15_P7_final_project_main+0)
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
;cp_game_ctl.h,857 :: 		} else {
IT	AL
BAL	L_refresh_hs_scr237
L_refresh_hs_scr236:
;cp_game_ctl.h,858 :: 		sprintf(g_str_buffer, "FINISHED");
MOVW	R2, #lo_addr(?lstr_16_P7_final_project_main+0)
MOVT	R2, #hi_addr(?lstr_16_P7_final_project_main+0)
MOVW	R1, #lo_addr(_g_str_buffer+0)
MOVT	R1, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,859 :: 		}
L_refresh_hs_scr237:
L_refresh_hs_scr235:
L_refresh_hs_scr233:
;cp_game_ctl.h,861 :: 		TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #160
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,862 :: 		Delay_ms(200); // Small wait for the user experience
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_refresh_hs_scr238:
SUBS	R7, R7, #1
BNE	L_refresh_hs_scr238
NOP
NOP
NOP
;cp_game_ctl.h,863 :: 		}
L_refresh_hs_scr231:
;cp_game_ctl.h,866 :: 		}
L_end_refresh_hs_scr:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _refresh_hs_scr
_game_high_score_scr:
;cp_game_ctl.h,870 :: 		void game_high_score_scr() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,873 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,874 :: 		set_game_phase(PHASE_HSCORE);
MOVS	R0, #4
BL	_set_game_phase+0
;cp_game_ctl.h,877 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,880 :: 		draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY);
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_y+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_hs_cursor_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_hs_cursor_x+0)
LDR	R0, [R0, #0]
MOVS	R2, #4
BL	_draw_ini_cell_xy+0
;cp_game_ctl.h,881 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_game_high_score_scr240:
SUBS	R7, R7, #1
BNE	L_game_high_score_scr240
NOP
NOP
NOP
;cp_game_ctl.h,882 :: 		sprintf(g_str_buffer, "Enter high score: \x20 ");
MOVW	R1, #lo_addr(?lstr_17_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_17_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,883 :: 		TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #32
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,884 :: 		sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(_init_cur+0)
MOVT	R0, #hi_addr(_init_cur+0)
LDRB	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_18_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_18_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,885 :: 		TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #160
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,887 :: 		while (cur_screen_run_flag == TRUE) {}
L_game_high_score_scr242:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_game_high_score_scr243
IT	AL
BAL	L_game_high_score_scr242
L_game_high_score_scr243:
;cp_game_ctl.h,890 :: 		set_game_phase(PHASE_PRINT_TOP_TEN); // change to restart game
MOVS	R0, #5
BL	_set_game_phase+0
;cp_game_ctl.h,892 :: 		}
L_end_game_high_score_scr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _game_high_score_scr
_EE_write:
;cp_game_ctl.h,894 :: 		void EE_write(uint8_t reg_addr, uint8_t tx_byte, uint32_t tx_size) {
; tx_size start address is: 8 (R2)
; reg_addr start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
UXTB	R1, R0
MOV	R0, R2
; tx_size end address is: 8 (R2)
; reg_addr end address is: 0 (R0)
; reg_addr start address is: 4 (R1)
; tx_size start address is: 0 (R0)
;cp_game_ctl.h,895 :: 		tx_buffer_[0] = reg_addr;
MOVW	R3, #lo_addr(P7_final_project_main_tx_buffer_+0)
MOVT	R3, #hi_addr(P7_final_project_main_tx_buffer_+0)
STRB	R1, [R3, #0]
; reg_addr end address is: 4 (R1)
;cp_game_ctl.h,896 :: 		tx_buffer_[1] = 'W';
MOVS	R4, #87
MOVW	R3, #lo_addr(P7_final_project_main_tx_buffer_+1)
MOVT	R3, #hi_addr(P7_final_project_main_tx_buffer_+1)
STRB	R4, [R3, #0]
;cp_game_ctl.h,897 :: 		tx_buffer_[2] = 'T';
MOVS	R4, #84
MOVW	R3, #lo_addr(P7_final_project_main_tx_buffer_+2)
MOVT	R3, #hi_addr(P7_final_project_main_tx_buffer_+2)
STRB	R4, [R3, #0]
;cp_game_ctl.h,898 :: 		tx_buffer_[3] = 'F';
MOVS	R4, #70
MOVW	R3, #lo_addr(P7_final_project_main_tx_buffer_+3)
MOVT	R3, #hi_addr(P7_final_project_main_tx_buffer_+3)
STRB	R4, [R3, #0]
;cp_game_ctl.h,899 :: 		tx_buffer_[4] = '9';
MOVS	R4, #57
MOVW	R3, #lo_addr(P7_final_project_main_tx_buffer_+4)
MOVT	R3, #hi_addr(P7_final_project_main_tx_buffer_+4)
STRB	R4, [R3, #0]
;cp_game_ctl.h,900 :: 		tx_buffer_[5] = '7';
MOVS	R4, #55
MOVW	R3, #lo_addr(P7_final_project_main_tx_buffer_+5)
MOVT	R3, #hi_addr(P7_final_project_main_tx_buffer_+5)
STRB	R4, [R3, #0]
;cp_game_ctl.h,901 :: 		tx_buffer_[6] = '5';
MOVS	R4, #53
MOVW	R3, #lo_addr(P7_final_project_main_tx_buffer_+6)
MOVT	R3, #hi_addr(P7_final_project_main_tx_buffer_+6)
STRB	R4, [R3, #0]
;cp_game_ctl.h,903 :: 		I2C1_Start();
STR	R0, [SP, #4]
BL	_I2C1_Start+0
LDR	R0, [SP, #4]
;cp_game_ctl.h,906 :: 		I2C1_Write(0x50, tx_buffer_, tx_size, END_MODE_STOP);
MOVW	R3, #1
MOV	R2, R0
; tx_size end address is: 0 (R0)
MOVW	R1, #lo_addr(P7_final_project_main_tx_buffer_+0)
MOVT	R1, #hi_addr(P7_final_project_main_tx_buffer_+0)
MOVS	R0, #80
BL	_I2C1_Write+0
;cp_game_ctl.h,908 :: 		}
L_end_EE_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _EE_write
_EE_read:
;cp_game_ctl.h,925 :: 		void EE_read(uint8_t reg_addr, uint8_t *read_buffer, uint32_t rx_size) {
SUB	SP, SP, #12
STR	LR, [SP, #0]
STRB	R0, [SP, #4]
STR	R2, [SP, #8]
;cp_game_ctl.h,928 :: 		I2C1_Start();
BL	_I2C1_Start+0
;cp_game_ctl.h,929 :: 		I2C1_Write(0x50, reg_addr, 1, END_MODE_RESTART);
MOVW	R3, #0
MOVS	R2, #1
LDRB	R1, [SP, #4]
MOVS	R0, #80
BL	_I2C1_Write+0
;cp_game_ctl.h,930 :: 		I2C1_Read(0x50, rx_buffer_, rx_size +4, END_MODE_STOP);
LDR	R3, [SP, #8]
ADDS	R3, R3, #4
MOV	R2, R3
MOVW	R3, #1
MOVW	R1, #lo_addr(P7_final_project_main_rx_buffer_+0)
MOVT	R1, #hi_addr(P7_final_project_main_rx_buffer_+0)
MOVS	R0, #80
BL	_I2C1_Read+0
;cp_game_ctl.h,933 :: 		}
L_end_EE_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _EE_read
_sort_score:
;cp_game_ctl.h,939 :: 		void sort_score(uint8_t *hs_buffer) {
SUB	SP, SP, #4
;cp_game_ctl.h,940 :: 		int32_t cell_pos = 0;
;cp_game_ctl.h,941 :: 		int32_t row_found = 0;
;cp_game_ctl.h,980 :: 		}
L_end_sort_score:
ADD	SP, SP, #4
BX	LR
; end of _sort_score
_print_top_score_list:
;cp_game_ctl.h,984 :: 		void print_top_score_list() {
SUB	SP, SP, #140
STR	LR, [SP, #0]
;cp_game_ctl.h,985 :: 		uint32_t tx_count = 0;
;cp_game_ctl.h,991 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,995 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,998 :: 		I2C1_Init();
BL	_I2C1_Init+0
;cp_game_ctl.h,1001 :: 		EE_read(0, &hs_buffer, 71);
ADD	R0, SP, #8
MOVS	R2, #71
MOV	R1, R0
MOVS	R0, #0
BL	_EE_read+0
;cp_game_ctl.h,1007 :: 		sprintf(g_str_buffer, "TOP SCORES:");
MOVW	R1, #lo_addr(?lstr_19_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_19_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,1008 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);
MOVW	R2, #32
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1011 :: 		sprintf(g_str_buffer, "test: %s", user_score_entry);
MOVW	R2, #lo_addr(P7_final_project_main_user_score_entry+0)
MOVT	R2, #hi_addr(P7_final_project_main_user_score_entry+0)
MOVW	R1, #lo_addr(?lstr_20_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_20_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,1012 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 4*PX_BLOCK);
MOVW	R2, #64
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1014 :: 		user_score_entry[3] = 0x30+5;
MOVS	R1, #53
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+3)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+3)
STRB	R1, [R0, #0]
;cp_game_ctl.h,1015 :: 		atest[0] = user_score_entry[3];
ADD	R2, SP, #136
MOVS	R0, #53
STRB	R0, [R2, #0]
;cp_game_ctl.h,1016 :: 		atest[1] = user_score_entry[4];
ADDS	R1, R2, #1
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+4)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+4)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;cp_game_ctl.h,1017 :: 		atest[2] = user_score_entry[5];
ADDS	R1, R2, #2
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+5)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+5)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;cp_game_ctl.h,1018 :: 		atest[3] = user_score_entry[6];
ADDS	R1, R2, #3
MOVW	R0, #lo_addr(P7_final_project_main_user_score_entry+6)
MOVT	R0, #hi_addr(P7_final_project_main_user_score_entry+6)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;cp_game_ctl.h,1020 :: 		test_num = atoi(atest);
MOV	R0, R2
BL	_atoi+0
; test_num start address is: 12 (R3)
SXTH	R3, R0
;cp_game_ctl.h,1021 :: 		sprintf(g_str_buffer, "atoi: %d", test_num);
MOV	R2, R3
MOVW	R1, #lo_addr(?lstr_21_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_21_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
STR	R3, [SP, #4]
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,1022 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 5*PX_BLOCK);
MOVW	R2, #80
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
LDR	R3, [SP, #4]
;cp_game_ctl.h,1024 :: 		if (test_num > 999) {
MOVW	R0, #999
CMP	R3, R0
IT	LE
BLE	L_print_top_score_list244
; test_num end address is: 12 (R3)
;cp_game_ctl.h,1025 :: 		sprintf(g_str_buffer, "test num is greater");
MOVW	R1, #lo_addr(?lstr_22_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_22_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #8
;cp_game_ctl.h,1026 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 6*PX_BLOCK);
MOVW	R2, #96
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1027 :: 		}
L_print_top_score_list244:
;cp_game_ctl.h,1031 :: 		GPIOB_ODR |= 0xFF00; // PB6 PB7
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #65280
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,1032 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_top_score_list245:
SUBS	R7, R7, #1
BNE	L_print_top_score_list245
NOP
NOP
NOP
;cp_game_ctl.h,1045 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_top_score_list247:
SUBS	R7, R7, #1
BNE	L_print_top_score_list247
NOP
NOP
NOP
;cp_game_ctl.h,1046 :: 		GPIOB_ODR |= 0xFF00;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #65280
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,1047 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_print_top_score_list249:
SUBS	R7, R7, #1
BNE	L_print_top_score_list249
NOP
NOP
NOP
;cp_game_ctl.h,1057 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_print_top_score_list251:
SUBS	R7, R7, #1
BNE	L_print_top_score_list251
NOP
NOP
NOP
;cp_game_ctl.h,1059 :: 		sprintf(g_str_buffer, "I2C data: \x20 %s", rx_buffer_);
MOVW	R2, #lo_addr(P7_final_project_main_rx_buffer_+0)
MOVT	R2, #hi_addr(P7_final_project_main_rx_buffer_+0)
MOVW	R1, #lo_addr(?lstr_23_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_23_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,1060 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 9*PX_BLOCK);
MOVW	R2, #144
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,1074 :: 		while (cur_screen_run_flag == TRUE) {}
L_print_top_score_list253:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_print_top_score_list254
IT	AL
BAL	L_print_top_score_list253
L_print_top_score_list254:
;cp_game_ctl.h,1078 :: 		set_game_phase(PHASE1_READY); // change to restart game
MOVS	R0, #1
BL	_set_game_phase+0
;cp_game_ctl.h,1080 :: 		}
L_end_print_top_score_list:
LDR	LR, [SP, #0]
ADD	SP, SP, #140
BX	LR
; end of _print_top_score_list
_EXTI15_10:
;P7_final_project_main.c,84 :: 		void EXTI15_10() iv IVT_INT_EXTI15_10  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,86 :: 		EXTI_PR |= 1 << 13;     // Rearm interrupt
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,87 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,89 :: 		while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }
L_EXTI15_10255:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_10256
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTI15_10255
L_EXTI15_10256:
;P7_final_project_main.c,91 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,93 :: 		switch (g_cur_game_phase)
IT	AL
BAL	L_EXTI15_10257
;P7_final_project_main.c,95 :: 		case PHASE_LOGO:
L_EXTI15_10259:
;P7_final_project_main.c,96 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,97 :: 		g_cur_game_phase = PHASE1_READY; // load_duck
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,98 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,100 :: 		case PHASE_INTRO:
L_EXTI15_10260:
;P7_final_project_main.c,101 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,102 :: 		g_cur_game_phase = PHASE1_READY; // load_snake_game
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,103 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,105 :: 		case PHASE1_READY:
L_EXTI15_10261:
;P7_final_project_main.c,106 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,107 :: 		g_cur_game_phase = PHASE2_PLAYING;    // Start snake game
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,108 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,110 :: 		case PHASE2_PLAYING:
L_EXTI15_10262:
;P7_final_project_main.c,111 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_EXTI15_10263:
SUBS	R7, R7, #1
BNE	L_EXTI15_10263
NOP
NOP
NOP
;P7_final_project_main.c,115 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,117 :: 		case PHASE_QUIT:
L_EXTI15_10265:
;P7_final_project_main.c,118 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,119 :: 		g_cur_game_phase = PHASE_HSCORE;
MOVS	R1, #4
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,120 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,122 :: 		case PHASE_HSCORE:
L_EXTI15_10266:
;P7_final_project_main.c,124 :: 		refresh_hs_scr(JBTN_DOWN);
MOVS	R0, #4
BL	_refresh_hs_scr+0
;P7_final_project_main.c,125 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,127 :: 		case PHASE_PRINT_TOP_TEN:
L_EXTI15_10267:
;P7_final_project_main.c,128 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,129 :: 		g_cur_game_phase = PHASE1_READY; // PHASE1_ready? seems to cause problems
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,130 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,139 :: 		default:
L_EXTI15_10268:
;P7_final_project_main.c,140 :: 		break;
IT	AL
BAL	L_EXTI15_10258
;P7_final_project_main.c,141 :: 		}
L_EXTI15_10257:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTI15_10259
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTI15_10260
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTI15_10261
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTI15_10262
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_EXTI15_10265
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_EXTI15_10266
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	EQ
BEQ	L_EXTI15_10267
IT	AL
BAL	L_EXTI15_10268
L_EXTI15_10258:
;P7_final_project_main.c,142 :: 		}
L_end_EXTI15_10:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10
_EXTIPA0:
;P7_final_project_main.c,146 :: 		void EXTIPA0() iv IVT_INT_EXTI0  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,147 :: 		EXTI_PR |= 1 << 2;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,148 :: 		while (GPIOA_IDR.B0 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPA0269:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA0270
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA0269
L_EXTIPA0270:
;P7_final_project_main.c,149 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,151 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
CMP	R0, #2
IT	NE
BNE	L_EXTIPA0271
;P7_final_project_main.c,152 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,153 :: 		game_cur_screen_run_flag = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_game_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_game_cur_screen_run_flag+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,154 :: 		g_cur_game_phase = PHASE_QUIT;
MOVS	R1, #3
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,158 :: 		TIM3_CR1 = 0; // Start TIMER3 now
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,159 :: 		}
IT	AL
BAL	L_EXTIPA0272
L_EXTIPA0271:
;P7_final_project_main.c,160 :: 		else if (g_cur_game_phase == PHASE_QUIT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_EXTIPA0273
;P7_final_project_main.c,161 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,162 :: 		g_cur_game_phase = PHASE_HSCORE;
MOVS	R1, #4
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,163 :: 		}
L_EXTIPA0273:
L_EXTIPA0272:
;P7_final_project_main.c,166 :: 		}
L_end_EXTIPA0:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPA0
_EXTIPA6:
;P7_final_project_main.c,169 :: 		void EXTIPA6() iv IVT_INT_EXTI9_5  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,170 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,173 :: 		if (GPIOB_IDR.B5 == 0) {
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6274
;P7_final_project_main.c,174 :: 		while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
L_EXTIPA6275:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6276
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6275
L_EXTIPA6276:
;P7_final_project_main.c,175 :: 		EXTI_PR |= 1 << 5;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,177 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_EXTIPA6277
;P7_final_project_main.c,178 :: 		if (g_curr_snake_dir != MOVE_UP) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTIPA6278
;P7_final_project_main.c,179 :: 		set_curr_snake_dir(MOVE_DOWN);
MOVS	R0, #3
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,180 :: 		}
L_EXTIPA6278:
;P7_final_project_main.c,181 :: 		} else if (g_cur_game_phase == PHASE_HSCORE) {
IT	AL
BAL	L_EXTIPA6279
L_EXTIPA6277:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_EXTIPA6280
;P7_final_project_main.c,182 :: 		refresh_hs_scr(MOVE_DOWN);
MOVS	R0, #3
BL	_refresh_hs_scr+0
;P7_final_project_main.c,183 :: 		}
L_EXTIPA6280:
L_EXTIPA6279:
;P7_final_project_main.c,184 :: 		}
L_EXTIPA6274:
;P7_final_project_main.c,187 :: 		if (GPIOA_IDR.B6 == 0) {
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6281
;P7_final_project_main.c,188 :: 		while(GPIOA_IDR.B6 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
L_EXTIPA6282:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6283
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6282
L_EXTIPA6283:
;P7_final_project_main.c,189 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,191 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
CMP	R0, #2
IT	NE
BNE	L_EXTIPA6284
;P7_final_project_main.c,193 :: 		EXTI_PR |= 1 << 6;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,194 :: 		while (GPIOA_IDR.B6 == 0) {
L_EXTIPA6285:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6286
;P7_final_project_main.c,195 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,196 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_EXTIPA6287:
SUBS	R7, R7, #1
BNE	L_EXTIPA6287
NOP
NOP
NOP
;P7_final_project_main.c,197 :: 		}
IT	AL
BAL	L_EXTIPA6285
L_EXTIPA6286:
;P7_final_project_main.c,198 :: 		if (g_curr_snake_dir != MOVE_LEFT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTIPA6289
;P7_final_project_main.c,199 :: 		set_curr_snake_dir(MOVE_RIGHT);
MOVS	R0, #0
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,200 :: 		}
L_EXTIPA6289:
;P7_final_project_main.c,201 :: 		}
L_EXTIPA6284:
;P7_final_project_main.c,202 :: 		}
L_EXTIPA6281:
;P7_final_project_main.c,205 :: 		}
L_end_EXTIPA6:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPA6
_EXTIPD2:
;P7_final_project_main.c,210 :: 		void EXTIPD2() iv IVT_INT_EXTI2  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,211 :: 		EXTI_PR |= 1 << 2;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,212 :: 		while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD2290:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD2291
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD2290
L_EXTIPD2291:
;P7_final_project_main.c,213 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,215 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
CMP	R0, #2
IT	NE
BNE	L_EXTIPD2292
;P7_final_project_main.c,216 :: 		if (g_curr_snake_dir != MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTIPD2293
;P7_final_project_main.c,217 :: 		set_curr_snake_dir(MOVE_LEFT);
MOVS	R0, #1
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,218 :: 		}
L_EXTIPD2293:
;P7_final_project_main.c,219 :: 		}
L_EXTIPD2292:
;P7_final_project_main.c,222 :: 		}
L_end_EXTIPD2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD2
_EXTIPD4:
;P7_final_project_main.c,227 :: 		void EXTIPD4() iv IVT_INT_EXTI4  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,228 :: 		EXTI_PR |= 1 << 4;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,229 :: 		while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD4294:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD4295
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD4294
L_EXTIPD4295:
;P7_final_project_main.c,230 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,232 :: 		if (g_cur_game_phase == PHASE2_PLAYING) {
CMP	R0, #2
IT	NE
BNE	L_EXTIPD4296
;P7_final_project_main.c,234 :: 		if (g_curr_snake_dir != MOVE_DOWN) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_EXTIPD4297
;P7_final_project_main.c,235 :: 		set_curr_snake_dir(MOVE_UP);
MOVS	R0, #2
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,236 :: 		}
L_EXTIPD4297:
;P7_final_project_main.c,237 :: 		} else if (g_cur_game_phase == PHASE_HSCORE) {
IT	AL
BAL	L_EXTIPD4298
L_EXTIPD4296:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L_EXTIPD4299
;P7_final_project_main.c,238 :: 		refresh_hs_scr(MOVE_UP);
MOVS	R0, #2
BL	_refresh_hs_scr+0
;P7_final_project_main.c,239 :: 		}
L_EXTIPD4299:
L_EXTIPD4298:
;P7_final_project_main.c,240 :: 		}
L_end_EXTIPD4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD4
_TIMER2_ISR:
;P7_final_project_main.c,243 :: 		void TIMER2_ISR() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,244 :: 		TIM2_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,245 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,247 :: 		update_game_time();
BL	_update_game_time+0
;P7_final_project_main.c,249 :: 		if (g_GAME_PHASE == PHASE2_PLAYING) {
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_TIMER2_ISR300
;P7_final_project_main.c,252 :: 		update_session_time();
BL	_update_session_time+0
;P7_final_project_main.c,255 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;P7_final_project_main.c,256 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_TIMER2_ISR301:
SUBS	R7, R7, #1
BNE	L_TIMER2_ISR301
NOP
NOP
NOP
;P7_final_project_main.c,260 :: 		update_time();
BL	_update_time+0
;P7_final_project_main.c,263 :: 		update_stats();
BL	_update_stats+0
;P7_final_project_main.c,270 :: 		debug_val = ADC1_Read(3);
MOVS	R0, #3
BL	_ADC1_Read+0
MOVW	R1, #lo_addr(_debug_val+0)
MOVT	R1, #hi_addr(_debug_val+0)
STR	R0, [R1, #0]
;P7_final_project_main.c,274 :: 		}
L_TIMER2_ISR300:
;P7_final_project_main.c,275 :: 		}
L_end_TIMER2_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER2_ISR
_TIMER3_ISR:
;P7_final_project_main.c,278 :: 		void TIMER3_ISR() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,279 :: 		g_cur_game_phase = get_game_phase();
BL	_get_game_phase+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,280 :: 		TIM3_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,282 :: 		toggle_game_clock_delay();
BL	_toggle_game_clock_delay+0
;P7_final_project_main.c,289 :: 		screen_refresh_TIM3();
BL	_screen_refresh_TIM3+0
;P7_final_project_main.c,290 :: 		}
L_end_TIMER3_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER3_ISR
_init_cfg_M_CTL:
;P7_final_project_main.c,300 :: 		void init_cfg_M_CTL() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,303 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,305 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,306 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,308 :: 		RCC_APB2ENR |= 1 << 2;                    // Enable GPIO clock for PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,309 :: 		RCC_APB2ENR |= 1 << 3;                    // Enable GPIO clock for PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,310 :: 		RCC_APB2ENR |= 1 << 4;                    // Enable GPIO clock for PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,311 :: 		RCC_APB2ENR |= 1 << 5;                    // Enable GPIO clock for PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,312 :: 		RCC_APB2ENR |= 1 << 6;                    // Enable GPIO clock for PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,313 :: 		RCC_APB2ENR |= 1 << 14;                   // Enable GPIO clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,314 :: 		RCC_APB2ENR |= 1 << 9;                   // Enable ADC1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #512
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,316 :: 		RCC_APB1ENR |= (uint32_t) 1 << 21;          // Enable I2C1 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2097152
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,319 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_14); // added here to enabed PE14 for piezo buzzer
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;P7_final_project_main.c,320 :: 		GPIOE_CRH &= (long int) ~(0xF << 24);
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R0, [R0, #0]
AND	R1, R0, #-1
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,321 :: 		GPIOE_CRH &= (uint32_t) ~(0xC <<  24) ;                    // PE14 output for Piezo buzzer 0xc inverse of 0x3
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
LDR	R0, [R0, #0]
AND	R1, R0, #-1
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,323 :: 		GPIOA_CRL &= ~(0xF << 12);                 // PA3 - Analog input mode b0000 bit[15:12]
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MVN	R0, #61440
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,326 :: 		GPIOA_CRL |= 4 << 0;                       // Enable PA0;  Quit button
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,328 :: 		GPIOA_CRL |= 4 << 4;                       // Enable PA4;  Game TIMER3 control
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,329 :: 		GPIOA_CRL |= 4 << 6;                       // Enable PA6;  joystick=RIGHT
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,330 :: 		GPIOB_CRL |= 4 << 5;                       // Enable PB5;  joystick=DOWN
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,331 :: 		GPIOD_CRL |= 4 << 2;                       // Enable PD2;  joystick=LEFT
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,332 :: 		GPIOD_CRL |= 4 << 4;                       // Enable PD4;  joystick=UP
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,333 :: 		GPIOC_CRH |= 4 << 5;                       // Enable PC13; joystick=PUSH BUTTON
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,367 :: 		}
L_end_init_cfg_M_CTL:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_cfg_M_CTL
_config_USART1:
;P7_final_project_main.c,370 :: 		void config_USART1() {
SUB	SP, SP, #4
;P7_final_project_main.c,371 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,372 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,373 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,376 :: 		USART1_BRR = 0x00000506;                    // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,380 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,382 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,383 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,384 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,385 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,387 :: 		USART1_CR1 |=   1 << 3;                     // Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,388 :: 		USART1_CR1 |=   1 << 2;                     // Rx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,390 :: 		Delay_ms(100);                              // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_config_USART1303:
SUBS	R7, R7, #1
BNE	L_config_USART1303
NOP
NOP
NOP
;P7_final_project_main.c,391 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,394 :: 		}
L_end_config_USART1:
ADD	SP, SP, #4
BX	LR
; end of _config_USART1
_init_timer2:
;P7_final_project_main.c,400 :: 		void init_timer2() {
SUB	SP, SP, #4
;P7_final_project_main.c,401 :: 		RCC_APB1ENR |= 1 << 0;                      // Enable Clock for TIMER2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,402 :: 		TIM2_CR1     = 0x0000;                      // Disable the timer for config setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,403 :: 		TIM2_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,405 :: 		TIM2_ARR     = 9000;                        // Set the auto-reload register to calclated value
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,406 :: 		TIM2_DIER   |= 1 << 0;                      // Enable TIMER2 Interrupt
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,408 :: 		}
L_end_init_timer2:
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_timer3:
;P7_final_project_main.c,412 :: 		void init_timer3() {
SUB	SP, SP, #4
;P7_final_project_main.c,413 :: 		RCC_APB1ENR |= (1 << 1);                    // Enable TIMER3 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,414 :: 		TIM3_CR1     = 0x0000;                      // Disable time for setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,415 :: 		TIM3_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,417 :: 		TIM3_ARR     = g_game_speed;                // auto-reload reg. 2 seconds so  double it = 9000*2 = 18000
MOVW	R0, #lo_addr(P7_final_project_main_g_game_speed+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_speed+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,418 :: 		TIM3_DIER   |= 1 << 0;                      // Enable interrupt
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,421 :: 		}
L_end_init_timer3:
ADD	SP, SP, #4
BX	LR
; end of _init_timer3
_init_interrupt:
;P7_final_project_main.c,425 :: 		void init_interrupt() {
SUB	SP, SP, #4
;P7_final_project_main.c,428 :: 		AFIO_EXTICR2 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,429 :: 		NVIC_ISER0   = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,433 :: 		AFIO_EXTICR1 &= ~(0xF << 0);                // PD2 = EXTI0[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,434 :: 		AFIO_EXTICR1 |= 3 << 8;                     // PD2 = EXTI2[11:8]; PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,435 :: 		AFIO_EXTICR2 |= 3 << 0;                     // PD4 = EXTI4[3:0];  PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,436 :: 		AFIO_EXTICR2 |= 1 << 4;                     // PB5 = EXTI5[7:4];  PortB = b0001;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,437 :: 		AFIO_EXTICR2 &= ~(0xF << 8);                // PA6 = EXTI6[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MVN	R0, #3840
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,438 :: 		AFIO_EXTICR4 |= 2 << 4;                     // PC13  EXTI13[7:4]; PortC = b0010;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,442 :: 		EXTI_FTSR |= 1 << 2;                        // EXTI2 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,443 :: 		EXTI_FTSR |= 1 << 4;                        // EXTI4 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,444 :: 		EXTI_FTSR |= 1 << 5;                        // EXTI5 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,445 :: 		EXTI_FTSR |= 1 << 6;                        // EXTI6 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,446 :: 		EXTI_FTSR |= 1 << 13;                       // EXTI13 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,447 :: 		EXTI_RTSR |= 1 << 0;                        // EXIT0 is RISING Edge
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,448 :: 		EXTI_IMR  |= 0x00002075;                    // Set EXTI 0,2,4,5,6,13 to not-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R1, [R0, #0]
MOVW	R0, #8309
ORRS	R1, R0
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,453 :: 		NVIC_ISER0 |= (uint32_t) 1 << 6;            // EXTI0  NVIC Pos=6:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,454 :: 		NVIC_ISER0 |= (uint32_t) 1 << 8;            // EXTI2  NVIC Pos=8:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,455 :: 		NVIC_ISER0 |= (uint32_t) 1 << 10;           // EXTI4  NVIC Pos=10:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,456 :: 		NVIC_ISER0 |= (uint32_t) 1 << 23;           // EXTI5  NVIC Pos=23: EXTI9_5
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,457 :: 		NVIC_ISER0 |= (uint32_t) 1 << 28;           // TIMER2  NVIC Pos=28
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #268435456
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,458 :: 		NVIC_ISER0 |= (uint32_t) 1 << 29;           // TIMER3  NVIC Pos=29
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #536870912
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,459 :: 		NVIC_ISER1 |= (uint32_t) 1 << 8;            // EXTI13 NVIC Pos=40: EXTI15_10
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,460 :: 		NVIC_ISER1 |= (uint32_t) 1 << 5;            // USART1 NVIC Pos=37: ISER1[63:32]; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,471 :: 		}
L_end_init_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _init_interrupt
_main:
;P7_final_project_main.c,476 :: 		void main() {
SUB	SP, SP, #4
;P7_final_project_main.c,480 :: 		int num =0;
;P7_final_project_main.c,483 :: 		init_cfg_M_CTL();
BL	_init_cfg_M_CTL+0
;P7_final_project_main.c,486 :: 		config_USART1();
BL	_config_USART1+0
;P7_final_project_main.c,491 :: 		init_timer2();
BL	_init_timer2+0
;P7_final_project_main.c,492 :: 		init_timer3();
BL	_init_timer3+0
;P7_final_project_main.c,496 :: 		init_interrupt();
BL	_init_interrupt+0
;P7_final_project_main.c,512 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,542 :: 		while (1) {
L_main305:
;P7_final_project_main.c,544 :: 		load_snake_game();
BL	_load_snake_game+0
;P7_final_project_main.c,548 :: 		init_snake_game();
BL	_init_snake_game+0
;P7_final_project_main.c,549 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;P7_final_project_main.c,550 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_main307:
SUBS	R7, R7, #1
BNE	L_main307
NOP
NOP
NOP
;P7_final_project_main.c,553 :: 		update_time();
BL	_update_time+0
;P7_final_project_main.c,556 :: 		update_stats();
BL	_update_stats+0
;P7_final_project_main.c,558 :: 		TIM2_CR1     = 0x0001; // Start TIMER2 for game time
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,559 :: 		TIM3_CR1    = 0x0001; // Start TIMER3 now
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,560 :: 		start_snake_game();
BL	_start_snake_game+0
;P7_final_project_main.c,561 :: 		g_GAME_PHASE = PHASE_QUIT;
MOVS	R1, #3
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,562 :: 		set_game_phase (PHASE_QUIT);
MOVS	R0, #3
BL	_set_game_phase+0
;P7_final_project_main.c,564 :: 		game_over_scr();
BL	_game_over_scr+0
;P7_final_project_main.c,565 :: 		game_high_score_scr();
BL	_game_high_score_scr+0
;P7_final_project_main.c,566 :: 		print_top_score_list();
BL	_print_top_score_list+0
;P7_final_project_main.c,568 :: 		}
IT	AL
BAL	L_main305
;P7_final_project_main.c,569 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
