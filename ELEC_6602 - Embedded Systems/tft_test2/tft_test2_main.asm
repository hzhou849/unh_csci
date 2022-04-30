_main:
;tft_test2_main.c,22 :: 		void main() {
SUB	SP, SP, #4
;tft_test2_main.c,24 :: 		unsigned int counter = 0;
MOVW	R0, #0
STRH	R0, [SP, #0]
;tft_test2_main.c,25 :: 		Start_TP();
BL	_Start_TP+0
;tft_test2_main.c,26 :: 		RCC_APB2ENR |= 1 << 2;
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;tft_test2_main.c,27 :: 		GPIOA_CRL = 0x44444444;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;tft_test2_main.c,28 :: 		GPIOA_CRH = 0x44444444;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;tft_test2_main.c,30 :: 		TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
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
;tft_test2_main.c,31 :: 		TFT_Rectangle(0,0,320, 240);
MOVS	R3, #240
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;tft_test2_main.c,36 :: 		while (1) {
L_main0:
;tft_test2_main.c,38 :: 		TFT_Set_Brush(1, CL_AQUA, 0, 0, 0, 0);
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
;tft_test2_main.c,39 :: 		TFT_Rectangle(counter+50,0,counter+100, 50);
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
;tft_test2_main.c,42 :: 		if (GPIOA_IDR.B0 == 1) {
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_main2
;tft_test2_main.c,43 :: 		if (counter < 240-50) {
LDRH	R0, [SP, #0]
CMP	R0, #190
IT	CS
BCS	L_main3
;tft_test2_main.c,44 :: 		TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
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
;tft_test2_main.c,45 :: 		TFT_Rectangle(counter+50,0,counter+100, 50);
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
;tft_test2_main.c,46 :: 		}
L_main3:
;tft_test2_main.c,49 :: 		counter+=25;
LDRH	R0, [SP, #0]
ADDS	R0, #25
STRH	R0, [SP, #0]
;tft_test2_main.c,51 :: 		}
L_main2:
;tft_test2_main.c,52 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
;tft_test2_main.c,59 :: 		Check_TP();
BL	_Check_TP+0
;tft_test2_main.c,60 :: 		}
IT	AL
BAL	L_main0
;tft_test2_main.c,61 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
