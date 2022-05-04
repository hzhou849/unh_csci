_debug:
;cp_const_def.h,53 :: 		void debug(uint32_t value) {
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 0 (R0)
; value start address is: 0 (R0)
;cp_const_def.h,54 :: 		Delay_ms(1);
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
;cp_const_def.h,55 :: 		USART1_DR = 0xD;
MOVS	R2, #13
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,56 :: 		Delay_ms(1);
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
;cp_const_def.h,57 :: 		USART1_DR=0xA;
MOVS	R2, #10
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,58 :: 		Delay_ms(1);
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
;cp_const_def.h,59 :: 		USART1_DR = value;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; value end address is: 0 (R0)
;cp_const_def.h,60 :: 		}
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
BHI	L__load_intro_screen_simple120
LDR	R0, [SP, #8]
CMP	R0, #290
IT	HI
BHI	L__load_intro_screen_simple119
IT	AL
BAL	L_load_intro_screen_simple11
L__load_intro_screen_simple120:
L__load_intro_screen_simple119:
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
BCC	L__load_intro_screen_simple122
LDR	R0, [SP, #8]
CMP	R0, #2
IT	CC
BCC	L__load_intro_screen_simple121
IT	AL
BAL	L_load_intro_screen_simple15
L__load_intro_screen_simple122:
L__load_intro_screen_simple121:
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
BHI	L__load_intro_screen128
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen127
IT	AL
BAL	L_load_intro_screen21
L__load_intro_screen128:
L__load_intro_screen127:
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
BHI	L__load_intro_screen130
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen129
IT	AL
BAL	L_load_intro_screen28
L__load_intro_screen130:
L__load_intro_screen129:
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
BCC	L__load_intro_screen132
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen131
IT	AL
BAL	L_load_intro_screen35
L__load_intro_screen132:
L__load_intro_screen131:
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
BNE	L__load_intro_screen135
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
BCC	L__load_intro_screen134
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen133
IT	AL
BAL	L_load_intro_screen42
L__load_intro_screen134:
L__load_intro_screen133:
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
L__load_intro_screen135:
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
;cp_intro_screen_ctl.h,212 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
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
_set_sprite_offset:
;cp_pix_render.h,53 :: 		void set_sprite_offset(uint32_t ofs_x, uint32_t ofs_y) {
; ofs_y start address is: 4 (R1)
; ofs_x start address is: 0 (R0)
SUB	SP, SP, #4
; ofs_y end address is: 4 (R1)
; ofs_x end address is: 0 (R0)
; ofs_x start address is: 0 (R0)
; ofs_y start address is: 4 (R1)
;cp_pix_render.h,54 :: 		offset_x = ofs_x;
MOVW	R2, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_x+0)
STR	R0, [R2, #0]
; ofs_x end address is: 0 (R0)
;cp_pix_render.h,55 :: 		offset_y = ofs_y;
MOVW	R2, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_y+0)
STR	R1, [R2, #0]
; ofs_y end address is: 4 (R1)
;cp_pix_render.h,56 :: 		}
L_end_set_sprite_offset:
ADD	SP, SP, #4
BX	LR
; end of _set_sprite_offset
_get_offset_x:
;cp_pix_render.h,58 :: 		uint32_t get_offset_x() {
SUB	SP, SP, #4
;cp_pix_render.h,59 :: 		return offset_x;
MOVW	R0, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,60 :: 		}
L_end_get_offset_x:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_x
_get_offset_y:
;cp_pix_render.h,61 :: 		uint32_t get_offset_y() {
SUB	SP, SP, #4
;cp_pix_render.h,62 :: 		return offset_y;
MOVW	R0, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,63 :: 		}
L_end_get_offset_y:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_y
_get_xy:
;cp_pix_render.h,66 :: 		void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var ) {
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
;cp_pix_render.h,68 :: 		uint32_t row = 0;
; row start address is: 0 (R0)
MOV	R0, #0
;cp_pix_render.h,69 :: 		uint32_t col = 0;
;cp_pix_render.h,70 :: 		uint32_t temp_val = *cell_pos;
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
;cp_pix_render.h,74 :: 		while (temp_val >= (MAX_COL_WIDTH) ) {
L_get_xy48:
; temp_val start address is: 20 (R5)
; row start address is: 8 (R2)
; y_var start address is: 0 (R0)
; x_var start address is: 4 (R1)
CMP	R5, #20
IT	CC
BCC	L_get_xy49
;cp_pix_render.h,75 :: 		temp_val -= MAX_COL_WIDTH-1;
SUBW	R4, R5, #19
MOV	R5, R4
;cp_pix_render.h,76 :: 		++row;
ADDS	R2, R2, #1
;cp_pix_render.h,78 :: 		if (temp_val > 0 ) {
CMP	R4, #0
IT	LS
BLS	L__get_xy136
;cp_pix_render.h,79 :: 		--temp_val; // compensate for zero-index of array by adding 1
SUBS	R3, R5, #1
; temp_val end address is: 20 (R5)
; temp_val start address is: 16 (R4)
MOV	R4, R3
; temp_val end address is: 16 (R4)
MOV	R5, R4
;cp_pix_render.h,80 :: 		}
IT	AL
BAL	L_get_xy50
L__get_xy136:
;cp_pix_render.h,78 :: 		if (temp_val > 0 ) {
;cp_pix_render.h,80 :: 		}
L_get_xy50:
;cp_pix_render.h,82 :: 		}
; temp_val start address is: 20 (R5)
IT	AL
BAL	L_get_xy48
L_get_xy49:
;cp_pix_render.h,94 :: 		*x_var = col;
STR	R5, [R1, #0]
; x_var end address is: 4 (R1)
; temp_val end address is: 20 (R5)
;cp_pix_render.h,95 :: 		*y_var = row;
STR	R2, [R0, #0]
; y_var end address is: 0 (R0)
; row end address is: 8 (R2)
;cp_pix_render.h,97 :: 		}
L_end_get_xy:
ADD	SP, SP, #4
BX	LR
; end of _get_xy
_color_convert_32:
;cp_pix_render.h,101 :: 		uint32_t color_convert_32(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #4
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 0 (R0)
;cp_pix_render.h,103 :: 		if (color_8bit == m_YELLOW){
CMP	R0, #1
IT	NE
BNE	L_color_convert_3251
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,104 :: 		return CL_YELLOW;
MOVW	R0, #65504
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,105 :: 		} else if (color_8bit == m_BLACK) {
L_color_convert_3251:
; color_8bit start address is: 0 (R0)
CMP	R0, #0
IT	NE
BNE	L_color_convert_3253
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,106 :: 		return CL_BLACK;
MOVW	R0, #0
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,107 :: 		} else if (color_8bit == m_RED) {
L_color_convert_3253:
; color_8bit start address is: 0 (R0)
CMP	R0, #2
IT	NE
BNE	L_color_convert_3255
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,108 :: 		return CL_RED;
MOVW	R0, #63488
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,109 :: 		} else if (color_8bit == m_NAVY) {
L_color_convert_3255:
; color_8bit start address is: 0 (R0)
CMP	R0, #3
IT	NE
BNE	L_color_convert_3257
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,110 :: 		return CL_NAVY;
MOVW	R0, #16
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,111 :: 		} else if (color_8bit == m_GREEN) {
L_color_convert_3257:
; color_8bit start address is: 0 (R0)
CMP	R0, #4
IT	NE
BNE	L_color_convert_3259
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,112 :: 		return CL_GREEN;
MOVW	R0, #1024
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,113 :: 		} else {
L_color_convert_3259:
;cp_pix_render.h,114 :: 		return CL_WHITE;
MOVW	R0, #65535
;cp_pix_render.h,116 :: 		}
L_end_color_convert_32:
ADD	SP, SP, #4
BX	LR
; end of _color_convert_32
_set_brush_color:
;cp_pix_render.h,118 :: 		void set_brush_color(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R7, R0
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 28 (R7)
;cp_pix_render.h,120 :: 		px_clr = color_convert_32(color_8bit);
UXTB	R0, R7
BL	_color_convert_32+0
;cp_pix_render.h,122 :: 		TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
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
;cp_pix_render.h,123 :: 		CUR_BRUSH_COLOUR = color_8bit; // assign the new colour code
MOVW	R1, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R1, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
STRB	R7, [R1, #0]
; color_8bit end address is: 28 (R7)
;cp_pix_render.h,124 :: 		}
L_end_set_brush_color:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_brush_color
_draw_cell_pos:
;cp_pix_render.h,127 :: 		void draw_cell_pos( uint32_t linear_pos, uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; linear_pos start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; linear_pos end address is: 0 (R0)
; linear_pos start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,130 :: 		uint32_t cell_pos = linear_pos;
STR	R0, [SP, #12]
; linear_pos end address is: 0 (R0)
;cp_pix_render.h,133 :: 		if (color_8bit != CUR_BRUSH_COLOUR) {
MOVW	R2, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R2, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
LDRB	R2, [R2, #0]
CMP	R1, R2
IT	EQ
BEQ	L_draw_cell_pos61
;cp_pix_render.h,147 :: 		set_brush_color(color_8bit);
UXTB	R0, R1
; color_8bit end address is: 4 (R1)
BL	_set_brush_color+0
;cp_pix_render.h,148 :: 		}
L_draw_cell_pos61:
;cp_pix_render.h,151 :: 		get_xy(&cell_pos, &x_var, &y_var );
ADD	R4, SP, #8
ADD	R3, SP, #4
ADD	R2, SP, #12
MOV	R1, R3
MOV	R0, R2
MOV	R2, R4
BL	_get_xy+0
;cp_pix_render.h,156 :: 		x_var +=offset_x; // right 2 blocks
MOVW	R2, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R3, [R2, #0]
LDR	R2, [SP, #4]
ADDS	R6, R2, R3
STR	R6, [SP, #4]
;cp_pix_render.h,157 :: 		y_var +=offset_y; // down 1 block
MOVW	R2, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R3, [R2, #0]
LDR	R2, [SP, #8]
ADDS	R2, R2, R3
STR	R2, [SP, #8]
;cp_pix_render.h,164 :: 		PX_BLOCK + (PX_BLOCK * y_var)               // Lower-right Y
LSLS	R5, R2, #4
ADDW	R4, R5, #16
;cp_pix_render.h,163 :: 		PX_BLOCK + (PX_BLOCK * x_var),              // Lower-right X
LSLS	R3, R6, #4
ADDW	R2, R3, #16
SXTH	R2, R2
;cp_pix_render.h,162 :: 		(y_var * PX_BLOCK),                         // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,161 :: 		PX_BLOCK * x_var,                           // Upper-left X
SXTH	R0, R3
;cp_pix_render.h,164 :: 		PX_BLOCK + (PX_BLOCK * y_var)               // Lower-right Y
SXTH	R3, R4
BL	_TFT_Rectangle+0
;cp_pix_render.h,169 :: 		}
L_end_draw_cell_pos:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _draw_cell_pos
_draw_cell_xy:
;cp_pix_render.h,173 :: 		void draw_cell_xy(uint32_t x_var, uint32_t y_var) {
; y_var start address is: 4 (R1)
; x_var start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; y_var end address is: 4 (R1)
; x_var end address is: 0 (R0)
; x_var start address is: 0 (R0)
; y_var start address is: 4 (R1)
;cp_pix_render.h,174 :: 		uint32_t linear_val = 0;
;cp_pix_render.h,181 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
LSLS	R5, R1, #4
; y_var end address is: 4 (R1)
ADDW	R4, R5, #16
;cp_pix_render.h,180 :: 		PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
LSLS	R3, R0, #4
; x_var end address is: 0 (R0)
ADDW	R2, R3, #16
SXTH	R2, R2
;cp_pix_render.h,179 :: 		(y_var * PX_BLOCK),                 // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,178 :: 		PX_BLOCK * x_var,                   // Upper-left X
SXTH	R0, R3
;cp_pix_render.h,181 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
SXTH	R3, R4
BL	_TFT_Rectangle+0
;cp_pix_render.h,190 :: 		}
L_end_draw_cell_xy:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_cell_xy
_render_rect_mask:
;cp_pix_render.h,196 :: 		void render_rect_mask(uint32_t ul_x, uint32_t ul_y, uint32_t lr_x, uint32_t lr_y, uint8_t color_8bit) {
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
;cp_pix_render.h,199 :: 		set_brush_color(color_8bit);
UXTB	R0, R4
; color_8bit end address is: 16 (R4)
BL	_set_brush_color+0
;cp_pix_render.h,205 :: 		PX_BLOCK * lr_y                // Lower-right Y
LSL	R7, R11, #4
; lr_y end address is: 44 (R11)
;cp_pix_render.h,204 :: 		PX_BLOCK * lr_x,               // Lower-right X
LSL	R6, R10, #4
; lr_x end address is: 40 (R10)
;cp_pix_render.h,203 :: 		PX_BLOCK * ul_y,               // Upper-left Y
LSL	R5, R9, #4
; ul_y end address is: 36 (R9)
;cp_pix_render.h,202 :: 		PX_BLOCK * ul_x,               // Upper-left X
LSL	R4, R8, #4
; ul_x end address is: 32 (R8)
;cp_pix_render.h,205 :: 		PX_BLOCK * lr_y                // Lower-right Y
SXTH	R3, R7
;cp_pix_render.h,204 :: 		PX_BLOCK * lr_x,               // Lower-right X
SXTH	R2, R6
;cp_pix_render.h,203 :: 		PX_BLOCK * ul_y,               // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,202 :: 		PX_BLOCK * ul_x,               // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,205 :: 		PX_BLOCK * lr_y                // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,207 :: 		}
L_end_render_rect_mask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _render_rect_mask
_load_cell_xy:
;cp_pix_render.h,212 :: 		void load_cell_xy(uint32_t x_var, uint32_t y_var, uint8_t clr_code) {
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
;cp_pix_render.h,213 :: 		uint32_t linear_val = 0;
;cp_pix_render.h,225 :: 		linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
MOV	R3, #20
MULS	R3, R1, R3
; y_var end address is: 4 (R1)
ADDS	R4, R3, R0
; x_var end address is: 0 (R0)
;cp_pix_render.h,227 :: 		g_DS_BUFFER[linear_val] = color_8bit;
MOVW	R3, #lo_addr(_g_DS_BUFFER+0)
MOVT	R3, #hi_addr(_g_DS_BUFFER+0)
ADDS	R3, R3, R4
STRB	R2, [R3, #0]
; clr_code end address is: 8 (R2)
;cp_pix_render.h,229 :: 		}
L_end_load_cell_xy:
ADD	SP, SP, #4
BX	LR
; end of _load_cell_xy
_dump_ds_buffer:
;cp_pix_render.h,232 :: 		void dump_ds_buffer() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;cp_pix_render.h,233 :: 		uint32_t i=0;
;cp_pix_render.h,235 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; i end address is: 4 (R1)
L_dump_ds_buffer62:
; i start address is: 4 (R1)
CMP	R1, #300
IT	CS
BCS	L_dump_ds_buffer63
;cp_pix_render.h,237 :: 		if (g_DS_BUFFER[i] != 0xFF) {
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	EQ
BEQ	L_dump_ds_buffer65
;cp_pix_render.h,238 :: 		draw_cell_pos(i, g_DS_BUFFER[i]); // pass the colour code
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
;cp_pix_render.h,239 :: 		}
L_dump_ds_buffer65:
;cp_pix_render.h,235 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
ADDS	R1, R1, #1
;cp_pix_render.h,241 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_ds_buffer62
L_dump_ds_buffer63:
;cp_pix_render.h,242 :: 		}
L_end_dump_ds_buffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _dump_ds_buffer
_update_game_time:
;cp_game_ctl.h,61 :: 		void update_game_time () {
SUB	SP, SP, #4
;cp_game_ctl.h,62 :: 		time_count++;
MOVW	R0, #lo_addr(P7_final_project_main_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_time_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P7_final_project_main_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_time_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,63 :: 		}
L_end_update_game_time:
ADD	SP, SP, #4
BX	LR
; end of _update_game_time
_get_game_mode:
;cp_game_ctl.h,66 :: 		uint8_t get_game_mode() {
SUB	SP, SP, #4
;cp_game_ctl.h,67 :: 		return GAME_PHASE;
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
LDRB	R0, [R0, #0]
;cp_game_ctl.h,68 :: 		}
L_end_get_game_mode:
ADD	SP, SP, #4
BX	LR
; end of _get_game_mode
_init_arr:
;cp_game_ctl.h,71 :: 		void init_arr(uint8_t *in_arr, uint32_t a_size) {
; a_size start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R2, R1
MOV	R1, R0
; a_size end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 4 (R1)
; a_size start address is: 8 (R2)
;cp_game_ctl.h,72 :: 		uint32_t i=0;
;cp_game_ctl.h,74 :: 		for (i=0; i < a_size; i++) {
; i start address is: 0 (R0)
MOVS	R0, #0
; a_size end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R4, R0
MOV	R0, R2
L_init_arr66:
; i start address is: 16 (R4)
; a_size start address is: 0 (R0)
; in_arr start address is: 4 (R1)
; in_arr end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_init_arr67
; in_arr end address is: 4 (R1)
;cp_game_ctl.h,75 :: 		in_arr[i]=0xFF;
; in_arr start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
;cp_game_ctl.h,74 :: 		for (i=0; i < a_size; i++) {
ADDS	R4, R4, #1
;cp_game_ctl.h,76 :: 		}
; a_size end address is: 0 (R0)
; in_arr end address is: 4 (R1)
; i end address is: 16 (R4)
IT	AL
BAL	L_init_arr66
L_init_arr67:
;cp_game_ctl.h,77 :: 		}
L_end_init_arr:
ADD	SP, SP, #4
BX	LR
; end of _init_arr
_dump_arr_memory:
;cp_game_ctl.h,81 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
;cp_game_ctl.h,84 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_game_ctl.h,81 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
;cp_game_ctl.h,84 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_game_ctl.h,81 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 0 (R0)
;cp_game_ctl.h,82 :: 		uint32_t i = 0;
;cp_game_ctl.h,84 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
L_dump_arr_memory69:
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
CMP	R1, #300
IT	CS
BCS	L_dump_arr_memory70
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
;cp_game_ctl.h,87 :: 		while ( (USART1_SR & (1 << 7 )) == 0) {}
L_dump_arr_memory72:
; in_arr start address is: 0 (R0)
; i start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_dump_arr_memory73
IT	AL
BAL	L_dump_arr_memory72
L_dump_arr_memory73:
;cp_game_ctl.h,88 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory74:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory74
NOP
NOP
NOP
;cp_game_ctl.h,89 :: 		USART1_DR = (uint32_t)in_arr[i];
ADDS	R2, R0, R1
LDRB	R2, [R2, #0]
UXTB	R3, R2
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,90 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory76:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory76
NOP
NOP
NOP
;cp_game_ctl.h,84 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
ADDS	R1, R1, #1
;cp_game_ctl.h,92 :: 		}
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_arr_memory69
L_dump_arr_memory70:
;cp_game_ctl.h,93 :: 		}
L_end_dump_arr_memory:
ADD	SP, SP, #4
BX	LR
; end of _dump_arr_memory
_load_duck_screen:
;cp_game_ctl.h,105 :: 		void load_duck_screen() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;cp_game_ctl.h,106 :: 		uint32_t x_axis = 0;
;cp_game_ctl.h,107 :: 		uint32_t y_axis = 0;
;cp_game_ctl.h,108 :: 		uint32_t PX_BLOCK = 16;
;cp_game_ctl.h,109 :: 		uint32_t i=0;
;cp_game_ctl.h,111 :: 		uint32_t value = 0;
;cp_game_ctl.h,115 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,119 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,123 :: 		TFT_Fill_Screen(CL_NAVY);
MOVW	R0, #16
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,125 :: 		TFT_SET_PEN(m_BLACK, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,126 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,130 :: 		duck_sprite();
BL	_duck_sprite+0
;cp_game_ctl.h,135 :: 		for (i=0; i< 20; i++) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_load_duck_screen78:
; i start address is: 12 (R3)
CMP	R3, #20
IT	CS
BCS	L_load_duck_screen79
;cp_game_ctl.h,137 :: 		if (i < 1) {
CMP	R3, #1
IT	CS
BCS	L_load_duck_screen81
;cp_game_ctl.h,138 :: 		render_rect_mask(0, 0+6, 13+i, 9+6, m_NAVY);
MOVS	R1, #3
ADDW	R0, R3, #13
STR	R3, [SP, #4]
PUSH	(R1)
MOVW	R3, #15
MOV	R2, R0
MOVW	R1, #6
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
LDR	R3, [SP, #4]
;cp_game_ctl.h,139 :: 		}
L_load_duck_screen81:
;cp_game_ctl.h,140 :: 		render_rect_mask(0+ (i-1), 0+6, 13+i, 9+6, m_NAVY);
MOVS	R2, #3
ADDW	R1, R3, #13
SUBS	R0, R3, #1
STR	R3, [SP, #4]
PUSH	(R2)
MOVW	R3, #15
MOV	R2, R1
MOVW	R1, #6
BL	_render_rect_mask+0
ADD	SP, SP, #4
LDR	R3, [SP, #4]
;cp_game_ctl.h,143 :: 		set_sprite_offset(i, 6);
MOVS	R1, #6
MOV	R0, R3
BL	_set_sprite_offset+0
;cp_game_ctl.h,144 :: 		dump_ds_buffer();
STR	R3, [SP, #4]
BL	_dump_ds_buffer+0
LDR	R3, [SP, #4]
;cp_game_ctl.h,135 :: 		for (i=0; i< 20; i++) {
ADDS	R3, R3, #1
;cp_game_ctl.h,145 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_load_duck_screen78
L_load_duck_screen79:
;cp_game_ctl.h,149 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_duck_screen82:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_duck_screen83
IT	AL
BAL	L_load_duck_screen82
L_load_duck_screen83:
;cp_game_ctl.h,152 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_game_ctl.h,157 :: 		}
L_end_load_duck_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _load_duck_screen
_load_snake_game:
;cp_game_ctl.h,159 :: 		void load_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,162 :: 		GAME_PHASE = PHASE1_READY;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,164 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,168 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,170 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,172 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,173 :: 		set_brush_color(m_BLACK);
MOVS	R0, #0
BL	_set_brush_color+0
;cp_game_ctl.h,175 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,176 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,177 :: 		TFT_Write_Text("READY?", 7 * PX_BLOCK, 6 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr1_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr1_P7_final_project_main+0)
MOVW	R2, #96
MOVW	R1, #112
BL	_TFT_Write_Text+0
;cp_game_ctl.h,178 :: 		TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 7*PX_BLOCK);
MOVW	R0, #lo_addr(?lstr2_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr2_P7_final_project_main+0)
MOVW	R2, #112
MOVW	R1, #80
BL	_TFT_Write_Text+0
;cp_game_ctl.h,180 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_snake_game84:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_snake_game85
IT	AL
BAL	L_load_snake_game84
L_load_snake_game85:
;cp_game_ctl.h,181 :: 		}
L_end_load_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _load_snake_game
_start_snake_game:
;cp_game_ctl.h,184 :: 		void start_snake_game() {
SUB	SP, SP, #136
STR	LR, [SP, #0]
;cp_game_ctl.h,188 :: 		uint32_t num = 2550;
;cp_game_ctl.h,192 :: 		GAME_PHASE = PHASE2_PLAYING;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,194 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,198 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,200 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,202 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,203 :: 		set_brush_color(m_GREEN);
MOVS	R0, #4
BL	_set_brush_color+0
;cp_game_ctl.h,208 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,209 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,218 :: 		snake_sprite();
BL	_snake_sprite+0
;cp_game_ctl.h,220 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_game_ctl.h,223 :: 		while (cur_screen_run_flag == TRUE) {
L_start_snake_game86:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_start_snake_game87
;cp_game_ctl.h,225 :: 		rand_num = (rand() % 100);
BL	_rand+0
MOVS	R2, #100
SXTH	R2, R2
SDIV	R1, R0, R2
MLS	R1, R2, R1, R0
; rand_num start address is: 4 (R1)
;cp_game_ctl.h,227 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
STRH	R1, [SP, #4]
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
LDRSH	R1, [SP, #4]
;cp_game_ctl.h,231 :: 		sprintf(str_buffer, "Score: %d", rand_num);
SXTH	R2, R1
; rand_num end address is: 4 (R1)
MOVW	R1, #lo_addr(?lstr_3_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_3_P7_final_project_main+0)
ADD	R0, SP, #8
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,232 :: 		TFT_Write_Text(&str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
ADD	R0, SP, #8
MOVW	R2, #0
MOVW	R1, #0
BL	_TFT_Write_Text+0
;cp_game_ctl.h,233 :: 		sprintf(str_buffer, "Time: %d", time_count);
MOVW	R0, #lo_addr(P7_final_project_main_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_time_count+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_4_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_4_P7_final_project_main+0)
ADD	R0, SP, #8
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,234 :: 		TFT_Write_Text(&str_buffer, 13*PX_BLOCK, 0*PX_BLOCK);
ADD	R0, SP, #8
MOVW	R2, #0
MOVW	R1, #208
BL	_TFT_Write_Text+0
;cp_game_ctl.h,236 :: 		move_snake();
BL	_move_snake+0
;cp_game_ctl.h,237 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_game_ctl.h,238 :: 		Delay_ms(200);
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_start_snake_game88:
SUBS	R7, R7, #1
BNE	L_start_snake_game88
NOP
NOP
NOP
;cp_game_ctl.h,239 :: 		};
IT	AL
BAL	L_start_snake_game86
L_start_snake_game87:
;cp_game_ctl.h,242 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_game_ctl.h,243 :: 		}
L_end_start_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #136
BX	LR
; end of _start_snake_game
_move_snake:
;cp_game_ctl.h,259 :: 		void move_snake() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;cp_game_ctl.h,261 :: 		if (snake_direction == MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_snake_direction+0)
MOVT	R0, #hi_addr(P7_final_project_main_snake_direction+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake90
;cp_game_ctl.h,262 :: 		set_sprite_offset( (get_offset_x() + 1), (get_offset_y())  );
BL	_get_offset_y+0
STR	R0, [SP, #8]
BL	_get_offset_x+0
ADDS	R1, R0, #1
LDR	R0, [SP, #8]
STR	R1, [SP, #4]
MOV	R1, R0
LDR	R0, [SP, #4]
BL	_set_sprite_offset+0
;cp_game_ctl.h,263 :: 		}
L_move_snake90:
;cp_game_ctl.h,265 :: 		}
L_end_move_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _move_snake
_snake_sprite:
;cp_game_ctl.h,318 :: 		void snake_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,319 :: 		load_cell_xy(0,1, m_GREEN);
MOVS	R2, #4
MOVS	R1, #1
MOVS	R0, #0
BL	_load_cell_xy+0
;cp_game_ctl.h,320 :: 		}
L_end_snake_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _snake_sprite
_duck_sprite:
;cp_game_ctl.h,322 :: 		void duck_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,332 :: 		load_cell_xy(8,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,333 :: 		load_cell_xy(9,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,334 :: 		load_cell_xy(10,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,337 :: 		load_cell_xy(2,2,m_YELLOW); //face
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,338 :: 		load_cell_xy(3,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,339 :: 		load_cell_xy(7,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,340 :: 		load_cell_xy(8,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,345 :: 		load_cell_xy(7,1, m_BLACK); // Sunglasses
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,346 :: 		load_cell_xy(8,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,347 :: 		load_cell_xy(9,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,348 :: 		load_cell_xy(10,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,349 :: 		load_cell_xy(11,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,350 :: 		load_cell_xy(9,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,351 :: 		load_cell_xy(10,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,356 :: 		load_cell_xy(11,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,357 :: 		load_cell_xy(12,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_game_ctl.h,358 :: 		load_cell_xy(13,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #13
BL	_load_cell_xy+0
;cp_game_ctl.h,359 :: 		load_cell_xy(11,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,360 :: 		load_cell_xy(12,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_game_ctl.h,363 :: 		load_cell_xy(1,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,364 :: 		load_cell_xy(2,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,365 :: 		load_cell_xy(3,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,366 :: 		load_cell_xy(4,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,367 :: 		load_cell_xy(8,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,368 :: 		load_cell_xy(9,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,369 :: 		load_cell_xy(10,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,370 :: 		load_cell_xy(0,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #0
BL	_load_cell_xy+0
;cp_game_ctl.h,371 :: 		load_cell_xy(1,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,372 :: 		load_cell_xy(2,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,373 :: 		load_cell_xy(3,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,374 :: 		load_cell_xy(4,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,375 :: 		load_cell_xy(5,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,376 :: 		load_cell_xy(6,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,377 :: 		load_cell_xy(7,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,378 :: 		load_cell_xy(8,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,379 :: 		load_cell_xy(9,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,380 :: 		load_cell_xy(10,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,381 :: 		load_cell_xy(1,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,382 :: 		load_cell_xy(2,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,383 :: 		load_cell_xy(3,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,384 :: 		load_cell_xy(4,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,385 :: 		load_cell_xy(5,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,386 :: 		load_cell_xy(6,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,387 :: 		load_cell_xy(7,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,388 :: 		load_cell_xy(8,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,389 :: 		load_cell_xy(9,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,390 :: 		load_cell_xy(10,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,391 :: 		load_cell_xy(2,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,392 :: 		load_cell_xy(3,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,393 :: 		load_cell_xy(4,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,394 :: 		load_cell_xy(5,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,395 :: 		load_cell_xy(6,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,396 :: 		load_cell_xy(7,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,397 :: 		load_cell_xy(8,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,398 :: 		load_cell_xy(9,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,399 :: 		load_cell_xy(10,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,400 :: 		load_cell_xy(3,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,401 :: 		load_cell_xy(4,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,402 :: 		load_cell_xy(5,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,403 :: 		load_cell_xy(6,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,404 :: 		load_cell_xy(7,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,405 :: 		load_cell_xy(8,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,406 :: 		load_cell_xy(9,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,407 :: 		load_cell_xy(4,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,408 :: 		load_cell_xy(5,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,409 :: 		load_cell_xy(6,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,410 :: 		load_cell_xy(7,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,411 :: 		load_cell_xy(8,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,412 :: 		}
L_end_duck_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _duck_sprite
_EXTI15_10:
;P7_final_project_main.c,88 :: 		void EXTI15_10() iv IVT_INT_EXTI15_10  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,90 :: 		EXTI_PR |= 1 << 13;     // Rearm interrupt
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,91 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,93 :: 		while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }
L_EXTI15_1091:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_1092
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTI15_1091
L_EXTI15_1092:
;P7_final_project_main.c,95 :: 		CUR_GAME_PHASE=get_game_mode();
BL	_get_game_mode+0
MOVW	R1, #lo_addr(P7_final_project_main_CUR_GAME_PHASE+0)
MOVT	R1, #hi_addr(P7_final_project_main_CUR_GAME_PHASE+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,97 :: 		switch (CUR_GAME_PHASE)
IT	AL
BAL	L_EXTI15_1093
;P7_final_project_main.c,99 :: 		case PHASE_INTRO:
L_EXTI15_1095:
;P7_final_project_main.c,100 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,101 :: 		CUR_GAME_PHASE = PHASE1_READY; // load_snake_game
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_CUR_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_CUR_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,102 :: 		break;
IT	AL
BAL	L_EXTI15_1094
;P7_final_project_main.c,104 :: 		case PHASE1_READY:
L_EXTI15_1096:
;P7_final_project_main.c,105 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,106 :: 		CUR_GAME_PHASE = PHASE2_PLAYING;    // Start snake game
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_CUR_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_CUR_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,107 :: 		break;
IT	AL
BAL	L_EXTI15_1094
;P7_final_project_main.c,109 :: 		case PHASE2_PLAYING:
L_EXTI15_1097:
;P7_final_project_main.c,110 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_EXTI15_1098:
SUBS	R7, R7, #1
BNE	L_EXTI15_1098
NOP
NOP
NOP
;P7_final_project_main.c,114 :: 		break;
IT	AL
BAL	L_EXTI15_1094
;P7_final_project_main.c,121 :: 		default:
L_EXTI15_10100:
;P7_final_project_main.c,122 :: 		break;
IT	AL
BAL	L_EXTI15_1094
;P7_final_project_main.c,123 :: 		}
L_EXTI15_1093:
MOVW	R0, #lo_addr(P7_final_project_main_CUR_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_CUR_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTI15_1095
MOVW	R0, #lo_addr(P7_final_project_main_CUR_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_CUR_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTI15_1096
MOVW	R0, #lo_addr(P7_final_project_main_CUR_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_CUR_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTI15_1097
IT	AL
BAL	L_EXTI15_10100
L_EXTI15_1094:
;P7_final_project_main.c,147 :: 		}
L_end_EXTI15_10:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10
_EXTIPA6:
;P7_final_project_main.c,150 :: 		void EXTIPA6() iv IVT_INT_EXTI9_5  {
;P7_final_project_main.c,151 :: 		if (GPIOB_IDR.B5 == 0) {
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6101
;P7_final_project_main.c,152 :: 		while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
L_EXTIPA6102:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6103
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6102
L_EXTIPA6103:
;P7_final_project_main.c,153 :: 		EXTI_PR |= 1 << 5;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,154 :: 		}
L_EXTIPA6101:
;P7_final_project_main.c,157 :: 		if (GPIOA_IDR.B6 == 0) {
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6104
;P7_final_project_main.c,158 :: 		while (GPIOA_IDR.B6 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPA6105:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6106
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6105
L_EXTIPA6106:
;P7_final_project_main.c,159 :: 		EXTI_PR |= 1 << 6;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,160 :: 		}
L_EXTIPA6104:
;P7_final_project_main.c,164 :: 		}
L_end_EXTIPA6:
BX	LR
; end of _EXTIPA6
_EXTIPD2:
;P7_final_project_main.c,167 :: 		void EXTIPD2() iv IVT_INT_EXTI2  {
;P7_final_project_main.c,168 :: 		EXTI_PR |= 1 << 2;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,169 :: 		while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD2107:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD2108
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD2107
L_EXTIPD2108:
;P7_final_project_main.c,170 :: 		}
L_end_EXTIPD2:
BX	LR
; end of _EXTIPD2
_EXTIPD4:
;P7_final_project_main.c,173 :: 		void EXTIPD4() iv IVT_INT_EXTI4  {
;P7_final_project_main.c,174 :: 		EXTI_PR |= 1 << 4;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,175 :: 		while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD4109:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD4110
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD4109
L_EXTIPD4110:
;P7_final_project_main.c,176 :: 		}
L_end_EXTIPD4:
BX	LR
; end of _EXTIPD4
_TIMER2_ISR:
;P7_final_project_main.c,179 :: 		void TIMER2_ISR() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,180 :: 		TIM2_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,181 :: 		update_game_time();
BL	_update_game_time+0
;P7_final_project_main.c,182 :: 		}
L_end_TIMER2_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER2_ISR
_init_cfg_M_CTL:
;P7_final_project_main.c,192 :: 		void init_cfg_M_CTL() {
SUB	SP, SP, #4
;P7_final_project_main.c,195 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,197 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,198 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,200 :: 		RCC_APB2ENR |= 1 << 2;                    // Enable GPIO clock for PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,201 :: 		RCC_APB2ENR |= 1 << 3;                    // Enable GPIO clock for PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,202 :: 		RCC_APB2ENR |= 1 << 4;                    // Enable GPIO clock for PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,203 :: 		RCC_APB2ENR |= 1 << 5;                    // Enable GPIO clock for PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,204 :: 		RCC_APB2ENR |= 1 << 6;                    // Enable GPIO clock for PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,205 :: 		RCC_APB2ENR |= 1 << 14;                   // Enable GPIO clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,208 :: 		GPIOA_CRL = GPIO_INPUT_MASK;                     // Enable PA2 PA4 PA5 PA6 for joystick control
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,209 :: 		GPIOE_CRH = 0xFF00;
MOVW	R1, #65280
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,212 :: 		GPIOA_CRL |= 4 << 6;                       // Enable PA6;  joystick=RIGHT
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,213 :: 		GPIOB_CRL |= 4 << 5;                       // Enable PB5;  joystick=DOWN
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,214 :: 		GPIOD_CRL |= 4 << 2;                       // Enable PD2;  joystick=LEFT
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,215 :: 		GPIOD_CRL |= 4 << 4;                       // Enable PD4;  joystick=UP
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,216 :: 		GPIOC_CRH |= 4 << 5;                       // Enable PC13; joystick=PUSH BUTTON
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,217 :: 		}
L_end_init_cfg_M_CTL:
ADD	SP, SP, #4
BX	LR
; end of _init_cfg_M_CTL
_config_USART1:
;P7_final_project_main.c,220 :: 		void config_USART1() {
SUB	SP, SP, #4
;P7_final_project_main.c,221 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,222 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,223 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,226 :: 		USART1_BRR = 0x00000506;                    // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,230 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,232 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,233 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,234 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,235 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,237 :: 		USART1_CR1 |=   1 << 3;                     // Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,238 :: 		USART1_CR1 |=   1 << 2;                     // Rx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,240 :: 		Delay_ms(100);                              // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_config_USART1111:
SUBS	R7, R7, #1
BNE	L_config_USART1111
NOP
NOP
NOP
;P7_final_project_main.c,241 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,242 :: 		}
L_end_config_USART1:
ADD	SP, SP, #4
BX	LR
; end of _config_USART1
_init_timer2:
;P7_final_project_main.c,247 :: 		void init_timer2() {
SUB	SP, SP, #4
;P7_final_project_main.c,248 :: 		RCC_APB1ENR |= 1 << 0;                      // Enable Clock for TIMER2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,249 :: 		TIM2_CR1     = 0x0000;                      // Disable the timer for config setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,250 :: 		TIM2_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,252 :: 		TIM2_ARR     = 9000;                        // Set the auto-reload register to calclated value
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,253 :: 		TIM2_DIER  |= 1 << 0;                      // Enable TIMER2 Interrupt
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,254 :: 		TIM2_CR1     = 0x0001;                      // After timer setup, enable TIMER2 bit[1]; bit[4]=0 counting up.
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,255 :: 		}
L_end_init_timer2:
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_interrupt:
;P7_final_project_main.c,259 :: 		void init_interrupt() {
SUB	SP, SP, #4
;P7_final_project_main.c,262 :: 		AFIO_EXTICR2 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,263 :: 		NVIC_ISER0   = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,266 :: 		AFIO_EXTICR1 |= 3 << 8;                     // PD2 = EXTI2[11:8]; PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,267 :: 		AFIO_EXTICR2 |= 3 << 0;                     // PD4 = EXTI4[3:0];  PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,268 :: 		AFIO_EXTICR2 |= 1 << 4;                     // PB5 = EXTI5[7:4];  PortB = b0001;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,269 :: 		AFIO_EXTICR2 &= ~(0xF << 8);                // PA6 = EXTI6[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MVN	R0, #3840
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,270 :: 		AFIO_EXTICR4 |= 2 << 4;                     // PC13  EXTI13[7:4]; PortC = b0010;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,274 :: 		EXTI_FTSR |= 1 << 2; // EXTI2 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,275 :: 		EXTI_FTSR |= 1 << 4; // EXTI4 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,276 :: 		EXTI_FTSR |= 1 << 5; // EXTI5 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,277 :: 		EXTI_FTSR |= 1 << 6; // EXTI6 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,278 :: 		EXTI_FTSR |= 1 << 13; // EXTI13 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,281 :: 		EXTI_IMR |= 0x00002074;      // Set EXTI2,4,5,6,13 to not-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R1, [R0, #0]
MOVW	R0, #8308
ORRS	R1, R0
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,286 :: 		NVIC_ISER0 |= (uint32_t) 1 << 8;            // EXTI2  NVIC Pos=8:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,287 :: 		NVIC_ISER0 |= (uint32_t) 1 << 10;           // EXTI4  NVIC Pos=10:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,288 :: 		NVIC_ISER0 |= (uint32_t) 1 << 23;           // EXTI5  NVIC Pos=23: EXTI9_5
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,289 :: 		NVIC_ISER1 |= (uint32_t) 1 << 8;            // EXTI13 NVIC Pos=40: EXTI15_10
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,290 :: 		NVIC_ISER1 |= (uint32_t) 1 << 5;            // USART1 NVIC Pos=37: ISER1[63:32]; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,291 :: 		NVIC_ISER0 |= (uint32_t) 1 << 28;           // TIMER  NVIC Pos=28
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #268435456
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,293 :: 		}
L_end_init_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _init_interrupt
_rand_num_gen:
;P7_final_project_main.c,296 :: 		uint32_t rand_num_gen() {
SUB	SP, SP, #4
;P7_final_project_main.c,297 :: 		uint32_t ret = 0;
;P7_final_project_main.c,298 :: 		ret = TIM2_CNT % 100;
MOVW	R0, #lo_addr(TIM2_CNT+0)
MOVT	R0, #hi_addr(TIM2_CNT+0)
LDR	R2, [R0, #0]
MOVS	R1, #100
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
;P7_final_project_main.c,299 :: 		return ret ;
;P7_final_project_main.c,300 :: 		}
L_end_rand_num_gen:
ADD	SP, SP, #4
BX	LR
; end of _rand_num_gen
_main:
;P7_final_project_main.c,304 :: 		void main() {
SUB	SP, SP, #4
;P7_final_project_main.c,308 :: 		int num =0;
;P7_final_project_main.c,311 :: 		init_cfg_M_CTL();
BL	_init_cfg_M_CTL+0
;P7_final_project_main.c,314 :: 		config_USART1();
BL	_config_USART1+0
;P7_final_project_main.c,319 :: 		init_timer2();
BL	_init_timer2+0
;P7_final_project_main.c,323 :: 		init_interrupt();
BL	_init_interrupt+0
;P7_final_project_main.c,327 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,335 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,336 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,337 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,342 :: 		load_snake_game();
BL	_load_snake_game+0
;P7_final_project_main.c,344 :: 		start_snake_game();
BL	_start_snake_game+0
;P7_final_project_main.c,347 :: 		TFT_SET_Brush(1, CL_RED, 0, 0, 0 ,0);
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
;P7_final_project_main.c,348 :: 		TFT_Rectangle(0, 0, 320, 240);
MOVS	R3, #240
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;P7_final_project_main.c,349 :: 		TFT_Fill_Screen(CL_RED);
MOVW	R0, #63488
BL	_TFT_Fill_Screen+0
;P7_final_project_main.c,351 :: 		Delay_ms(3000);
MOVW	R7, #20735
MOVT	R7, #549
NOP
NOP
L_main113:
SUBS	R7, R7, #1
BNE	L_main113
NOP
NOP
NOP
;P7_final_project_main.c,353 :: 		while (1) {
L_main115:
;P7_final_project_main.c,355 :: 		}
IT	AL
BAL	L_main115
;P7_final_project_main.c,356 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
