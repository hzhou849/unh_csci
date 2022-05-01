_draw_intro_screen:
;tft_test2_main.c,26 :: 		void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
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
;tft_test2_main.c,30 :: 		TFT_Set_Font(TFT_defaultFont, CL_GRAY, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #33808
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;tft_test2_main.c,33 :: 		TFT_Write_Text(&intro_msg, x_axis, y_axis);
UXTH	R2, R6
; y_axis end address is: 24 (R6)
UXTH	R1, R5
; x_axis end address is: 20 (R5)
MOVW	R0, #lo_addr(_intro_msg+0)
MOVT	R0, #hi_addr(_intro_msg+0)
BL	_TFT_Write_Text+0
;tft_test2_main.c,35 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;tft_test2_main.c,37 :: 		}
L_end_draw_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _draw_intro_screen
_load_intro_screen:
;tft_test2_main.c,41 :: 		void load_intro_screen() {
SUB	SP, SP, #20
STR	LR, [SP, #0]
;tft_test2_main.c,43 :: 		uint8_t scroll_dir = 1;
; scroll_dir start address is: 12 (R3)
MOVS	R3, #1
;tft_test2_main.c,44 :: 		uint8_t intro_screen_run_flag = 1;
; intro_screen_run_flag start address is: 4 (R1)
MOVS	R1, #1
;tft_test2_main.c,45 :: 		uint32_t x_axis = 35;
; x_axis start address is: 16 (R4)
MOV	R4, #35
;tft_test2_main.c,46 :: 		uint32_t y_axis = 115;
; y_axis start address is: 8 (R2)
MOV	R2, #115
; intro_screen_run_flag end address is: 4 (R1)
; x_axis end address is: 16 (R4)
; y_axis end address is: 8 (R2)
; scroll_dir end address is: 12 (R3)
;tft_test2_main.c,48 :: 		while (intro_screen_run_flag == TRUE ) {
L_load_intro_screen0:
; y_axis start address is: 8 (R2)
; x_axis start address is: 16 (R4)
; intro_screen_run_flag start address is: 4 (R1)
; scroll_dir start address is: 12 (R3)
CMP	R1, #1
IT	NE
BNE	L_load_intro_screen1
;tft_test2_main.c,51 :: 		if (scroll_dir == 1 ) {
CMP	R3, #1
IT	NE
BNE	L_load_intro_screen2
;tft_test2_main.c,52 :: 		if (y_axis > (SCREEN_Y_MAX-5) || x_axis > (SCREEN_X_MAX -30) ) {
CMP	R2, #235
IT	HI
BHI	L__load_intro_screen19
CMP	R4, #290
IT	HI
BHI	L__load_intro_screen18
; scroll_dir end address is: 12 (R3)
IT	AL
BAL	L_load_intro_screen5
L__load_intro_screen19:
L__load_intro_screen18:
;tft_test2_main.c,53 :: 		scroll_dir = 0;
; scroll_dir start address is: 12 (R3)
MOVS	R3, #0
; scroll_dir end address is: 12 (R3)
;tft_test2_main.c,54 :: 		}
L_load_intro_screen5:
;tft_test2_main.c,56 :: 		x_axis+=5;
; scroll_dir start address is: 12 (R3)
ADDS	R4, R4, #5
;tft_test2_main.c,57 :: 		y_axis+=5;
ADDS	R0, R2, #5
; y_axis end address is: 8 (R2)
; y_axis start address is: 0 (R0)
;tft_test2_main.c,59 :: 		}
; y_axis end address is: 0 (R0)
MOV	R2, R0
MOV	R0, R4
IT	AL
BAL	L_load_intro_screen6
L_load_intro_screen2:
;tft_test2_main.c,62 :: 		if (y_axis < 10 || x_axis < 10) {
; y_axis start address is: 8 (R2)
CMP	R2, #10
IT	CC
BCC	L__load_intro_screen21
CMP	R4, #10
IT	CC
BCC	L__load_intro_screen20
; scroll_dir end address is: 12 (R3)
IT	AL
BAL	L_load_intro_screen9
L__load_intro_screen21:
L__load_intro_screen20:
;tft_test2_main.c,63 :: 		scroll_dir = 1;
; scroll_dir start address is: 12 (R3)
MOVS	R3, #1
; scroll_dir end address is: 12 (R3)
;tft_test2_main.c,64 :: 		}
L_load_intro_screen9:
;tft_test2_main.c,66 :: 		x_axis-=5;
; scroll_dir start address is: 12 (R3)
SUBS	R4, R4, #5
;tft_test2_main.c,67 :: 		y_axis-=5;
SUBS	R2, R2, #5
; x_axis end address is: 16 (R4)
; y_axis end address is: 8 (R2)
; scroll_dir end address is: 12 (R3)
MOV	R0, R4
;tft_test2_main.c,68 :: 		}
L_load_intro_screen6:
;tft_test2_main.c,70 :: 		draw_intro_screen(x_axis, y_axis);
; y_axis start address is: 8 (R2)
; x_axis start address is: 0 (R0)
; scroll_dir start address is: 12 (R3)
STRB	R3, [SP, #4]
STR	R0, [SP, #8]
STR	R2, [SP, #12]
STRB	R1, [SP, #16]
MOV	R1, R2
BL	_draw_intro_screen+0
LDRB	R1, [SP, #16]
LDR	R2, [SP, #12]
LDR	R0, [SP, #8]
LDRB	R3, [SP, #4]
;tft_test2_main.c,73 :: 		}
; intro_screen_run_flag end address is: 4 (R1)
; y_axis end address is: 8 (R2)
; x_axis end address is: 0 (R0)
; scroll_dir end address is: 12 (R3)
MOV	R4, R0
IT	AL
BAL	L_load_intro_screen0
L_load_intro_screen1:
;tft_test2_main.c,74 :: 		}
L_end_load_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _load_intro_screen
_main:
;tft_test2_main.c,80 :: 		void main() {
SUB	SP, SP, #4
;tft_test2_main.c,82 :: 		unsigned int counter = 0;
MOVW	R0, #0
STRH	R0, [SP, #0]
;tft_test2_main.c,83 :: 		Start_TP();
BL	_Start_TP+0
;tft_test2_main.c,84 :: 		RCC_APB2ENR |= 1 << 2;
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;tft_test2_main.c,85 :: 		GPIOA_CRL = 0x44444444;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;tft_test2_main.c,86 :: 		GPIOA_CRH = 0x44444444;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;tft_test2_main.c,88 :: 		TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
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
;tft_test2_main.c,89 :: 		TFT_Rectangle(0,0,320, 240);
MOVS	R3, #240
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;tft_test2_main.c,91 :: 		load_intro_screen();
BL	_load_intro_screen+0
;tft_test2_main.c,95 :: 		while (1) {
L_main10:
;tft_test2_main.c,97 :: 		TFT_Set_Brush(1, CL_AQUA, 0, 0, 0, 0);
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
;tft_test2_main.c,98 :: 		TFT_Rectangle(counter+50,0,counter+100, 50);
LDRH	R0, [SP, #0]
ADDW	R1, R0, #100
LDRH	R0, [SP, #0]
ADDS	R0, #50
MOVS	R3, #50
SXTH	R3, R3
SXTH	R2, R1
MOVS	R1, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_TFT_Rectangle+0
;tft_test2_main.c,101 :: 		if (GPIOA_IDR.B0 == 1) {
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main12
;tft_test2_main.c,102 :: 		if (counter < 240-50) {
LDRH	R0, [SP, #0]
CMP	R0, #190
IT	CS
BCS	L_main13
;tft_test2_main.c,103 :: 		TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
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
;tft_test2_main.c,104 :: 		TFT_Rectangle(counter+50,0,counter+100, 50);
LDRH	R0, [SP, #0]
ADDW	R1, R0, #100
LDRH	R0, [SP, #0]
ADDS	R0, #50
MOVS	R3, #50
SXTH	R3, R3
SXTH	R2, R1
MOVS	R1, #0
SXTH	R1, R1
SXTH	R0, R0
BL	_TFT_Rectangle+0
;tft_test2_main.c,105 :: 		}
L_main13:
;tft_test2_main.c,108 :: 		counter+=25;
LDRH	R0, [SP, #0]
ADDS	R0, #25
STRH	R0, [SP, #0]
;tft_test2_main.c,110 :: 		}
L_main12:
;tft_test2_main.c,111 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main14:
SUBS	R7, R7, #1
BNE	L_main14
NOP
NOP
NOP
;tft_test2_main.c,118 :: 		Check_TP();
BL	_Check_TP+0
;tft_test2_main.c,119 :: 		}
IT	AL
BAL	L_main10
;tft_test2_main.c,120 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
