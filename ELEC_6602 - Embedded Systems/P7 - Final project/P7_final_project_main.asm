_load_intro_screen:
;cp_screens.h,13 :: 		void load_intro_screen() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;cp_screens.h,14 :: 		cp_intro_screen(35, 115);
MOVS	R1, #115
MOVS	R0, #35
BL	_cp_intro_screen+0
;cp_screens.h,16 :: 		while (GPIOC_IDR.B13 != 0 ) {
L_load_intro_screen0:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_load_intro_screen1
;cp_screens.h,18 :: 		}
IT	AL
BAL	L_load_intro_screen0
L_load_intro_screen1:
;cp_screens.h,19 :: 		}
L_end_load_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _load_intro_screen
_cp_intro_screen:
;cp_screens.h,21 :: 		void cp_intro_screen(uint32_t x_axis, uint32_t y_axis) {
SUB	SP, SP, #56
STR	LR, [SP, #0]
STR	R0, [SP, #48]
STR	R1, [SP, #52]
;cp_screens.h,22 :: 		uint8_t intro_msg[] = "Hello Please press Joystick down \nto start";
ADD	R11, SP, #4
ADD	R10, R11, #43
MOVW	R12, #lo_addr(?ICScp_intro_screen_intro_msg_L0+0)
MOVT	R12, #hi_addr(?ICScp_intro_screen_intro_msg_L0+0)
BL	___CC2DW+0
;cp_screens.h,25 :: 		TFT_Set_Font(TFT_defaultFont, CL_GRAY, FO_HORIZONTAL );
MOVS	R2, #0
MOVW	R1, #33808
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;cp_screens.h,28 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;cp_screens.h,29 :: 		TFT_Write_Text(&intro_msg, x_axis, y_axis);
ADD	R2, SP, #4
LDR	R1, [SP, #48]
MOV	R0, R2
LDR	R2, [SP, #52]
BL	_TFT_Write_Text+0
;cp_screens.h,32 :: 		}
L_end_cp_intro_screen:
LDR	LR, [SP, #0]
ADD	SP, SP, #56
BX	LR
; end of _cp_intro_screen
_main:
;P7_final_project_main.c,51 :: 		void main() {
;P7_final_project_main.c,58 :: 		RCC_APB2ENR |=  1 << 2;                          // Enable GPIO Clock PORT A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,59 :: 		RCC_APB2ENR |=  1 << 4;                          // Enable GPIO Clock PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,64 :: 		GPIOA_CRL = GPIO_INPUT_MASK;                     // Enable PA2 PA4 PA5 PA6 for joystick control
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,65 :: 		GPIOC_CRH |= 4 << 5;                             // Enable PC13 for joystick button press PC13
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #128
MOVW	R0, #lo_addr(GPIOC_CRH+0)
MOVT	R0, #hi_addr(GPIOC_CRH+0)
STR	R1, [R0, #0]
;P7_final_project_main.c,71 :: 		Start_TP();
BL	_Start_TP+0
;P7_final_project_main.c,85 :: 		load_intro_screen();
BL	_load_intro_screen+0
;P7_final_project_main.c,87 :: 		while (GPIOC_IDR.B13 != 0 ) {}                    // Hold here for button press to start
L_main2:
MOVW	R0, #lo_addr(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
_LX	[R0, ByteOffset(GPIOC_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main3
IT	AL
BAL	L_main2
L_main3:
;P7_final_project_main.c,91 :: 		TFT_Fill_Screen(CL_RED);
MOVW	R0, #63488
BL	_TFT_Fill_Screen+0
;P7_final_project_main.c,93 :: 		while (1) {
L_main4:
;P7_final_project_main.c,94 :: 		Check_TP();
BL	_Check_TP+0
;P7_final_project_main.c,95 :: 		}
IT	AL
BAL	L_main4
;P7_final_project_main.c,96 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
