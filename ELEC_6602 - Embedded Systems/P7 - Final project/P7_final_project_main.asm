_set_cur_screen_run_flag:
;cp_intro_screen_ctl.h,46 :: 		void set_cur_screen_run_flag(uint8_t run_flag) {
; run_flag start address is: 0 (R0)
SUB	SP, SP, #4
; run_flag end address is: 0 (R0)
; run_flag start address is: 0 (R0)
;cp_intro_screen_ctl.h,47 :: 		cur_screen_run_flag = run_flag;
MOVW	R1, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R1, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
STRB	R0, [R1, #0]
; run_flag end address is: 0 (R0)
;cp_intro_screen_ctl.h,48 :: 		}
L_end_set_cur_screen_run_flag:
ADD	SP, SP, #4
BX	LR
; end of _set_cur_screen_run_flag
_load_intro_screen_simple:
;cp_intro_screen_ctl.h,53 :: 		void load_intro_screen_simple() {
SUB	SP, SP, #16
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,56 :: 		uint8_t scroll_dir = 5; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_simple_scroll_dir_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,57 :: 		uint32_t volatile x_axis = 35;
;cp_intro_screen_ctl.h,58 :: 		uint32_t volatile y_axis = 115;
;cp_intro_screen_ctl.h,60 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,61 :: 		uint32_t  prev_val2 = 0;
;cp_intro_screen_ctl.h,66 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,68 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen_simple0:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple1
;cp_intro_screen_ctl.h,71 :: 		draw_rectangle(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_rectangle+0
;cp_intro_screen_ctl.h,73 :: 		if (scroll_dir == 1 ) {
LDRB	R0, [SP, #4]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen_simple2
;cp_intro_screen_ctl.h,74 :: 		if (y_axis > (SCREEN_Y_MAX-20) || x_axis > (SCREEN_X_MAX -30) ) {
LDR	R0, [SP, #12]
CMP	R0, #220
IT	HI
BHI	L__load_intro_screen_simple65
LDR	R0, [SP, #8]
CMP	R0, #290
IT	HI
BHI	L__load_intro_screen_simple64
IT	AL
BAL	L_load_intro_screen_simple5
L__load_intro_screen_simple65:
L__load_intro_screen_simple64:
;cp_intro_screen_ctl.h,75 :: 		scroll_dir = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,76 :: 		}
L_load_intro_screen_simple5:
;cp_intro_screen_ctl.h,77 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,78 :: 		y_axis+=SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,80 :: 		}
IT	AL
BAL	L_load_intro_screen_simple6
L_load_intro_screen_simple2:
;cp_intro_screen_ctl.h,83 :: 		if (y_axis < 10 || x_axis < 2) {
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen_simple67
LDR	R0, [SP, #8]
CMP	R0, #2
IT	CC
BCC	L__load_intro_screen_simple66
IT	AL
BAL	L_load_intro_screen_simple9
L__load_intro_screen_simple67:
L__load_intro_screen_simple66:
;cp_intro_screen_ctl.h,84 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,85 :: 		}
L_load_intro_screen_simple9:
;cp_intro_screen_ctl.h,86 :: 		x_axis-=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
SUBS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,87 :: 		y_axis-=SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,88 :: 		}
L_load_intro_screen_simple6:
;cp_intro_screen_ctl.h,89 :: 		draw_intro_screen(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_intro_screen+0
;cp_intro_screen_ctl.h,91 :: 		}
IT	AL
BAL	L_load_intro_screen_simple0
L_load_intro_screen_simple1:
;cp_intro_screen_ctl.h,92 :: 		}
L_end_load_intro_screen_simple:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _load_intro_screen_simple
_load_intro_screen:
;cp_intro_screen_ctl.h,96 :: 		void load_intro_screen() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;cp_intro_screen_ctl.h,98 :: 		uint8_t rotation = 0;
ADD	R11, SP, #4
ADD	R10, R11, #16
MOVW	R12, #lo_addr(?ICSload_intro_screen_rotation_L0+0)
MOVT	R12, #hi_addr(?ICSload_intro_screen_rotation_L0+0)
BL	___CC2DW+0
;cp_intro_screen_ctl.h,99 :: 		uint8_t scroll_dir = 1; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
;cp_intro_screen_ctl.h,100 :: 		uint32_t volatile x_axis = 35;
;cp_intro_screen_ctl.h,101 :: 		uint32_t volatile y_axis = 115;
;cp_intro_screen_ctl.h,103 :: 		uint32_t  prev_val = 0;
;cp_intro_screen_ctl.h,104 :: 		uint32_t  prev_val2 = 5;
;cp_intro_screen_ctl.h,105 :: 		uint32_t counter = 1;
;cp_intro_screen_ctl.h,112 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_intro_screen_ctl.h,114 :: 		draw_info_text( 10,220);
MOVS	R1, #220
MOVS	R0, #10
BL	_draw_info_text+0
;cp_intro_screen_ctl.h,117 :: 		while (cur_screen_run_flag == TRUE ) {
L_load_intro_screen10:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen11
;cp_intro_screen_ctl.h,120 :: 		draw_rectangle(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_rectangle+0
;cp_intro_screen_ctl.h,123 :: 		if (scroll_dir == 1){
LDRB	R0, [SP, #5]
CMP	R0, #1
IT	NE
BNE	L_load_intro_screen12
;cp_intro_screen_ctl.h,124 :: 		x_axis+=X_SCROLL_SPEED;
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,125 :: 		y_axis+=SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,128 :: 		if ( x_axis > (SCREEN_X_MAX -200) || y_axis > (SCREEN_Y_MAX-42) ) {
LDR	R0, [SP, #8]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen73
LDR	R0, [SP, #12]
CMP	R0, #198
IT	HI
BHI	L__load_intro_screen72
IT	AL
BAL	L_load_intro_screen15
L__load_intro_screen73:
L__load_intro_screen72:
;cp_intro_screen_ctl.h,129 :: 		if (rotation == 0) {
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen16
;cp_intro_screen_ctl.h,130 :: 		scroll_dir = 2;
MOVS	R0, #2
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,131 :: 		}
IT	AL
BAL	L_load_intro_screen17
L_load_intro_screen16:
;cp_intro_screen_ctl.h,133 :: 		scroll_dir = 4;
MOVS	R0, #4
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,134 :: 		}
L_load_intro_screen17:
;cp_intro_screen_ctl.h,135 :: 		}
L_load_intro_screen15:
;cp_intro_screen_ctl.h,137 :: 		}
IT	AL
BAL	L_load_intro_screen18
L_load_intro_screen12:
;cp_intro_screen_ctl.h,139 :: 		else if (scroll_dir == 2) {
LDRB	R0, [SP, #5]
CMP	R0, #2
IT	NE
BNE	L_load_intro_screen19
;cp_intro_screen_ctl.h,140 :: 		x_axis += X_SCROLL_SPEED;
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,141 :: 		y_axis -= SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,144 :: 		if (x_axis > (SCREEN_X_MAX -200) || y_axis <10   ) {
LDR	R0, [SP, #8]
CMP	R0, #120
IT	HI
BHI	L__load_intro_screen75
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen74
IT	AL
BAL	L_load_intro_screen22
L__load_intro_screen75:
L__load_intro_screen74:
;cp_intro_screen_ctl.h,145 :: 		if (rotation == 0) {
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen23
;cp_intro_screen_ctl.h,146 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,147 :: 		}
IT	AL
BAL	L_load_intro_screen24
L_load_intro_screen23:
;cp_intro_screen_ctl.h,149 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,150 :: 		}
L_load_intro_screen24:
;cp_intro_screen_ctl.h,151 :: 		}
L_load_intro_screen22:
;cp_intro_screen_ctl.h,152 :: 		}
IT	AL
BAL	L_load_intro_screen25
L_load_intro_screen19:
;cp_intro_screen_ctl.h,155 :: 		else if (scroll_dir == 3) {
LDRB	R0, [SP, #5]
CMP	R0, #3
IT	NE
BNE	L_load_intro_screen26
;cp_intro_screen_ctl.h,156 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #8]
SUBS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,157 :: 		y_axis -= SCROLL_SPEED;
LDR	R0, [SP, #12]
SUBS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,160 :: 		if ( x_axis < 10 || y_axis < 10 ) {
LDR	R0, [SP, #8]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen77
LDR	R0, [SP, #12]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen76
IT	AL
BAL	L_load_intro_screen29
L__load_intro_screen77:
L__load_intro_screen76:
;cp_intro_screen_ctl.h,162 :: 		if (rotation == 0) {
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen30
;cp_intro_screen_ctl.h,163 :: 		scroll_dir = 4; //4
MOVS	R0, #4
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,164 :: 		}
IT	AL
BAL	L_load_intro_screen31
L_load_intro_screen30:
;cp_intro_screen_ctl.h,166 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,167 :: 		}
L_load_intro_screen31:
;cp_intro_screen_ctl.h,170 :: 		}
L_load_intro_screen29:
;cp_intro_screen_ctl.h,172 :: 		}
IT	AL
BAL	L_load_intro_screen32
L_load_intro_screen26:
;cp_intro_screen_ctl.h,174 :: 		else if (scroll_dir == 4) {
LDRB	R0, [SP, #5]
CMP	R0, #4
IT	NE
BNE	L_load_intro_screen33
;cp_intro_screen_ctl.h,175 :: 		x_axis -= X_SCROLL_SPEED;
LDR	R0, [SP, #8]
SUBS	R0, R0, #1
STR	R0, [SP, #8]
;cp_intro_screen_ctl.h,176 :: 		y_axis += SCROLL_SPEED;
LDR	R0, [SP, #12]
ADDS	R0, R0, #3
STR	R0, [SP, #12]
;cp_intro_screen_ctl.h,179 :: 		if ( x_axis < 10 || y_axis > (SCREEN_Y_MAX-42)) {
LDR	R0, [SP, #8]
CMP	R0, #10
IT	CC
BCC	L__load_intro_screen79
LDR	R0, [SP, #12]
CMP	R0, #198
IT	HI
BHI	L__load_intro_screen78
IT	AL
BAL	L_load_intro_screen36
L__load_intro_screen79:
L__load_intro_screen78:
;cp_intro_screen_ctl.h,181 :: 		if (rotation == 0) {
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen37
;cp_intro_screen_ctl.h,182 :: 		scroll_dir = 1;
MOVS	R0, #1
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,183 :: 		} else {
IT	AL
BAL	L_load_intro_screen38
L_load_intro_screen37:
;cp_intro_screen_ctl.h,184 :: 		scroll_dir = 3;
MOVS	R0, #3
STRB	R0, [SP, #5]
;cp_intro_screen_ctl.h,186 :: 		}
L_load_intro_screen38:
;cp_intro_screen_ctl.h,188 :: 		if (counter % 2 == 0) {
LDR	R0, [SP, #16]
AND	R0, R0, #1
CMP	R0, #0
IT	NE
BNE	L_load_intro_screen39
;cp_intro_screen_ctl.h,189 :: 		rotation = ~rotation; // change direction
LDRB	R0, [SP, #4]
MVN	R0, R0
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,190 :: 		counter = 2;
MOVS	R0, #2
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,191 :: 		}
L_load_intro_screen39:
;cp_intro_screen_ctl.h,192 :: 		}
L_load_intro_screen36:
;cp_intro_screen_ctl.h,193 :: 		}
L_load_intro_screen33:
L_load_intro_screen32:
L_load_intro_screen25:
L_load_intro_screen18:
;cp_intro_screen_ctl.h,195 :: 		counter++;
LDR	R0, [SP, #16]
ADDS	R0, R0, #1
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,196 :: 		if (counter == 5) {
CMP	R0, #5
IT	NE
BNE	L_load_intro_screen40
;cp_intro_screen_ctl.h,197 :: 		rotation = ~rotation; // change direction
LDRB	R0, [SP, #4]
MVN	R0, R0
STRB	R0, [SP, #4]
;cp_intro_screen_ctl.h,198 :: 		counter = 0;
MOVS	R0, #0
STR	R0, [SP, #16]
;cp_intro_screen_ctl.h,199 :: 		}
L_load_intro_screen40:
;cp_intro_screen_ctl.h,201 :: 		draw_intro_screen(x_axis, y_axis);
LDR	R1, [SP, #12]
LDR	R0, [SP, #8]
BL	_draw_intro_screen+0
;cp_intro_screen_ctl.h,203 :: 		}
IT	AL
BAL	L_load_intro_screen10
L_load_intro_screen11:
;cp_intro_screen_ctl.h,204 :: 		}
L_end_load_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _load_intro_screen
_draw_info_text:
;cp_intro_screen_ctl.h,208 :: 		void draw_info_text(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,209 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,210 :: 		TFT_Write_Text(&intro_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_intro_msg+0)
MOVT	R0, #hi_addr(_intro_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,211 :: 		}
L_end_draw_info_text:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_info_text
_draw_rectangle:
;cp_intro_screen_ctl.h,213 :: 		void draw_rectangle(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,215 :: 		TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
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
;cp_intro_screen_ctl.h,216 :: 		TFT_Rectangle(x_axis, y_axis, x_axis+255, y_axis+15);   // 15 is miny to hide text
ADD	R3, R8, #15
ADDW	R2, R7, #255
SXTH	R3, R3
SXTH	R2, R2
SXTH	R1, R8
; y_axis end address is: 32 (R8)
SXTH	R0, R7
; x_axis end address is: 28 (R7)
BL	_TFT_Rectangle+0
;cp_intro_screen_ctl.h,219 :: 		}
L_end_draw_rectangle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_rectangle
_draw_intro_screen:
;cp_intro_screen_ctl.h,223 :: 		void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
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
;cp_intro_screen_ctl.h,228 :: 		TFT_Set_Font(TFT_defaultFont, CL_YELLOW, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #65504
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_intro_screen_ctl.h,231 :: 		TFT_Write_Text(&pub_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_pub_msg+0)
MOVT	R0, #hi_addr(_pub_msg+0)
BL	_TFT_Write_Text+0
;cp_intro_screen_ctl.h,235 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_draw_intro_screen41:
SUBS	R7, R7, #1
BNE	L_draw_intro_screen41
NOP
NOP
NOP
;cp_intro_screen_ctl.h,237 :: 		}
L_end_draw_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_intro_screen
_load_game_screen:
;cp_game_ctl.h,9 :: 		void load_game_screen() {
SUB	SP, SP, #16
STR	LR, [SP, #0]
;cp_game_ctl.h,10 :: 		uint32_t x_axis = 0;
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICSload_game_screen_x_axis_L0+0)
MOVT	R12, #hi_addr(?ICSload_game_screen_x_axis_L0+0)
BL	___CC2DW+0
;cp_game_ctl.h,11 :: 		uint32_t y_axis = 0;
;cp_game_ctl.h,12 :: 		uint32_t pixel_s = 16;
;cp_game_ctl.h,14 :: 		set_cur_screen_run_flag(TRUE);
MOVS	R0, #1
BL	_set_cur_screen_run_flag+0
;cp_game_ctl.h,16 :: 		TFT_Fill_Screen(CL_NAVY);
MOVW	R0, #16
BL	_TFT_Fill_Screen+0
;cp_game_ctl.h,17 :: 		TFT_SET_PEN(CL_BLACK, 2);
MOVS	R1, #2
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;cp_game_ctl.h,18 :: 		TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
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
;cp_game_ctl.h,19 :: 		TFT_Rectangle(x_axis,y_axis, pixel_s,pixel_s);
LDR	R3, [SP, #12]
LDR	R2, [SP, #12]
LDR	R1, [SP, #8]
LDR	R0, [SP, #4]
BL	_TFT_Rectangle+0
;cp_game_ctl.h,20 :: 		TFT_Rectangle(pixel_s*1 , pixel_s*0 , pixel_s*2,pixel_s*1);
LDR	R0, [SP, #12]
LSLS	R0, R0, #1
LDR	R3, [SP, #12]
SXTH	R2, R0
MOVW	R1, #0
SXTH	R1, R1
LDR	R0, [SP, #12]
BL	_TFT_Rectangle+0
;cp_game_ctl.h,22 :: 		while (cur_screen_run_flag == TRUE) {};
L_load_game_screen43:
MOVW	R0, #lo_addr(P7_final_project_main_cur_screen_run_flag+0)
MOVT	R0, #hi_addr(P7_final_project_main_cur_screen_run_flag+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_load_game_screen44
IT	AL
BAL	L_load_game_screen43
L_load_game_screen44:
;cp_game_ctl.h,25 :: 		}
L_end_load_game_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _load_game_screen
_EXTI15_10:
;P7_final_project_main.c,83 :: 		void EXTI15_10() iv IVT_INT_EXTI15_10  {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_main.c,86 :: 		if (GAME_PHASE == PHASE_INTRO) {
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_1045
;P7_final_project_main.c,87 :: 		while (GPIOC_IDR.B13 == 0) {}
L_EXTI15_1046:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L_EXTI15_1047
IT	AL
BAL	L_EXTI15_1046
L_EXTI15_1047:
;P7_final_project_main.c,89 :: 		EXTI_PR |= 1 << 15;
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32768
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,92 :: 		GPIOB_ODR = ~GPIOB_ODR;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,94 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,95 :: 		GAME_PHASE = PHASE_GAME1;
MOVS	R1, #1
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,96 :: 		}
IT	AL
BAL	L_EXTI15_1048
L_EXTI15_1045:
;P7_final_project_main.c,97 :: 		else if (GAME_PHASE == PHASE_GAME1) {
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_EXTI15_1049
;P7_final_project_main.c,98 :: 		set_cur_screen_run_flag(FALSE);
MOVS	R0, #0
BL	_set_cur_screen_run_flag+0
;P7_final_project_main.c,99 :: 		GAME_PHASE = PHASE_GAME2;
MOVS	R1, #2
MOVW	R0, #lo_addr(P7_final_project_main_GAME_PHASE+0)
MOVT	R0, #hi_addr(P7_final_project_main_GAME_PHASE+0)
STRB	R1, [R0, #0]
;P7_final_project_main.c,101 :: 		}
L_EXTI15_1049:
L_EXTI15_1048:
;P7_final_project_main.c,102 :: 		}
L_end_EXTI15_10:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _EXTI15_10
_init_cfg_M_CTL:
;P7_final_project_main.c,111 :: 		void init_cfg_M_CTL() {
SUB	SP, SP, #4
;P7_final_project_main.c,114 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,116 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,117 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,119 :: 		RCC_APB2ENR |= 1 << 2;                    // Enable GPIO clock for PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,120 :: 		RCC_APB2ENR |= 1 << 3;                    // Enable GPIO clock for PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,121 :: 		RCC_APB2ENR |= 1 << 4;                    // Enable GPIO clock for PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,122 :: 		RCC_APB2ENR |= 1 << 5;                    // Enable GPIO clock for PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,123 :: 		RCC_APB2ENR |= 1 << 6;                    // Enable GPIO clock for PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,124 :: 		RCC_APB2ENR |= 1 << 14;                   // Enable GPIO clock for USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,127 :: 		GPIOA_CRL = GPIO_INPUT_MASK;                     // Enable PA2 PA4 PA5 PA6 for joystick control
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,128 :: 		GPIOE_CRH = 0xFF00;
MOVW	R1, #65280
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,131 :: 		GPIOA_CRL |= 4 << 6;                       // Enable PA6;  joystick=RIGHT
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,132 :: 		GPIOB_CRL |= 4 << 5;                       // Enable PB5;  joystick=DOWN
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,133 :: 		GPIOD_CRL |= 4 << 2;                       // Enable PD2;  joystick=LEFT
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,134 :: 		GPIOD_CRL |= 4 << 4;                       // Enable PD4;  joystick=UP
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,135 :: 		GPIOC_CRH |= 4 << 5;                       // Enable PC13; joystick=PUSH BUTTON
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,136 :: 		}
L_end_init_cfg_M_CTL:
ADD	SP, SP, #4
BX	LR
; end of _init_cfg_M_CTL
_config_USART1:
;P7_final_project_main.c,139 :: 		void config_USART1() {
SUB	SP, SP, #4
;P7_final_project_main.c,140 :: 		GPIOA_CRH &= ~(0xFF << 4);                  // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,141 :: 		GPIOA_CRH |=  (0x0B << 4);                  // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,142 :: 		GPIOA_CRH |=  (0x04 << 8);                  // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,145 :: 		USART1_BRR = 0x00000506;                    // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,149 :: 		USART1_CR1 &= ~(1 << 13);                   // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,151 :: 		USART1_CR1 &= ~(1 << 12);                   // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,152 :: 		USART1_CR1 &= ~(3 << 9);                    // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,153 :: 		USART1_CR2 &= ~(3 << 12);                   // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,154 :: 		USART1_CR3 &= ~(3 << 8);                    // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,156 :: 		USART1_CR1 |=   1 << 3;                     // Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,157 :: 		USART1_CR1 |=   1 << 2;                     // Rx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,159 :: 		Delay_ms(100);                              // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_config_USART150:
SUBS	R7, R7, #1
BNE	L_config_USART150
NOP
NOP
NOP
;P7_final_project_main.c,160 :: 		USART1_CR1 |= 1 << 13;                      // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,161 :: 		}
L_end_config_USART1:
ADD	SP, SP, #4
BX	LR
; end of _config_USART1
_init_timer2:
;P7_final_project_main.c,166 :: 		void init_timer2() {
SUB	SP, SP, #4
;P7_final_project_main.c,167 :: 		RCC_APB1ENR |= 1 << 0;                      // Enable Clock for TIMER2
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,168 :: 		TIM2_CR1     = 0x0000;                      // Disable the timer for config setup
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,169 :: 		TIM2_PSC     = 7999;                        // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1) from datasheet
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,171 :: 		TIM2_ARR     = 9000;                        // Set the auto-reload register to calclated value
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,172 :: 		TIM2_DIER  |= 1 << 0;                      // Enable TIMER2 Interrupt
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,173 :: 		TIM2_CR1     = 0x0001;                      // After timer setup, enable TIMER2 bit[1]; bit[4]=0 counting up.
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,174 :: 		}
L_end_init_timer2:
ADD	SP, SP, #4
BX	LR
; end of _init_timer2
_init_interrupt:
;P7_final_project_main.c,178 :: 		void init_interrupt() {
SUB	SP, SP, #4
;P7_final_project_main.c,181 :: 		AFIO_EXTICR2 = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,182 :: 		NVIC_ISER0   = 0x00000000;
MOVS	R1, #0
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,185 :: 		AFIO_EXTICR1 |= 3 << 8;                     // PD2 = EXTI2[11:8]; PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #768
MOVW	R0, #lo_addr(AFIO_EXTICR1+0)
MOVT	R0, #hi_addr(AFIO_EXTICR1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,186 :: 		AFIO_EXTICR2 |= 3 << 0;                     // PD4 = EXTI4[3:0];  PortD = b0011;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #3
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,187 :: 		AFIO_EXTICR2 |= 1 << 4;                     // PB5 = EXTI5[7:4];  PortB = b0001;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,188 :: 		AFIO_EXTICR2 &= ~(0xF << 0);                // PA6 = EXTI6[3:0];  PortA = b0000;
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MVN	R0, #15
ANDS	R1, R0
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,189 :: 		AFIO_EXTICR4 |= 2 << 4;                     // PC13  EXTI13[7:4]; PortC = b0010;
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(AFIO_EXTICR4+0)
MOVT	R0, #hi_addr(AFIO_EXTICR4+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,193 :: 		EXTI_FTSR |= 1 << 13; // EXTI13 is FALLING EDGE
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(EXTI_FTSR+0)
MOVT	R0, #hi_addr(EXTI_FTSR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,195 :: 		EXTI_IMR |= 0x00002074;      // Set EXTI2,4,5,6,13 to not-maskable
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R1, [R0, #0]
MOVW	R0, #8308
ORRS	R1, R0
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,200 :: 		NVIC_ISER0 |= (uint32_t) 1 << 8;            // EXTI2  NVIC Pos=8:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,201 :: 		NVIC_ISER0 |= (uint32_t) 1 << 10;           // EXTI4  NVIC Pos=10:
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,202 :: 		NVIC_ISER0 |= (uint32_t) 1 << 23;           // EXTI5  NVIC Pos=23: EXTI9_5
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,203 :: 		NVIC_ISER1 |= (uint32_t) 1 << 8;            // EXTI13 NVIC Pos=40: EXTI15_10
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,204 :: 		NVIC_ISER1 |= (uint32_t) 1 << 5;            // USART1 NVIC Pos=37: ISER1[63:32]; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,206 :: 		}
L_end_init_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _init_interrupt
_debug:
;P7_final_project_main.c,208 :: 		void debug(uint32_t value) {
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 0 (R0)
; value start address is: 0 (R0)
;P7_final_project_main.c,209 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_debug52:
SUBS	R7, R7, #1
BNE	L_debug52
NOP
NOP
NOP
;P7_final_project_main.c,210 :: 		USART1_DR = 0xD;
MOVS	R2, #13
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;P7_final_project_main.c,211 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_debug54:
SUBS	R7, R7, #1
BNE	L_debug54
NOP
NOP
NOP
;P7_final_project_main.c,212 :: 		USART1_DR=0xA;
MOVS	R2, #10
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R2, [R1, #0]
;P7_final_project_main.c,213 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_debug56:
SUBS	R7, R7, #1
BNE	L_debug56
NOP
NOP
NOP
;P7_final_project_main.c,214 :: 		USART1_DR = value;
MOVW	R1, #lo_addr(USART1_DR+0)
MOVT	R1, #hi_addr(USART1_DR+0)
STR	R0, [R1, #0]
; value end address is: 0 (R0)
;P7_final_project_main.c,215 :: 		}
L_end_debug:
ADD	SP, SP, #4
BX	LR
; end of _debug
_rand_num_gen:
;P7_final_project_main.c,217 :: 		uint32_t rand_num_gen() {
SUB	SP, SP, #4
;P7_final_project_main.c,218 :: 		uint32_t ret = 0;
;P7_final_project_main.c,219 :: 		ret = TIM2_CNT % 100;
MOVW	R0, #lo_addr(TIM2_CNT+0)
MOVT	R0, #hi_addr(TIM2_CNT+0)
LDR	R2, [R0, #0]
MOVS	R1, #100
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
;P7_final_project_main.c,220 :: 		return ret ;
;P7_final_project_main.c,221 :: 		}
L_end_rand_num_gen:
ADD	SP, SP, #4
BX	LR
; end of _rand_num_gen
_main:
;P7_final_project_main.c,225 :: 		void main() {
SUB	SP, SP, #4
;P7_final_project_main.c,229 :: 		int num =0;
;P7_final_project_main.c,232 :: 		init_cfg_M_CTL();
BL	_init_cfg_M_CTL+0
;P7_final_project_main.c,235 :: 		config_USART1();
BL	_config_USART1+0
;P7_final_project_main.c,240 :: 		init_timer2();
BL	_init_timer2+0
;P7_final_project_main.c,244 :: 		init_interrupt();
BL	_init_interrupt+0
;P7_final_project_main.c,248 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,255 :: 		load_intro_screen();
BL	_load_intro_screen+0
;P7_final_project_main.c,256 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,257 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,258 :: 		debug( rand_num_gen() );
BL	_rand_num_gen+0
BL	_debug+0
;P7_final_project_main.c,261 :: 		load_game_screen();
BL	_load_game_screen+0
;P7_final_project_main.c,264 :: 		TFT_SET_Brush(1, CL_RED, 0, 0, 0 ,0);
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
;P7_final_project_main.c,265 :: 		TFT_Rectangle(0, 0, 320, 240);
MOVS	R3, #240
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;P7_final_project_main.c,266 :: 		TFT_Fill_Screen(CL_RED);
MOVW	R0, #63488
BL	_TFT_Fill_Screen+0
;P7_final_project_main.c,268 :: 		Delay_ms(3000);
MOVW	R7, #20735
MOVT	R7, #549
NOP
NOP
L_main58:
SUBS	R7, R7, #1
BNE	L_main58
NOP
NOP
NOP
;P7_final_project_main.c,270 :: 		while (1) {
L_main60:
;P7_final_project_main.c,272 :: 		}
IT	AL
BAL	L_main60
;P7_final_project_main.c,273 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
