_debug:
;cp_const_def.h,18 :: 		void debug(uint32_t value) {
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 0 (R0)
; value start address is: 0 (R0)
;cp_const_def.h,19 :: 		Delay_ms(1);
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
;cp_const_def.h,20 :: 		USART1_DR = 0xD;
MOVS	R2, #13
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,21 :: 		Delay_ms(1);
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
;cp_const_def.h,22 :: 		USART1_DR=0xA;
MOVS	R2, #10
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,23 :: 		Delay_ms(1);
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
;cp_const_def.h,24 :: 		USART1_DR = value;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; value end address is: 0 (R0)
;cp_const_def.h,25 :: 		}
L_end_debug:
ADD	SP, SP, #4
BX	LR
; end of _debug
_set_cur_screen_run_flag:
;cp_intro_screen_ctl.h,48 :: 		void set_cur_screen_run_flag(uint8_t run_flag) {
; run_flag start address is: 0 (R0)
SUB	SP, SP, #4
; run_flag end address is: 0 (R0)
; run_flag start address is: 0 (R0)
;cp_intro_screen_ctl.h,49 :: 		cur_screen_run_flag = run_flag;
MOVW	R1, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R1, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
STRB	R0, [R1, #0]
; run_flag end address is: 0 (R0)
;cp_intro_screen_ctl.h,50 :: 		}
L_end_set_cur_screen_run_flag:
ADD	SP, SP, #4
BX	LR
; end of _set_cur_screen_run_flag
_load_intro_screen_simple:
;cp_intro_screen_ctl.h,55 :: 		void load_intro_screen_simple() {
SUB	SP, SP, #16
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,58 :: 		uint8_t scroll_dir = 5; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,59 :: 		uint32_t volatile x_axis = 55;
;cp_intro_screen_ctl.h,60 :: 		uint32_t volatile y_axis = 115;
;cp_intro_screen_ctl.h,62 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,63 :: 		uint32_t  prev_val2 = 0;
;cp_intro_screen_ctl.h,68 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,70 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen_simple6:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple7
;cp_intro_screen_ctl.h,73 :: 		draw_rectangle(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_rectangle+0
;cp_intro_screen_ctl.h,75 :: 		if (scroll_dir == 1 ) {
LDRB	R0, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple8
;cp_intro_screen_ctl.h,76 :: 		if (y_axis > (SCREEN_Y_MAX-20) || x_axis > (SCREEN_X_MAX -30) ) {
LDR	R0, [SP, #12]
CMP	R0, #220
IT	HI
BHI	L__load_intro_screen_simple92
LDR	R0, [SP, #8]
CMP	R0, #290
IT	HI
BHI	L__load_intro_screen_simple91
IT	AL
BAL	L_load_intro_screen_simple11
L__load_intro_screen_simple92:
L__load_intro_screen_simple91:
;cp_intro_screen_ctl.h,77 :: 		scroll_dir = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,78 :: 		}
L_load_intro_screen_simple11:
;cp_intro_screen_ctl.h,79 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,80 :: 		y_axis+=SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,82 :: 		}
IT	AL
BAL	L_load_intro_screen_simple12
L_load_intro_screen_simple8:
;cp_intro_screen_ctl.h,85 :: 		if (y_axis < 10 || x_axis < 2) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen_simple94
LDR	R0, [SP, #8]
CMP	R0, #2
IT	CC
BCC	L__load_intro_screen_simple93
IT	AL
BAL	L_load_intro_screen_simple15
L__load_intro_screen_simple94:
L__load_intro_screen_simple93:
;cp_intro_screen_ctl.h,86 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,87 :: 		}
L_load_intro_screen_simple15:
;cp_intro_screen_ctl.h,88 :: 		x_axis-=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
SUBS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,89 :: 		y_axis-=SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,90 :: 		}
L_load_intro_screen_simple12:
;cp_intro_screen_ctl.h,91 :: 		draw_intro_screen(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_intro_screen+0
;cp_intro_screen_ctl.h,93 :: 		}
IT	AL
BAL	L_load_intro_screen_simple6
L_load_intro_screen_simple7:
;cp_intro_screen_ctl.h,94 :: 		}
L_end_load_intro_screen_simple:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _load_intro_screen_simple
_load_intro_screen:
;cp_intro_screen_ctl.h,98 :: 		void load_intro_screen() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,100 :: 		uint8_t rotation = 0;
ADD	R11, SP, #8
ADD	R10, R11, #8
MOVW	R12, #lo_addr(?ICSload_intro_screen_rotation_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_rotation_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,101 :: 		uint8_t scroll_dir = 1; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
;cp_intro_screen_ctl.h,102 :: 		uint32_t volatile x_axis = 35;
;cp_intro_screen_ctl.h,103 :: 		uint32_t volatile y_axis = 115;
; y_axis start address is: 4 (R1)
MOV	R1, #115
;cp_intro_screen_ctl.h,105 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,106 :: 		uint32_t  prev_val2 = 5;
;cp_intro_screen_ctl.h,107 :: 		uint32_t counter = 1;
MOV	R0, #1
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,114 :: 		TFT_Fill_Screen(CL_BLACK);
STR	R1, [SP, #4]
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,116 :: 		draw_info_text( 10,220);
MOVS	R1, #220
MOVS	R0, #10
BL	_draw_info_text+0
; y_axis end address is: 4 (R1)
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,119 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen16:
; y_axis start address is: 4 (R1)
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen17
;cp_intro_screen_ctl.h,122 :: 		draw_rectangle(x_axis, y_axis);
STR	R1, [SP, #4]
LDR	R0, [SP, #12]
BL	_draw_rectangle+0
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,125 :: 		if (scroll_dir == 1){
LDRB	R0, [SP, #9]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen18
;cp_intro_screen_ctl.h,126 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,127 :: 		y_axis+=SCROLL_SPEED;
ADDS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,130 :: 		if ( x_axis > (SCREEN_X_MAX -200) || y_axis > (SCREEN_Y_MAX-42) ) {
LDR	R0, [SP, #12]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen100
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen99
IT	AL
BAL	L_load_intro_screen21
L__load_intro_screen100:
L__load_intro_screen99:
;cp_intro_screen_ctl.h,131 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen22
;cp_intro_screen_ctl.h,132 :: 		scroll_dir = 2;
MOVS	R0, #2
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,133 :: 		}
IT	AL
BAL	L_load_intro_screen23
L_load_intro_screen22:
;cp_intro_screen_ctl.h,135 :: 		scroll_dir = 4;
MOVS	R0, #4
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,136 :: 		}
L_load_intro_screen23:
;cp_intro_screen_ctl.h,137 :: 		}
L_load_intro_screen21:
;cp_intro_screen_ctl.h,139 :: 		}
MOV	R1, R4
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen24
L_load_intro_screen18:
;cp_intro_screen_ctl.h,141 :: 		else if (scroll_dir == 2) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #2
IT	NE
BNE	L_load_intro_screen25
;cp_intro_screen_ctl.h,142 :: 		x_axis += X_SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,143 :: 		y_axis -= SCROLL_SPEED;
SUBS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,146 :: 		if (x_axis > (SCREEN_X_MAX -200) || y_axis <10   ) {
LDR	R0, [SP, #12]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen102
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen101
IT	AL
BAL	L_load_intro_screen28
L__load_intro_screen102:
L__load_intro_screen101:
;cp_intro_screen_ctl.h,147 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen29
;cp_intro_screen_ctl.h,148 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,149 :: 		}
IT	AL
BAL	L_load_intro_screen30
L_load_intro_screen29:
;cp_intro_screen_ctl.h,151 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,152 :: 		}
L_load_intro_screen30:
;cp_intro_screen_ctl.h,153 :: 		}
L_load_intro_screen28:
;cp_intro_screen_ctl.h,154 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen31
L_load_intro_screen25:
;cp_intro_screen_ctl.h,157 :: 		else if (scroll_dir == 3) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #3
IT	NE
BNE	L_load_intro_screen32
;cp_intro_screen_ctl.h,158 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,159 :: 		y_axis -= SCROLL_SPEED;
SUBS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,162 :: 		if ( x_axis < 10 || y_axis < 10 ) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen104
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen103
IT	AL
BAL	L_load_intro_screen35
L__load_intro_screen104:
L__load_intro_screen103:
;cp_intro_screen_ctl.h,164 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen36
;cp_intro_screen_ctl.h,165 :: 		scroll_dir = 4; //4
MOVS	R0, #4
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,166 :: 		}
IT	AL
BAL	L_load_intro_screen37
L_load_intro_screen36:
;cp_intro_screen_ctl.h,168 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,169 :: 		}
L_load_intro_screen37:
;cp_intro_screen_ctl.h,172 :: 		}
L_load_intro_screen35:
;cp_intro_screen_ctl.h,174 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen38
L_load_intro_screen32:
;cp_intro_screen_ctl.h,176 :: 		else if (scroll_dir == 4) {
; y_axis start address is: 4 (R1)
LDRB	R0, [SP, #9]
CMP	R0, #4
IT	NE
BNE	L__load_intro_screen107
;cp_intro_screen_ctl.h,177 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #1
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,178 :: 		y_axis += SCROLL_SPEED;
ADDS	R4, R1, #3
; y_axis end address is: 4 (R1)
; y_axis start address is: 16 (R4)
;cp_intro_screen_ctl.h,181 :: 		if ( x_axis < 10 || y_axis > (SCREEN_Y_MAX-42)) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen106
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen105
IT	AL
BAL	L_load_intro_screen42
L__load_intro_screen106:
L__load_intro_screen105:
;cp_intro_screen_ctl.h,183 :: 		if (rotation == 0) {
LDRB	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen43
;cp_intro_screen_ctl.h,184 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,185 :: 		} else {
IT	AL
BAL	L_load_intro_screen44
L_load_intro_screen43:
;cp_intro_screen_ctl.h,186 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #9]
;cp_intro_screen_ctl.h,188 :: 		}
L_load_intro_screen44:
;cp_intro_screen_ctl.h,195 :: 		}
L_load_intro_screen42:
;cp_intro_screen_ctl.h,196 :: 		}
; y_axis end address is: 16 (R4)
IT	AL
BAL	L_load_intro_screen39
L__load_intro_screen107:
;cp_intro_screen_ctl.h,176 :: 		else if (scroll_dir == 4) {
MOV	R4, R1
;cp_intro_screen_ctl.h,196 :: 		}
L_load_intro_screen39:
; y_axis start address is: 16 (R4)
; y_axis end address is: 16 (R4)
L_load_intro_screen38:
; y_axis start address is: 16 (R4)
; y_axis end address is: 16 (R4)
L_load_intro_screen31:
; y_axis start address is: 16 (R4)
MOV	R1, R4
; y_axis end address is: 16 (R4)
L_load_intro_screen24:
;cp_intro_screen_ctl.h,198 :: 		counter++;
; y_axis start address is: 4 (R1)
LDR	R0, [SP, #16]
ADDS	R0, R0, #1
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,199 :: 		if (counter == 5) {
CMP	R0, #5
IT	NE
BNE	L_load_intro_screen45
;cp_intro_screen_ctl.h,200 :: 		rotation = ~rotation; // change direction
LDRB	R0, [SP, #8]
MVN	R0, R0
STRB	R0, [SP, #8]
;cp_intro_screen_ctl.h,201 :: 		counter = 0;
MOVS	R0, #0
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,202 :: 		}
L_load_intro_screen45:
;cp_intro_screen_ctl.h,204 :: 		draw_intro_screen(x_axis, y_axis);
STR	R1, [SP, #4]
LDR	R0, [SP, #12]
BL	_draw_intro_screen+0
LDR	R1, [SP, #4]
;cp_intro_screen_ctl.h,206 :: 		}
; y_axis end address is: 4 (R1)
IT	AL
BAL	L_load_intro_screen16
L_load_intro_screen17:
;cp_intro_screen_ctl.h,207 :: 		}
L_end_load_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _load_intro_screen
_draw_info_text:
;cp_intro_screen_ctl.h,211 :: 		void draw_info_text(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,212 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,213 :: 		TFT_Write_Text(&intro_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_intro_msg+0)
MOVT	R0, #hi_addr(_intro_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,214 :: 		}
L_end_draw_info_text:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_info_text
_draw_rectangle:
;cp_intro_screen_ctl.h,216 :: 		void draw_rectangle(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,218 :: 		TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
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
;cp_intro_screen_ctl.h,219 :: 		TFT_Rectangle(x_axis, y_axis, x_axis+255, y_axis+15);   // 15 is miny to hide text
ADD	R3, R8, #15
ADDW	R2, R7, #255
SXTH	R3, R3
SXTH	R2, R2
SXTH	R1, R8
; y_axis end address is: 32 (R8)
SXTH	R0, R7
; x_axis end address is: 28 (R7)
BL	_TFT_Rectangle+0
;cp_intro_screen_ctl.h,222 :: 		}
L_end_draw_rectangle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_rectangle
_draw_intro_screen:
;cp_intro_screen_ctl.h,226 :: 		void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,231 :: 		TFT_Set_Font(TFT_defaultFont, CL_YELLOW, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65504
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,234 :: 		TFT_Write_Text(&pub_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_pub_msg+0)
MOVT	R0, #hi_addr(_pub_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,238 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_draw_intro_screen46:
SUBS	R7, R7, #1
BNE	L_draw_intro_screen46
NOP
NOP
NOP
;cp_intro_screen_ctl.h,240 :: 		}
L_end_draw_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_intro_screen
_init_arr:
;cp_game_ctl.h,59 :: 		void init_arr(uint8_t *in_arr, uint32_t a_size) {
; a_size start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R2, R1
MOV	R1, R0
; a_size end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 4 (R1)
; a_size start address is: 8 (R2)
;cp_game_ctl.h,60 :: 		uint32_t i=0;
;cp_game_ctl.h,62 :: 		for (i=0; i < a_size; i++) {
; i start address is: 0 (R0)
MOVS	R0, #0
; a_size end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R4, R0
MOV	R0, R2
L_init_arr48:
; i start address is: 16 (R4)
; a_size start address is: 0 (R0)
; in_arr start address is: 4 (R1)
; in_arr end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_init_arr49
; in_arr end address is: 4 (R1)
;cp_game_ctl.h,63 :: 		in_arr[i]=0xFF;
; in_arr start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
;cp_game_ctl.h,62 :: 		for (i=0; i < a_size; i++) {
ADDS	R4, R4, #1
;cp_game_ctl.h,64 :: 		}
; a_size end address is: 0 (R0)
; in_arr end address is: 4 (R1)
; i end address is: 16 (R4)
IT	AL
BAL	L_init_arr48
L_init_arr49:
;cp_game_ctl.h,65 :: 		}
L_end_init_arr:
ADD	SP, SP, #4
BX	LR
; end of _init_arr
_dump_arr_memory:
;cp_game_ctl.h,69 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
;cp_game_ctl.h,72 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_game_ctl.h,69 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
;cp_game_ctl.h,72 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_game_ctl.h,69 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 0 (R0)
;cp_game_ctl.h,70 :: 		uint32_t i = 0;
;cp_game_ctl.h,72 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
L_dump_arr_memory51:
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
CMP	R1, #300
IT	CS
BCS	L_dump_arr_memory52
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
;cp_game_ctl.h,83 :: 		while ( (USART1_SR & (1 << 7 )) == 0) {}
L_dump_arr_memory54:
; in_arr start address is: 0 (R0)
; i start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_dump_arr_memory55
IT	AL
BAL	L_dump_arr_memory54
L_dump_arr_memory55:
;cp_game_ctl.h,84 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory56:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory56
NOP
NOP
NOP
;cp_game_ctl.h,85 :: 		USART1_DR = (uint32_t)in_arr[i];
ADDS	R2, R0, R1
LDRB	R2, [R2, #0]
UXTB	R3, R2
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,86 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory58:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory58
NOP
NOP
NOP
;cp_game_ctl.h,72 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
ADDS	R1, R1, #1
;cp_game_ctl.h,88 :: 		}
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_arr_memory51
L_dump_arr_memory52:
;cp_game_ctl.h,89 :: 		}
L_end_dump_arr_memory:
ADD	SP, SP, #4
BX	LR
; end of _dump_arr_memory
_load_game_screen:
;cp_game_ctl.h,101 :: 		void load_game_screen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,102 :: 		uint32_t x_axis = 0;
;cp_game_ctl.h,103 :: 		uint32_t y_axis = 0;
;cp_game_ctl.h,104 :: 		uint32_t PX_BLOCK = 16;
;cp_game_ctl.h,105 :: 		uint32_t i=0;
;cp_game_ctl.h,107 :: 		uint32_t value = 0;
;cp_game_ctl.h,111 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOVS	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,115 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,119 :: 		TFT_Fill_Screen(CL_NAVY);
MOVW	R0, #16
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,121 :: 		TFT_SET_PEN(CL_BLACK, 0);
MOVS	R1, #0
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,122 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,136 :: 		draw_cell_xy(0, 4);
MOVS	R1, #4
MOVS	R0, #0
BL	_draw_cell_xy+0
;cp_game_ctl.h,137 :: 		draw_cell_xy(0, 5);
MOVS	R1, #5
MOVS	R0, #0
BL	_draw_cell_xy+0
;cp_game_ctl.h,138 :: 		draw_cell_xy(0, 6);
MOVS	R1, #6
MOVS	R0, #0
BL	_draw_cell_xy+0
;cp_game_ctl.h,140 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_game_ctl.h,151 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_game_screen60:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_game_screen61
IT	AL
BAL	L_load_game_screen60
L_load_game_screen61:
;cp_game_ctl.h,154 :: 		}
L_end_load_game_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _load_game_screen
_draw_snake:
;cp_game_ctl.h,155 :: 		void draw_snake() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,157 :: 		g_DS_BUFFER[0] = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,158 :: 		g_DS_BUFFER[1] = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_g_DS_BUFFER+1)
MOVT	R0, #hi_addr(_g_DS_BUFFER+1)
STRB	R1, [R0, #0]
;cp_game_ctl.h,159 :: 		g_DS_BUFFER[2] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_g_DS_BUFFER+2)
MOVT	R0, #hi_addr(_g_DS_BUFFER+2)
STRB	R1, [R0, #0]
;cp_game_ctl.h,160 :: 		g_DS_BUFFER[3] = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_g_DS_BUFFER+3)
MOVT	R0, #hi_addr(_g_DS_BUFFER+3)
STRB	R1, [R0, #0]
;cp_game_ctl.h,161 :: 		g_DS_BUFFER[4] = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_g_DS_BUFFER+4)
MOVT	R0, #hi_addr(_g_DS_BUFFER+4)
STRB	R1, [R0, #0]
;cp_game_ctl.h,162 :: 		g_DS_BUFFER[5] = EOF_ARRAY;
MOVS	R1, #255
MOVW	R0, #lo_addr(_g_DS_BUFFER+5)
MOVT	R0, #hi_addr(_g_DS_BUFFER+5)
STRB	R1, [R0, #0]
;cp_game_ctl.h,164 :: 		draw_block(&g_DS_BUFFER,1,1);
MOVS	R2, #1
MOVS	R1, #1
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_draw_block+0
;cp_game_ctl.h,167 :: 		}
L_end_draw_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_snake
_get_xy:
;cp_game_ctl.h,169 :: 		void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var ) {
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
;cp_game_ctl.h,171 :: 		uint32_t row = 0;
; row start address is: 0 (R0)
MOV	R0, #0
;cp_game_ctl.h,172 :: 		uint32_t col = 0;
;cp_game_ctl.h,173 :: 		uint32_t temp_val = *cell_pos;
LDR	R5, [R4, #0]
; cell_pos end address is: 16 (R4)
; temp_val start address is: 20 (R5)
; y_var end address is: 8 (R2)
; row end address is: 0 (R0)
; x_var end address is: 4 (R1)
; temp_val end address is: 20 (R5)
STR	R0, [SP, #0]
MOV	R0, R2
LDR	R2, [SP, #0]
;cp_game_ctl.h,177 :: 		while (temp_val >= (X_MAX_WIDTH) ) {
L_get_xy62:
; temp_val start address is: 20 (R5)
; row start address is: 8 (R2)
; y_var start address is: 0 (R0)
; x_var start address is: 4 (R1)
CMP	R5, #20
IT	CC
BCC	L_get_xy63
;cp_game_ctl.h,178 :: 		temp_val -= X_MAX_WIDTH-1;
SUBW	R4, R5, #19
MOV	R5, R4
;cp_game_ctl.h,179 :: 		++row;
ADDS	R2, R2, #1
;cp_game_ctl.h,181 :: 		if (temp_val > 0 ) {
CMP	R4, #0
IT	LS
BLS	L__get_xy108
;cp_game_ctl.h,182 :: 		--temp_val; // compensate for zero-index of array by adding 1
SUBS	R3, R5, #1
; temp_val end address is: 20 (R5)
; temp_val start address is: 16 (R4)
MOV	R4, R3
; temp_val end address is: 16 (R4)
MOV	R5, R4
;cp_game_ctl.h,183 :: 		}
IT	AL
BAL	L_get_xy64
L__get_xy108:
;cp_game_ctl.h,181 :: 		if (temp_val > 0 ) {
;cp_game_ctl.h,183 :: 		}
L_get_xy64:
;cp_game_ctl.h,185 :: 		}
; temp_val start address is: 20 (R5)
IT	AL
BAL	L_get_xy62
L_get_xy63:
;cp_game_ctl.h,197 :: 		*x_var = col;
STR	R5, [R1, #0]
; x_var end address is: 4 (R1)
; temp_val end address is: 20 (R5)
;cp_game_ctl.h,198 :: 		*y_var = row;
STR	R2, [R0, #0]
; y_var end address is: 0 (R0)
; row end address is: 8 (R2)
;cp_game_ctl.h,200 :: 		}
L_end_get_xy:
ADD	SP, SP, #4
BX	LR
; end of _get_xy
_draw_cell_pos:
;cp_game_ctl.h,230 :: 		void draw_cell_pos( uint32_t linear_pos) {
; linear_pos start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; linear_pos end address is: 0 (R0)
; linear_pos start address is: 0 (R0)
;cp_game_ctl.h,236 :: 		uint32_t cell_pos = linear_pos;
STR	R0, [SP, #12]
; linear_pos end address is: 0 (R0)
;cp_game_ctl.h,238 :: 		get_xy(&cell_pos, &x_var, &y_var );
ADD	R3, SP, #8
ADD	R2, SP, #4
ADD	R1, SP, #12
MOV	R0, R1
MOV	R1, R2
MOV	R2, R3
BL	_get_xy+0
;cp_game_ctl.h,241 :: 		debug(x_var);
LDR	R0, [SP, #4]
BL	_debug+0
;cp_game_ctl.h,242 :: 		debug(y_var);
LDR	R0, [SP, #8]
BL	_debug+0
;cp_game_ctl.h,248 :: 		PX_BLOCK + (PX_BLOCK * y_var)
LDR	R1, [SP, #8]
LSLS	R4, R1, #4
ADDW	R3, R4, #16
;cp_game_ctl.h,247 :: 		PX_BLOCK + (PX_BLOCK * x_var),
LDR	R1, [SP, #4]
LSLS	R2, R1, #4
ADDW	R1, R2, #16
;cp_game_ctl.h,248 :: 		PX_BLOCK + (PX_BLOCK * y_var)
SXTH	R3, R3
;cp_game_ctl.h,245 :: 		PX_BLOCK * x_var,
SXTH	R0, R2
;cp_game_ctl.h,247 :: 		PX_BLOCK + (PX_BLOCK * x_var),
SXTH	R2, R1
;cp_game_ctl.h,246 :: 		(y_var * PX_BLOCK),
SXTH	R1, R4
;cp_game_ctl.h,248 :: 		PX_BLOCK + (PX_BLOCK * y_var)
BL	_TFT_Rectangle+0
;cp_game_ctl.h,251 :: 		}
L_end_draw_cell_pos:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _draw_cell_pos
_draw_cell_xy:
;cp_game_ctl.h,253 :: 		void draw_cell_xy(uint32_t x_var, uint32_t y_var) {
; y_var start address is: 4 (R1)
; x_var start address is: 0 (R0)
SUB	SP, SP, #4
; y_var end address is: 4 (R1)
; x_var end address is: 0 (R0)
; x_var start address is: 0 (R0)
; y_var start address is: 4 (R1)
;cp_game_ctl.h,254 :: 		uint32_t linear_val = 0;
;cp_game_ctl.h,265 :: 		linear_val = ( (y_var * X_MAX_WIDTH) + x_var );
MOV	R2, #20
MULS	R2, R1, R2
; y_var end address is: 4 (R1)
ADDS	R3, R2, R0
; x_var end address is: 0 (R0)
;cp_game_ctl.h,267 :: 		g_DS_BUFFER[linear_val] = 1;
MOVW	R2, #lo_addr(_g_DS_BUFFER+0)
MOVT	R2, #hi_addr(_g_DS_BUFFER+0)
ADDS	R3, R2, R3
MOVS	R2, #1
STRB	R2, [R3, #0]
;cp_game_ctl.h,269 :: 		}
L_end_draw_cell_xy:
ADD	SP, SP, #4
BX	LR
; end of _draw_cell_xy
_dump_ds_buffer:
;cp_game_ctl.h,272 :: 		void dump_ds_buffer() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;cp_game_ctl.h,274 :: 		uint32_t i=0;
;cp_game_ctl.h,276 :: 		for (i=0; i < MAX_BLOCK_COUNT; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; i end address is: 4 (R1)
L_dump_ds_buffer65:
; i start address is: 4 (R1)
CMP	R1, #300
IT	CS
BCS	L_dump_ds_buffer66
;cp_game_ctl.h,277 :: 		if (g_DS_BUFFER[i] == 1) {
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_dump_ds_buffer68
;cp_game_ctl.h,278 :: 		draw_cell_pos(i);
STR	R1, [SP, #4]
MOV	R0, R1
BL	_draw_cell_pos+0
LDR	R1, [SP, #4]
;cp_game_ctl.h,279 :: 		}
L_dump_ds_buffer68:
;cp_game_ctl.h,276 :: 		for (i=0; i < MAX_BLOCK_COUNT; i++) {
ADDS	R1, R1, #1
;cp_game_ctl.h,281 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_ds_buffer65
L_dump_ds_buffer66:
;cp_game_ctl.h,282 :: 		}
L_end_dump_ds_buffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _dump_ds_buffer
_draw_block:
;cp_game_ctl.h,284 :: 		void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos) {
; row_count start address is: 8 (R2)
; col_count start address is: 24 (R6)
; dp_buffer start address is: 0 (R0)
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_game_ctl.h,288 :: 		uint32_t row_count = 0;
;cp_game_ctl.h,287 :: 		uint32_t col_count = 0;
;cp_game_ctl.h,284 :: 		void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos) {
;cp_game_ctl.h,287 :: 		uint32_t col_count = 0;
;cp_game_ctl.h,288 :: 		uint32_t row_count = 0;
;cp_game_ctl.h,284 :: 		void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos) {
; row_count end address is: 8 (R2)
; col_count end address is: 24 (R6)
; dp_buffer end address is: 0 (R0)
; dp_buffer start address is: 0 (R0)
;cp_game_ctl.h,286 :: 		uint32_t i = 0;
;cp_game_ctl.h,287 :: 		uint32_t col_count = 0;
; col_count start address is: 24 (R6)
MOV	R6, #0
;cp_game_ctl.h,288 :: 		uint32_t row_count = 0;
; row_count start address is: 8 (R2)
MOV	R2, #0
;cp_game_ctl.h,296 :: 		for (i=0; i < MAX_BLOCK_COUNT; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; col_count end address is: 24 (R6)
; row_count end address is: 8 (R2)
; i end address is: 4 (R1)
L_draw_block69:
; i start address is: 4 (R1)
; row_count start address is: 8 (R2)
; col_count start address is: 24 (R6)
; dp_buffer start address is: 0 (R0)
; dp_buffer end address is: 0 (R0)
CMP	R1, #300
IT	CS
BCS	L_draw_block70
; dp_buffer end address is: 0 (R0)
;cp_game_ctl.h,298 :: 		if (dp_buffer[i] == 0xFF) {
; dp_buffer start address is: 0 (R0)
ADDS	R3, R0, R1
LDRB	R3, [R3, #0]
CMP	R3, #255
IT	NE
BNE	L_draw_block72
; col_count end address is: 24 (R6)
; dp_buffer end address is: 0 (R0)
; row_count end address is: 8 (R2)
; i end address is: 4 (R1)
;cp_game_ctl.h,299 :: 		break;      //EOF reached.
IT	AL
BAL	L_draw_block70
;cp_game_ctl.h,300 :: 		}
L_draw_block72:
;cp_game_ctl.h,304 :: 		else if (dp_buffer[i] == 1) {
; i start address is: 4 (R1)
; row_count start address is: 8 (R2)
; dp_buffer start address is: 0 (R0)
; col_count start address is: 24 (R6)
ADDS	R3, R0, R1
LDRB	R3, [R3, #0]
CMP	R3, #1
IT	NE
BNE	L_draw_block74
;cp_game_ctl.h,307 :: 		TFT_Rectangle(PX_BLOCK*i, row_count, (PX_BLOCK + (PX_BLOCK*i)),(PX_BLOCK+(PX_BLOCK*row_count))   );
LSLS	R3, R2, #4
ADDW	R5, R3, #16
LSLS	R4, R1, #4
ADDW	R3, R4, #16
STR	R0, [SP, #4]
STR	R6, [SP, #8]
STR	R2, [SP, #12]
STR	R1, [SP, #16]
SXTH	R1, R2
SXTH	R2, R3
SXTH	R3, R5
SXTH	R0, R4
BL	_TFT_Rectangle+0
LDR	R1, [SP, #16]
LDR	R2, [SP, #12]
LDR	R6, [SP, #8]
LDR	R0, [SP, #4]
;cp_game_ctl.h,308 :: 		}
L_draw_block74:
;cp_game_ctl.h,311 :: 		col_count++;
ADDS	R3, R6, #1
; col_count end address is: 24 (R6)
; col_count start address is: 16 (R4)
MOV	R4, R3
;cp_game_ctl.h,312 :: 		if (col_count > X_MAX_WIDTH-1) {
CMP	R3, #19
IT	LS
BLS	L__draw_block109
;cp_game_ctl.h,313 :: 		row_count++;
ADDS	R2, R2, #1
; row_count end address is: 8 (R2)
;cp_game_ctl.h,314 :: 		}
IT	AL
BAL	L_draw_block75
L__draw_block109:
;cp_game_ctl.h,312 :: 		if (col_count > X_MAX_WIDTH-1) {
;cp_game_ctl.h,314 :: 		}
L_draw_block75:
;cp_game_ctl.h,296 :: 		for (i=0; i < MAX_BLOCK_COUNT; i++) {
; row_count start address is: 8 (R2)
ADDS	R1, R1, #1
;cp_game_ctl.h,315 :: 		}
; dp_buffer end address is: 0 (R0)
; col_count end address is: 16 (R4)
; row_count end address is: 8 (R2)
; i end address is: 4 (R1)
MOV	R6, R4
IT	AL
BAL	L_draw_block69
L_draw_block70:
;cp_game_ctl.h,319 :: 		}
L_end_draw_block:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _draw_block
_duck_sprite:
;cp_game_ctl.h,328 :: 		void duck_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,329 :: 		TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #65504
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_game_ctl.h,330 :: 		draw_cell_xy(8,4);
MOVS	R1, #4
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,331 :: 		draw_cell_xy(9,4);
MOVS	R1, #4
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,332 :: 		draw_cell_xy(10,4);
MOVS	R1, #4
MOVS	R0, #10
BL	_draw_cell_xy+0
;cp_game_ctl.h,334 :: 		draw_cell_xy(7,5);
MOVS	R1, #5
MOVS	R0, #7
BL	_draw_cell_xy+0
;cp_game_ctl.h,335 :: 		draw_cell_xy(8,5);
MOVS	R1, #5
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,336 :: 		draw_cell_xy(9,5);
MOVS	R1, #5
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,338 :: 		TFT_SET_Brush(1, CL_BLACK, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_game_ctl.h,339 :: 		draw_cell_xy(10,5);
MOVS	R1, #5
MOVS	R0, #10
BL	_draw_cell_xy+0
;cp_game_ctl.h,342 :: 		TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #65504
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_game_ctl.h,343 :: 		draw_cell_xy(11,5); //face
MOVS	R1, #5
MOVS	R0, #11
BL	_draw_cell_xy+0
;cp_game_ctl.h,344 :: 		draw_cell_xy(2,6);
MOVS	R1, #6
MOVS	R0, #2
BL	_draw_cell_xy+0
;cp_game_ctl.h,345 :: 		draw_cell_xy(3,6);
MOVS	R1, #6
MOVS	R0, #3
BL	_draw_cell_xy+0
;cp_game_ctl.h,346 :: 		draw_cell_xy(7,6);
MOVS	R1, #6
MOVS	R0, #7
BL	_draw_cell_xy+0
;cp_game_ctl.h,347 :: 		draw_cell_xy(8,6);
MOVS	R1, #6
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,348 :: 		draw_cell_xy(9,6);
MOVS	R1, #6
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,349 :: 		draw_cell_xy(10,6);
MOVS	R1, #6
MOVS	R0, #10
BL	_draw_cell_xy+0
;cp_game_ctl.h,351 :: 		TFT_SET_Brush(1, CL_RED, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #63488
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_game_ctl.h,352 :: 		draw_cell_xy(11,6);
MOVS	R1, #6
MOVS	R0, #11
BL	_draw_cell_xy+0
;cp_game_ctl.h,353 :: 		draw_cell_xy(12,6);
MOVS	R1, #6
MOVS	R0, #12
BL	_draw_cell_xy+0
;cp_game_ctl.h,354 :: 		draw_cell_xy(13,6);
MOVS	R1, #6
MOVS	R0, #13
BL	_draw_cell_xy+0
;cp_game_ctl.h,357 :: 		draw_cell_xy(11,7);
MOVS	R1, #7
MOVS	R0, #11
BL	_draw_cell_xy+0
;cp_game_ctl.h,358 :: 		draw_cell_xy(12,7);
MOVS	R1, #7
MOVS	R0, #12
BL	_draw_cell_xy+0
;cp_game_ctl.h,360 :: 		TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #65504
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;cp_game_ctl.h,361 :: 		draw_cell_xy(1,7);
MOVS	R1, #7
MOVS	R0, #1
BL	_draw_cell_xy+0
;cp_game_ctl.h,362 :: 		draw_cell_xy(2,7);
MOVS	R1, #7
MOVS	R0, #2
BL	_draw_cell_xy+0
;cp_game_ctl.h,363 :: 		draw_cell_xy(3,7);
MOVS	R1, #7
MOVS	R0, #3
BL	_draw_cell_xy+0
;cp_game_ctl.h,364 :: 		draw_cell_xy(4,7);
MOVS	R1, #7
MOVS	R0, #4
BL	_draw_cell_xy+0
;cp_game_ctl.h,365 :: 		draw_cell_xy(8,7);
MOVS	R1, #7
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,366 :: 		draw_cell_xy(9,7);
MOVS	R1, #7
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,367 :: 		draw_cell_xy(10,7);
MOVS	R1, #7
MOVS	R0, #10
BL	_draw_cell_xy+0
;cp_game_ctl.h,368 :: 		draw_cell_xy(0,8);
MOVS	R1, #8
MOVS	R0, #0
BL	_draw_cell_xy+0
;cp_game_ctl.h,369 :: 		draw_cell_xy(1,8);
MOVS	R1, #8
MOVS	R0, #1
BL	_draw_cell_xy+0
;cp_game_ctl.h,370 :: 		draw_cell_xy(2,8);
MOVS	R1, #8
MOVS	R0, #2
BL	_draw_cell_xy+0
;cp_game_ctl.h,371 :: 		draw_cell_xy(3,8);
MOVS	R1, #8
MOVS	R0, #3
BL	_draw_cell_xy+0
;cp_game_ctl.h,372 :: 		draw_cell_xy(4,8);
MOVS	R1, #8
MOVS	R0, #4
BL	_draw_cell_xy+0
;cp_game_ctl.h,373 :: 		draw_cell_xy(5,8);
MOVS	R1, #8
MOVS	R0, #5
BL	_draw_cell_xy+0
;cp_game_ctl.h,374 :: 		draw_cell_xy(6,8);
MOVS	R1, #8
MOVS	R0, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,375 :: 		draw_cell_xy(7,8);
MOVS	R1, #8
MOVS	R0, #7
BL	_draw_cell_xy+0
;cp_game_ctl.h,376 :: 		draw_cell_xy(8,8);
MOVS	R1, #8
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,377 :: 		draw_cell_xy(9,8);
MOVS	R1, #8
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,378 :: 		draw_cell_xy(10,8);
MOVS	R1, #8
MOVS	R0, #10
BL	_draw_cell_xy+0
;cp_game_ctl.h,379 :: 		draw_cell_xy(1,9);
MOVS	R1, #9
MOVS	R0, #1
BL	_draw_cell_xy+0
;cp_game_ctl.h,380 :: 		draw_cell_xy(2,9);
MOVS	R1, #9
MOVS	R0, #2
BL	_draw_cell_xy+0
;cp_game_ctl.h,381 :: 		draw_cell_xy(3,9);
MOVS	R1, #9
MOVS	R0, #3
BL	_draw_cell_xy+0
;cp_game_ctl.h,382 :: 		draw_cell_xy(4,9);
MOVS	R1, #9
MOVS	R0, #4
BL	_draw_cell_xy+0
;cp_game_ctl.h,383 :: 		draw_cell_xy(5,9);
MOVS	R1, #9
MOVS	R0, #5
BL	_draw_cell_xy+0
;cp_game_ctl.h,384 :: 		draw_cell_xy(6,9);
MOVS	R1, #9
MOVS	R0, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,385 :: 		draw_cell_xy(7,9);
MOVS	R1, #9
MOVS	R0, #7
BL	_draw_cell_xy+0
;cp_game_ctl.h,386 :: 		draw_cell_xy(8,9);
MOVS	R1, #9
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,387 :: 		draw_cell_xy(9,9);
MOVS	R1, #9
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,388 :: 		draw_cell_xy(10,9);
MOVS	R1, #9
MOVS	R0, #10
BL	_draw_cell_xy+0
;cp_game_ctl.h,389 :: 		draw_cell_xy(2,10);
MOVS	R1, #10
MOVS	R0, #2
BL	_draw_cell_xy+0
;cp_game_ctl.h,390 :: 		draw_cell_xy(3,10);
MOVS	R1, #10
MOVS	R0, #3
BL	_draw_cell_xy+0
;cp_game_ctl.h,391 :: 		draw_cell_xy(4,10);
MOVS	R1, #10
MOVS	R0, #4
BL	_draw_cell_xy+0
;cp_game_ctl.h,392 :: 		draw_cell_xy(5,10);
MOVS	R1, #10
MOVS	R0, #5
BL	_draw_cell_xy+0
;cp_game_ctl.h,393 :: 		draw_cell_xy(6,10);
MOVS	R1, #10
MOVS	R0, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,394 :: 		draw_cell_xy(7,10);
MOVS	R1, #10
MOVS	R0, #7
BL	_draw_cell_xy+0
;cp_game_ctl.h,395 :: 		draw_cell_xy(8,10);
MOVS	R1, #10
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,396 :: 		draw_cell_xy(9,10);
MOVS	R1, #10
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,397 :: 		draw_cell_xy(10,10);
MOVS	R1, #10
MOVS	R0, #10
BL	_draw_cell_xy+0
;cp_game_ctl.h,398 :: 		draw_cell_xy(3,11);
MOVS	R1, #11
MOVS	R0, #3
BL	_draw_cell_xy+0
;cp_game_ctl.h,399 :: 		draw_cell_xy(4,11);
MOVS	R1, #11
MOVS	R0, #4
BL	_draw_cell_xy+0
;cp_game_ctl.h,400 :: 		draw_cell_xy(5,11);
MOVS	R1, #11
MOVS	R0, #5
BL	_draw_cell_xy+0
;cp_game_ctl.h,401 :: 		draw_cell_xy(6,11);
MOVS	R1, #11
MOVS	R0, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,402 :: 		draw_cell_xy(7,11);
MOVS	R1, #11
MOVS	R0, #7
BL	_draw_cell_xy+0
;cp_game_ctl.h,403 :: 		draw_cell_xy(8,11);
MOVS	R1, #11
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,404 :: 		draw_cell_xy(9,11);
MOVS	R1, #11
MOVS	R0, #9
BL	_draw_cell_xy+0
;cp_game_ctl.h,405 :: 		draw_cell_xy(4,12);
MOVS	R1, #12
MOVS	R0, #4
BL	_draw_cell_xy+0
;cp_game_ctl.h,406 :: 		draw_cell_xy(5,12);
MOVS	R1, #12
MOVS	R0, #5
BL	_draw_cell_xy+0
;cp_game_ctl.h,407 :: 		draw_cell_xy(6,12);
MOVS	R1, #12
MOVS	R0, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,408 :: 		draw_cell_xy(7,12);
MOVS	R1, #12
MOVS	R0, #7
BL	_draw_cell_xy+0
;cp_game_ctl.h,409 :: 		draw_cell_xy(8,12);
MOVS	R1, #12
MOVS	R0, #8
BL	_draw_cell_xy+0
;cp_game_ctl.h,410 :: 		}
L_end_duck_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _duck_sprite
_EXTI15_10:
;P7_final_project_main.c,89 :: 		void EXTI15_10() iv IVT_INT_EXTI15_10  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,92 :: 		if (GAME_PHASE == PHASE_INTRO) {
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_1076
;P7_final_project_main.c,93 :: 		while (GPIOC_IDR.B13 == 0) {}
L_EXTI15_1077:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_1078
IT	AL
BAL	L_EXTI15_1077
L_EXTI15_1078:
;P7_final_project_main.c,96 :: 		EXTI_PR |= 1 << 13;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,99 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,101 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,102 :: 		GAME_PHASE = PHASE_GAME1;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,103 :: 		}
IT	AL
BAL	L_EXTI15_1079
L_EXTI15_1076:
;P7_final_project_main.c,104 :: 		else if (GAME_PHASE == PHASE_GAME1) {
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_EXTI15_1080
;P7_final_project_main.c,105 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,106 :: 		GAME_PHASE = PHASE_GAME2;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,108 :: 		}
L_EXTI15_1080:
L_EXTI15_1079:
;P7_final_project_main.c,109 :: 		}
L_end_EXTI15_10:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10
_EXTIPA6:
;P7_final_project_main.c,112 :: 		void EXTIPA6() iv IVT_INT_EXTI9_5  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,113 :: 		EXTI_PR |= 1 << 6;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,114 :: 		while (GPIOA_IDR.B6 == 0) {}
L_EXTIPA681:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA682
IT	AL
BAL	L_EXTIPA681
L_EXTIPA682:
;P7_final_project_main.c,116 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,118 :: 		}
L_end_EXTIPA6:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPA6
_init_cfg_M_CTL:
;P7_final_project_main.c,128 :: 		void init_cfg_M_CTL() {
SUB	SP, SP, #4
;P7_final_project_main.c,131 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,133 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,134 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,136 :: 		RCC_APB2ENR |= 1 << 2;                    // Enable GPIO clock for PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,137 :: 		RCC_APB2ENR |= 1 << 3;                    // Enable GPIO clock for PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,138 :: 		RCC_APB2ENR |= 1 << 4;                    // Enable GPIO clock for PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,139 :: 		RCC_APB2ENR |= 1 << 5;                    // Enable GPIO clock for PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,140 :: 		RCC_APB2ENR |= 1 << 6;                    // Enable GPIO clock for PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,141 :: 		RCC_APB2ENR |= 1 << 14;                   // Enable GPIO clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,144 :: 		GPIOA_CRL = GPIO_INPUT_MASK;                     // Enable PA2 PA4 PA5 PA6 for joystick control
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,145 :: 		GPIOE_CRH = 0xFF00;
MOVW	R1, #65280
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,148 :: 		GPIOA_CRL |= 4 << 6;                       // Enable PA6;  joystick=RIGHT
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,149 :: 		GPIOB_CRL |= 4 << 5;                       // Enable PB5;  joystick=DOWN
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,150 :: 		GPIOD_CRL |= 4 << 2;                       // Enable PD2;  joystick=LEFT
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,151 :: 		GPIOD_CRL |= 4 << 4;                       // Enable PD4;  joystick=UP
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,152 :: 		GPIOC_CRH |= 4 << 5;                       // Enable PC13; joystick=PUSH BUTTON
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,153 :: 		}
L_end_init_cfg_M_CTL:
ADD	SP, SP, #4
BX	LR
; end of _init_cfg_M_CTL
_config_USART1:
;P7_final_project_main.c,156 :: 		void config_USART1() {
SUB	SP, SP, #4
;P7_final_project_main.c,157 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,158 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,159 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,162 :: 		USART1_BRR = 0x00000506;                    // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,166 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,168 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,169 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,170 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,171 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,173 :: 		USART1_CR1 |=   1 << 3;                     // Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,174 :: 		USART1_CR1 |=   1 << 2;                     // Rx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,176 :: 		Delay_ms(100);                              // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_config_USART183:
SUBS	R7, R7, #1
BNE	L_config_USART183
NOP
NOP
NOP
;P7_final_project_main.c,177 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,178 :: 		}
L_end_config_USART1:
ADD	SP, SP, #4
BX	LR
; end of _config_USART1
_init_timer2:
;P7_final_project_main.c,183 :: 		void init_timer2() {
SUB	SP, SP, #4
;P7_final_project_main.c,184 :: 		RCC_APB1ENR |= 1 << 0;                      // Enable Clock for TIMER2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,185 :: 		TIM2_CR1     = 0x0000;                      // Disable the timer for config setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,186 :: 		TIM2_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,188 :: 		TIM2_ARR     = 9000;                        // Set the auto-reload register to calclated value
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,189 :: 		TIM2_DIER  |= 1 << 0;                      // Enable TIMER2 Interrupt
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,190 :: 		TIM2_CR1     = 0x0001;                      // After timer setup, enable TIMER2 bit[1]; bit[4]=0 counting up.
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,191 :: 		}
L_end_init_timer2:
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_interrupt:
;P7_final_project_main.c,195 :: 		void init_interrupt() {
SUB	SP, SP, #4
;P7_final_project_main.c,198 :: 		AFIO_EXTICR2 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,199 :: 		NVIC_ISER0   = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,202 :: 		AFIO_EXTICR1 |= 3 << 8;                     // PD2 = EXTI2[11:8]; PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,203 :: 		AFIO_EXTICR2 |= 3 << 0;                     // PD4 = EXTI4[3:0];  PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,204 :: 		AFIO_EXTICR2 |= 1 << 4;                     // PB5 = EXTI5[7:4];  PortB = b0001;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,205 :: 		AFIO_EXTICR2 &= ~(0xF << 8);                // PA6 = EXTI6[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MVN	R0, #3840
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,206 :: 		AFIO_EXTICR4 |= 2 << 4;                     // PC13  EXTI13[7:4]; PortC = b0010;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,210 :: 		EXTI_FTSR |= 1 << 6; // EXTI6 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,211 :: 		EXTI_FTSR |= 1 << 13; // EXTI13 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,214 :: 		EXTI_IMR |= 0x00002074;      // Set EXTI2,4,5,6,13 to not-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R1, [R0, #0]
MOVW	R0, #8308
ORRS	R1, R0
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,219 :: 		NVIC_ISER0 |= (uint32_t) 1 << 8;            // EXTI2  NVIC Pos=8:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,220 :: 		NVIC_ISER0 |= (uint32_t) 1 << 10;           // EXTI4  NVIC Pos=10:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,221 :: 		NVIC_ISER0 |= (uint32_t) 1 << 23;           // EXTI5  NVIC Pos=23: EXTI9_5
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,222 :: 		NVIC_ISER1 |= (uint32_t) 1 << 8;            // EXTI13 NVIC Pos=40: EXTI15_10
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,223 :: 		NVIC_ISER1 |= (uint32_t) 1 << 5;            // USART1 NVIC Pos=37: ISER1[63:32]; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,225 :: 		}
L_end_init_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _init_interrupt
_rand_num_gen:
;P7_final_project_main.c,228 :: 		uint32_t rand_num_gen() {
SUB	SP, SP, #4
;P7_final_project_main.c,229 :: 		uint32_t ret = 0;
;P7_final_project_main.c,230 :: 		ret = TIM2_CNT % 100;
MOVW	R0, #lo_addr(TIM2_CNT+0)
MOVT	R0, #hi_addr(TIM2_CNT+0)
LDR	R2, [R0, #0]
MOVS	R1, #100
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
;P7_final_project_main.c,231 :: 		return ret ;
;P7_final_project_main.c,232 :: 		}
L_end_rand_num_gen:
ADD	SP, SP, #4
BX	LR
; end of _rand_num_gen
_main:
;P7_final_project_main.c,236 :: 		void main() {
SUB	SP, SP, #4
;P7_final_project_main.c,240 :: 		int num =0;
;P7_final_project_main.c,243 :: 		init_cfg_M_CTL();
BL	_init_cfg_M_CTL+0
;P7_final_project_main.c,246 :: 		config_USART1();
BL	_config_USART1+0
;P7_final_project_main.c,251 :: 		init_timer2();
BL	_init_timer2+0
;P7_final_project_main.c,255 :: 		init_interrupt();
BL	_init_interrupt+0
;P7_final_project_main.c,259 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,267 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,268 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,269 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,272 :: 		load_game_screen();
BL	_load_game_screen+0
;P7_final_project_main.c,275 :: 		TFT_SET_Brush(1, CL_RED, 0, 0, 0 ,0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #63488
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;P7_final_project_main.c,276 :: 		TFT_Rectangle(0, 0, 320, 240);
MOVS	R3, #240
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;P7_final_project_main.c,277 :: 		TFT_Fill_Screen(CL_RED);
MOVW	R0, #63488
BL	_TFT_Fill_Screen+0
;P7_final_project_main.c,279 :: 		Delay_ms(3000);
MOVW	R7, #20735
MOVT	R7, #549
NOP
NOP
L_main85:
SUBS	R7, R7, #1
BNE	L_main85
NOP
NOP
NOP
;P7_final_project_main.c,281 :: 		while (1) {
L_main87:
;P7_final_project_main.c,283 :: 		}
IT	AL
BAL	L_main87
;P7_final_project_main.c,284 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
