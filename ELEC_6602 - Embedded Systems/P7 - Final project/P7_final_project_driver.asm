_Init_ADC:
;P7_final_project_driver.c,37 :: 		void Init_ADC() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_driver.c,38 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
MOVW	R0, #768
BL	_ADC_Set_Input_Channel+0
;P7_final_project_driver.c,39 :: 		ADC1_Init();
BL	_ADC1_Init+0
;P7_final_project_driver.c,40 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_Init_ADC0:
SUBS	R7, R7, #1
BNE	L_Init_ADC0
NOP
NOP
NOP
;P7_final_project_driver.c,41 :: 		}
L_end_Init_ADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_ADC
P7_final_project_driver_InitializeTouchPanel:
;P7_final_project_driver.c,42 :: 		static void InitializeTouchPanel() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_driver.c,43 :: 		Init_ADC();
BL	_Init_ADC+0
;P7_final_project_driver.c,44 :: 		TFT_Init_ILI9341_8bit(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;P7_final_project_driver.c,46 :: 		TP_TFT_Init(320, 240, 8, 9);                                  // Initialize touch panel
MOVS	R3, #9
MOVS	R2, #8
MOVS	R1, #240
MOVW	R0, #320
BL	_TP_TFT_Init+0
;P7_final_project_driver.c,47 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
MOVW	R0, #1500
SXTH	R0, R0
BL	_TP_TFT_Set_ADC_Threshold+0
;P7_final_project_driver.c,49 :: 		PenDown = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;P7_final_project_driver.c,50 :: 		PressedObject = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PressedObject+0)
MOVT	R0, #hi_addr(_PressedObject+0)
STR	R1, [R0, #0]
;P7_final_project_driver.c,51 :: 		PressedObjectType = -1;
MOVW	R1, #65535
SXTH	R1, R1
MOVW	R0, #lo_addr(_PressedObjectType+0)
MOVT	R0, #hi_addr(_PressedObjectType+0)
STRH	R1, [R0, #0]
;P7_final_project_driver.c,52 :: 		}
L_end_InitializeTouchPanel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of P7_final_project_driver_InitializeTouchPanel
_Calibrate:
;P7_final_project_driver.c,54 :: 		void Calibrate() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_driver.c,55 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;P7_final_project_driver.c,56 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;P7_final_project_driver.c,57 :: 		TFT_Write_Text("Touch selected corners for calibration", 50, 80);
MOVW	R0, #lo_addr(?lstr1_P7_final_project_driver+0)
MOVT	R0, #hi_addr(?lstr1_P7_final_project_driver+0)
MOVS	R2, #80
MOVS	R1, #50
BL	_TFT_Write_Text+0
;P7_final_project_driver.c,58 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,59 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,60 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,61 :: 		TFT_Write_Text("first here", 210, 220);
MOVW	R0, #lo_addr(?lstr2_P7_final_project_driver+0)
MOVT	R0, #hi_addr(?lstr2_P7_final_project_driver+0)
MOVS	R2, #220
MOVS	R1, #210
BL	_TFT_Write_Text+0
;P7_final_project_driver.c,63 :: 		TP_TFT_Calibrate_Min();                      // Calibration of TP minimum
BL	_TP_TFT_Calibrate_Min+0
;P7_final_project_driver.c,64 :: 		Delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_Calibrate2:
SUBS	R7, R7, #1
BNE	L_Calibrate2
NOP
NOP
NOP
;P7_final_project_driver.c,66 :: 		TFT_Set_Pen(CL_BLACK, 3);
MOVS	R1, #3
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;P7_final_project_driver.c,67 :: 		TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;P7_final_project_driver.c,68 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,69 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,70 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,71 :: 		TFT_Write_Text("first here", 210, 220);
MOVW	R0, #lo_addr(?lstr3_P7_final_project_driver+0)
MOVT	R0, #hi_addr(?lstr3_P7_final_project_driver+0)
MOVS	R2, #220
MOVS	R1, #210
BL	_TFT_Write_Text+0
;P7_final_project_driver.c,73 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;P7_final_project_driver.c,74 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;P7_final_project_driver.c,75 :: 		TFT_Write_Text("now here ", 20, 5);
MOVW	R0, #lo_addr(?lstr4_P7_final_project_driver+0)
MOVT	R0, #hi_addr(?lstr4_P7_final_project_driver+0)
MOVS	R2, #5
MOVS	R1, #20
BL	_TFT_Write_Text+0
;P7_final_project_driver.c,76 :: 		TFT_Line(0, 0, 5, 0);
MOVS	R3, #0
SXTH	R3, R3
MOVS	R2, #5
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,77 :: 		TFT_Line(0, 0, 0, 5);
MOVS	R3, #5
SXTH	R3, R3
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,78 :: 		TFT_Line(0, 0, 10, 10);
MOVS	R3, #10
SXTH	R3, R3
MOVS	R2, #10
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;P7_final_project_driver.c,80 :: 		TP_TFT_Calibrate_Max();                       // Calibration of TP maximum
BL	_TP_TFT_Calibrate_Max+0
;P7_final_project_driver.c,81 :: 		Delay_ms(500);
MOVW	R7, #36223
MOVT	R7, #91
NOP
NOP
L_Calibrate4:
SUBS	R7, R7, #1
BNE	L_Calibrate4
NOP
NOP
NOP
;P7_final_project_driver.c,82 :: 		}
L_end_Calibrate:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Calibrate
P7_final_project_driver_InitializeObjects:
;P7_final_project_driver.c,92 :: 		static void InitializeObjects() {
SUB	SP, SP, #4
;P7_final_project_driver.c,93 :: 		Screen1.Color                     = 0x5AEB;
MOVW	R1, #23275
MOVW	R0, #lo_addr(_Screen1+0)
MOVT	R0, #hi_addr(_Screen1+0)
STRH	R1, [R0, #0]
;P7_final_project_driver.c,94 :: 		Screen1.Width                     = 320;
MOVW	R1, #320
MOVW	R0, #lo_addr(_Screen1+2)
MOVT	R0, #hi_addr(_Screen1+2)
STRH	R1, [R0, #0]
;P7_final_project_driver.c,95 :: 		Screen1.Height                    = 240;
MOVS	R1, #240
MOVW	R0, #lo_addr(_Screen1+4)
MOVT	R0, #hi_addr(_Screen1+4)
STRH	R1, [R0, #0]
;P7_final_project_driver.c,96 :: 		Screen1.ObjectsCount              = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Screen1+6)
MOVT	R0, #hi_addr(_Screen1+6)
STRH	R1, [R0, #0]
;P7_final_project_driver.c,98 :: 		}
L_end_InitializeObjects:
ADD	SP, SP, #4
BX	LR
; end of P7_final_project_driver_InitializeObjects
P7_final_project_driver_IsInsideObject:
;P7_final_project_driver.c,100 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
; Top start address is: 12 (R3)
; Left start address is: 8 (R2)
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #4
; Top end address is: 12 (R3)
; Left end address is: 8 (R2)
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
; Left start address is: 8 (R2)
; Top start address is: 12 (R3)
; Width start address is: 20 (R5)
LDRH	R5, [SP, #4]
; Height start address is: 24 (R6)
LDRH	R6, [SP, #8]
;P7_final_project_driver.c,101 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
CMP	R2, R0
IT	HI
BHI	L_P7_final_project_driver_IsInsideObject30
ADDS	R4, R2, R5
UXTH	R4, R4
; Left end address is: 8 (R2)
; Width end address is: 20 (R5)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R0
IT	CC
BCC	L_P7_final_project_driver_IsInsideObject29
; X end address is: 0 (R0)
;P7_final_project_driver.c,102 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
CMP	R3, R1
IT	HI
BHI	L_P7_final_project_driver_IsInsideObject28
ADDS	R4, R3, R6
UXTH	R4, R4
; Top end address is: 12 (R3)
; Height end address is: 24 (R6)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R1
IT	CC
BCC	L_P7_final_project_driver_IsInsideObject27
; Y end address is: 4 (R1)
L_P7_final_project_driver_IsInsideObject26:
;P7_final_project_driver.c,103 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_IsInsideObject
;P7_final_project_driver.c,101 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
L_P7_final_project_driver_IsInsideObject30:
L_P7_final_project_driver_IsInsideObject29:
;P7_final_project_driver.c,102 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
L_P7_final_project_driver_IsInsideObject28:
L_P7_final_project_driver_IsInsideObject27:
;P7_final_project_driver.c,105 :: 		return 0;
MOVS	R0, #0
;P7_final_project_driver.c,106 :: 		}
L_end_IsInsideObject:
ADD	SP, SP, #4
BX	LR
; end of P7_final_project_driver_IsInsideObject
_DrawScreen:
;P7_final_project_driver.c,111 :: 		void DrawScreen(TScreen *aScreen) {
; aScreen start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; aScreen end address is: 0 (R0)
; aScreen start address is: 0 (R0)
;P7_final_project_driver.c,115 :: 		object_pressed = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
STRB	R2, [R1, #0]
;P7_final_project_driver.c,116 :: 		order = 0;
MOVS	R1, #0
STRH	R1, [SP, #4]
;P7_final_project_driver.c,117 :: 		CurrentScreen = aScreen;
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
STR	R0, [R1, #0]
;P7_final_project_driver.c,119 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
ADDS	R1, R0, #2
; aScreen end address is: 0 (R0)
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
LDRH	R1, [R1, #0]
CMP	R1, R2
IT	NE
BNE	L__DrawScreen33
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_height+0)
MOVT	R1, #hi_addr(_display_height+0)
LDRH	R1, [R1, #0]
CMP	R1, R2
IT	NE
BNE	L__DrawScreen32
IT	AL
BAL	L_DrawScreen12
L__DrawScreen33:
L__DrawScreen32:
;P7_final_project_driver.c,120 :: 		save_bled = TFT_BLED;
MOVW	R2, #lo_addr(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
_LX	[R2, ByteOffset(GPIOE_ODR+0)]
STRB	R1, [SP, #6]
;P7_final_project_driver.c,121 :: 		TFT_BLED           = 0;
MOVS	R1, #0
SXTB	R1, R1
_SX	[R2, ByteOffset(GPIOE_ODR+0)]
;P7_final_project_driver.c,122 :: 		TFT_Init_ILI9341_8bit(CurrentScreen->Width, CurrentScreen->Height);
MOVW	R3, #lo_addr(_CurrentScreen+0)
MOVT	R3, #hi_addr(_CurrentScreen+0)
LDR	R1, [R3, #0]
ADDS	R1, R1, #4
LDRH	R1, [R1, #0]
UXTH	R2, R1
MOV	R1, R3
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRH	R1, [R1, #0]
UXTH	R0, R1
UXTH	R1, R2
BL	_TFT_Init_ILI9341_8bit+0
;P7_final_project_driver.c,123 :: 		TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 8, 9);                                  // Initialize touch panel
MOVW	R3, #lo_addr(_CurrentScreen+0)
MOVT	R3, #hi_addr(_CurrentScreen+0)
LDR	R1, [R3, #0]
ADDS	R1, R1, #4
LDRH	R1, [R1, #0]
UXTH	R2, R1
MOV	R1, R3
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRH	R1, [R1, #0]
MOVS	R3, #9
UXTH	R0, R1
UXTH	R1, R2
MOVS	R2, #8
BL	_TP_TFT_Init+0
;P7_final_project_driver.c,124 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
MOVW	R0, #1500
SXTH	R0, R0
BL	_TP_TFT_Set_ADC_Threshold+0
;P7_final_project_driver.c,125 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
;P7_final_project_driver.c,126 :: 		display_width = CurrentScreen->Width;
MOVW	R3, #lo_addr(_CurrentScreen+0)
MOVT	R3, #hi_addr(_CurrentScreen+0)
LDR	R1, [R3, #0]
ADDS	R1, R1, #2
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
STRH	R2, [R1, #0]
;P7_final_project_driver.c,127 :: 		display_height = CurrentScreen->Height;
MOV	R1, R3
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_height+0)
MOVT	R1, #hi_addr(_display_height+0)
STRH	R2, [R1, #0]
;P7_final_project_driver.c,128 :: 		TFT_BLED           = save_bled;
LDRB	R2, [SP, #6]
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
_SX	[R1, ByteOffset(GPIOE_ODR+0)]
;P7_final_project_driver.c,129 :: 		}
IT	AL
BAL	L_DrawScreen13
L_DrawScreen12:
;P7_final_project_driver.c,131 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
L_DrawScreen13:
;P7_final_project_driver.c,134 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen14:
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #6
LDRH	R2, [R1, #0]
LDRH	R1, [SP, #4]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen15
;P7_final_project_driver.c,135 :: 		}
IT	AL
BAL	L_DrawScreen14
L_DrawScreen15:
;P7_final_project_driver.c,136 :: 		}
L_end_DrawScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _DrawScreen
_Get_Object:
;P7_final_project_driver.c,138 :: 		void Get_Object(unsigned int X, unsigned int Y) {
SUB	SP, SP, #4
;P7_final_project_driver.c,139 :: 		_object_count = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
;P7_final_project_driver.c,140 :: 		}
L_end_Get_Object:
ADD	SP, SP, #4
BX	LR
; end of _Get_Object
_Process_TP_Press:
;P7_final_project_driver.c,143 :: 		void Process_TP_Press(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
;P7_final_project_driver.c,145 :: 		Get_Object(X, Y);
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
BL	_Get_Object+0
;P7_final_project_driver.c,147 :: 		if (_object_count != -1) {
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, #-1
IT	EQ
BEQ	L_Process_TP_Press16
;P7_final_project_driver.c,148 :: 		}
L_Process_TP_Press16:
;P7_final_project_driver.c,149 :: 		}
L_end_Process_TP_Press:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Process_TP_Press
_Process_TP_Up:
;P7_final_project_driver.c,151 :: 		void Process_TP_Up(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
;P7_final_project_driver.c,154 :: 		Get_Object(X, Y);
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
BL	_Get_Object+0
;P7_final_project_driver.c,157 :: 		if (_object_count != -1) {
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, #-1
IT	EQ
BEQ	L_Process_TP_Up17
;P7_final_project_driver.c,158 :: 		}
L_Process_TP_Up17:
;P7_final_project_driver.c,159 :: 		PressedObject = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
STR	R3, [R2, #0]
;P7_final_project_driver.c,160 :: 		PressedObjectType = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
STRH	R3, [R2, #0]
;P7_final_project_driver.c,161 :: 		}
L_end_Process_TP_Up:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Process_TP_Up
_Process_TP_Down:
;P7_final_project_driver.c,163 :: 		void Process_TP_Down(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
;P7_final_project_driver.c,165 :: 		object_pressed      = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_object_pressed+0)
MOVT	R2, #hi_addr(_object_pressed+0)
STRB	R3, [R2, #0]
;P7_final_project_driver.c,167 :: 		Get_Object(X, Y);
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
BL	_Get_Object+0
;P7_final_project_driver.c,169 :: 		if (_object_count != -1) {
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, #-1
IT	EQ
BEQ	L_Process_TP_Down18
;P7_final_project_driver.c,170 :: 		}
L_Process_TP_Down18:
;P7_final_project_driver.c,171 :: 		}
L_end_Process_TP_Down:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Process_TP_Down
_Check_TP:
;P7_final_project_driver.c,173 :: 		void Check_TP() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_driver.c,174 :: 		if (TP_TFT_Press_Detect()) {
BL	_TP_TFT_Press_Detect+0
CMP	R0, #0
IT	EQ
BEQ	L_Check_TP19
;P7_final_project_driver.c,175 :: 		if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
MOVW	R1, #lo_addr(_Ycoord+0)
MOVT	R1, #hi_addr(_Ycoord+0)
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
BL	_TP_TFT_Get_Coordinates+0
CMP	R0, #0
IT	NE
BNE	L_Check_TP20
;P7_final_project_driver.c,177 :: 		Process_TP_Press(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Press+0
;P7_final_project_driver.c,178 :: 		if (PenDown == 0) {
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Check_TP21
;P7_final_project_driver.c,179 :: 		PenDown = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;P7_final_project_driver.c,180 :: 		Process_TP_Down(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Down+0
;P7_final_project_driver.c,181 :: 		}
L_Check_TP21:
;P7_final_project_driver.c,182 :: 		}
L_Check_TP20:
;P7_final_project_driver.c,183 :: 		}
IT	AL
BAL	L_Check_TP22
L_Check_TP19:
;P7_final_project_driver.c,184 :: 		else if (PenDown == 1) {
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_Check_TP23
;P7_final_project_driver.c,185 :: 		PenDown = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;P7_final_project_driver.c,186 :: 		Process_TP_Up(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Up+0
;P7_final_project_driver.c,187 :: 		}
L_Check_TP23:
L_Check_TP22:
;P7_final_project_driver.c,188 :: 		}
L_end_Check_TP:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Check_TP
_Init_MCU:
;P7_final_project_driver.c,190 :: 		void Init_MCU() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_driver.c,191 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_9);
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;P7_final_project_driver.c,193 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;P7_final_project_driver.c,194 :: 		TFT_Set_Default_Mode();
BL	_TFT_Set_Default_Mode+0
;P7_final_project_driver.c,195 :: 		TP_TFT_Set_Default_Mode();
BL	_TP_TFT_Set_Default_Mode+0
;P7_final_project_driver.c,196 :: 		}
L_end_Init_MCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_MCU
_Start_TP:
;P7_final_project_driver.c,198 :: 		void Start_TP() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;P7_final_project_driver.c,199 :: 		Init_MCU();
BL	_Init_MCU+0
;P7_final_project_driver.c,201 :: 		InitializeTouchPanel();        // Must be enabled to work. This enables the display not just the touch
BL	P7_final_project_driver_InitializeTouchPanel+0
;P7_final_project_driver.c,203 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_Start_TP24:
SUBS	R7, R7, #1
BNE	L_Start_TP24
NOP
NOP
NOP
;P7_final_project_driver.c,204 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;P7_final_project_driver.c,206 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;P7_final_project_driver.c,208 :: 		InitializeObjects();
BL	P7_final_project_driver_InitializeObjects+0
;P7_final_project_driver.c,209 :: 		display_width = Screen1.Width;
MOVW	R0, #lo_addr(_Screen1+2)
MOVT	R0, #hi_addr(_Screen1+2)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_width+0)
MOVT	R0, #hi_addr(_display_width+0)
STRH	R1, [R0, #0]
;P7_final_project_driver.c,210 :: 		display_height = Screen1.Height;
MOVW	R0, #lo_addr(_Screen1+4)
MOVT	R0, #hi_addr(_Screen1+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_height+0)
MOVT	R0, #hi_addr(_display_height+0)
STRH	R1, [R0, #0]
;P7_final_project_driver.c,211 :: 		DrawScreen(&Screen1);
MOVW	R0, #lo_addr(_Screen1+0)
MOVT	R0, #hi_addr(_Screen1+0)
BL	_DrawScreen+0
;P7_final_project_driver.c,212 :: 		}
L_end_Start_TP:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Start_TP
