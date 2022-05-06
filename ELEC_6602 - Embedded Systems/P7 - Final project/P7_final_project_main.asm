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
BHI	L__load_intro_screen_simple177
LDR	R0, [SP, #8]
CMP	R0, #290
IT	HI
BHI	L__load_intro_screen_simple176
IT	AL
BAL	L_load_intro_screen_simple11
L__load_intro_screen_simple177:
L__load_intro_screen_simple176:
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
BCC	L__load_intro_screen_simple179
LDR	R0, [SP, #8]
CMP	R0, #2
IT	CC
BCC	L__load_intro_screen_simple178
IT	AL
BAL	L_load_intro_screen_simple15
L__load_intro_screen_simple179:
L__load_intro_screen_simple178:
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
BHI	L__load_intro_screen185
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen184
IT	AL
BAL	L_load_intro_screen21
L__load_intro_screen185:
L__load_intro_screen184:
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
BHI	L__load_intro_screen187
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen186
IT	AL
BAL	L_load_intro_screen28
L__load_intro_screen187:
L__load_intro_screen186:
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
BCC	L__load_intro_screen189
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen188
IT	AL
BAL	L_load_intro_screen35
L__load_intro_screen189:
L__load_intro_screen188:
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
BNE	L__load_intro_screen192
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
BCC	L__load_intro_screen191
CMP	R4, #198
IT	HI
BHI	L__load_intro_screen190
IT	AL
BAL	L_load_intro_screen42
L__load_intro_screen191:
L__load_intro_screen190:
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
L__load_intro_screen192:
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
;cp_pix_render.h,51 :: 		void set_sprite_offset(int32_t ofs_x, int32_t ofs_y) {
; ofs_y start address is: 4 (R1)
; ofs_x start address is: 0 (R0)
SUB	SP, SP, #4
; ofs_y end address is: 4 (R1)
; ofs_x end address is: 0 (R0)
; ofs_x start address is: 0 (R0)
; ofs_y start address is: 4 (R1)
;cp_pix_render.h,52 :: 		offset_x = ofs_x;
MOVW	R2, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_x+0)
STR	R0, [R2, #0]
; ofs_x end address is: 0 (R0)
;cp_pix_render.h,53 :: 		offset_y = ofs_y;
MOVW	R2, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R2, #hi_addr(P7_final_project_main_offset_y+0)
STR	R1, [R2, #0]
; ofs_y end address is: 4 (R1)
;cp_pix_render.h,54 :: 		}
L_end_set_sprite_offset:
ADD	SP, SP, #4
BX	LR
; end of _set_sprite_offset
_get_offset_x:
;cp_pix_render.h,56 :: 		int32_t get_offset_x() {
SUB	SP, SP, #4
;cp_pix_render.h,57 :: 		return offset_x;
MOVW	R0, #lo_addr(P7_final_project_main_offset_x+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_x+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,58 :: 		}
L_end_get_offset_x:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_x
_get_offset_y:
;cp_pix_render.h,59 :: 		int32_t get_offset_y() {
SUB	SP, SP, #4
;cp_pix_render.h,60 :: 		return offset_y;
MOVW	R0, #lo_addr(P7_final_project_main_offset_y+0)
MOVT	R0, #hi_addr(P7_final_project_main_offset_y+0)
LDR	R0, [R0, #0]
;cp_pix_render.h,61 :: 		}
L_end_get_offset_y:
ADD	SP, SP, #4
BX	LR
; end of _get_offset_y
_convert_lin_xy:
;cp_pix_render.h,66 :: 		void convert_lin_xy(int32_t *cell_pos, int32_t *x_var, int32_t *y_var ) {
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
;cp_pix_render.h,68 :: 		int32_t row = 0;
; row start address is: 0 (R0)
MOV	R0, #0
;cp_pix_render.h,69 :: 		int32_t col = 0;
;cp_pix_render.h,70 :: 		int32_t temp_val = *cell_pos;
LDR	R3, [R4, #0]
; cell_pos end address is: 16 (R4)
; temp_val start address is: 16 (R4)
MOV	R4, R3
;cp_pix_render.h,72 :: 		if (temp_val > MAX_BLOCK_COUNT) {
CMP	R3, #300
IT	LE
BLE	L__convert_lin_xy193
; temp_val end address is: 16 (R4)
;cp_pix_render.h,73 :: 		temp_val = 300;
; temp_val start address is: 12 (R3)
MOVW	R3, #300
; temp_val end address is: 12 (R3)
;cp_pix_render.h,74 :: 		}
IT	AL
BAL	L_convert_lin_xy48
L__convert_lin_xy193:
;cp_pix_render.h,72 :: 		if (temp_val > MAX_BLOCK_COUNT) {
MOV	R3, R4
;cp_pix_render.h,74 :: 		}
L_convert_lin_xy48:
;cp_pix_render.h,79 :: 		while (temp_val >= (MAX_COL_WIDTH) ) {
; temp_val start address is: 12 (R3)
; y_var end address is: 8 (R2)
; row end address is: 0 (R0)
; x_var end address is: 4 (R1)
; temp_val end address is: 12 (R3)
MOV	R5, R0
MOV	R0, R2
MOV	R2, R3
L_convert_lin_xy49:
; temp_val start address is: 8 (R2)
; row start address is: 20 (R5)
; y_var start address is: 0 (R0)
; x_var start address is: 4 (R1)
CMP	R2, #20
IT	LT
BLT	L_convert_lin_xy50
;cp_pix_render.h,80 :: 		temp_val -= MAX_COL_WIDTH-1;
SUBW	R4, R2, #19
; temp_val end address is: 8 (R2)
; temp_val start address is: 24 (R6)
MOV	R6, R4
;cp_pix_render.h,81 :: 		++row;
ADDS	R3, R5, #1
; row end address is: 20 (R5)
; row start address is: 8 (R2)
MOV	R2, R3
;cp_pix_render.h,83 :: 		if (temp_val > 0 ) {
CMP	R4, #0
IT	LE
BLE	L__convert_lin_xy194
;cp_pix_render.h,84 :: 		--temp_val; // compensate for zero-index of array by subtract 1
SUBS	R3, R6, #1
; temp_val end address is: 24 (R6)
; temp_val start address is: 16 (R4)
MOV	R4, R3
; temp_val end address is: 16 (R4)
MOV	R3, R4
;cp_pix_render.h,85 :: 		}
IT	AL
BAL	L_convert_lin_xy51
L__convert_lin_xy194:
;cp_pix_render.h,83 :: 		if (temp_val > 0 ) {
MOV	R3, R6
;cp_pix_render.h,85 :: 		}
L_convert_lin_xy51:
;cp_pix_render.h,87 :: 		}
; temp_val start address is: 12 (R3)
; row end address is: 8 (R2)
; temp_val end address is: 12 (R3)
MOV	R5, R2
MOV	R2, R3
IT	AL
BAL	L_convert_lin_xy49
L_convert_lin_xy50:
;cp_pix_render.h,91 :: 		if (row <= 0 ) {
; row start address is: 20 (R5)
; temp_val start address is: 8 (R2)
CMP	R5, #0
IT	GT
BGT	L__convert_lin_xy195
; row end address is: 20 (R5)
;cp_pix_render.h,92 :: 		row = 1;
; row start address is: 12 (R3)
MOVS	R3, #1
; row end address is: 12 (R3)
;cp_pix_render.h,93 :: 		}
IT	AL
BAL	L_convert_lin_xy52
L__convert_lin_xy195:
;cp_pix_render.h,91 :: 		if (row <= 0 ) {
MOV	R3, R5
;cp_pix_render.h,93 :: 		}
L_convert_lin_xy52:
;cp_pix_render.h,97 :: 		*x_var = col;
; row start address is: 12 (R3)
STR	R2, [R1, #0]
; temp_val end address is: 8 (R2)
; x_var end address is: 4 (R1)
;cp_pix_render.h,98 :: 		*y_var = row;
STR	R3, [R0, #0]
; y_var end address is: 0 (R0)
; row end address is: 12 (R3)
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
BNE	L_color_convert_3253
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,107 :: 		return CL_YELLOW;
MOVW	R0, #65504
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,108 :: 		} else if (color_8bit == m_BLACK) {
L_color_convert_3253:
; color_8bit start address is: 0 (R0)
CMP	R0, #0
IT	NE
BNE	L_color_convert_3255
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,109 :: 		return CL_BLACK;
MOVW	R0, #0
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,110 :: 		} else if (color_8bit == m_RED) {
L_color_convert_3255:
; color_8bit start address is: 0 (R0)
CMP	R0, #2
IT	NE
BNE	L_color_convert_3257
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,111 :: 		return CL_RED;
MOVW	R0, #63488
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,112 :: 		} else if (color_8bit == m_NAVY) {
L_color_convert_3257:
; color_8bit start address is: 0 (R0)
CMP	R0, #3
IT	NE
BNE	L_color_convert_3259
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,113 :: 		return CL_NAVY;
MOVW	R0, #16
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,114 :: 		} else if (color_8bit == m_GREEN) {
L_color_convert_3259:
; color_8bit start address is: 0 (R0)
CMP	R0, #4
IT	NE
BNE	L_color_convert_3261
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,115 :: 		return CL_GREEN;
MOVW	R0, #1024
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,116 :: 		} else if (color_8bit == m_FUCHSIA) {
L_color_convert_3261:
; color_8bit start address is: 0 (R0)
CMP	R0, #6
IT	NE
BNE	L_color_convert_3263
; color_8bit end address is: 0 (R0)
;cp_pix_render.h,117 :: 		return CL_FUCHSIA;
MOVW	R0, #63519
IT	AL
BAL	L_end_color_convert_32
;cp_pix_render.h,118 :: 		} else {
L_color_convert_3263:
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
BEQ	L_draw_cell_pos65
;cp_pix_render.h,140 :: 		set_brush_color(color_8bit);
UXTB	R0, R1
; color_8bit end address is: 4 (R1)
BL	_set_brush_color+0
;cp_pix_render.h,141 :: 		}
L_draw_cell_pos65:
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
;cp_pix_render.h,157 :: 		}
L_end_draw_cell_pos:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _draw_cell_pos
_draw_cell_xy:
;cp_pix_render.h,161 :: 		void draw_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {
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
;cp_pix_render.h,163 :: 		if (color_8bit != CUR_BRUSH_COLOUR) {
MOVW	R3, #lo_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
MOVT	R3, #hi_addr(P7_final_project_main_CUR_BRUSH_COLOUR+0)
LDRB	R3, [R3, #0]
CMP	R2, R3
IT	EQ
BEQ	L_draw_cell_xy66
;cp_pix_render.h,164 :: 		set_brush_color(color_8bit);
UXTB	R0, R2
; color_8bit end address is: 8 (R2)
BL	_set_brush_color+0
;cp_pix_render.h,165 :: 		}
L_draw_cell_xy66:
;cp_pix_render.h,172 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
LSL	R6, R9, #4
SXTH	R6, R6
; y_var end address is: 36 (R9)
ADDW	R5, R6, #16
;cp_pix_render.h,171 :: 		PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
LSL	R4, R8, #4
SXTH	R4, R4
; x_var end address is: 32 (R8)
ADDW	R3, R4, #16
SXTH	R2, R3
;cp_pix_render.h,172 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
SXTH	R3, R5
;cp_pix_render.h,170 :: 		(y_var * PX_BLOCK),                 // Upper-left Y
SXTH	R1, R6
;cp_pix_render.h,169 :: 		PX_BLOCK * x_var,                   // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,172 :: 		PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,181 :: 		}
L_end_draw_cell_xy:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_cell_xy
_render_rect_mask:
;cp_pix_render.h,187 :: 		void render_rect_mask(int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit) {
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
;cp_pix_render.h,190 :: 		set_brush_color(color_8bit);
UXTB	R0, R4
; color_8bit end address is: 16 (R4)
BL	_set_brush_color+0
;cp_pix_render.h,196 :: 		PX_BLOCK * lr_y                // Lower-right Y
LSL	R7, R11, #4
; lr_y end address is: 44 (R11)
;cp_pix_render.h,195 :: 		PX_BLOCK * lr_x,               // Lower-right X
LSL	R6, R10, #4
; lr_x end address is: 40 (R10)
;cp_pix_render.h,194 :: 		PX_BLOCK * ul_y,               // Upper-left Y
LSL	R5, R9, #4
; ul_y end address is: 36 (R9)
;cp_pix_render.h,193 :: 		PX_BLOCK * ul_x,               // Upper-left X
LSL	R4, R8, #4
; ul_x end address is: 32 (R8)
;cp_pix_render.h,196 :: 		PX_BLOCK * lr_y                // Lower-right Y
SXTH	R3, R7
;cp_pix_render.h,195 :: 		PX_BLOCK * lr_x,               // Lower-right X
SXTH	R2, R6
;cp_pix_render.h,194 :: 		PX_BLOCK * ul_y,               // Upper-left Y
SXTH	R1, R5
;cp_pix_render.h,193 :: 		PX_BLOCK * ul_x,               // Upper-left X
SXTH	R0, R4
;cp_pix_render.h,196 :: 		PX_BLOCK * lr_y                // Lower-right Y
BL	_TFT_Rectangle+0
;cp_pix_render.h,198 :: 		}
L_end_render_rect_mask:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _render_rect_mask
_load_cell_xy:
;cp_pix_render.h,203 :: 		void load_cell_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
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
;cp_pix_render.h,204 :: 		int32_t linear_val = 0;
;cp_pix_render.h,216 :: 		linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
MOV	R3, #20
MULS	R3, R1, R3
; y_var end address is: 4 (R1)
ADDS	R4, R3, R0
; x_var end address is: 0 (R0)
;cp_pix_render.h,218 :: 		g_DS_BUFFER[linear_val] = color_8bit;
MOVW	R3, #lo_addr(_g_DS_BUFFER+0)
MOVT	R3, #hi_addr(_g_DS_BUFFER+0)
ADDS	R3, R3, R4
STRB	R2, [R3, #0]
; clr_code end address is: 8 (R2)
;cp_pix_render.h,220 :: 		}
L_end_load_cell_xy:
ADD	SP, SP, #4
BX	LR
; end of _load_cell_xy
_load_snake_xy:
;cp_pix_render.h,223 :: 		void load_snake_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
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
;cp_pix_render.h,224 :: 		int32_t linear_val = 0;
;cp_pix_render.h,236 :: 		linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
MOV	R3, #20
MULS	R3, R1, R3
; y_var end address is: 4 (R1)
ADDS	R4, R3, R0
; x_var end address is: 0 (R0)
;cp_pix_render.h,238 :: 		g_DS_BUFFER[linear_val] = color_8bit;
MOVW	R3, #lo_addr(_g_DS_BUFFER+0)
MOVT	R3, #hi_addr(_g_DS_BUFFER+0)
ADDS	R3, R3, R4
STRB	R2, [R3, #0]
; clr_code end address is: 8 (R2)
;cp_pix_render.h,240 :: 		}
L_end_load_snake_xy:
ADD	SP, SP, #4
BX	LR
; end of _load_snake_xy
_dump_ds_buffer:
;cp_pix_render.h,243 :: 		void dump_ds_buffer() {
SUB	SP, SP, #12
STR	LR, [SP, #0]
;cp_pix_render.h,244 :: 		int32_t i=0;
;cp_pix_render.h,246 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
; i start address is: 4 (R1)
MOVS	R1, #0
; i end address is: 4 (R1)
L_dump_ds_buffer67:
; i start address is: 4 (R1)
CMP	R1, #300
IT	GE
BGE	L_dump_ds_buffer68
;cp_pix_render.h,248 :: 		if (g_DS_BUFFER[i] != 0xFF) {
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #255
IT	EQ
BEQ	L_dump_ds_buffer70
;cp_pix_render.h,249 :: 		draw_cell_pos(i, g_DS_BUFFER[i]); // pass the colour code
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
;cp_pix_render.h,250 :: 		}
L_dump_ds_buffer70:
;cp_pix_render.h,246 :: 		for (i=0; i < MAX_BLOCK_COUNT  ; i++) {
ADDS	R1, R1, #1
;cp_pix_render.h,252 :: 		}
; i end address is: 4 (R1)
IT	AL
BAL	L_dump_ds_buffer67
L_dump_ds_buffer68:
;cp_pix_render.h,253 :: 		}
L_end_dump_ds_buffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _dump_ds_buffer
_print_snake:
;cp_pix_render.h,255 :: 		void print_snake(t_node *node, uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; node start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; node end address is: 0 (R0)
; node start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,259 :: 		draw_cell_xy(node->node_x, node->node_y, color_8bit);
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
;cp_pix_render.h,261 :: 		}
L_end_print_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _print_snake
_clean_tail:
;cp_pix_render.h,263 :: 		void clean_tail(t_node * node_tail,  uint8_t color_8bit) {
; color_8bit start address is: 4 (R1)
; node_tail start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; color_8bit end address is: 4 (R1)
; node_tail end address is: 0 (R0)
; node_tail start address is: 0 (R0)
; color_8bit start address is: 4 (R1)
;cp_pix_render.h,264 :: 		print_snake(node_tail, color_8bit);
; color_8bit end address is: 4 (R1)
; node_tail end address is: 0 (R0)
BL	_print_snake+0
;cp_pix_render.h,265 :: 		}
L_end_clean_tail:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clean_tail
_scr_debug:
;cp_game_ctl.h,100 :: 		void scr_debug(int32_t value, int32_t value2) {
; value2 start address is: 4 (R1)
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value2 end address is: 4 (R1)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
; value2 start address is: 4 (R1)
;cp_game_ctl.h,101 :: 		g_debug = value;
MOVW	R2, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_debug+0)
STR	R0, [R2, #0]
; value end address is: 0 (R0)
;cp_game_ctl.h,102 :: 		g_debug2 = value2;
MOVW	R2, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_debug2+0)
STR	R1, [R2, #0]
; value2 end address is: 4 (R1)
;cp_game_ctl.h,103 :: 		}
L_end_scr_debug:
ADD	SP, SP, #4
BX	LR
; end of _scr_debug
_set_curr_snake_dir:
;cp_game_ctl.h,109 :: 		void set_curr_snake_dir(uint8_t new_dir) {
; new_dir start address is: 0 (R0)
SUB	SP, SP, #4
; new_dir end address is: 0 (R0)
; new_dir start address is: 0 (R0)
;cp_game_ctl.h,110 :: 		g_curr_snake_dir = new_dir;
MOVW	R1, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
STRB	R0, [R1, #0]
; new_dir end address is: 0 (R0)
;cp_game_ctl.h,111 :: 		}
L_end_set_curr_snake_dir:
ADD	SP, SP, #4
BX	LR
; end of _set_curr_snake_dir
_toggle_game_clock_delay:
;cp_game_ctl.h,115 :: 		void toggle_game_clock_delay() {
SUB	SP, SP, #4
;cp_game_ctl.h,116 :: 		g_game_clock_delay_tim3 = ~g_game_clock_delay_tim3;
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
LDRB	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_clock_delay_tim3+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,117 :: 		}
L_end_toggle_game_clock_delay:
ADD	SP, SP, #4
BX	LR
; end of _toggle_game_clock_delay
_update_game_time:
;cp_game_ctl.h,121 :: 		void update_game_time () {
SUB	SP, SP, #4
;cp_game_ctl.h,122 :: 		g_time_count++;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,123 :: 		}
L_end_update_game_time:
ADD	SP, SP, #4
BX	LR
; end of _update_game_time
_get_game_mode:
;cp_game_ctl.h,127 :: 		uint8_t get_game_mode() {
SUB	SP, SP, #4
;cp_game_ctl.h,128 :: 		return g_GAME_PHASE;
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
LDRB	R0, [R0, #0]
;cp_game_ctl.h,129 :: 		}
L_end_get_game_mode:
ADD	SP, SP, #4
BX	LR
; end of _get_game_mode
_set_food_in_play_flag:
;cp_game_ctl.h,133 :: 		void set_food_in_play_flag (uint8_t state) {
; state start address is: 0 (R0)
SUB	SP, SP, #4
; state end address is: 0 (R0)
; state start address is: 0 (R0)
;cp_game_ctl.h,134 :: 		g_food_in_play = state;
MOVW	R1, #lo_addr(P7_final_project_main_g_food_in_play+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_food_in_play+0)
STRB	R0, [R1, #0]
; state end address is: 0 (R0)
;cp_game_ctl.h,135 :: 		}
L_end_set_food_in_play_flag:
ADD	SP, SP, #4
BX	LR
; end of _set_food_in_play_flag
_set_food_xy:
;cp_game_ctl.h,139 :: 		void set_food_xy(int32_t *x_val, int32_t *y_val) {
; y_val start address is: 4 (R1)
; x_val start address is: 0 (R0)
SUB	SP, SP, #4
; y_val end address is: 4 (R1)
; x_val end address is: 0 (R0)
; x_val start address is: 0 (R0)
; y_val start address is: 4 (R1)
;cp_game_ctl.h,140 :: 		g_fd_x_val = *x_val;
LDR	R3, [R0, #0]
; x_val end address is: 0 (R0)
MOVW	R2, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_fd_x_val+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,141 :: 		g_fd_y_val = *y_val;
LDR	R3, [R1, #0]
; y_val end address is: 4 (R1)
MOVW	R2, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R2, #hi_addr(P7_final_project_main_g_fd_y_val+0)
STR	R3, [R2, #0]
;cp_game_ctl.h,144 :: 		}
L_end_set_food_xy:
ADD	SP, SP, #4
BX	LR
; end of _set_food_xy
_move_snake:
;cp_game_ctl.h,151 :: 		void move_snake() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,153 :: 		int16_t temp_x = m_node_head->node_x;
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
LDRSH	R0, [R0, #0]
; temp_x start address is: 12 (R3)
SXTH	R3, R0
;cp_game_ctl.h,154 :: 		int16_t temp_y = m_node_head->node_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
; temp_y start address is: 16 (R4)
SXTH	R4, R0
;cp_game_ctl.h,156 :: 		if (g_curr_snake_dir == MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_move_snake71
;cp_game_ctl.h,158 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake72
;cp_game_ctl.h,159 :: 		m_node_start->node_x = ++temp_x;
ADDS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,160 :: 		m_node_start->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,162 :: 		m_node_head = m_node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,163 :: 		} else {
IT	AL
BAL	L_move_snake73
L_move_snake72:
;cp_game_ctl.h,165 :: 		(m_node_head+1)->node_x = ++temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
ADDS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,166 :: 		(m_node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,167 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,168 :: 		}
L_move_snake73:
;cp_game_ctl.h,173 :: 		if (m_node_head->node_x > MAX_COL_WIDTH-1) { //0-indexed array
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #19
IT	LE
BLE	L_move_snake74
;cp_game_ctl.h,174 :: 		m_node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,175 :: 		}
L_move_snake74:
;cp_game_ctl.h,176 :: 		}
IT	AL
BAL	L_move_snake75
L_move_snake71:
;cp_game_ctl.h,177 :: 		else if (g_curr_snake_dir == MOVE_LEFT)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_move_snake76
;cp_game_ctl.h,179 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake77
;cp_game_ctl.h,180 :: 		(m_node_start)->node_x = --temp_x;
SUBS	R2, R3, #1
; temp_x end address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
LDR	R0, [R1, #0]
STRH	R2, [R0, #0]
;cp_game_ctl.h,181 :: 		(m_node_start)->node_y = temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,183 :: 		m_node_head = m_node_start;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,184 :: 		} else {
IT	AL
BAL	L_move_snake78
L_move_snake77:
;cp_game_ctl.h,186 :: 		(m_node_head+1)->node_x = --temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
LDR	R0, [R2, #0]
ADDS	R1, R0, #4
SUBS	R0, R3, #1
; temp_x end address is: 12 (R3)
STRH	R0, [R1, #0]
;cp_game_ctl.h,187 :: 		(m_node_head+1)->node_y = temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R0, R0, #2
STRH	R4, [R0, #0]
; temp_y end address is: 16 (R4)
;cp_game_ctl.h,189 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,190 :: 		}
L_move_snake78:
;cp_game_ctl.h,193 :: 		if (m_node_head->node_x < 0) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	GE
BGE	L_move_snake79
;cp_game_ctl.h,194 :: 		m_node_head->node_x = 19;
MOVS	R1, #19
SXTH	R1, R1
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,195 :: 		}
L_move_snake79:
;cp_game_ctl.h,197 :: 		}
IT	AL
BAL	L_move_snake80
L_move_snake76:
;cp_game_ctl.h,198 :: 		else if (g_curr_snake_dir == MOVE_UP)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_move_snake81
;cp_game_ctl.h,200 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake82
;cp_game_ctl.h,201 :: 		(m_node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_m_node_start+0)
MOVT	R2, #hi_addr(_m_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,202 :: 		(m_node_start)->node_y = --temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,203 :: 		m_node_head = m_node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,204 :: 		} else {
IT	AL
BAL	L_move_snake83
L_move_snake82:
;cp_game_ctl.h,206 :: 		(m_node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,207 :: 		(m_node_head+1)->node_y = --temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
SUBS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,209 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,210 :: 		}
L_move_snake83:
;cp_game_ctl.h,213 :: 		if (m_node_head->node_y < 1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	GE
BGE	L_move_snake84
;cp_game_ctl.h,214 :: 		m_node_head->node_y = (MAX_ROW_LENGTH-1);
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVW	R0, #14
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,215 :: 		}
L_move_snake84:
;cp_game_ctl.h,216 :: 		}
IT	AL
BAL	L_move_snake85
L_move_snake81:
;cp_game_ctl.h,217 :: 		else if (g_curr_snake_dir == MOVE_DOWN)  {
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	NE
BNE	L_move_snake86
;cp_game_ctl.h,218 :: 		if (m_node_head+1 > m_node_end) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #4
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R0, [R0, #0]
CMP	R1, R0
IT	LS
BLS	L_move_snake87
;cp_game_ctl.h,219 :: 		(m_node_start)->node_x = temp_x;
MOVW	R2, #lo_addr(_m_node_start+0)
MOVT	R2, #hi_addr(_m_node_start+0)
LDR	R0, [R2, #0]
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,220 :: 		(m_node_start)->node_y = ++temp_y;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,221 :: 		m_node_head = m_node_start;
MOV	R0, R2
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,222 :: 		} else {
IT	AL
BAL	L_move_snake88
L_move_snake87:
;cp_game_ctl.h,224 :: 		(m_node_head+1)->node_x = temp_x;
; temp_y start address is: 16 (R4)
; temp_x start address is: 12 (R3)
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STRH	R3, [R0, #0]
; temp_x end address is: 12 (R3)
;cp_game_ctl.h,225 :: 		(m_node_head+1)->node_y = ++temp_y;
MOV	R0, R1
LDR	R0, [R0, #0]
ADDS	R0, R0, #4
ADDS	R1, R0, #2
ADDS	R0, R4, #1
; temp_y end address is: 16 (R4)
STRH	R0, [R1, #0]
;cp_game_ctl.h,228 :: 		incr_snake_head();
BL	_incr_snake_head+0
;cp_game_ctl.h,229 :: 		}
L_move_snake88:
;cp_game_ctl.h,232 :: 		if (m_node_head->node_y > MAX_ROW_LENGTH-1 ) { // status bar is row 0
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRSH	R0, [R0, #0]
CMP	R0, #14
IT	LE
BLE	L_move_snake89
;cp_game_ctl.h,233 :: 		m_node_head->node_y = 1;
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,234 :: 		}
L_move_snake89:
;cp_game_ctl.h,236 :: 		}
L_move_snake86:
L_move_snake85:
L_move_snake80:
L_move_snake75:
;cp_game_ctl.h,238 :: 		}
L_end_move_snake:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _move_snake
_check_snake_collision:
;cp_game_ctl.h,242 :: 		int32_t check_snake_collision(int16_t x_val, int16_t y_val, t_node * start_pos) {
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
;cp_game_ctl.h,244 :: 		t_node *temp_itr = start_pos;
; temp_itr start address is: 16 (R4)
MOV	R4, R2
;cp_game_ctl.h,246 :: 		if (start_pos > m_node_end) {
MOVW	R3, #lo_addr(_m_node_end+0)
MOVT	R3, #hi_addr(_m_node_end+0)
LDR	R3, [R3, #0]
CMP	R2, R3
IT	LS
BLS	L_check_snake_collision90
; start_pos end address is: 8 (R2)
;cp_game_ctl.h,248 :: 		}
L_check_snake_collision90:
;cp_game_ctl.h,250 :: 		do {
MOV	R5, R4
; y_val end address is: 4 (R1)
; temp_itr end address is: 16 (R4)
SXTH	R4, R0
SXTH	R2, R1
IT	AL
BAL	L_check_snake_collision91
; x_val end address is: 0 (R0)
L__check_snake_collision199:
;cp_game_ctl.h,260 :: 		} while (temp_itr <= m_node_head);
MOV	R5, R1
;cp_game_ctl.h,250 :: 		do {
L_check_snake_collision91:
;cp_game_ctl.h,254 :: 		if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {
; y_val start address is: 8 (R2)
; temp_itr start address is: 20 (R5)
; y_val start address is: 8 (R2)
; y_val end address is: 8 (R2)
; x_val start address is: 16 (R4)
LDRSH	R3, [R5, #0]
CMP	R3, R4
IT	NE
BNE	L__check_snake_collision198
; y_val end address is: 8 (R2)
; y_val start address is: 8 (R2)
ADDS	R3, R5, #2
LDRSH	R3, [R3, #0]
CMP	R3, R2
IT	NE
BNE	L__check_snake_collision197
; temp_itr end address is: 20 (R5)
; y_val end address is: 8 (R2)
; x_val end address is: 16 (R4)
L__check_snake_collision196:
;cp_game_ctl.h,256 :: 		return TRUE; // Collision found
MOVS	R0, #1
IT	AL
BAL	L_end_check_snake_collision
;cp_game_ctl.h,254 :: 		if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {
L__check_snake_collision198:
; x_val start address is: 16 (R4)
; y_val start address is: 8 (R2)
; temp_itr start address is: 20 (R5)
L__check_snake_collision197:
;cp_game_ctl.h,259 :: 		temp_itr = incr_node(temp_itr);
MOV	R0, R5
; temp_itr end address is: 20 (R5)
BL	_incr_node+0
; temp_itr start address is: 4 (R1)
MOV	R1, R0
;cp_game_ctl.h,260 :: 		} while (temp_itr <= m_node_head);
MOVW	R3, #lo_addr(_m_node_head+0)
MOVT	R3, #hi_addr(_m_node_head+0)
LDR	R3, [R3, #0]
CMP	R0, R3
IT	LS
BLS	L__check_snake_collision199
; y_val end address is: 8 (R2)
; x_val end address is: 16 (R4)
; temp_itr end address is: 4 (R1)
;cp_game_ctl.h,262 :: 		return FALSE;
MOVS	R0, #0
;cp_game_ctl.h,263 :: 		}
L_end_check_snake_collision:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _check_snake_collision
_generate_food:
;cp_game_ctl.h,267 :: 		void generate_food() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_game_ctl.h,271 :: 		int16_t col_ret = TRUE;
;cp_game_ctl.h,274 :: 		int32_t temp_time = TIM3_CNT %33;
MOVW	R0, #lo_addr(TIM3_CNT+0)
MOVT	R0, #hi_addr(TIM3_CNT+0)
LDR	R2, [R0, #0]
MOVS	R1, #33
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
STR	R0, [SP, #12]
;cp_game_ctl.h,278 :: 		do  {
L_generate_food97:
;cp_game_ctl.h,280 :: 		for (i=0; i <= temp_time; i++) {
MOVS	R1, #0
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STR	R1, [R0, #0]
L_generate_food100:
LDR	R1, [SP, #12]
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	GT
BGT	L_generate_food101
;cp_game_ctl.h,282 :: 		g_rand_num = (int32_t)  (rand() % MAX_BLOCK_COUNT);// + MAX_COL_WIDTH because row 0 is reserved for info
BL	_rand+0
MOV	R2, #300
SDIV	R1, R0, R2
MLS	R1, R2, R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,280 :: 		for (i=0; i <= temp_time; i++) {
MOVW	R1, #lo_addr(_i+0)
MOVT	R1, #hi_addr(_i+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,283 :: 		}
IT	AL
BAL	L_generate_food100
L_generate_food101:
;cp_game_ctl.h,285 :: 		scr_debug(g_rand_num, temp_time);
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
LDR	R0, [R0, #0]
LDR	R1, [SP, #12]
BL	_scr_debug+0
;cp_game_ctl.h,287 :: 		convert_lin_xy(&g_rand_num, &fd_x_val, &fd_y_val);
ADD	R1, SP, #8
ADD	R0, SP, #4
MOV	R2, R1
MOV	R1, R0
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
BL	_convert_lin_xy+0
;cp_game_ctl.h,292 :: 		col_ret = check_snake_collision(&fd_x_val, &fd_y_val, m_node_tail);
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R2, [R0, #0]
ADD	R1, SP, #8
ADD	R0, SP, #4
SXTH	R1, R1
SXTH	R0, R0
BL	_check_snake_collision+0
STRH	R0, [SP, #16]
;cp_game_ctl.h,296 :: 		if (col_ret == FALSE) {
SXTH	R0, R0
CMP	R0, #0
IT	NE
BNE	L_generate_food103
;cp_game_ctl.h,298 :: 		draw_cell_pos(&g_rand_num, m_FUCHSIA);
MOVS	R1, #6
MOVW	R0, #lo_addr(P7_final_project_main_g_rand_num+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_rand_num+0)
BL	_draw_cell_pos+0
;cp_game_ctl.h,299 :: 		set_food_in_play_flag(TRUE);
MOVS	R0, #1
BL	_set_food_in_play_flag+0
;cp_game_ctl.h,302 :: 		set_food_xy(&fd_x_val, &fd_y_val);
ADD	R1, SP, #8
ADD	R0, SP, #4
BL	_set_food_xy+0
;cp_game_ctl.h,303 :: 		}
L_generate_food103:
;cp_game_ctl.h,305 :: 		} while (col_ret == TRUE);
LDRSH	R0, [SP, #16]
CMP	R0, #1
IT	EQ
BEQ	L_generate_food97
;cp_game_ctl.h,307 :: 		}
L_end_generate_food:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _generate_food
_incr_snake_head:
;cp_game_ctl.h,312 :: 		void incr_snake_head() {
SUB	SP, SP, #4
;cp_game_ctl.h,314 :: 		if (m_node_head < m_node_end) { // array_size * sizeof(t_node)
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_head104
;cp_game_ctl.h,315 :: 		m_node_head++;
MOVW	R1, #lo_addr(_m_node_head+0)
MOVT	R1, #hi_addr(_m_node_head+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,316 :: 		} else {
IT	AL
BAL	L_incr_snake_head105
L_incr_snake_head104:
;cp_game_ctl.h,318 :: 		m_node_head = m_node_start; // Wrap around array if end is reached
MOVW	R0, #lo_addr(_m_node_start+0)
MOVT	R0, #hi_addr(_m_node_start+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,319 :: 		}
L_incr_snake_head105:
;cp_game_ctl.h,321 :: 		}
L_end_incr_snake_head:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_head
_incr_node:
;cp_game_ctl.h,325 :: 		t_node* incr_node( t_node *_node) {
; _node start address is: 0 (R0)
SUB	SP, SP, #4
; _node end address is: 0 (R0)
; _node start address is: 0 (R0)
;cp_game_ctl.h,328 :: 		if (_node <= m_node_end) {
MOVW	R1, #lo_addr(_m_node_end+0)
MOVT	R1, #hi_addr(_m_node_end+0)
LDR	R1, [R1, #0]
CMP	R0, R1
IT	HI
BHI	L_incr_node106
;cp_game_ctl.h,329 :: 		_node++;
ADDS	R0, R0, #4
;cp_game_ctl.h,330 :: 		} else {
; _node end address is: 0 (R0)
IT	AL
BAL	L_incr_node107
L_incr_node106:
;cp_game_ctl.h,332 :: 		_node = m_node_start;
MOVW	R1, #lo_addr(_m_node_start+0)
MOVT	R1, #hi_addr(_m_node_start+0)
; _node start address is: 0 (R0)
LDR	R0, [R1, #0]
; _node end address is: 0 (R0)
;cp_game_ctl.h,333 :: 		}
L_incr_node107:
;cp_game_ctl.h,335 :: 		return _node;
; _node start address is: 0 (R0)
; _node end address is: 0 (R0)
;cp_game_ctl.h,336 :: 		}
L_end_incr_node:
ADD	SP, SP, #4
BX	LR
; end of _incr_node
_incr_snake_tail:
;cp_game_ctl.h,341 :: 		void incr_snake_tail() {
SUB	SP, SP, #4
;cp_game_ctl.h,343 :: 		if (m_node_tail != m_node_head) {
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_incr_snake_tail108
;cp_game_ctl.h,346 :: 		m_node_tail->node_x = 0xFF;
MOVS	R1, #255
SXTH	R1, R1
MOVW	R2, #lo_addr(_m_node_tail+0)
MOVT	R2, #hi_addr(_m_node_tail+0)
LDR	R0, [R2, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,347 :: 		m_node_tail->node_y = 0xFF;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #255
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,350 :: 		if (m_node_tail < m_node_end) {
MOVW	R0, #lo_addr(_m_node_end+0)
MOVT	R0, #hi_addr(_m_node_end+0)
LDR	R1, [R0, #0]
MOV	R0, R2
LDR	R0, [R0, #0]
CMP	R0, R1
IT	CS
BCS	L_incr_snake_tail109
;cp_game_ctl.h,351 :: 		m_node_tail++;
MOVW	R1, #lo_addr(_m_node_tail+0)
MOVT	R1, #hi_addr(_m_node_tail+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #4
STR	R0, [R1, #0]
;cp_game_ctl.h,352 :: 		} else {
IT	AL
BAL	L_incr_snake_tail110
L_incr_snake_tail109:
;cp_game_ctl.h,354 :: 		m_node_tail = m_node_start;
MOVW	R0, #lo_addr(_m_node_start+0)
MOVT	R0, #hi_addr(_m_node_start+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,355 :: 		}
L_incr_snake_tail110:
;cp_game_ctl.h,356 :: 		}
L_incr_snake_tail108:
;cp_game_ctl.h,358 :: 		}
L_end_incr_snake_tail:
ADD	SP, SP, #4
BX	LR
; end of _incr_snake_tail
_init_arr:
;cp_game_ctl.h,362 :: 		void init_arr(uint8_t *in_arr, uint32_t a_size) {
; a_size start address is: 4 (R1)
; in_arr start address is: 0 (R0)
SUB	SP, SP, #4
MOV	R2, R1
MOV	R1, R0
; a_size end address is: 4 (R1)
; in_arr end address is: 0 (R0)
; in_arr start address is: 4 (R1)
; a_size start address is: 8 (R2)
;cp_game_ctl.h,363 :: 		uint32_t i=0;
;cp_game_ctl.h,365 :: 		for (i=0; i < a_size; i++) {
; i start address is: 0 (R0)
MOVS	R0, #0
; a_size end address is: 8 (R2)
; i end address is: 0 (R0)
MOV	R4, R0
MOV	R0, R2
L_init_arr111:
; i start address is: 16 (R4)
; a_size start address is: 0 (R0)
; in_arr start address is: 4 (R1)
; in_arr end address is: 4 (R1)
CMP	R4, R0
IT	CS
BCS	L_init_arr112
; in_arr end address is: 4 (R1)
;cp_game_ctl.h,366 :: 		in_arr[i]=0xFF;
; in_arr start address is: 4 (R1)
ADDS	R3, R1, R4
MOVS	R2, #255
STRB	R2, [R3, #0]
;cp_game_ctl.h,365 :: 		for (i=0; i < a_size; i++) {
ADDS	R4, R4, #1
;cp_game_ctl.h,367 :: 		}
; a_size end address is: 0 (R0)
; in_arr end address is: 4 (R1)
; i end address is: 16 (R4)
IT	AL
BAL	L_init_arr111
L_init_arr112:
;cp_game_ctl.h,368 :: 		}
L_end_init_arr:
ADD	SP, SP, #4
BX	LR
; end of _init_arr
_load_duck_screen:
;cp_game_ctl.h,375 :: 		void load_duck_screen() {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;cp_game_ctl.h,376 :: 		uint32_t x_axis = 0;
;cp_game_ctl.h,377 :: 		uint32_t y_axis = 0;
;cp_game_ctl.h,378 :: 		uint32_t PX_BLOCK = 16;
;cp_game_ctl.h,379 :: 		uint32_t i=0;
;cp_game_ctl.h,381 :: 		uint32_t value = 0;
;cp_game_ctl.h,385 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,389 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,393 :: 		TFT_Fill_Screen(CL_NAVY);
MOVW	R0, #16
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,395 :: 		TFT_SET_PEN(m_BLACK, 0);
MOVS	R1, #0
MOVS	R0, #0
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,396 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,400 :: 		duck_sprite();
BL	_duck_sprite+0
;cp_game_ctl.h,405 :: 		for (i=0; i< 20; i++) {
MOVS	R0, #0
STR	R0, [SP, #4]
L_load_duck_screen114:
LDR	R0, [SP, #4]
CMP	R0, #20
IT	CS
BCS	L_load_duck_screen115
;cp_game_ctl.h,411 :: 		cleaning_buffer(m_NAVY);
MOVS	R0, #3
BL	_cleaning_buffer+0
;cp_game_ctl.h,414 :: 		set_sprite_offset(i, 6);
MOVS	R1, #6
LDR	R0, [SP, #4]
BL	_set_sprite_offset+0
;cp_game_ctl.h,415 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_game_ctl.h,405 :: 		for (i=0; i< 20; i++) {
LDR	R0, [SP, #4]
ADDS	R0, R0, #1
STR	R0, [SP, #4]
;cp_game_ctl.h,416 :: 		}
IT	AL
BAL	L_load_duck_screen114
L_load_duck_screen115:
;cp_game_ctl.h,420 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_duck_screen117:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_duck_screen118
IT	AL
BAL	L_load_duck_screen117
L_load_duck_screen118:
;cp_game_ctl.h,423 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_game_ctl.h,425 :: 		}
L_end_load_duck_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _load_duck_screen
_load_snake_game:
;cp_game_ctl.h,429 :: 		void load_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,432 :: 		g_GAME_PHASE = PHASE1_READY;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,434 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,438 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,440 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,442 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,443 :: 		set_brush_color(m_BLACK);
MOVS	R0, #0
BL	_set_brush_color+0
;cp_game_ctl.h,445 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,446 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,447 :: 		TFT_Write_Text("READY?", 7 * PX_BLOCK, 6 * PX_BLOCK);
MOVW	R0, #lo_addr(?lstr1_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr1_P7_final_project_main+0)
MOVW	R2, #96
MOVW	R1, #112
BL	_TFT_Write_Text+0
;cp_game_ctl.h,448 :: 		TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 7*PX_BLOCK);
MOVW	R0, #lo_addr(?lstr2_P7_final_project_main+0)
MOVT	R0, #hi_addr(?lstr2_P7_final_project_main+0)
MOVW	R2, #112
MOVW	R1, #80
BL	_TFT_Write_Text+0
;cp_game_ctl.h,450 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_snake_game119:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_snake_game120
IT	AL
BAL	L_load_snake_game119
L_load_snake_game120:
;cp_game_ctl.h,451 :: 		}
L_end_load_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _load_snake_game
_update_stats:
;cp_game_ctl.h,455 :: 		void update_stats() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,456 :: 		sprintf(g_str_buffer, "Score: \x20 %04d", g_game_score);
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
;cp_game_ctl.h,457 :: 		TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,460 :: 		sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );       // ****Printout debugger
MOVW	R0, #lo_addr(P7_final_project_main_g_debug2+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug2+0)
LDR	R3, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_debug+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_debug+0)
LDR	R2, [R0, #0]
MOVW	R1, #lo_addr(?lstr_4_P7_final_project_main+0)
MOVT	R1, #hi_addr(?lstr_4_P7_final_project_main+0)
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;cp_game_ctl.h,461 :: 		TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #112
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,462 :: 		}
L_end_update_stats:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_stats
_update_time:
;cp_game_ctl.h,466 :: 		void update_time() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,467 :: 		g_t_secs = g_time_count % 60;
MOVW	R0, #lo_addr(P7_final_project_main_g_time_count+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_time_count+0)
LDR	R2, [R0, #0]
MOVS	R0, #60
UDIV	R1, R2, R0
MLS	R1, R0, R1, R2
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,468 :: 		if (g_t_secs != 0) {
CMP	R1, #0
IT	EQ
BEQ	L_update_time121
;cp_game_ctl.h,469 :: 		g_t_wait = FALSE;
MOVS	R1, #0
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,470 :: 		}
L_update_time121:
;cp_game_ctl.h,471 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
MOVW	R0, #lo_addr(P7_final_project_main_g_t_secs+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_secs+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time202
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
LDR	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__update_time201
L__update_time200:
;cp_game_ctl.h,472 :: 		g_t_mins++;
MOVW	R1, #lo_addr(P7_final_project_main_g_t_mins+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_t_mins+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,473 :: 		g_t_wait = TRUE;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_t_wait+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_t_wait+0)
STR	R1, [R0, #0]
;cp_game_ctl.h,471 :: 		if (g_t_secs == 0 && g_t_wait == FALSE) {
L__update_time202:
L__update_time201:
;cp_game_ctl.h,475 :: 		sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins, g_t_secs );
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
;cp_game_ctl.h,476 :: 		TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);
MOVW	R2, #0
MOVW	R1, #240
MOVW	R0, #lo_addr(_g_str_buffer+0)
MOVT	R0, #hi_addr(_g_str_buffer+0)
BL	_TFT_Write_Text+0
;cp_game_ctl.h,477 :: 		}
L_end_update_time:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _update_time
_init_snake_game:
;cp_game_ctl.h,481 :: 		void init_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,483 :: 		g_GAME_PHASE = PHASE2_PLAYING;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_GAME_PHASE+0)
STRB	R1, [R0, #0]
;cp_game_ctl.h,485 :: 		init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
MOV	R1, #300
MOVW	R0, #lo_addr(_g_DS_BUFFER+0)
MOVT	R0, #hi_addr(_g_DS_BUFFER+0)
BL	_init_arr+0
;cp_game_ctl.h,488 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,491 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,494 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,495 :: 		set_brush_color(m_GREEN);
MOVS	R0, #4
BL	_set_brush_color+0
;cp_game_ctl.h,497 :: 		TFT_SET_PEN(CL_GRAY, 0);
MOVS	R1, #0
MOVW	R0, #33808
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,498 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_game_ctl.h,500 :: 		Delay_ms(100);  // Delay to allow screen to get wiped
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_init_snake_game125:
SUBS	R7, R7, #1
BNE	L_init_snake_game125
NOP
NOP
NOP
;cp_game_ctl.h,501 :: 		init_snake_sprite();
BL	_init_snake_sprite+0
;cp_game_ctl.h,503 :: 		dump_ds_buffer();
BL	_dump_ds_buffer+0
;cp_game_ctl.h,506 :: 		}
L_end_init_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_game
_start_snake_game:
;cp_game_ctl.h,511 :: 		void start_snake_game() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,512 :: 		Delay_ms(500); // Allow timers to wind up
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_start_snake_game127:
SUBS	R7, R7, #1
BNE	L_start_snake_game127
NOP
NOP
NOP
;cp_game_ctl.h,517 :: 		while (cur_screen_run_flag == TRUE) {
L_start_snake_game129:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_start_snake_game130
;cp_game_ctl.h,521 :: 		};
IT	AL
BAL	L_start_snake_game129
L_start_snake_game130:
;cp_game_ctl.h,524 :: 		set_sprite_offset(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_set_sprite_offset+0
;cp_game_ctl.h,526 :: 		}
L_end_start_snake_game:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _start_snake_game
_init_snake_sprite:
;cp_game_ctl.h,532 :: 		void init_snake_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,533 :: 		m_node_head->node_x = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R2, #lo_addr(_m_node_head+0)
MOVT	R2, #hi_addr(_m_node_head+0)
LDR	R0, [R2, #0]
STRH	R1, [R0, #0]
;cp_game_ctl.h,534 :: 		m_node_head->node_y = 1;
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R1, R0, #2
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [R1, #0]
;cp_game_ctl.h,535 :: 		print_snake(m_node_head, m_GREEN);
MOV	R0, R2
LDR	R0, [R0, #0]
MOVS	R1, #4
BL	_print_snake+0
;cp_game_ctl.h,536 :: 		generate_food();
BL	_generate_food+0
;cp_game_ctl.h,537 :: 		}
L_end_init_snake_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _init_snake_sprite
_screen_refresh_TIM3:
;cp_game_ctl.h,542 :: 		void screen_refresh_TIM3() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,545 :: 		if ( check_snake_collision((m_node_tail)->node_x, (m_node_tail)->node_y, m_node_tail+1) == FALSE ) {
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
BNE	L_screen_refresh_TIM3131
;cp_game_ctl.h,546 :: 		clean_tail(m_node_tail, m_BLACK);
MOVW	R0, #lo_addr(_m_node_tail+0)
MOVT	R0, #hi_addr(_m_node_tail+0)
LDR	R0, [R0, #0]
MOVS	R1, #0
BL	_clean_tail+0
;cp_game_ctl.h,547 :: 		}
L_screen_refresh_TIM3131:
;cp_game_ctl.h,549 :: 		draw_cell_xy(g_fd_x_val, g_fd_y_val, m_FUCHSIA); // refresh food
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_y_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_y_val+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(P7_final_project_main_g_fd_x_val+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_fd_x_val+0)
LDR	R0, [R0, #0]
MOVS	R2, #6
BL	_draw_cell_xy+0
;cp_game_ctl.h,550 :: 		Delay_ms(5);
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_screen_refresh_TIM3132:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3132
NOP
NOP
NOP
;cp_game_ctl.h,553 :: 		move_snake();
BL	_move_snake+0
;cp_game_ctl.h,554 :: 		print_snake(m_node_head, m_GREEN);
MOVW	R0, #lo_addr(_m_node_head+0)
MOVT	R0, #hi_addr(_m_node_head+0)
LDR	R0, [R0, #0]
MOVS	R1, #4
BL	_print_snake+0
;cp_game_ctl.h,555 :: 		Delay_ms(5); // Delay needed for screen to catch up
MOVW	R7, #59999
MOVT	R7, #0
NOP
NOP
L_screen_refresh_TIM3134:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3134
NOP
NOP
NOP
;cp_game_ctl.h,558 :: 		if ( check_snake_collision(g_fd_x_val, g_fd_y_val, m_node_head) == FALSE ) {
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
BNE	L_screen_refresh_TIM3136
;cp_game_ctl.h,559 :: 		incr_snake_tail();
BL	_incr_snake_tail+0
;cp_game_ctl.h,560 :: 		} else {
IT	AL
BAL	L_screen_refresh_TIM3137
L_screen_refresh_TIM3136:
;cp_game_ctl.h,561 :: 		g_game_score++;
MOVW	R1, #lo_addr(P7_final_project_main_g_game_score+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_game_score+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;cp_game_ctl.h,562 :: 		generate_food();
BL	_generate_food+0
;cp_game_ctl.h,563 :: 		}
L_screen_refresh_TIM3137:
;cp_game_ctl.h,570 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_screen_refresh_TIM3138:
SUBS	R7, R7, #1
BNE	L_screen_refresh_TIM3138
NOP
NOP
NOP
;cp_game_ctl.h,578 :: 		}
L_end_screen_refresh_TIM3:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _screen_refresh_TIM3
_duck_sprite:
;cp_game_ctl.h,591 :: 		void duck_sprite() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_game_ctl.h,601 :: 		load_cell_xy(8,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,602 :: 		load_cell_xy(9,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,603 :: 		load_cell_xy(10,0, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #0
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,606 :: 		load_cell_xy(2,2,m_YELLOW); //face
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,607 :: 		load_cell_xy(3,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,608 :: 		load_cell_xy(7,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,609 :: 		load_cell_xy(8,2,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #2
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,614 :: 		load_cell_xy(7,1, m_BLACK); // Sunglasses
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,615 :: 		load_cell_xy(8,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,616 :: 		load_cell_xy(9,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,617 :: 		load_cell_xy(10,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,618 :: 		load_cell_xy(11,1, m_BLACK);
MOVS	R2, #0
MOVS	R1, #1
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,619 :: 		load_cell_xy(9,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,620 :: 		load_cell_xy(10,2, m_BLACK);
MOVS	R2, #0
MOVS	R1, #2
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,625 :: 		load_cell_xy(11,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,626 :: 		load_cell_xy(12,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_game_ctl.h,627 :: 		load_cell_xy(13,2, m_RED);
MOVS	R2, #2
MOVS	R1, #2
MOVS	R0, #13
BL	_load_cell_xy+0
;cp_game_ctl.h,628 :: 		load_cell_xy(11,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #11
BL	_load_cell_xy+0
;cp_game_ctl.h,629 :: 		load_cell_xy(12,3, m_RED);
MOVS	R2, #2
MOVS	R1, #3
MOVS	R0, #12
BL	_load_cell_xy+0
;cp_game_ctl.h,632 :: 		load_cell_xy(1,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,633 :: 		load_cell_xy(2,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,634 :: 		load_cell_xy(3,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,635 :: 		load_cell_xy(4,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,636 :: 		load_cell_xy(8,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,637 :: 		load_cell_xy(9,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,638 :: 		load_cell_xy(10,3, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #3
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,639 :: 		load_cell_xy(0,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #0
BL	_load_cell_xy+0
;cp_game_ctl.h,640 :: 		load_cell_xy(1,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,641 :: 		load_cell_xy(2,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,642 :: 		load_cell_xy(3,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,643 :: 		load_cell_xy(4,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,644 :: 		load_cell_xy(5,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,645 :: 		load_cell_xy(6,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,646 :: 		load_cell_xy(7,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,647 :: 		load_cell_xy(8,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,648 :: 		load_cell_xy(9,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,649 :: 		load_cell_xy(10,4, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #4
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,650 :: 		load_cell_xy(1,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #1
BL	_load_cell_xy+0
;cp_game_ctl.h,651 :: 		load_cell_xy(2,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,652 :: 		load_cell_xy(3,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,653 :: 		load_cell_xy(4,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,654 :: 		load_cell_xy(5,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,655 :: 		load_cell_xy(6,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,656 :: 		load_cell_xy(7,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,657 :: 		load_cell_xy(8,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,658 :: 		load_cell_xy(9,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,659 :: 		load_cell_xy(10,5, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #5
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,660 :: 		load_cell_xy(2,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #2
BL	_load_cell_xy+0
;cp_game_ctl.h,661 :: 		load_cell_xy(3,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,662 :: 		load_cell_xy(4,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,663 :: 		load_cell_xy(5,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,664 :: 		load_cell_xy(6,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,665 :: 		load_cell_xy(7,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,666 :: 		load_cell_xy(8,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,667 :: 		load_cell_xy(9,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,668 :: 		load_cell_xy(10,6, m_YELLOW);
MOVS	R2, #1
MOVS	R1, #6
MOVS	R0, #10
BL	_load_cell_xy+0
;cp_game_ctl.h,669 :: 		load_cell_xy(3,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #3
BL	_load_cell_xy+0
;cp_game_ctl.h,670 :: 		load_cell_xy(4,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,671 :: 		load_cell_xy(5,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,672 :: 		load_cell_xy(6,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,673 :: 		load_cell_xy(7,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,674 :: 		load_cell_xy(8,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,675 :: 		load_cell_xy(9,7,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #7
MOVS	R0, #9
BL	_load_cell_xy+0
;cp_game_ctl.h,676 :: 		load_cell_xy(4,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #4
BL	_load_cell_xy+0
;cp_game_ctl.h,677 :: 		load_cell_xy(5,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #5
BL	_load_cell_xy+0
;cp_game_ctl.h,678 :: 		load_cell_xy(6,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #6
BL	_load_cell_xy+0
;cp_game_ctl.h,679 :: 		load_cell_xy(7,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #7
BL	_load_cell_xy+0
;cp_game_ctl.h,680 :: 		load_cell_xy(8,8,m_YELLOW);
MOVS	R2, #1
MOVS	R1, #8
MOVS	R0, #8
BL	_load_cell_xy+0
;cp_game_ctl.h,681 :: 		}
L_end_duck_sprite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _duck_sprite
_EXTI15_10:
;P7_final_project_main.c,92 :: 		void EXTI15_10() iv IVT_INT_EXTI15_10  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,94 :: 		EXTI_PR |= 1 << 13;     // Rearm interrupt
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,95 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,97 :: 		while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }
L_EXTI15_10140:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_10141
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTI15_10140
L_EXTI15_10141:
;P7_final_project_main.c,99 :: 		g_cur_game_phase = get_game_mode();
BL	_get_game_mode+0
MOVW	R1, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R1, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R0, [R1, #0]
;P7_final_project_main.c,101 :: 		switch (g_cur_game_phase)
IT	AL
BAL	L_EXTI15_10142
;P7_final_project_main.c,103 :: 		case PHASE_INTRO:
L_EXTI15_10144:
;P7_final_project_main.c,104 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,105 :: 		g_cur_game_phase = PHASE1_READY; // load_snake_game
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,106 :: 		break;
IT	AL
BAL	L_EXTI15_10143
;P7_final_project_main.c,108 :: 		case PHASE1_READY:
L_EXTI15_10145:
;P7_final_project_main.c,109 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,110 :: 		g_cur_game_phase = PHASE2_PLAYING;    // Start snake game
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,111 :: 		break;
IT	AL
BAL	L_EXTI15_10143
;P7_final_project_main.c,113 :: 		case PHASE2_PLAYING:
L_EXTI15_10146:
;P7_final_project_main.c,114 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_EXTI15_10147:
SUBS	R7, R7, #1
BNE	L_EXTI15_10147
NOP
NOP
NOP
;P7_final_project_main.c,118 :: 		break;
IT	AL
BAL	L_EXTI15_10143
;P7_final_project_main.c,125 :: 		default:
L_EXTI15_10149:
;P7_final_project_main.c,126 :: 		break;
IT	AL
BAL	L_EXTI15_10143
;P7_final_project_main.c,127 :: 		}
L_EXTI15_10142:
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTI15_10144
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTI15_10145
MOVW	R0, #lo_addr(P7_final_project_main_g_cur_game_phase+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_cur_game_phase+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTI15_10146
IT	AL
BAL	L_EXTI15_10149
L_EXTI15_10143:
;P7_final_project_main.c,151 :: 		}
L_end_EXTI15_10:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10
_EXTIPA6:
;P7_final_project_main.c,154 :: 		void EXTIPA6() iv IVT_INT_EXTI9_5  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,155 :: 		if (GPIOB_IDR.B5 == 0) {
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6150
;P7_final_project_main.c,156 :: 		while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
L_EXTIPA6151:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6152
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPA6151
L_EXTIPA6152:
;P7_final_project_main.c,157 :: 		EXTI_PR |= 1 << 5;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,159 :: 		if (g_curr_snake_dir != MOVE_UP) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_EXTIPA6153
;P7_final_project_main.c,160 :: 		set_curr_snake_dir(MOVE_DOWN);
MOVS	R0, #3
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,161 :: 		}
L_EXTIPA6153:
;P7_final_project_main.c,162 :: 		}
L_EXTIPA6150:
;P7_final_project_main.c,165 :: 		if (GPIOA_IDR.B6 == 0) {
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6154
;P7_final_project_main.c,166 :: 		EXTI_PR |= 1 << 6;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,167 :: 		while (GPIOA_IDR.B6 == 0) {
L_EXTIPA6155:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPA6156
;P7_final_project_main.c,168 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,169 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_EXTIPA6157:
SUBS	R7, R7, #1
BNE	L_EXTIPA6157
NOP
NOP
NOP
;P7_final_project_main.c,170 :: 		}
IT	AL
BAL	L_EXTIPA6155
L_EXTIPA6156:
;P7_final_project_main.c,171 :: 		if (g_curr_snake_dir != MOVE_LEFT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_EXTIPA6159
;P7_final_project_main.c,172 :: 		set_curr_snake_dir(MOVE_RIGHT);
MOVS	R0, #0
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,173 :: 		}
L_EXTIPA6159:
;P7_final_project_main.c,176 :: 		}
L_EXTIPA6154:
;P7_final_project_main.c,180 :: 		}
L_end_EXTIPA6:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPA6
_EXTIPD2:
;P7_final_project_main.c,183 :: 		void EXTIPD2() iv IVT_INT_EXTI2  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,184 :: 		EXTI_PR |= 1 << 2;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,185 :: 		while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD2160:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD2161
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD2160
L_EXTIPD2161:
;P7_final_project_main.c,187 :: 		if (g_curr_snake_dir != MOVE_RIGHT) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_EXTIPD2162
;P7_final_project_main.c,188 :: 		set_curr_snake_dir(MOVE_LEFT);
MOVS	R0, #1
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,189 :: 		}
L_EXTIPD2162:
;P7_final_project_main.c,192 :: 		}
L_end_EXTIPD2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD2
_EXTIPD4:
;P7_final_project_main.c,195 :: 		void EXTIPD4() iv IVT_INT_EXTI4  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,196 :: 		EXTI_PR |= 1 << 4;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,197 :: 		while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
L_EXTIPD4163:
MOVW	R0, #lo_addr(GPIOD_IDR+0)
MOVT	R0, #hi_addr(GPIOD_IDR+0)
_LX	[R0, ByteOffset(GPIOD_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTIPD4164
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_EXTIPD4163
L_EXTIPD4164:
;P7_final_project_main.c,199 :: 		if (g_curr_snake_dir != MOVE_DOWN) {
MOVW	R0, #lo_addr(P7_final_project_main_g_curr_snake_dir+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_curr_snake_dir+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_EXTIPD4165
;P7_final_project_main.c,200 :: 		set_curr_snake_dir(MOVE_UP);
MOVS	R0, #2
BL	_set_curr_snake_dir+0
;P7_final_project_main.c,201 :: 		}
L_EXTIPD4165:
;P7_final_project_main.c,202 :: 		}
L_end_EXTIPD4:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTIPD4
_TIMER2_ISR:
;P7_final_project_main.c,205 :: 		void TIMER2_ISR() iv IVT_INT_TIM2 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,206 :: 		TIM2_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,209 :: 		update_game_time();
BL	_update_game_time+0
;P7_final_project_main.c,214 :: 		render_rect_mask(0,0,20,1, m_NAVY);
MOVS	R0, #3
PUSH	(R0)
MOVS	R3, #1
MOVS	R2, #20
MOVS	R1, #0
MOVS	R0, #0
BL	_render_rect_mask+0
ADD	SP, SP, #4
;P7_final_project_main.c,215 :: 		Delay_ms(50);
MOVW	R7, #10175
MOVT	R7, #9
NOP
NOP
L_TIMER2_ISR166:
SUBS	R7, R7, #1
BNE	L_TIMER2_ISR166
NOP
NOP
NOP
;P7_final_project_main.c,218 :: 		update_time();
BL	_update_time+0
;P7_final_project_main.c,221 :: 		update_stats();
BL	_update_stats+0
;P7_final_project_main.c,228 :: 		debug_val = ADC1_Read(3);
MOVS	R0, #3
BL	_ADC1_Read+0
MOVW	R1, #lo_addr(_debug_val+0)
MOVT	R1, #hi_addr(_debug_val+0)
STR	R0, [R1, #0]
;P7_final_project_main.c,232 :: 		}
L_end_TIMER2_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER2_ISR
_TIMER3_ISR:
;P7_final_project_main.c,235 :: 		void TIMER3_ISR() iv IVT_INT_TIM3 {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,236 :: 		TIM3_SR &= ~(1<<0);         // Bit[0] UIF interrupt reset set to 0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM3_SR+0)
MOVT	R0, #hi_addr(TIM3_SR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,238 :: 		toggle_game_clock_delay();
BL	_toggle_game_clock_delay+0
;P7_final_project_main.c,245 :: 		screen_refresh_TIM3();
BL	_screen_refresh_TIM3+0
;P7_final_project_main.c,246 :: 		}
L_end_TIMER3_ISR:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TIMER3_ISR
_init_cfg_M_CTL:
;P7_final_project_main.c,256 :: 		void init_cfg_M_CTL() {
SUB	SP, SP, #4
;P7_final_project_main.c,259 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,261 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,262 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,264 :: 		RCC_APB2ENR |= 1 << 2;                    // Enable GPIO clock for PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,265 :: 		RCC_APB2ENR |= 1 << 3;                    // Enable GPIO clock for PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,266 :: 		RCC_APB2ENR |= 1 << 4;                    // Enable GPIO clock for PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,267 :: 		RCC_APB2ENR |= 1 << 5;                    // Enable GPIO clock for PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,268 :: 		RCC_APB2ENR |= 1 << 6;                    // Enable GPIO clock for PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,269 :: 		RCC_APB2ENR |= 1 << 14;                   // Enable GPIO clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,270 :: 		RCC_APB2ENR |= 1 << 9;                   // Enable ADC1 Clock
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #512
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,273 :: 		GPIOE_CRH = 0xFF00;
MOVW	R1, #65280
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,274 :: 		GPIOA_CRL &= ~(0xF << 12);                 // PA3 - Analog input mode b0000 bit[15:12]
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MVN	R0, #61440
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,277 :: 		GPIOA_CRL |= 4 << 4;                       // Enable PA4;  Game TIMER3 control
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,278 :: 		GPIOA_CRL |= 4 << 6;                       // Enable PA6;  joystick=RIGHT
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,279 :: 		GPIOB_CRL |= 4 << 5;                       // Enable PB5;  joystick=DOWN
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,280 :: 		GPIOD_CRL |= 4 << 2;                       // Enable PD2;  joystick=LEFT
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,281 :: 		GPIOD_CRL |= 4 << 4;                       // Enable PD4;  joystick=UP
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,282 :: 		GPIOC_CRH |= 4 << 5;                       // Enable PC13; joystick=PUSH BUTTON
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,310 :: 		}
L_end_init_cfg_M_CTL:
ADD	SP, SP, #4
BX	LR
; end of _init_cfg_M_CTL
_config_USART1:
;P7_final_project_main.c,313 :: 		void config_USART1() {
SUB	SP, SP, #4
;P7_final_project_main.c,314 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,315 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,316 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,319 :: 		USART1_BRR = 0x00000506;                    // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,323 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,325 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,326 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,327 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,328 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,330 :: 		USART1_CR1 |=   1 << 3;                     // Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,331 :: 		USART1_CR1 |=   1 << 2;                     // Rx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,333 :: 		Delay_ms(100);                              // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_config_USART1168:
SUBS	R7, R7, #1
BNE	L_config_USART1168
NOP
NOP
NOP
;P7_final_project_main.c,334 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,337 :: 		}
L_end_config_USART1:
ADD	SP, SP, #4
BX	LR
; end of _config_USART1
_init_timer2:
;P7_final_project_main.c,343 :: 		void init_timer2() {
SUB	SP, SP, #4
;P7_final_project_main.c,344 :: 		RCC_APB1ENR |= 1 << 0;                      // Enable Clock for TIMER2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,345 :: 		TIM2_CR1     = 0x0000;                      // Disable the timer for config setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,346 :: 		TIM2_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,348 :: 		TIM2_ARR     = 9000;                        // Set the auto-reload register to calclated value
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,349 :: 		TIM2_DIER  |= 1 << 0;                      // Enable TIMER2 Interrupt
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,351 :: 		}
L_end_init_timer2:
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_timer3:
;P7_final_project_main.c,353 :: 		void init_timer3() {
SUB	SP, SP, #4
;P7_final_project_main.c,354 :: 		RCC_APB1ENR |= (1 << 1);                   // Enable TIMER3 Clock
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,355 :: 		TIM3_CR1    = 0x0000;                       // Disable time for setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,356 :: 		TIM3_PSC    = 7999;                         // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,358 :: 		TIM3_ARR    = g_game_speed;                         // auto-reload reg. 2 seconds so  double it = 9000*2 = 18000
MOVW	R0, #lo_addr(P7_final_project_main_g_game_speed+0)
MOVT	R0, #hi_addr(P7_final_project_main_g_game_speed+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,359 :: 		TIM3_DIER   |= 1 << 0;                      // Enable interrupt
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM3_DIER+0)
MOVT	R0, #hi_addr(TIM3_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,362 :: 		}
L_end_init_timer3:
ADD	SP, SP, #4
BX	LR
; end of _init_timer3
_init_interrupt:
;P7_final_project_main.c,365 :: 		void init_interrupt() {
SUB	SP, SP, #4
;P7_final_project_main.c,368 :: 		AFIO_EXTICR2 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,369 :: 		NVIC_ISER0   = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,373 :: 		AFIO_EXTICR1 |= 3 << 8;                     // PD2 = EXTI2[11:8]; PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,374 :: 		AFIO_EXTICR2 |= 3 << 0;                     // PD4 = EXTI4[3:0];  PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,375 :: 		AFIO_EXTICR2 |= 1 << 4;                     // PB5 = EXTI5[7:4];  PortB = b0001;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,376 :: 		AFIO_EXTICR2 &= ~(0xF << 8);                // PA6 = EXTI6[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MVN	R0, #3840
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,377 :: 		AFIO_EXTICR4 |= 2 << 4;                     // PC13  EXTI13[7:4]; PortC = b0010;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,381 :: 		EXTI_FTSR |= 1 << 2; // EXTI2 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,382 :: 		EXTI_FTSR |= 1 << 4; // EXTI4 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,383 :: 		EXTI_FTSR |= 1 << 5; // EXTI5 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,384 :: 		EXTI_FTSR |= 1 << 6; // EXTI6 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,385 :: 		EXTI_FTSR |= 1 << 13; // EXTI13 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,388 :: 		EXTI_IMR |= 0x00002074;      // Set EXTI2,4,5,6,13 to not-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R1, [R0, #0]
MOVW	R0, #8308
ORRS	R1, R0
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,393 :: 		NVIC_ISER0 |= (uint32_t) 1 << 8;            // EXTI2  NVIC Pos=8:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,394 :: 		NVIC_ISER0 |= (uint32_t) 1 << 10;           // EXTI4  NVIC Pos=10:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,395 :: 		NVIC_ISER0 |= (uint32_t) 1 << 23;           // EXTI5  NVIC Pos=23: EXTI9_5
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,396 :: 		NVIC_ISER0 |= (uint32_t) 1 << 28;           // TIMER2  NVIC Pos=28
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #268435456
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,397 :: 		NVIC_ISER0 |= (uint32_t) 1 << 29;           // TIMER3  NVIC Pos=29
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #536870912
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,399 :: 		NVIC_ISER1 |= (uint32_t) 1 << 8;            // EXTI13 NVIC Pos=40: EXTI15_10
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,400 :: 		NVIC_ISER1 |= (uint32_t) 1 << 5;            // USART1 NVIC Pos=37: ISER1[63:32]; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,411 :: 		}
L_end_init_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _init_interrupt
_main:
;P7_final_project_main.c,416 :: 		void main() {
SUB	SP, SP, #4
;P7_final_project_main.c,420 :: 		int num =0;
;P7_final_project_main.c,423 :: 		init_cfg_M_CTL();
BL	_init_cfg_M_CTL+0
;P7_final_project_main.c,426 :: 		config_USART1();
BL	_config_USART1+0
;P7_final_project_main.c,431 :: 		init_timer2();
BL	_init_timer2+0
;P7_final_project_main.c,432 :: 		init_timer3();
BL	_init_timer3+0
;P7_final_project_main.c,436 :: 		init_interrupt();
BL	_init_interrupt+0
;P7_final_project_main.c,440 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,453 :: 		load_snake_game();
BL	_load_snake_game+0
;P7_final_project_main.c,457 :: 		init_snake_game();
BL	_init_snake_game+0
;P7_final_project_main.c,459 :: 		TIM2_CR1     = 0x0001; // Start TIMER2 for game time
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,460 :: 		TIM3_CR1    = 0x0001; // Start TIMER3 now
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM3_CR1+0)
MOVT	R0, #hi_addr(TIM3_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,461 :: 		start_snake_game();
BL	_start_snake_game+0
;P7_final_project_main.c,464 :: 		TFT_SET_Brush(1, CL_RED, 0, 0, 0 ,0);
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
;P7_final_project_main.c,465 :: 		TFT_Rectangle(0, 0, 320, 240);
MOVS	R3, #240
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;P7_final_project_main.c,466 :: 		TFT_Fill_Screen(CL_RED);
MOVW	R0, #63488
BL	_TFT_Fill_Screen+0
;P7_final_project_main.c,468 :: 		Delay_ms(3000);
MOVW	R7, #20735
MOVT	R7, #549
NOP
NOP
L_main170:
SUBS	R7, R7, #1
BNE	L_main170
NOP
NOP
NOP
;P7_final_project_main.c,470 :: 		while (1) {
L_main172:
;P7_final_project_main.c,472 :: 		}
IT	AL
BAL	L_main172
;P7_final_project_main.c,473 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
