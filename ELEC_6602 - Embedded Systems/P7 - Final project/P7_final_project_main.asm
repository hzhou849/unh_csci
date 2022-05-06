_debug:
;cp_const_def.h,79 :: 		void debug(uint32_t value) {
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 0 (R0)
; value start address is: 0 (R0)
;cp_const_def.h,80 :: 		Delay_ms(1);
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
;cp_const_def.h,81 :: 		USART1_DR = 0xD;
MOVS	R2, #13
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,82 :: 		Delay_ms(1);
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
;cp_const_def.h,83 :: 		USART1_DR=0xA;
MOVS	R2, #10
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;cp_const_def.h,84 :: 		Delay_ms(1);
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
;cp_const_def.h,85 :: 		USART1_DR = value;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; value end address is: 0 (R0)
;cp_const_def.h,86 :: 		}
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
BHI	L__load_intro_screen_simple167
LDR	R0, [SP, #8]
CMP	R0, #290
IT	HI
BHI	L__load_intro_screen_simple166
IT	AL
BAL	L_load_intro_screen_simple11
L__load_intro_screen_simple167:
L__load_intro_screen_simple166:
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
BCC	L__load_intro_screen_simple169
LDR	R0, [SP, #8]
CMP	R0, #2
IT	CC
BCC	L__load_intro_screen_simple168
IT	AL
BAL	L_load_intro_screen_simple15
L__load_intro_screen_simple169:
L__load_intro_screen_simple168:
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
BHI	L__load_intro_screen175
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen174
IT	AL
BAL	L_load_intro_screen21
L__load_intro_screen175:
L__load_intro_screen174:
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
BHI	L__load_intro_screen177
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen176
IT	AL
BAL	L_load_intro_screen28
L__load_intro_screen177:
L__load_intro_screen176:
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
BCC	L__load_intro_screen179
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen178
IT	AL
BAL	L_load_intro_screen35
L__load_intro_screen179:
L__load_intro_screen178:
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
BNE	L__load_intro_screen182
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
BCC	L__load_intro_screen181
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen180
IT	AL
BAL	L_load_intro_screen42
L__load_intro_screen181:
L__load_intro_screen180:
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
L__load_intro_screen182:
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
;cp_pix_render.h,52 :: 		void set_sprite_offset(int32_t ofs_x, int32_t ofs_y) {
; ofs_y start address is: 4 (R1)
; ofs_x start address is: 0 (R0)
SUB	SP, SP, #4
; ofs_y end address is: 4 (R1)
; ofs_x end address is: 0 (R0)
; ofs_x start address is: 0 (R0)
; ofs_y start address is: 4 (R1)
;cp_pix_render.h,53 :: 		offset_x = ofs_x;
MOVW	R2, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_x+0)
STR	R0, [R2, #0]
; ofs_x end address is: 0 (R0)
;cp_pix_render.h,54 :: 		offset_y = ofs_y;
MOVW	R2, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_y+0)
STR	R1, [R2, #0]
; ofs_y end address is: 4 (R1)
;cp_pix_render.h,55 :: 		}
L_end_set_sprite_offset:
ADD	SP, SP, #4
BX	LR
; end of _set_sprite_offset
_get_offset_x:
;cp_pix_render.h,57 :: 		int32_t get_offset_x() {
SUB	SP, SP, #4
;cp_pix_render.h,58 :: 		return offset_x;
MOVW	R0, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,59 :: 		}
L_end_get_offset_x:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_x
_get_offset_y:
;cp_pix_render.h,60 :: 		int32_t get_offset_y() {
SUB	SP, SP, #4
;cp_pix_render.h,61 :: 		return offset_y;
MOVW	R0, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,62 :: 		}
L_end_get_offset_y:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_y
_convert_lin_xy:
;cp_pix_render.h,65 :: 		void convert_lin_xy(int32_t *cell_pos, int32_t *x_var, int32_t *y_var ) {
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
;cp_pix_render.h,67 :: 		int32_t row = 0;
; row start address is: 0 (R0)
MOV	R0, #0
;cp_pix_render.h,68 :: 		int32_t col = 0;
;cp_pix_render.h,69 :: 		int32_t temp_val = *cell_pos;
LDR	R3, [R4, #0]
; cell_pos end address is: 16 (R4)
; temp_val start address is: 16 (R4)
MOV	R4, R3
;cp_pix_render.h,71 :: 		if (temp_val > MAX_BLOCK_COUNT) {
CMP	R3, #300
IT	LE
BLE	L__convert_lin_xy183
; temp_val end address is: 16 (R4)
;cp_pix_render.h,72 :: 		temp_val = 300;
; temp_val start address is: 12 (R3)
MOVW	R3, #300
; temp_val end address is: 12 (R3)
MOV	R5, R3
;cp_pix_render.h,73 :: 		}
IT	AL
BAL	L_convert_lin_xy48
L__convert_lin_xy183:
;cp_pix_render.h,71 :: 		if (temp_val > MAX_BLOCK_COUNT) {
MOV	R5, R4
;cp_pix_render.h,73 :: 		}
L_convert_lin_xy48:
;cp_pix_render.h,77 :: 		while (temp_val >= (MAX_COL_WIDTH) ) {
; temp_val start address is: 20 (R5)
STR	R0, [SP, #0]
; y_var end address is: 8 (R2)
; row end address is: 0 (R0)
; x_var end address is: 4 (R1)
; temp_val end address is: 20 (R5)
MOV	R0, R2
LDR	R2, [SP, #0]
L_convert_lin_xy49:
; temp_val start address is: 20 (R5)
; row start address is: 8 (R2)
; y_var start address is: 0 (R0)
; x_var start address is: 4 (R1)
CMP	R5, #20
IT	LT
BLT	L_convert_lin_xy50
;cp_pix_render.h,78 :: 		temp_val -= MAX_COL_WIDTH-1;
SUBW	R4, R5, #19
MOV	R5, R4
;cp_pix_render.h,79 :: 		++row;
ADDS	R2, R2, #1
;cp_pix_render.h,81 :: 		if (temp_val > 0 ) {
CMP	R4, #0
IT	LE
BLE	L__convert_lin_xy184
;cp_pix_render.h,82 :: 		--temp_val; // compensate for zero-index of array by adding 1
SUBS	R3, R5, #1
; temp_val end address is: 20 (R5)
; temp_val start address is: 16 (R4)
MOV	R4, R3
; temp_val end address is: 16 (R4)
MOV	R5, R4
;cp_pix_render.h,83 :: 		}
IT	AL
BAL	L_convert_lin_xy51
L__convert_lin_xy184:
;cp_pix_render.h,81 :: 		if (temp_val > 0 ) {
;cp_pix_render.h,83 :: 		}
L_convert_lin_xy51:
;cp_pix_render.h,85 :: 		}
; temp_val start address is: 20 (R5)
IT	AL
BAL	L_convert_lin_xy49
L_convert_lin_xy50:
;cp_pix_render.h,97 :: 		*x_var = col;
STR	R5, [R1, #0]
; x_var end address is: 4 (R1)
; temp_val end address is: 20 (R5)
;cp_pix_render.h,98 :: 		*y_var = row;
STR	R2, [R0, #0]
; y_var end address is: 0 (R0)
; row end address is: 8 (R2)
;cp_pix_render.h,100 :: 		}
L_end_convert_lin_xy:
ADD	SP, SP, #4
BX	LR
; end of _convert_lin_xy
_color_convert_32:
;cp_pix_render.h,104 :: 		int32_t color_convert_32(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #4
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 0 (R0)
;cp_pix_render.h,106 :: 		if (color_8bit == m_YELLOW){
CMP	R0, #1
IT	NE
BNE	L_color_convert_3252
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,107 :: 		return CL_YELLOW;
MOVW	R0, #65504
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,108 :: 		} else if (color_8bit == m_BLACK) {
L_color_convert_3252:
; color_8bit start address is: 0 (R0)
CMP	R0, #0
IT	NE
BNE	L_color_convert_3254
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,109 :: 		return CL_BLACK;
MOVW	R0, #0
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,110 :: 		} else if (color_8bit == m_RED) {
L_color_convert_3254:
; color_8bit start address is: 0 (R0)
CMP	R0, #2
IT	NE
BNE	L_color_convert_3256
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,111 :: 		return CL_RED;
MOVW	R0, #63488
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,112 :: 		} else if (color_8bit == m_NAVY) {
L_color_convert_3256:
; color_8bit start address is: 0 (R0)
CMP	R0, #3
IT	NE
BNE	L_color_convert_3258
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,113 :: 		return CL_NAVY;
MOVW	R0, #16
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,114 :: 		} else if (color_8bit == m_GREEN) {
L_color_convert_3258:
; color_8bit start address is: 0 (R0)
CMP	R0, #4
IT	NE
BNE	L_color_convert_3260
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,115 :: 		return CL_GREEN;
MOVW	R0, #1024
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,116 :: 		} else if (color_8bit == m_FUCHSIA) {
L_color_convert_3260:
; color_8bit start address is: 0 (R0)
CMP	R0, #6
IT	NE
BNE	L_color_convert_3262
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,117 :: 		return CL_FUCHSIA;
MOVW	R0, #63519
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,118 :: 		} else {
L_color_convert_3262:
;cp_pix_render.h,119 :: 		return CL_WHITE;
MOVW	R0, #65535
;cp_pix_render.h,121 :: 		}
L_end_color_convert_32:
ADD	SP, SP, #4
BX	LR
; end of _color_convert_32
_set_brush_color:
;cp_pix_render.h,123 :: 		void set_brush_color(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R7, R0
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 28 (R7)
;cp_pix_render.h,125 :: 		px_clr = color_convert_32(color_8bit);
UXTB	R0, R7
BL	_color_convert_32+0
;cp_pix_render.h,127 :: 		TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
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
;cp_pix_render.h,128 :: 		CUR_BRUSH_COLOUR = color_8bit; // assign the new colour code
MOVW	R1, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R1, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
STRB	R7, [R1, #0]
; color_8bit end address is: 28 (R7)
;cp_pix_render.h,129 :: 		}
L_end_set_brush_color:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_brush_color
_draw_cell_pos:
;cp_pix_render.h,132 :: 		void draw_cell_pos( int32_t *linear_pos, uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; linear_pos start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; linear_pos end address is: 0 (R0)
; linear_pos start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,135 :: 		int32_t cell_pos = *linear_pos;
LDR	R2, [R0, #0]
; linear_pos end address is: 0 (R0)
STR	R2, [SP, #12]
;cp_pix_render.h,138 :: 		if (color_8bit != CUR_BRUSH_COLOUR) {
MOVW	R2, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R2, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
LDRB	R2, [R2, #0]
CMP	R1, R2
IT	EQ
BEQ	L_draw_cell_pos64
;cp_pix_render.h,140 :: 		set_brush_color(color_8bit);
UXTB	R0, R1
; color_8bit end address is: 4 (R1)
BL	_set_brush_color+0
;cp_pix_render.h,141 :: 		}
L_draw_cell_pos64:
;cp_pix_render.h,144 :: 		convert_lin_xy(&cell_pos, &x_var, &y_var );
ADD	R4, SP, #8
ADD	R3, SP, #4
ADD	R2, SP, #12
MOV	R1, R3
MOV	R0, R2
MOV	R2, R4
BL	_convert_lin_xy+0
;cp_pix_render.h,155 :: 		PX_BLOCK + (PX_BLOCK * y_var)               // Lower-right Y
LDR	R2, [SP, #8]
LSLS	R5, R2, #4
ADDW	R4, R5, #16
;cp_pix_render.h,154 :: 		PX_BLOCK + (PX_BLOCK * x_var),              // Lower-right X
LDR	R2, [SP, #4]
LSLS	R3, R2, #4
ADDW	R2, R3, #16
SXTH	R2, R2
;cp_pix_render.h,153 :: 		(y_var * PX_BLOCK),                         // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,152 :: 		PX_BLOCK * x_var,                           // Upper-left X
SXTH	R0, R3
;cp_pix_render.h,155 :: 		PX_BLOCK + (PX_BLOCK * y_var)               // Lower-right Y
SXTH	R3, R4
BL	_TFT_Rectangle+0
;cp_pix_render.h,160 :: 		}
L_end_draw_cell_pos:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _draw_cell_pos
_draw_cell_xy:
;cp_pix_render.h,164 :: 		void draw_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {
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
;cp_pix_render.h,167 :: 		if (color_8bit != CUR_BRUSH_COLOUR) {
MOVW	R3, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R3, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
LDRB	R3, [R3, #0]
CMP	R2, R3
IT	EQ
BEQ	L_draw_cell_xy65
;cp_pix_render.h,168 :: 		set_brush_color(color_8bit);
UXTB	R0, R2
; color_8bit end address is: 8 (R2)
BL	_set_brush_color+0
;cp_pix_render.h,169 :: 		}
L_draw_cell_xy65:
;cp_pix_render.h,178 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
LSL	R6, R9, #4
SXTH	R6, R6
; y_var end address is: 36 (R9)
ADDW	R5, R6, #16
;cp_pix_render.h,177 :: 		PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
LSL	R4, R8, #4
SXTH	R4, R4
; x_var end address is: 32 (R8)
ADDW	R3, R4, #16
SXTH	R2, R3
;cp_pix_render.h,178 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
SXTH	R3, R5
;cp_pix_render.h,176 :: 		(y_var * PX_BLOCK),                 // Upper-left Y
SXTH	R1, R6
;cp_pix_render.h,175 :: 		PX_BLOCK * x_var,                   // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,178 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,187 :: 		}
L_end_draw_cell_xy:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_cell_xy
_render_rect_mask:
;cp_pix_render.h,193 :: 		void render_rect_mask(int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit) {
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
;cp_pix_render.h,196 :: 		set_brush_color(color_8bit);
UXTB	R0, R4
; color_8bit end address is: 16 (R4)
BL	_set_brush_color+0
;cp_pix_render.h,202 :: 		PX_BLOCK * lr_y                // Lower-right Y
LSL	R7, R11, #4
; lr_y end address is: 44 (R11)
;cp_pix_render.h,201 :: 		PX_BLOCK * lr_x,               // Lower-right X
LSL	R6, R10, #4
; lr_x end address is: 40 (R10)
;cp_pix_render.h,200 :: 		PX_BLOCK * ul_y,               // Upper-left Y
LSL	R5, R9, #4
; ul_y end address is: 36 (R9)
;cp_pix_render.h,199 :: 		PX_BLOCK * ul_x,               // Upper-left X
LSL	R4, R8, #4
; ul_x end address is: 32 (R8)
;cp_pix_render.h,202 :: 		PX_BLOCK * lr_y                // Lower-right Y
SXTH	R3, R7
;cp_pix_render.h,201 :: 		PX_BLOCK * lr_x,               // Lower-right X
SXTH	R2, R6
;cp_pix_render.h,200 :: 		PX_BLOCK * ul_y,               // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,199 :: 		PX_BLOCK * ul_x,               // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,202 :: 		PX_BLOCK * lr_y                // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,204 :: 		}
L_end_render_rect_mask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _render_rect_mask
_load_cell_xy:
;cp_pix_render.h,209 :: 		void load_cell_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
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
;cp_pix_render.h,210 :: 		int32_t linear_val = 0;
;cp_pix_render.h,222 :: 		linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
MOV	R3, #20
MULS	R3, R1, R3
; y_var end address is: 4 (R1)
ADDS	R4, R3, R0
; x_var end address is: 0 (R0)
;cp_pix_render.h,224 :: 		g_DS_BUFFER[linear_val] = color_8bit;
MOVW	R3, #lo_addr(_g_DS_BUFFER+0)
MOVT	R3, #hi_addr(_g_DS_BUFFER+0)
ADDS	R3, R3, R4
STRB	R2, [R3, #0]
; clr_code end address is: 8 (R2)
;cp_pix_render.h,226 :: 		}
L_end_load_cell_xy:
ADD	SP, SP, #4
BX	LR
; end of _load_cell_xy
_load_snake_xy:
;cp_pix_render.h,229 :: 		void load_snake_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
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
;cp_pix_render.h,230 :: 		int32_t linear_val = 0;
;cp_pix_render.h,242 :: 		linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
MOV	R3, #20
MULS	R3, R1, R3
; y_var end address is: 4 (R1)
ADDS	R4, R3, R0
; x_var end address is: 0 (R0)
;cp_pix_render.h,244 :: 		g_DS_BUFFER[linear_val] = color_8bit;
MOVW	R3, #lo_addr(_g_DS_BUFFER+0)
MOVT	R3, #hi_addr(_g_DS_BUFFER+0)
ADDS	R3, R3, R4
STRB	R2, [R3, #0]
; clr_code end address is: 8 (R2)
;cp_pix_render.h,246 :: 		}
L_end_load_snake_xy:
ADD	SP, SP, #4
BX	LR
; end of _load_snake_xy
_dump_ds_buffer:
;cp_pix_render.h,249 :: 		void dump_ds_buffer() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;cp_pix_render.h,250 :: 		int32_t i=0;
;cp_pix_render.h,252 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; i end address is: 4 (R1)
L_dump_ds_buffer66:
; i start address is: 4 (R1)
CMP	R1, #300
IT	GE
BGE	L_dump_ds_buffer67
;cp_pix_render.h,254 :: 		if (g_DS_BUFFER[i] != 0xFF) {
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	EQ
BEQ	L_dump_ds_buffer69
;cp_pix_render.h,255 :: 		draw_cell_pos(i, g_DS_BUFFER[i]); // pass the colour code
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
;cp_pix_render.h,256 :: 		}
L_dump_ds_buffer69:
;cp_pix_render.h,252 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
ADDS	R1, R1, #1
;cp_pix_render.h,258 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_ds_buffer66
L_dump_ds_buffer67:
;cp_pix_render.h,259 :: 		}
L_end_dump_ds_buffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _dump_ds_buffer
_print_snake:
;cp_pix_render.h,261 :: 		void print_snake(t_node *node, uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; node start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; node end address is: 0 (R0)
; node start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,265 :: 		draw_cell_xy(node->node_x, node->node_y, color_8bit);
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
;cp_pix_render.h,267 :: 		}
L_end_print_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _print_snake
_cleaning_buffer:
;cp_pix_render.h,269 :: 		void cleaning_buffer(uint8_t color_8bit) {
; color_8bit start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; color_8bit end address is: 0 (R0)
; color_8bit start address is: 0 (R0)
;cp_pix_render.h,270 :: 		int32_t i=0;
;cp_pix_render.h,272 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
; i start address is: 8 (R2)
MOVS	R2, #0
; i end address is: 8 (R2)
L_cleaning_buffer70:
; i start address is: 8 (R2)
; color_8bit start address is: 0 (R0)
; color_8bit end address is: 0 (R0)
CMP	R2, #300
IT	GE
BGE	L_cleaning_buffer71
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,274 :: 		if (g_DS_BUFFER[i] != 0xFF) {
; color_8bit start address is: 0 (R0)
MOVW	R1, #lo_addr(_g_DS_BUFFER+0)
MOVT	R1, #hi_addr(_g_DS_BUFFER+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
CMP	R1, #255
IT	EQ
BEQ	L_cleaning_buffer73
;cp_pix_render.h,275 :: 		draw_cell_pos(i, color_8bit ); // pass the colour code~
STRB	R0, [SP, #4]
STR	R2, [SP, #8]
UXTB	R1, R0
MOV	R0, R2
BL	_draw_cell_pos+0
LDR	R2, [SP, #8]
LDRB	R0, [SP, #4]
;cp_pix_render.h,276 :: 		}
L_cleaning_buffer73:
;cp_pix_render.h,272 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
ADDS	R2, R2, #1
;cp_pix_render.h,278 :: 		}
; color_8bit end address is: 0 (R0)
; i end address is: 8 (R2)
IT	AL
BAL	L_cleaning_buffer70
L_cleaning_buffer71:
;cp_pix_render.h,279 :: 		}
L_end_cleaning_buffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _cleaning_buffer
_clean_tail:
;cp_pix_render.h,281 :: 		void clean_tail(t_node * node_tail,  uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; node_tail start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; node_tail end address is: 0 (R0)
; node_tail start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,282 :: 		int32_t i = 0;
;cp_pix_render.h,286 :: 		print_snake(node_tail, color_8bit);
; color_8bit end address is: 4 (R1)
; node_tail end address is: 0 (R0)
BL	_print_snake+0
;cp_pix_render.h,289 :: 		}
L_end_clean_tail:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clean_tail
_set_curr_snake_dir:
;cp_game_ctl.h,94 :: 		void set_curr_snake_dir(uint8_t new_dir) {
; new_dir start address is: 0 (R0)
SUB	SP, SP, #4
; new_dir end address is: 0 (R0)
; new_dir start address is: 0 (R0)
;cp_game_ctl.h,95 :: 		g_curr_snake_dir = new_dir;
MOVW	R1, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
STRB	R0, [R1, #0]
; new_dir end address is: 0 (R0)
;cp_game_ctl.h,96 :: 		}
L_end_set_curr_snake_dir:
ADD	SP, SP, #4
BX	LR
; end of _set_curr_snake_dir
_toggle_game_clock_delay:
;cp_game_ctl.h,99 :: 		void toggle_game_clock_delay() {
SUB	SP, SP, #4
;cp_game_ctl.h,100 :: 		g_game_clock_delay_tim3 = ~g_game_clock_delay_tim3;
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
LDRB	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,101 :: 		}
L_end_toggle_game_clock_delay:
ADD	SP, SP, #4
BX	LR
; end of _toggle_game_clock_delay
_update_game_time:
;cp_game_ctl.h,104 :: 		void update_game_time () {
SUB	SP, SP, #4
;cp_game_ctl.h,105 :: 		g_time_count++;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,106 :: 		}
L_end_update_game_time:
ADD	SP, SP, #4
BX	LR
; end of _update_game_time
_get_game_mode:
;cp_game_ctl.h,109 :: 		uint8_t get_game_mode() {
SUB	SP, SP, #4
;cp_game_ctl.h,110 :: 		return g_GAME_PHASE;
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
;cp_game_ctl.h,111 :: 		}
L_end_get_game_mode:
ADD	SP, SP, #4
BX	LR
; end of _get_game_mode
_move_snake:
;cp_game_ctl.h,113 :: 		void move_snake() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,115 :: 		int16_t temp_x = node_head->node_x;
MOVW	R1, #lo_addr(_node_head+0)
MOVT	R1, #hi_addr(_node_head+0)
LDR	R0, [R1, #0]
LDRSH	R0, [R0, #0]
; temp_x start address is: 12 (R3)
SXTH	R3, R0
;cp_game_ctl.h,116 :: 		int16_t temp_y = node_head->node_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
; temp_y start address is: 16 (R4)
SXTH	R4, R0
;cp_game_ctl.h,118 :: 		if (g_curr_snake_dir == MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake74
;cp_game_ctl.h,120 :: 		if (node_head+1 > node_end) {
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_node_end+0)
MOVT	R0, #hi_addr(_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake75
;cp_game_ctl.h,121 :: 		node_start->node_x = ++temp_x;
ADDS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_node_start+0)
MOVT	R1, #hi_addr(_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,122 :: 		node_start->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,124 :: 		node_head = node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,125 :: 		} else {
IT	AL
BAL	L_move_snake76
L_move_snake75:
;cp_game_ctl.h,127 :: 		(node_head+1)->node_x = ++temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_node_head+0)
MOVT	R2, #hi_addr(_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
ADDS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,128 :: 		(node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,129 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,130 :: 		}
L_move_snake76:
;cp_game_ctl.h,135 :: 		if (node_head->node_x > MAX_COL_WIDTH-1) { //0-indexed array
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #19
IT	LE
BLE	L_move_snake77
;cp_game_ctl.h,136 :: 		node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,137 :: 		}
L_move_snake77:
;cp_game_ctl.h,138 :: 		}
IT	AL
BAL	L_move_snake78
L_move_snake74:
;cp_game_ctl.h,139 :: 		else if (g_curr_snake_dir == MOVE_LEFT)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_move_snake79
;cp_game_ctl.h,141 :: 		if (node_head+1 > node_end) {
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_node_end+0)
MOVT	R0, #hi_addr(_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake80
;cp_game_ctl.h,142 :: 		(node_start)->node_x = --temp_x;
SUBS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_node_start+0)
MOVT	R1, #hi_addr(_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,143 :: 		(node_start)->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,145 :: 		node_head = node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,146 :: 		} else {
IT	AL
BAL	L_move_snake81
L_move_snake80:
;cp_game_ctl.h,148 :: 		(node_head+1)->node_x = --temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_node_head+0)
MOVT	R2, #hi_addr(_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
SUBS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,149 :: 		(node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,151 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,152 :: 		}
L_move_snake81:
;cp_game_ctl.h,155 :: 		if (node_head->node_x < 0) {
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_move_snake82
;cp_game_ctl.h,156 :: 		node_head->node_x = 19;
MOVS	R1, #19
SXTH	R1, R1
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,157 :: 		}
L_move_snake82:
;cp_game_ctl.h,159 :: 		}
IT	AL
BAL	L_move_snake83
L_move_snake79:
;cp_game_ctl.h,160 :: 		else if (g_curr_snake_dir == MOVE_UP)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_move_snake84
;cp_game_ctl.h,162 :: 		if (node_head+1 > node_end) {
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_node_end+0)
MOVT	R0, #hi_addr(_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake85
;cp_game_ctl.h,163 :: 		(node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_node_start+0)
MOVT	R2, #hi_addr(_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,164 :: 		(node_start)->node_y = --temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,165 :: 		node_head = node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,166 :: 		} else {
IT	AL
BAL	L_move_snake86
L_move_snake85:
;cp_game_ctl.h,168 :: 		(node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_node_head+0)
MOVT	R1, #hi_addr(_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,169 :: 		(node_head+1)->node_y = --temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,171 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,172 :: 		}
L_move_snake86:
;cp_game_ctl.h,175 :: 		if (node_head->node_y < 1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	GE
BGE	L_move_snake87
;cp_game_ctl.h,176 :: 		node_head->node_y = (MAX_ROW_LENGTH-1);
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVW	R0, #14
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,177 :: 		}
L_move_snake87:
;cp_game_ctl.h,178 :: 		}
IT	AL
BAL	L_move_snake88
L_move_snake84:
;cp_game_ctl.h,179 :: 		else if (g_curr_snake_dir == MOVE_DOWN)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_move_snake89
;cp_game_ctl.h,180 :: 		if (node_head+1 > node_end) {
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_node_end+0)
MOVT	R0, #hi_addr(_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake90
;cp_game_ctl.h,181 :: 		(node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_node_start+0)
MOVT	R2, #hi_addr(_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,182 :: 		(node_start)->node_y = ++temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,183 :: 		node_head = node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,184 :: 		} else {
IT	AL
BAL	L_move_snake91
L_move_snake90:
;cp_game_ctl.h,186 :: 		(node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_node_head+0)
MOVT	R1, #hi_addr(_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,187 :: 		(node_head+1)->node_y = ++temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,190 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,191 :: 		}
L_move_snake91:
;cp_game_ctl.h,194 :: 		if (node_head->node_y > MAX_ROW_LENGTH-1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #14
IT	LE
BLE	L_move_snake92
;cp_game_ctl.h,195 :: 		node_head->node_y = 1;
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,196 :: 		}
L_move_snake92:
;cp_game_ctl.h,198 :: 		}
L_move_snake89:
L_move_snake88:
L_move_snake83:
L_move_snake78:
;cp_game_ctl.h,202 :: 		}
L_end_move_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _move_snake
_generate_food:
;cp_game_ctl.h,205 :: 		void  generate_food() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,206 :: 		g_rand_num = (int32_t) (rand() % MAX_BLOCK_COUNT);// + MAX_COL_WIDTH because row 0 is reserved for info
BL	_rand+0
MOV	R2, #300
SDIV	R1, R0, R2
MLS	R1, R2, R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,209 :: 		draw_cell_pos(&g_rand_num, m_RED);
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
BL	_draw_cell_pos+0
;cp_game_ctl.h,210 :: 		scr_debug(g_rand_num);
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
LDR	R0, [R0, #0]
BL	_scr_debug+0
;cp_game_ctl.h,211 :: 		g_food_in_play = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_food_in_play+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,212 :: 		}
L_end_generate_food:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _generate_food
_incr_snake_head:
;cp_game_ctl.h,216 :: 		void incr_snake_head() {
SUB	SP, SP, #4
;cp_game_ctl.h,218 :: 		if (node_head < node_end) { // array_size * sizeof(t_node)
MOVW	R0, #lo_addr(_node_end+0)
MOVT	R0, #hi_addr(_node_end+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_head93
;cp_game_ctl.h,219 :: 		node_head++;
MOVW	R1, #lo_addr(_node_head+0)
MOVT	R1, #hi_addr(_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,220 :: 		} else {
IT	AL
BAL	L_incr_snake_head94
L_incr_snake_head93:
;cp_game_ctl.h,221 :: 		node_head = node_restart_head; // Wrap around array if end is reached
MOVW	R0, #lo_addr(_node_restart_head+0)
MOVT	R0, #hi_addr(_node_restart_head+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,222 :: 		}
L_incr_snake_head94:
;cp_game_ctl.h,224 :: 		}
L_end_incr_snake_head:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_head
_incr_snake_tail:
;cp_game_ctl.h,228 :: 		void incr_snake_tail() {
SUB	SP, SP, #4
;cp_game_ctl.h,231 :: 		node_tail->node_x = 0xFF;
MOVS	R1, #255
SXTH	R1, R1
MOVW	R2, #lo_addr(_node_tail+0)
MOVT	R2, #hi_addr(_node_tail+0)
LDR	R0, [R2, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,232 :: 		node_tail->node_y = 0xFF;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #255
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,234 :: 		if (node_tail < node_end) { // array_size * sizeof(t_node)
MOVW	R0, #lo_addr(_node_end+0)
MOVT	R0, #hi_addr(_node_end+0)
LDR	R1, [R0, #0]
MOV	R0, R2
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_tail95
;cp_game_ctl.h,235 :: 		node_tail++;
MOVW	R1, #lo_addr(_node_tail+0)
MOVT	R1, #hi_addr(_node_tail+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,236 :: 		} else {
IT	AL
BAL	L_incr_snake_tail96
L_incr_snake_tail95:
;cp_game_ctl.h,237 :: 		node_tail = node_start; // Wrap around array if end is reached
MOVW	R0, #lo_addr(_node_start+0)
MOVT	R0, #hi_addr(_node_start+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_node_tail+0)
MOVT	R0, #hi_addr(_node_tail+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,238 :: 		}
L_incr_snake_tail96:
;cp_game_ctl.h,240 :: 		}
L_end_incr_snake_tail:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_tail
_update_snake_info:
;cp_game_ctl.h,242 :: 		void update_snake_info(uint32_t head_x, uint32_t head_y, uint8_t tail_flag)
; tail_flag start address is: 8 (R2)
; head_y start address is: 4 (R1)
; head_x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R6, R2
MOV	R2, R0
MOV	R5, R1
; tail_flag end address is: 8 (R2)
; head_y end address is: 4 (R1)
; head_x end address is: 0 (R0)
; head_x start address is: 8 (R2)
; head_y start address is: 20 (R5)
; tail_flag start address is: 24 (R6)
;cp_game_ctl.h,244 :: 		snake_info[0] = head_x;
MOVW	R3, #lo_addr(P7_final_project_main_snake_info+0)
MOVT	R3, #hi_addr(P7_final_project_main_snake_info+0)
STRH	R2, [R3, #0]
;cp_game_ctl.h,245 :: 		snake_info[1] = head_y;
MOVW	R3, #lo_addr(P7_final_project_main_snake_info+2)
MOVT	R3, #hi_addr(P7_final_project_main_snake_info+2)
STRH	R5, [R3, #0]
;cp_game_ctl.h,248 :: 		node_head->node_x = head_x;
MOVW	R4, #lo_addr(_node_head+0)
MOVT	R4, #hi_addr(_node_head+0)
LDR	R3, [R4, #0]
STRH	R2, [R3, #0]
;cp_game_ctl.h,249 :: 		node_head->node_y = head_y;
MOV	R3, R4
LDR	R3, [R3, #0]
ADDS	R3, R3, #2
STRH	R5, [R3, #0]
;cp_game_ctl.h,253 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,256 :: 		if (tail_flag == TAIL_ON) {
CMP	R6, #1
IT	NE
BNE	L_update_snake_info97
; tail_flag end address is: 24 (R6)
;cp_game_ctl.h,258 :: 		node_tail->node_x = head_x;
MOVW	R4, #lo_addr(_node_tail+0)
MOVT	R4, #hi_addr(_node_tail+0)
LDR	R3, [R4, #0]
STRH	R2, [R3, #0]
; head_x end address is: 8 (R2)
;cp_game_ctl.h,259 :: 		node_tail->node_y = head_y;
MOV	R3, R4
LDR	R3, [R3, #0]
ADDS	R3, R3, #2
STRH	R5, [R3, #0]
; head_y end address is: 20 (R5)
;cp_game_ctl.h,260 :: 		incr_snake_tail();
BL	_incr_snake_tail+0
;cp_game_ctl.h,261 :: 		}
L_update_snake_info97:
;cp_game_ctl.h,262 :: 		}
L_end_update_snake_info:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_snake_info
_init_arr:
;cp_game_ctl.h,266 :: 		void init_arr(uint8_t *in_arr, uint32_t a_size) {
; a_size start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R2, R1
MOV	R1, R0
; a_size end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 4 (R1)
; a_size start address is: 8 (R2)
;cp_game_ctl.h,267 :: 		uint32_t i=0;
;cp_game_ctl.h,269 :: 		for (i=0; i < a_size; i++) {
; i start address is: 0 (R0)
MOVS	R0, #0
; a_size end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R4, R0
MOV	R0, R2
L_init_arr98:
; i start address is: 16 (R4)
; a_size start address is: 0 (R0)
; in_arr start address is: 4 (R1)
; in_arr end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_init_arr99
; in_arr end address is: 4 (R1)
;cp_game_ctl.h,270 :: 		in_arr[i]=0xFF;
; in_arr start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
;cp_game_ctl.h,269 :: 		for (i=0; i < a_size; i++) {
ADDS	R4, R4, #1
;cp_game_ctl.h,271 :: 		}
; a_size end address is: 0 (R0)
; in_arr end address is: 4 (R1)
; i end address is: 16 (R4)
IT	AL
BAL	L_init_arr98
L_init_arr99:
;cp_game_ctl.h,272 :: 		}
L_end_init_arr:
ADD	SP, SP, #4
BX	LR
; end of _init_arr
_dump_arr_memory:
;cp_game_ctl.h,276 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
;cp_game_ctl.h,279 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_game_ctl.h,276 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
;cp_game_ctl.h,279 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
;cp_game_ctl.h,276 :: 		void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
; i end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 0 (R0)
;cp_game_ctl.h,277 :: 		uint32_t i = 0;
;cp_game_ctl.h,279 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
L_dump_arr_memory101:
; i start address is: 4 (R1)
; in_arr start address is: 0 (R0)
CMP	R1, #300
IT	CS
BCS	L_dump_arr_memory102
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
;cp_game_ctl.h,282 :: 		while ( (USART1_SR & (1 << 7 )) == 0) {}
L_dump_arr_memory104:
; in_arr start address is: 0 (R0)
; i start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_dump_arr_memory105
IT	AL
BAL	L_dump_arr_memory104
L_dump_arr_memory105:
;cp_game_ctl.h,283 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory106:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory106
NOP
NOP
NOP
;cp_game_ctl.h,284 :: 		USART1_DR = (uint32_t)in_arr[i];
ADDS	R2, R0, R1
LDRB	R2, [R2, #0]
UXTB	R3, R2
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,285 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_dump_arr_memory108:
SUBS	R7, R7, #1
BNE	L_dump_arr_memory108
NOP
NOP
NOP
;cp_game_ctl.h,279 :: 		for ( i=0; i < MAX_BLOCK_COUNT; i++) {
ADDS	R1, R1, #1
;cp_game_ctl.h,287 :: 		}
; in_arr end address is: 0 (R0)
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_arr_memory101
L_dump_arr_memory102:
;cp_game_ctl.h,288 :: 		}
L_end_dump_arr_memory:
ADD	SP, SP, #4
BX	LR
; end of _dump_arr_memory
_load_duck_screen:
;cp_game_ctl.h,300 :: 		void load_duck_screen() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;cp_game_ctl.h,301 :: 		uint32_t x_axis = 0;
;cp_game_ctl.h,302 :: 		uint32_t y_axis = 0;
;cp_game_ctl.h,303 :: 		uint32_t PX_BLOCK = 16;
;cp_game_ctl.h,304 :: 		uint32_t i=0;
;cp_game_ctl.h,306 :: 		uint32_t value = 0;
;cp_game_ctl.h,310 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,314 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,318 :: 		TFT_Fill_Screen(CL_NAVY);
MOVW	R0, #16
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,320 :: 		TFT_SET_PEN(m_BLACK, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,321 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,325 :: 		duck_sprite();
BL	_duck_sprite+0
;cp_game_ctl.h,330 :: 		for (i=0; i< 20; i++) {
MOVS	R0, #0
STR	R0, [SP, #4]
L_load_duck_screen110:
LDR	R0, [SP, #4]
CMP	R0, #20
IT	CS
BCS	L_load_duck_screen111
;cp_game_ctl.h,336 :: 		cleaning_buffer(m_NAVY);
MOVS	R0, #3
BL	_cleaning_buffer+0
;cp_game_ctl.h,339 :: 		set_sprite_offset(i, 6);
MOVS	R1, #6
LDR	R0, [SP, #4]
BL	_set_sprite_offset+0
;cp_game_ctl.h,340 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_game_ctl.h,330 :: 		for (i=0; i< 20; i++) {
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
STR	R0, [SP, #4]
;cp_game_ctl.h,341 :: 		}
IT	AL
BAL	L_load_duck_screen110
L_load_duck_screen111:
;cp_game_ctl.h,345 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_duck_screen113:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_duck_screen114
IT	AL
BAL	L_load_duck_screen113
L_load_duck_screen114:
;cp_game_ctl.h,348 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_game_ctl.h,353 :: 		}
L_end_load_duck_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _load_duck_screen
_load_snake_game:
;cp_game_ctl.h,355 :: 		void load_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,358 :: 		g_GAME_PHASE = PHASE1_READY;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,360 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,364 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,366 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,368 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,369 :: 		set_brush_color(m_BLACK);
MOVS	R0, #0
BL	_set_brush_color+0
;cp_game_ctl.h,371 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,372 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,373 :: 		TFT_Write_Text("READY?", 7 * PX_BLOCK, 6 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr1_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr1_P7_final_project_main+0)
MOVW	R2, #96
MOVW	R1, #112
BL	_TFT_Write_Text+0
;cp_game_ctl.h,374 :: 		TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 7*PX_BLOCK);
MOVW	R0, #lo_addr(?lstr2_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr2_P7_final_project_main+0)
MOVW	R2, #112
MOVW	R1, #80
BL	_TFT_Write_Text+0
;cp_game_ctl.h,376 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_snake_game115:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_snake_game116
IT	AL
BAL	L_load_snake_game115
L_load_snake_game116:
;cp_game_ctl.h,377 :: 		}
L_end_load_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _load_snake_game
_update_score:
;cp_game_ctl.h,380 :: 		void update_score() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,381 :: 		sprintf(g_str_buffer, "Score: \x20 %05d", g_game_score);
MOVW	R0, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_3_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_3_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,382 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,385 :: 		sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d",g_debug );       // ****Printout debugger
MOVW	R0, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_4_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_4_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;cp_game_ctl.h,386 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,387 :: 		}
L_end_update_score:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_score
_update_time:
;cp_game_ctl.h,390 :: 		void update_time() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,391 :: 		g_t_secs = g_time_count % 60;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R2, [R0, #0]
MOVS	R0, #60
UDIV	R1, R2, R0
MLS	R1, R0, R1, R2
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,392 :: 		if (g_t_secs != 0) {
CMP	R1, #0
IT	EQ
BEQ	L_update_time117
;cp_game_ctl.h,393 :: 		g_t_wait = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,394 :: 		}
L_update_time117:
;cp_game_ctl.h,395 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time187
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time186
L__update_time185:
;cp_game_ctl.h,396 :: 		g_t_mins++;
MOVW	R1, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,397 :: 		g_t_wait = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,395 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
L__update_time187:
L__update_time186:
;cp_game_ctl.h,399 :: 		sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins, g_t_secs );
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_5_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_5_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,400 :: 		TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #240
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,401 :: 		}
L_end_update_time:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_time
_init_snake_game:
;cp_game_ctl.h,405 :: 		void init_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,407 :: 		g_GAME_PHASE = PHASE2_PLAYING;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,409 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,413 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,415 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,417 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,418 :: 		set_brush_color(m_GREEN);
MOVS	R0, #4
BL	_set_brush_color+0
;cp_game_ctl.h,423 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,424 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,426 :: 		Delay_ms(100);  // Delay to allow screen to get wiped
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_init_snake_game121:
SUBS	R7, R7, #1
BNE	L_init_snake_game121
NOP
NOP
NOP
;cp_game_ctl.h,427 :: 		init_snake_sprite();
BL	_init_snake_sprite+0
;cp_game_ctl.h,429 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_game_ctl.h,431 :: 		}
L_end_init_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_game
_start_snake_game:
;cp_game_ctl.h,435 :: 		void start_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,439 :: 		uint32_t num = 2550;
;cp_game_ctl.h,446 :: 		while (cur_screen_run_flag == TRUE) {
L_start_snake_game123:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_start_snake_game124
;cp_game_ctl.h,483 :: 		};
IT	AL
BAL	L_start_snake_game123
L_start_snake_game124:
;cp_game_ctl.h,486 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_game_ctl.h,488 :: 		}
L_end_start_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _start_snake_game
_screen_refresh_TIM3:
;cp_game_ctl.h,490 :: 		void screen_refresh_TIM3() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,494 :: 		clean_tail(node_tail, m_BLACK);
MOVW	R0, #lo_addr(_node_tail+0)
MOVT	R0, #hi_addr(_node_tail+0)
LDR	R0, [R0, #0]
MOVS	R1, #0
BL	_clean_tail+0
;cp_game_ctl.h,495 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_screen_refresh_TIM3125:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3125
NOP
NOP
NOP
;cp_game_ctl.h,498 :: 		move_snake();
BL	_move_snake+0
;cp_game_ctl.h,499 :: 		print_snake(node_head, m_GREEN);
MOVW	R0, #lo_addr(_node_head+0)
MOVT	R0, #hi_addr(_node_head+0)
LDR	R0, [R0, #0]
MOVS	R1, #4
BL	_print_snake+0
;cp_game_ctl.h,500 :: 		Delay_ms(10); // Delay needed for screen to catch up
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_screen_refresh_TIM3127:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3127
NOP
NOP
NOP
;cp_game_ctl.h,502 :: 		incr_snake_tail();
BL	_incr_snake_tail+0
;cp_game_ctl.h,506 :: 		Delay_ms(20);
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_screen_refresh_TIM3129:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3129
NOP
NOP
NOP
;cp_game_ctl.h,507 :: 		if (g_food_in_play == FALSE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_food_in_play+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_screen_refresh_TIM3131
;cp_game_ctl.h,508 :: 		generate_food();
BL	_generate_food+0
;cp_game_ctl.h,509 :: 		}
L_screen_refresh_TIM3131:
;cp_game_ctl.h,510 :: 		g_food_in_play = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_food_in_play+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,513 :: 		}
L_end_screen_refresh_TIM3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _screen_refresh_TIM3
_scr_debug:
;cp_game_ctl.h,522 :: 		void scr_debug(uint32_t value) {
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 0 (R0)
; value start address is: 0 (R0)
;cp_game_ctl.h,523 :: 		g_debug = value;
MOVW	R1, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_debug+0)
STR	R0, [R1, #0]
; value end address is: 0 (R0)
;cp_game_ctl.h,524 :: 		}
L_end_scr_debug:
ADD	SP, SP, #4
BX	LR
; end of _scr_debug
_init_snake_sprite:
;cp_game_ctl.h,527 :: 		void init_snake_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,530 :: 		node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R2, #lo_addr(_node_head+0)
MOVT	R2, #hi_addr(_node_head+0)
LDR	R0, [R2, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,531 :: 		node_head->node_y = 1;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,532 :: 		print_snake(node_head, m_GREEN);
MOV	R0, R2
LDR	R0, [R0, #0]
MOVS	R1, #4
BL	_print_snake+0
;cp_game_ctl.h,541 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_init_snake_sprite132:
SUBS	R7, R7, #1
BNE	L_init_snake_sprite132
NOP
NOP
NOP
;cp_game_ctl.h,545 :: 		}
L_end_init_snake_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_sprite
_duck_sprite:
;cp_game_ctl.h,547 :: 		void duck_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,557 :: 		load_cell_xy(8,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,558 :: 		load_cell_xy(9,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,559 :: 		load_cell_xy(10,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,562 :: 		load_cell_xy(2,2,m_YELLOW); //face
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,563 :: 		load_cell_xy(3,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,564 :: 		load_cell_xy(7,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,565 :: 		load_cell_xy(8,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,570 :: 		load_cell_xy(7,1, m_BLACK); // Sunglasses
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,571 :: 		load_cell_xy(8,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,572 :: 		load_cell_xy(9,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,573 :: 		load_cell_xy(10,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,574 :: 		load_cell_xy(11,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,575 :: 		load_cell_xy(9,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,576 :: 		load_cell_xy(10,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,581 :: 		load_cell_xy(11,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,582 :: 		load_cell_xy(12,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_game_ctl.h,583 :: 		load_cell_xy(13,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #13
BL	_load_cell_xy+0
;cp_game_ctl.h,584 :: 		load_cell_xy(11,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,585 :: 		load_cell_xy(12,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_game_ctl.h,588 :: 		load_cell_xy(1,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,589 :: 		load_cell_xy(2,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,590 :: 		load_cell_xy(3,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,591 :: 		load_cell_xy(4,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,592 :: 		load_cell_xy(8,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,593 :: 		load_cell_xy(9,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,594 :: 		load_cell_xy(10,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,595 :: 		load_cell_xy(0,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #0
BL	_load_cell_xy+0
;cp_game_ctl.h,596 :: 		load_cell_xy(1,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,597 :: 		load_cell_xy(2,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,598 :: 		load_cell_xy(3,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,599 :: 		load_cell_xy(4,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,600 :: 		load_cell_xy(5,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,601 :: 		load_cell_xy(6,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,602 :: 		load_cell_xy(7,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,603 :: 		load_cell_xy(8,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,604 :: 		load_cell_xy(9,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,605 :: 		load_cell_xy(10,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,606 :: 		load_cell_xy(1,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,607 :: 		load_cell_xy(2,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,608 :: 		load_cell_xy(3,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,609 :: 		load_cell_xy(4,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,610 :: 		load_cell_xy(5,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,611 :: 		load_cell_xy(6,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,612 :: 		load_cell_xy(7,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,613 :: 		load_cell_xy(8,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,614 :: 		load_cell_xy(9,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,615 :: 		load_cell_xy(10,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,616 :: 		load_cell_xy(2,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,617 :: 		load_cell_xy(3,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,618 :: 		load_cell_xy(4,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,619 :: 		load_cell_xy(5,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,620 :: 		load_cell_xy(6,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,621 :: 		load_cell_xy(7,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,622 :: 		load_cell_xy(8,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,623 :: 		load_cell_xy(9,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,624 :: 		load_cell_xy(10,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,625 :: 		load_cell_xy(3,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,626 :: 		load_cell_xy(4,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,627 :: 		load_cell_xy(5,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,628 :: 		load_cell_xy(6,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,629 :: 		load_cell_xy(7,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,630 :: 		load_cell_xy(8,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,631 :: 		load_cell_xy(9,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,632 :: 		load_cell_xy(4,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,633 :: 		load_cell_xy(5,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,634 :: 		load_cell_xy(6,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,635 :: 		load_cell_xy(7,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,636 :: 		load_cell_xy(8,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,637 :: 		}
L_end_duck_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _duck_sprite
_EXTI15_10:
;P7_final_project_main.c,90 :: 		void EXTI15_10() iv IVT_INT_EXTI15_10  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,92 :: 		EXTI_PR |= 1 << 13;     // Rearm interrupt
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,93 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,95 :: 		while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }
L_EXTI15_10134:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_10135
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTI15_10134
L_EXTI15_10135:
;P7_final_project_main.c,97 :: 		g_cur_game_phase = get_game_mode();
BL	_get_game_mode+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,99 :: 		switch (g_cur_game_phase)
IT	AL
BAL	L_EXTI15_10136
;P7_final_project_main.c,101 :: 		case PHASE_INTRO:
L_EXTI15_10138:
;P7_final_project_main.c,102 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,103 :: 		g_cur_game_phase = PHASE1_READY; // load_snake_game
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,104 :: 		break;
IT	AL
BAL	L_EXTI15_10137
;P7_final_project_main.c,106 :: 		case PHASE1_READY:
L_EXTI15_10139:
;P7_final_project_main.c,107 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,108 :: 		g_cur_game_phase = PHASE2_PLAYING;    // Start snake game
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,109 :: 		break;
IT	AL
BAL	L_EXTI15_10137
;P7_final_project_main.c,111 :: 		case PHASE2_PLAYING:
L_EXTI15_10140:
;P7_final_project_main.c,112 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_EXTI15_10141:
SUBS	R7, R7, #1
BNE	L_EXTI15_10141
NOP
NOP
NOP
;P7_final_project_main.c,116 :: 		break;
IT	AL
BAL	L_EXTI15_10137
;P7_final_project_main.c,123 :: 		default:
L_EXTI15_10143:
;P7_final_project_main.c,124 :: 		break;
IT	AL
BAL	L_EXTI15_10137
;P7_final_project_main.c,125 :: 		}
L_EXTI15_10136:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTI15_10138
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTI15_10139
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTI15_10140
IT	AL
BAL	L_EXTI15_10143
L_EXTI15_10137:
;P7_final_project_main.c,149 :: 		}
L_end_EXTI15_10:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10
_EXTIPA6:
;P7_final_project_main.c,152 :: 		void EXTIPA6() iv IVT_INT_EXTI9_5  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,153 :: 		if (GPIOB_IDR.B5 == 0) {
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6144
;P7_final_project_main.c,154 :: 		while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
L_EXTIPA6145:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6146
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6145
L_EXTIPA6146:
;P7_final_project_main.c,155 :: 		EXTI_PR |= 1 << 5;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,156 :: 		set_curr_snake_dir(MOVE_DOWN);
MOVS	R0, #3
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,157 :: 		}
L_EXTIPA6144:
;P7_final_project_main.c,160 :: 		if (GPIOA_IDR.B6 == 0) {
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6147
;P7_final_project_main.c,161 :: 		EXTI_PR |= 1 << 6;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,162 :: 		while (GPIOA_IDR.B6 == 0) {
L_EXTIPA6148:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6149
;P7_final_project_main.c,163 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,164 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_EXTIPA6150:
SUBS	R7, R7, #1
BNE	L_EXTIPA6150
NOP
NOP
NOP
;P7_final_project_main.c,165 :: 		}
IT	AL
BAL	L_EXTIPA6148
L_EXTIPA6149:
;P7_final_project_main.c,166 :: 		set_curr_snake_dir(MOVE_RIGHT);
MOVS	R0, #0
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,180 :: 		}
L_EXTIPA6147:
;P7_final_project_main.c,184 :: 		}
L_end_EXTIPA6:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPA6
_EXTIPD2:
;P7_final_project_main.c,187 :: 		void EXTIPD2() iv IVT_INT_EXTI2  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,188 :: 		EXTI_PR |= 1 << 2;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,189 :: 		while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD2152:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD2153
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD2152
L_EXTIPD2153:
;P7_final_project_main.c,190 :: 		set_curr_snake_dir(MOVE_LEFT);
MOVS	R0, #1
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,193 :: 		}
L_end_EXTIPD2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD2
_EXTIPD4:
;P7_final_project_main.c,196 :: 		void EXTIPD4() iv IVT_INT_EXTI4  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,197 :: 		EXTI_PR |= 1 << 4;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,198 :: 		while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD4154:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD4155
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD4154
L_EXTIPD4155:
;P7_final_project_main.c,199 :: 		set_curr_snake_dir(MOVE_UP);
MOVS	R0, #2
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,200 :: 		}
L_end_EXTIPD4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD4
_TIMER2_ISR:
;P7_final_project_main.c,203 :: 		void TIMER2_ISR() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,204 :: 		TIM2_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,205 :: 		update_game_time();
BL	_update_game_time+0
;P7_final_project_main.c,210 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;P7_final_project_main.c,211 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_TIMER2_ISR156:
SUBS	R7, R7, #1
BNE	L_TIMER2_ISR156
NOP
NOP
NOP
;P7_final_project_main.c,214 :: 		update_time();
BL	_update_time+0
;P7_final_project_main.c,217 :: 		update_score();
BL	_update_score+0
;P7_final_project_main.c,224 :: 		debug_val = ADC1_Read(3);
MOVS	R0, #3
BL	_ADC1_Read+0
MOVW	R1, #lo_addr(_debug_val+0)
MOVT	R1, #hi_addr(_debug_val+0)
STR	R0, [R1, #0]
;P7_final_project_main.c,228 :: 		}
L_end_TIMER2_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER2_ISR
_TIMER3_ISR:
;P7_final_project_main.c,231 :: 		void TIMER3_ISR() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,232 :: 		TIM3_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,233 :: 		toggle_game_clock_delay();
BL	_toggle_game_clock_delay+0
;P7_final_project_main.c,240 :: 		screen_refresh_TIM3();
BL	_screen_refresh_TIM3+0
;P7_final_project_main.c,241 :: 		}
L_end_TIMER3_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER3_ISR
_init_cfg_M_CTL:
;P7_final_project_main.c,251 :: 		void init_cfg_M_CTL() {
SUB	SP, SP, #4
;P7_final_project_main.c,254 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,256 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,257 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,259 :: 		RCC_APB2ENR |= 1 << 2;                    // Enable GPIO clock for PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,260 :: 		RCC_APB2ENR |= 1 << 3;                    // Enable GPIO clock for PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,261 :: 		RCC_APB2ENR |= 1 << 4;                    // Enable GPIO clock for PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,262 :: 		RCC_APB2ENR |= 1 << 5;                    // Enable GPIO clock for PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,263 :: 		RCC_APB2ENR |= 1 << 6;                    // Enable GPIO clock for PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,264 :: 		RCC_APB2ENR |= 1 << 14;                   // Enable GPIO clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,265 :: 		RCC_APB2ENR |= 1 << 9;                   // Enable ADC1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #512
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,268 :: 		GPIOE_CRH = 0xFF00;
MOVW	R1, #65280
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,269 :: 		GPIOA_CRL &= ~(0xF << 12);                 // PA3 - Analog input mode b0000 bit[15:12]
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MVN	R0, #61440
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,272 :: 		GPIOA_CRL |= 4 << 4;                       // Enable PA4;  Game TIMER3 control
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,273 :: 		GPIOA_CRL |= 4 << 6;                       // Enable PA6;  joystick=RIGHT
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,274 :: 		GPIOB_CRL |= 4 << 5;                       // Enable PB5;  joystick=DOWN
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,275 :: 		GPIOD_CRL |= 4 << 2;                       // Enable PD2;  joystick=LEFT
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,276 :: 		GPIOD_CRL |= 4 << 4;                       // Enable PD4;  joystick=UP
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,277 :: 		GPIOC_CRH |= 4 << 5;                       // Enable PC13; joystick=PUSH BUTTON
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,305 :: 		}
L_end_init_cfg_M_CTL:
ADD	SP, SP, #4
BX	LR
; end of _init_cfg_M_CTL
_config_USART1:
;P7_final_project_main.c,308 :: 		void config_USART1() {
SUB	SP, SP, #4
;P7_final_project_main.c,309 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,310 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,311 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,314 :: 		USART1_BRR = 0x00000506;                    // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,318 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,320 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,321 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,322 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,323 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,325 :: 		USART1_CR1 |=   1 << 3;                     // Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,326 :: 		USART1_CR1 |=   1 << 2;                     // Rx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,328 :: 		Delay_ms(100);                              // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_config_USART1158:
SUBS	R7, R7, #1
BNE	L_config_USART1158
NOP
NOP
NOP
;P7_final_project_main.c,329 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,332 :: 		}
L_end_config_USART1:
ADD	SP, SP, #4
BX	LR
; end of _config_USART1
_init_timer2:
;P7_final_project_main.c,338 :: 		void init_timer2() {
SUB	SP, SP, #4
;P7_final_project_main.c,339 :: 		RCC_APB1ENR |= 1 << 0;                      // Enable Clock for TIMER2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,340 :: 		TIM2_CR1     = 0x0000;                      // Disable the timer for config setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,341 :: 		TIM2_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,343 :: 		TIM2_ARR     = 9000;                        // Set the auto-reload register to calclated value
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,344 :: 		TIM2_DIER  |= 1 << 0;                      // Enable TIMER2 Interrupt
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,346 :: 		}
L_end_init_timer2:
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_timer3:
;P7_final_project_main.c,348 :: 		void init_timer3() {
SUB	SP, SP, #4
;P7_final_project_main.c,349 :: 		RCC_APB1ENR |= (1 << 1);                   // Enable TIMER3 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,350 :: 		TIM3_CR1    = 0x0000;                       // Disable time for setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,351 :: 		TIM3_PSC    = 7999;                         // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,353 :: 		TIM3_ARR    = g_game_speed;                         // auto-reload reg. 2 seconds so  double it = 9000*2 = 18000
MOVW	R0, #lo_addr(P7_final_project_main_g_game_speed+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_speed+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,354 :: 		TIM3_DIER   |= 1 << 0;                      // Enable interrupt
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,357 :: 		}
L_end_init_timer3:
ADD	SP, SP, #4
BX	LR
; end of _init_timer3
_init_interrupt:
;P7_final_project_main.c,360 :: 		void init_interrupt() {
SUB	SP, SP, #4
;P7_final_project_main.c,363 :: 		AFIO_EXTICR2 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,364 :: 		NVIC_ISER0   = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,368 :: 		AFIO_EXTICR1 |= 3 << 8;                     // PD2 = EXTI2[11:8]; PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,369 :: 		AFIO_EXTICR2 |= 3 << 0;                     // PD4 = EXTI4[3:0];  PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,370 :: 		AFIO_EXTICR2 |= 1 << 4;                     // PB5 = EXTI5[7:4];  PortB = b0001;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,371 :: 		AFIO_EXTICR2 &= ~(0xF << 8);                // PA6 = EXTI6[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MVN	R0, #3840
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,372 :: 		AFIO_EXTICR4 |= 2 << 4;                     // PC13  EXTI13[7:4]; PortC = b0010;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,376 :: 		EXTI_FTSR |= 1 << 2; // EXTI2 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,377 :: 		EXTI_FTSR |= 1 << 4; // EXTI4 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,378 :: 		EXTI_FTSR |= 1 << 5; // EXTI5 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,379 :: 		EXTI_FTSR |= 1 << 6; // EXTI6 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,380 :: 		EXTI_FTSR |= 1 << 13; // EXTI13 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,383 :: 		EXTI_IMR |= 0x00002074;      // Set EXTI2,4,5,6,13 to not-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R1, [R0, #0]
MOVW	R0, #8308
ORRS	R1, R0
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,388 :: 		NVIC_ISER0 |= (uint32_t) 1 << 8;            // EXTI2  NVIC Pos=8:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,389 :: 		NVIC_ISER0 |= (uint32_t) 1 << 10;           // EXTI4  NVIC Pos=10:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,390 :: 		NVIC_ISER0 |= (uint32_t) 1 << 23;           // EXTI5  NVIC Pos=23: EXTI9_5
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,391 :: 		NVIC_ISER0 |= (uint32_t) 1 << 28;           // TIMER2  NVIC Pos=28
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #268435456
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,392 :: 		NVIC_ISER0 |= (uint32_t) 1 << 29;           // TIMER3  NVIC Pos=29
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #536870912
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,394 :: 		NVIC_ISER1 |= (uint32_t) 1 << 8;            // EXTI13 NVIC Pos=40: EXTI15_10
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,395 :: 		NVIC_ISER1 |= (uint32_t) 1 << 5;            // USART1 NVIC Pos=37: ISER1[63:32]; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,406 :: 		}
L_end_init_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _init_interrupt
_main:
;P7_final_project_main.c,411 :: 		void main() {
SUB	SP, SP, #4
;P7_final_project_main.c,415 :: 		int num =0;
;P7_final_project_main.c,418 :: 		init_cfg_M_CTL();
BL	_init_cfg_M_CTL+0
;P7_final_project_main.c,421 :: 		config_USART1();
BL	_config_USART1+0
;P7_final_project_main.c,426 :: 		init_timer2();
BL	_init_timer2+0
;P7_final_project_main.c,427 :: 		init_timer3();
BL	_init_timer3+0
;P7_final_project_main.c,431 :: 		init_interrupt();
BL	_init_interrupt+0
;P7_final_project_main.c,435 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,448 :: 		load_snake_game();
BL	_load_snake_game+0
;P7_final_project_main.c,452 :: 		init_snake_game();
BL	_init_snake_game+0
;P7_final_project_main.c,454 :: 		TIM2_CR1     = 0x0001; // Start TIMER2 for game time
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,455 :: 		TIM3_CR1    = 0x0001; // Start TIMER3 now
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,456 :: 		start_snake_game();
BL	_start_snake_game+0
;P7_final_project_main.c,459 :: 		TFT_SET_Brush(1, CL_RED, 0, 0, 0 ,0);
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
;P7_final_project_main.c,460 :: 		TFT_Rectangle(0, 0, 320, 240);
MOVS	R3, #240
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;P7_final_project_main.c,461 :: 		TFT_Fill_Screen(CL_RED);
MOVW	R0, #63488
BL	_TFT_Fill_Screen+0
;P7_final_project_main.c,463 :: 		Delay_ms(3000);
MOVW	R7, #20735
MOVT	R7, #549
NOP
NOP
L_main160:
SUBS	R7, R7, #1
BNE	L_main160
NOP
NOP
NOP
;P7_final_project_main.c,465 :: 		while (1) {
L_main162:
;P7_final_project_main.c,467 :: 		}
IT	AL
BAL	L_main162
;P7_final_project_main.c,468 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
