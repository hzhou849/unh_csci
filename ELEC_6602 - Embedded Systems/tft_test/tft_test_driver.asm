_Init_ADC:
;tft_test_driver.c,42 :: 		void Init_ADC() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tft_test_driver.c,43 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
MOVW	R0, #768
BL	_ADC_Set_Input_Channel+0
;tft_test_driver.c,44 :: 		ADC1_Init();
BL	_ADC1_Init+0
;tft_test_driver.c,45 :: 		Delay_ms(100);
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
;tft_test_driver.c,46 :: 		}
L_end_Init_ADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_ADC
tft_test_driver_InitializeTouchPanel:
;tft_test_driver.c,47 :: 		static void InitializeTouchPanel() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tft_test_driver.c,48 :: 		Init_ADC();
BL	_Init_ADC+0
;tft_test_driver.c,49 :: 		TFT_Init(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init+0
;tft_test_driver.c,51 :: 		TP_TFT_Init(320, 240, 8, 9);                                  // Initialize touch panel
MOVS	R3, #9
MOVS	R2, #8
MOVS	R1, #240
MOVW	R0, #320
BL	_TP_TFT_Init+0
;tft_test_driver.c,52 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
MOVW	R0, #1500
SXTH	R0, R0
BL	_TP_TFT_Set_ADC_Threshold+0
;tft_test_driver.c,54 :: 		PenDown = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;tft_test_driver.c,55 :: 		PressedObject = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PressedObject+0)
MOVT	R0, #hi_addr(_PressedObject+0)
STR	R1, [R0, #0]
;tft_test_driver.c,56 :: 		PressedObjectType = -1;
MOVW	R1, #65535
SXTH	R1, R1
MOVW	R0, #lo_addr(_PressedObjectType+0)
MOVT	R0, #hi_addr(_PressedObjectType+0)
STRH	R1, [R0, #0]
;tft_test_driver.c,57 :: 		}
L_end_InitializeTouchPanel:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of tft_test_driver_InitializeTouchPanel
_Calibrate:
;tft_test_driver.c,59 :: 		void Calibrate() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tft_test_driver.c,60 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;tft_test_driver.c,61 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;tft_test_driver.c,62 :: 		TFT_Write_Text("Touch selected corners for calibration", 50, 80);
MOVW	R0, #lo_addr(?lstr1_tft_test_driver+0)
MOVT	R0, #hi_addr(?lstr1_tft_test_driver+0)
MOVS	R2, #80
MOVS	R1, #50
BL	_TFT_Write_Text+0
;tft_test_driver.c,63 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,64 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,65 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,66 :: 		TFT_Write_Text("first here", 210, 220);
MOVW	R0, #lo_addr(?lstr2_tft_test_driver+0)
MOVT	R0, #hi_addr(?lstr2_tft_test_driver+0)
MOVS	R2, #220
MOVS	R1, #210
BL	_TFT_Write_Text+0
;tft_test_driver.c,68 :: 		TP_TFT_Calibrate_Min();                      // Calibration of TP minimum
BL	_TP_TFT_Calibrate_Min+0
;tft_test_driver.c,69 :: 		Delay_ms(500);
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
;tft_test_driver.c,71 :: 		TFT_Set_Pen(CL_BLACK, 3);
MOVS	R1, #3
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;tft_test_driver.c,72 :: 		TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;tft_test_driver.c,73 :: 		TFT_Line(315, 239, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #239
SXTH	R1, R1
MOVW	R0, #315
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,74 :: 		TFT_Line(309, 229, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #229
SXTH	R1, R1
MOVW	R0, #309
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,75 :: 		TFT_Line(319, 234, 319, 239);
MOVS	R3, #239
SXTH	R3, R3
MOVW	R2, #319
SXTH	R2, R2
MOVS	R1, #234
SXTH	R1, R1
MOVW	R0, #319
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,76 :: 		TFT_Write_Text("first here", 210, 220);
MOVW	R0, #lo_addr(?lstr3_tft_test_driver+0)
MOVT	R0, #hi_addr(?lstr3_tft_test_driver+0)
MOVS	R2, #220
MOVS	R1, #210
BL	_TFT_Write_Text+0
;tft_test_driver.c,78 :: 		TFT_Set_Pen(CL_WHITE, 3);
MOVS	R1, #3
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;tft_test_driver.c,79 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;tft_test_driver.c,80 :: 		TFT_Write_Text("now here ", 20, 5);
MOVW	R0, #lo_addr(?lstr4_tft_test_driver+0)
MOVT	R0, #hi_addr(?lstr4_tft_test_driver+0)
MOVS	R2, #5
MOVS	R1, #20
BL	_TFT_Write_Text+0
;tft_test_driver.c,81 :: 		TFT_Line(0, 0, 5, 0);
MOVS	R3, #0
SXTH	R3, R3
MOVS	R2, #5
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,82 :: 		TFT_Line(0, 0, 0, 5);
MOVS	R3, #5
SXTH	R3, R3
MOVS	R2, #0
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,83 :: 		TFT_Line(0, 0, 10, 10);
MOVS	R3, #10
SXTH	R3, R3
MOVS	R2, #10
SXTH	R2, R2
MOVS	R1, #0
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Line+0
;tft_test_driver.c,85 :: 		TP_TFT_Calibrate_Max();                       // Calibration of TP maximum
BL	_TP_TFT_Calibrate_Max+0
;tft_test_driver.c,86 :: 		Delay_ms(500);
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
;tft_test_driver.c,87 :: 		}
L_end_Calibrate:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Calibrate
tft_test_driver_InitializeObjects:
;tft_test_driver.c,109 :: 		static void InitializeObjects() {
;tft_test_driver.c,110 :: 		Screen1.Color                     = 0x5AEB;
MOVW	R1, #23275
MOVW	R0, #lo_addr(_Screen1+0)
MOVT	R0, #hi_addr(_Screen1+0)
STRH	R1, [R0, #0]
;tft_test_driver.c,111 :: 		Screen1.Width                     = 320;
MOVW	R1, #320
MOVW	R0, #lo_addr(_Screen1+2)
MOVT	R0, #hi_addr(_Screen1+2)
STRH	R1, [R0, #0]
;tft_test_driver.c,112 :: 		Screen1.Height                    = 240;
MOVS	R1, #240
MOVW	R0, #lo_addr(_Screen1+4)
MOVT	R0, #hi_addr(_Screen1+4)
STRH	R1, [R0, #0]
;tft_test_driver.c,113 :: 		Screen1.ButtonsCount              = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Screen1+8)
MOVT	R0, #hi_addr(_Screen1+8)
STRH	R1, [R0, #0]
;tft_test_driver.c,114 :: 		Screen1.Buttons                   = Screen1_Buttons;
MOVW	R1, #lo_addr(_Screen1_Buttons+0)
MOVT	R1, #hi_addr(_Screen1_Buttons+0)
MOVW	R0, #lo_addr(_Screen1+12)
MOVT	R0, #hi_addr(_Screen1+12)
STR	R1, [R0, #0]
;tft_test_driver.c,115 :: 		Screen1.BoxesCount                = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Screen1+16)
MOVT	R0, #hi_addr(_Screen1+16)
STRH	R1, [R0, #0]
;tft_test_driver.c,116 :: 		Screen1.Boxes                     = Screen1_Boxes;
MOVW	R1, #lo_addr(_Screen1_Boxes+0)
MOVT	R1, #hi_addr(_Screen1_Boxes+0)
MOVW	R0, #lo_addr(_Screen1+20)
MOVT	R0, #hi_addr(_Screen1+20)
STR	R1, [R0, #0]
;tft_test_driver.c,117 :: 		Screen1.ObjectsCount              = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_Screen1+6)
MOVT	R0, #hi_addr(_Screen1+6)
STRH	R1, [R0, #0]
;tft_test_driver.c,120 :: 		Box1.OwnerScreen     = &Screen1;
MOVW	R1, #lo_addr(_Screen1+0)
MOVT	R1, #hi_addr(_Screen1+0)
MOVW	R0, #lo_addr(_Box1+0)
MOVT	R0, #hi_addr(_Box1+0)
STR	R1, [R0, #0]
;tft_test_driver.c,121 :: 		Box1.Order           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Box1+4)
MOVT	R0, #hi_addr(_Box1+4)
STRB	R1, [R0, #0]
;tft_test_driver.c,122 :: 		Box1.Left            = 63;
MOVS	R1, #63
MOVW	R0, #lo_addr(_Box1+6)
MOVT	R0, #hi_addr(_Box1+6)
STRH	R1, [R0, #0]
;tft_test_driver.c,123 :: 		Box1.Top             = 52;
MOVS	R1, #52
MOVW	R0, #lo_addr(_Box1+8)
MOVT	R0, #hi_addr(_Box1+8)
STRH	R1, [R0, #0]
;tft_test_driver.c,124 :: 		Box1.Width           = 61;
MOVS	R1, #61
MOVW	R0, #lo_addr(_Box1+10)
MOVT	R0, #hi_addr(_Box1+10)
STRH	R1, [R0, #0]
;tft_test_driver.c,125 :: 		Box1.Height          = 46;
MOVS	R1, #46
MOVW	R0, #lo_addr(_Box1+12)
MOVT	R0, #hi_addr(_Box1+12)
STRH	R1, [R0, #0]
;tft_test_driver.c,126 :: 		Box1.Pen_Width       = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Box1+14)
MOVT	R0, #hi_addr(_Box1+14)
STRB	R1, [R0, #0]
;tft_test_driver.c,127 :: 		Box1.Pen_Color       = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Box1+16)
MOVT	R0, #hi_addr(_Box1+16)
STRH	R1, [R0, #0]
;tft_test_driver.c,128 :: 		Box1.Visible         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Box1+18)
MOVT	R0, #hi_addr(_Box1+18)
STRB	R1, [R0, #0]
;tft_test_driver.c,129 :: 		Box1.Active          = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Box1+19)
MOVT	R0, #hi_addr(_Box1+19)
STRB	R1, [R0, #0]
;tft_test_driver.c,130 :: 		Box1.Transparent     = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Box1+20)
MOVT	R0, #hi_addr(_Box1+20)
STRB	R1, [R0, #0]
;tft_test_driver.c,131 :: 		Box1.Gradient        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Box1+21)
MOVT	R0, #hi_addr(_Box1+21)
STRB	R1, [R0, #0]
;tft_test_driver.c,132 :: 		Box1.Gradient_Orientation = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Box1+22)
MOVT	R0, #hi_addr(_Box1+22)
STRB	R1, [R0, #0]
;tft_test_driver.c,133 :: 		Box1.Gradient_Start_Color = 0xFFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(_Box1+24)
MOVT	R0, #hi_addr(_Box1+24)
STRH	R1, [R0, #0]
;tft_test_driver.c,134 :: 		Box1.Gradient_End_Color = 0xC618;
MOVW	R1, #50712
MOVW	R0, #lo_addr(_Box1+26)
MOVT	R0, #hi_addr(_Box1+26)
STRH	R1, [R0, #0]
;tft_test_driver.c,135 :: 		Box1.Color           = 0xC618;
MOVW	R1, #50712
MOVW	R0, #lo_addr(_Box1+28)
MOVT	R0, #hi_addr(_Box1+28)
STRH	R1, [R0, #0]
;tft_test_driver.c,136 :: 		Box1.PressColEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Box1+30)
MOVT	R0, #hi_addr(_Box1+30)
STRB	R1, [R0, #0]
;tft_test_driver.c,137 :: 		Box1.Press_Color     = 0xE71C;
MOVW	R1, #59164
MOVW	R0, #lo_addr(_Box1+32)
MOVT	R0, #hi_addr(_Box1+32)
STRH	R1, [R0, #0]
;tft_test_driver.c,139 :: 		Button1.OwnerScreen     = &Screen1;
MOVW	R1, #lo_addr(_Screen1+0)
MOVT	R1, #hi_addr(_Screen1+0)
MOVW	R0, #lo_addr(_Button1+0)
MOVT	R0, #hi_addr(_Button1+0)
STR	R1, [R0, #0]
;tft_test_driver.c,140 :: 		Button1.Order           = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+4)
MOVT	R0, #hi_addr(_Button1+4)
STRB	R1, [R0, #0]
;tft_test_driver.c,141 :: 		Button1.Left            = 155;
MOVS	R1, #155
MOVW	R0, #lo_addr(_Button1+6)
MOVT	R0, #hi_addr(_Button1+6)
STRH	R1, [R0, #0]
;tft_test_driver.c,142 :: 		Button1.Top             = 144;
MOVS	R1, #144
MOVW	R0, #lo_addr(_Button1+8)
MOVT	R0, #hi_addr(_Button1+8)
STRH	R1, [R0, #0]
;tft_test_driver.c,143 :: 		Button1.Width           = 98;
MOVS	R1, #98
MOVW	R0, #lo_addr(_Button1+10)
MOVT	R0, #hi_addr(_Button1+10)
STRH	R1, [R0, #0]
;tft_test_driver.c,144 :: 		Button1.Height          = 48;
MOVS	R1, #48
MOVW	R0, #lo_addr(_Button1+12)
MOVT	R0, #hi_addr(_Button1+12)
STRH	R1, [R0, #0]
;tft_test_driver.c,145 :: 		Button1.Pen_Width       = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+14)
MOVT	R0, #hi_addr(_Button1+14)
STRB	R1, [R0, #0]
;tft_test_driver.c,146 :: 		Button1.Pen_Color       = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Button1+16)
MOVT	R0, #hi_addr(_Button1+16)
STRH	R1, [R0, #0]
;tft_test_driver.c,147 :: 		Button1.Visible         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+18)
MOVT	R0, #hi_addr(_Button1+18)
STRB	R1, [R0, #0]
;tft_test_driver.c,148 :: 		Button1.Active          = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+19)
MOVT	R0, #hi_addr(_Button1+19)
STRB	R1, [R0, #0]
;tft_test_driver.c,149 :: 		Button1.Transparent     = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+20)
MOVT	R0, #hi_addr(_Button1+20)
STRB	R1, [R0, #0]
;tft_test_driver.c,150 :: 		Button1.Caption         = Button1_Caption;
MOVW	R1, #lo_addr(_Button1_Caption+0)
MOVT	R1, #hi_addr(_Button1_Caption+0)
MOVW	R0, #lo_addr(_Button1+24)
MOVT	R0, #hi_addr(_Button1+24)
STR	R1, [R0, #0]
;tft_test_driver.c,151 :: 		Button1.TextAlign       = _taCenter;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+28)
MOVT	R0, #hi_addr(_Button1+28)
STRB	R1, [R0, #0]
;tft_test_driver.c,152 :: 		Button1.TextAlignVertical= _tavMiddle;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+29)
MOVT	R0, #hi_addr(_Button1+29)
STRB	R1, [R0, #0]
;tft_test_driver.c,153 :: 		Button1.FontName        = Tahoma11x13_Regular;
MOVW	R1, #lo_addr(_Tahoma11x13_Regular+0)
MOVT	R1, #hi_addr(_Tahoma11x13_Regular+0)
MOVW	R0, #lo_addr(_Button1+32)
MOVT	R0, #hi_addr(_Button1+32)
STR	R1, [R0, #0]
;tft_test_driver.c,154 :: 		Button1.PressColEnabled = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+48)
MOVT	R0, #hi_addr(_Button1+48)
STRB	R1, [R0, #0]
;tft_test_driver.c,155 :: 		Button1.Font_Color      = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Button1+36)
MOVT	R0, #hi_addr(_Button1+36)
STRH	R1, [R0, #0]
;tft_test_driver.c,156 :: 		Button1.VerticalText    = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Button1+38)
MOVT	R0, #hi_addr(_Button1+38)
STRB	R1, [R0, #0]
;tft_test_driver.c,157 :: 		Button1.Gradient        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Button1+39)
MOVT	R0, #hi_addr(_Button1+39)
STRB	R1, [R0, #0]
;tft_test_driver.c,158 :: 		Button1.Gradient_Orientation = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Button1+40)
MOVT	R0, #hi_addr(_Button1+40)
STRB	R1, [R0, #0]
;tft_test_driver.c,159 :: 		Button1.Gradient_Start_Color = 0xFFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(_Button1+42)
MOVT	R0, #hi_addr(_Button1+42)
STRH	R1, [R0, #0]
;tft_test_driver.c,160 :: 		Button1.Gradient_End_Color = 0xC618;
MOVW	R1, #50712
MOVW	R0, #lo_addr(_Button1+44)
MOVT	R0, #hi_addr(_Button1+44)
STRH	R1, [R0, #0]
;tft_test_driver.c,161 :: 		Button1.Color           = 0xC618;
MOVW	R1, #50712
MOVW	R0, #lo_addr(_Button1+46)
MOVT	R0, #hi_addr(_Button1+46)
STRH	R1, [R0, #0]
;tft_test_driver.c,162 :: 		Button1.Press_Color     = 0xE71C;
MOVW	R1, #59164
MOVW	R0, #lo_addr(_Button1+50)
MOVT	R0, #hi_addr(_Button1+50)
STRH	R1, [R0, #0]
;tft_test_driver.c,163 :: 		}
L_end_InitializeObjects:
BX	LR
; end of tft_test_driver_InitializeObjects
tft_test_driver_IsInsideObject:
;tft_test_driver.c,165 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
; Top start address is: 12 (R3)
; Left start address is: 8 (R2)
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
; Top end address is: 12 (R3)
; Left end address is: 8 (R2)
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
; Left start address is: 8 (R2)
; Top start address is: 12 (R3)
; Width start address is: 20 (R5)
LDRH	R5, [SP, #0]
; Height start address is: 24 (R6)
LDRH	R6, [SP, #4]
;tft_test_driver.c,166 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
CMP	R2, R0
IT	HI
BHI	L_tft_test_driver_IsInsideObject100
ADDS	R4, R2, R5
UXTH	R4, R4
; Left end address is: 8 (R2)
; Width end address is: 20 (R5)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R0
IT	CC
BCC	L_tft_test_driver_IsInsideObject99
; X end address is: 0 (R0)
;tft_test_driver.c,167 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
CMP	R3, R1
IT	HI
BHI	L_tft_test_driver_IsInsideObject98
ADDS	R4, R3, R6
UXTH	R4, R4
; Top end address is: 12 (R3)
; Height end address is: 24 (R6)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R1
IT	CC
BCC	L_tft_test_driver_IsInsideObject97
; Y end address is: 4 (R1)
L_tft_test_driver_IsInsideObject96:
;tft_test_driver.c,168 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_IsInsideObject
;tft_test_driver.c,166 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
L_tft_test_driver_IsInsideObject100:
L_tft_test_driver_IsInsideObject99:
;tft_test_driver.c,167 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
L_tft_test_driver_IsInsideObject98:
L_tft_test_driver_IsInsideObject97:
;tft_test_driver.c,170 :: 		return 0;
MOVS	R0, #0
;tft_test_driver.c,171 :: 		}
L_end_IsInsideObject:
BX	LR
; end of tft_test_driver_IsInsideObject
_DrawButton:
;tft_test_driver.c,177 :: 		void DrawButton(TButton *Abutton) {
; Abutton start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; Abutton end address is: 0 (R0)
; Abutton start address is: 0 (R0)
;tft_test_driver.c,179 :: 		if (Abutton->Visible != 0) {
ADDW	R1, R0, #18
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_DrawButton10
;tft_test_driver.c,180 :: 		if (object_pressed == 1) {
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	NE
BNE	L_DrawButton11
;tft_test_driver.c,181 :: 		object_pressed = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
STRB	R2, [R1, #0]
;tft_test_driver.c,182 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Press_Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_End_Color, Abutton->Gradient_Start_Color);
ADDW	R1, R0, #42
LDRH	R1, [R1, #0]
UXTH	R6, R1
ADDW	R1, R0, #44
LDRH	R1, [R1, #0]
UXTH	R5, R1
ADDW	R1, R0, #40
LDRB	R1, [R1, #0]
UXTB	R4, R1
ADDW	R1, R0, #39
LDRB	R1, [R1, #0]
UXTB	R3, R1
ADDW	R1, R0, #50
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #20
LDRB	R1, [R1, #0]
STR	R0, [SP, #4]
UXTB	R0, R1
UXTH	R1, R2
UXTB	R2, R3
UXTB	R3, R4
PUSH	(R6)
PUSH	(R5)
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
LDR	R0, [SP, #4]
;tft_test_driver.c,183 :: 		}
IT	AL
BAL	L_DrawButton12
L_DrawButton11:
;tft_test_driver.c,185 :: 		TFT_Set_Brush(Abutton->Transparent, Abutton->Color, Abutton->Gradient, Abutton->Gradient_Orientation, Abutton->Gradient_Start_Color, Abutton->Gradient_End_Color);
ADDW	R1, R0, #44
LDRH	R1, [R1, #0]
UXTH	R6, R1
ADDW	R1, R0, #42
LDRH	R1, [R1, #0]
UXTH	R5, R1
ADDW	R1, R0, #40
LDRB	R1, [R1, #0]
UXTB	R4, R1
ADDW	R1, R0, #39
LDRB	R1, [R1, #0]
UXTB	R3, R1
ADDW	R1, R0, #46
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #20
LDRB	R1, [R1, #0]
STR	R0, [SP, #4]
UXTB	R0, R1
UXTH	R1, R2
UXTB	R2, R3
UXTB	R3, R4
PUSH	(R6)
PUSH	(R5)
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
LDR	R0, [SP, #4]
;tft_test_driver.c,186 :: 		}
L_DrawButton12:
;tft_test_driver.c,187 :: 		TFT_Set_Pen(Abutton->Pen_Color, Abutton->Pen_Width);
ADDW	R1, R0, #14
LDRB	R1, [R1, #0]
UXTB	R2, R1
ADDW	R1, R0, #16
LDRH	R1, [R1, #0]
STR	R0, [SP, #4]
UXTH	R0, R1
UXTB	R1, R2
BL	_TFT_Set_Pen+0
LDR	R0, [SP, #4]
;tft_test_driver.c,188 :: 		TFT_Rectangle(Abutton->Left, Abutton->Top, Abutton->Left + Abutton->Width - 1, Abutton->Top + Abutton->Height - 1);
ADDW	R1, R0, #8
LDRH	R2, [R1, #0]
ADDW	R1, R0, #12
LDRH	R1, [R1, #0]
ADDS	R1, R2, R1
UXTH	R1, R1
SUBS	R5, R1, #1
ADDS	R1, R0, #6
LDRH	R4, [R1, #0]
ADDW	R1, R0, #10
LDRH	R1, [R1, #0]
ADDS	R1, R4, R1
UXTH	R1, R1
SUBS	R3, R1, #1
SXTH	R2, R2
SXTH	R1, R4
STR	R0, [SP, #4]
SXTH	R0, R1
SXTH	R1, R2
SXTH	R2, R3
SXTH	R3, R5
BL	_TFT_Rectangle+0
LDR	R0, [SP, #4]
;tft_test_driver.c,189 :: 		if (Abutton->VerticalText != 0)
ADDW	R1, R0, #38
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_DrawButton13
;tft_test_driver.c,190 :: 		TFT_Set_Font(Abutton->FontName, Abutton->Font_Color, FO_VERTICAL_COLUMN);
ADDW	R1, R0, #36
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #32
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
UXTH	R1, R2
MOVS	R2, #2
BL	_TFT_Set_Font+0
LDR	R0, [SP, #4]
IT	AL
BAL	L_DrawButton14
L_DrawButton13:
;tft_test_driver.c,192 :: 		TFT_Set_Font(Abutton->FontName, Abutton->Font_Color, FO_HORIZONTAL);
ADDW	R1, R0, #36
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #32
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
UXTH	R1, R2
MOVS	R2, #0
BL	_TFT_Set_Font+0
LDR	R0, [SP, #4]
L_DrawButton14:
;tft_test_driver.c,193 :: 		TFT_Write_Text_Return_Pos(Abutton->Caption, Abutton->Left, Abutton->Top);
ADDW	R1, R0, #8
LDRH	R1, [R1, #0]
UXTH	R3, R1
ADDS	R1, R0, #6
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #24
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
UXTH	R1, R2
UXTH	R2, R3
BL	_TFT_Write_Text_Return_Pos+0
LDR	R0, [SP, #4]
;tft_test_driver.c,194 :: 		if (Abutton->TextAlign == _taLeft)
ADDW	R1, R0, #28
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L_DrawButton15
;tft_test_driver.c,195 :: 		ALeft = Abutton->Left + 4;
ADDS	R1, R0, #6
LDRH	R1, [R1, #0]
ADDS	R1, R1, #4
STRH	R1, [SP, #8]
IT	AL
BAL	L_DrawButton16
L_DrawButton15:
;tft_test_driver.c,196 :: 		else if (Abutton->TextAlign == _taCenter)
ADDW	R1, R0, #28
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	NE
BNE	L_DrawButton17
;tft_test_driver.c,197 :: 		ALeft = Abutton->Left + (Abutton->Width - caption_length) / 2;
ADDS	R1, R0, #6
LDRH	R3, [R1, #0]
ADDW	R1, R0, #10
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_caption_length+0)
MOVT	R1, #hi_addr(_caption_length+0)
LDRH	R1, [R1, #0]
SUB	R1, R2, R1
UXTH	R1, R1
LSRS	R1, R1, #1
UXTH	R1, R1
ADDS	R1, R3, R1
STRH	R1, [SP, #8]
IT	AL
BAL	L_DrawButton18
L_DrawButton17:
;tft_test_driver.c,198 :: 		else if (Abutton->TextAlign == _taRight)
ADDW	R1, R0, #28
LDRB	R1, [R1, #0]
CMP	R1, #2
IT	NE
BNE	L_DrawButton19
;tft_test_driver.c,199 :: 		ALeft = Abutton->Left + Abutton->Width - caption_length - 4;
ADDS	R1, R0, #6
LDRH	R2, [R1, #0]
ADDW	R1, R0, #10
LDRH	R1, [R1, #0]
ADDS	R2, R2, R1
UXTH	R2, R2
MOVW	R1, #lo_addr(_caption_length+0)
MOVT	R1, #hi_addr(_caption_length+0)
LDRH	R1, [R1, #0]
SUB	R1, R2, R1
UXTH	R1, R1
SUBS	R1, R1, #4
STRH	R1, [SP, #8]
L_DrawButton19:
L_DrawButton18:
L_DrawButton16:
;tft_test_driver.c,201 :: 		if (Abutton->TextAlignVertical == _tavTop)
ADDW	R1, R0, #29
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L_DrawButton20
;tft_test_driver.c,202 :: 		ATop = Abutton->Top + 4;
ADDW	R1, R0, #8
LDRH	R1, [R1, #0]
ADDS	R1, R1, #4
STRH	R1, [SP, #10]
IT	AL
BAL	L_DrawButton21
L_DrawButton20:
;tft_test_driver.c,203 :: 		else if (Abutton->TextAlignVertical == _tavMiddle)
ADDW	R1, R0, #29
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	NE
BNE	L_DrawButton22
;tft_test_driver.c,204 :: 		ATop = Abutton->Top + ((Abutton->Height - caption_height) / 2);
ADDW	R1, R0, #8
LDRH	R3, [R1, #0]
ADDW	R1, R0, #12
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_caption_height+0)
MOVT	R1, #hi_addr(_caption_height+0)
LDRH	R1, [R1, #0]
SUB	R1, R2, R1
UXTH	R1, R1
LSRS	R1, R1, #1
UXTH	R1, R1
ADDS	R1, R3, R1
STRH	R1, [SP, #10]
IT	AL
BAL	L_DrawButton23
L_DrawButton22:
;tft_test_driver.c,205 :: 		else if (Abutton->TextAlignVertical == _tavBottom)
ADDW	R1, R0, #29
LDRB	R1, [R1, #0]
CMP	R1, #2
IT	NE
BNE	L_DrawButton24
;tft_test_driver.c,206 :: 		ATop = Abutton->Top + (Abutton->Height - caption_height - 4);
ADDW	R1, R0, #8
LDRH	R3, [R1, #0]
ADDW	R1, R0, #12
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_caption_height+0)
MOVT	R1, #hi_addr(_caption_height+0)
LDRH	R1, [R1, #0]
SUB	R1, R2, R1
UXTH	R1, R1
SUBS	R1, R1, #4
UXTH	R1, R1
ADDS	R1, R3, R1
STRH	R1, [SP, #10]
L_DrawButton24:
L_DrawButton23:
L_DrawButton21:
;tft_test_driver.c,208 :: 		TFT_Write_Text(Abutton->Caption, ALeft, ATop);
ADDW	R1, R0, #24
; Abutton end address is: 0 (R0)
LDR	R1, [R1, #0]
LDRH	R2, [SP, #10]
MOV	R0, R1
LDRH	R1, [SP, #8]
BL	_TFT_Write_Text+0
;tft_test_driver.c,209 :: 		}
L_DrawButton10:
;tft_test_driver.c,210 :: 		}
L_end_DrawButton:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _DrawButton
_DrawBox:
;tft_test_driver.c,212 :: 		void DrawBox(TBox *ABox) {
; ABox start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; ABox end address is: 0 (R0)
; ABox start address is: 0 (R0)
;tft_test_driver.c,213 :: 		if (ABox->Visible != 0) {
ADDW	R1, R0, #18
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_DrawBox25
;tft_test_driver.c,214 :: 		if (object_pressed == 1) {
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	NE
BNE	L_DrawBox26
;tft_test_driver.c,215 :: 		object_pressed = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
STRB	R2, [R1, #0]
;tft_test_driver.c,216 :: 		TFT_Set_Brush(ABox->Transparent, ABox->Press_Color, ABox->Gradient, ABox->Gradient_Orientation, ABox->Gradient_End_Color, ABox->Gradient_Start_Color);
ADDW	R1, R0, #24
LDRH	R1, [R1, #0]
UXTH	R6, R1
ADDW	R1, R0, #26
LDRH	R1, [R1, #0]
UXTH	R5, R1
ADDW	R1, R0, #22
LDRB	R1, [R1, #0]
UXTB	R4, R1
ADDW	R1, R0, #21
LDRB	R1, [R1, #0]
UXTB	R3, R1
ADDW	R1, R0, #32
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #20
LDRB	R1, [R1, #0]
STR	R0, [SP, #4]
UXTB	R0, R1
UXTH	R1, R2
UXTB	R2, R3
UXTB	R3, R4
PUSH	(R6)
PUSH	(R5)
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
LDR	R0, [SP, #4]
;tft_test_driver.c,217 :: 		}
IT	AL
BAL	L_DrawBox27
L_DrawBox26:
;tft_test_driver.c,219 :: 		TFT_Set_Brush(ABox->Transparent, ABox->Color, ABox->Gradient, ABox->Gradient_Orientation, ABox->Gradient_Start_Color, ABox->Gradient_End_Color);
ADDW	R1, R0, #26
LDRH	R1, [R1, #0]
UXTH	R6, R1
ADDW	R1, R0, #24
LDRH	R1, [R1, #0]
UXTH	R5, R1
ADDW	R1, R0, #22
LDRB	R1, [R1, #0]
UXTB	R4, R1
ADDW	R1, R0, #21
LDRB	R1, [R1, #0]
UXTB	R3, R1
ADDW	R1, R0, #28
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #20
LDRB	R1, [R1, #0]
STR	R0, [SP, #4]
UXTB	R0, R1
UXTH	R1, R2
UXTB	R2, R3
UXTB	R3, R4
PUSH	(R6)
PUSH	(R5)
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
LDR	R0, [SP, #4]
;tft_test_driver.c,220 :: 		}
L_DrawBox27:
;tft_test_driver.c,221 :: 		TFT_Set_Pen(ABox->Pen_Color, ABox->Pen_Width);
ADDW	R1, R0, #14
LDRB	R1, [R1, #0]
UXTB	R2, R1
ADDW	R1, R0, #16
LDRH	R1, [R1, #0]
STR	R0, [SP, #4]
UXTH	R0, R1
UXTB	R1, R2
BL	_TFT_Set_Pen+0
LDR	R0, [SP, #4]
;tft_test_driver.c,222 :: 		TFT_Rectangle(ABox->Left, ABox->Top, ABox->Left + ABox->Width - 1, ABox->Top + ABox->Height - 1);
ADDW	R1, R0, #8
LDRH	R2, [R1, #0]
ADDW	R1, R0, #12
LDRH	R1, [R1, #0]
ADDS	R1, R2, R1
UXTH	R1, R1
SUBS	R5, R1, #1
ADDS	R1, R0, #6
LDRH	R4, [R1, #0]
ADDW	R1, R0, #10
; ABox end address is: 0 (R0)
LDRH	R1, [R1, #0]
ADDS	R1, R4, R1
UXTH	R1, R1
SUBS	R3, R1, #1
SXTH	R2, R2
SXTH	R1, R4
SXTH	R0, R1
SXTH	R1, R2
SXTH	R2, R3
SXTH	R3, R5
BL	_TFT_Rectangle+0
;tft_test_driver.c,223 :: 		}
L_DrawBox25:
;tft_test_driver.c,224 :: 		}
L_end_DrawBox:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _DrawBox
_DrawScreen:
;tft_test_driver.c,226 :: 		void DrawScreen(TScreen *aScreen) {
; aScreen start address is: 0 (R0)
SUB	SP, SP, #24
STR	LR, [SP, #0]
; aScreen end address is: 0 (R0)
; aScreen start address is: 0 (R0)
;tft_test_driver.c,234 :: 		object_pressed = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
STRB	R2, [R1, #0]
;tft_test_driver.c,235 :: 		order = 0;
MOVS	R1, #0
STRH	R1, [SP, #4]
;tft_test_driver.c,236 :: 		button_idx = 0;
MOVS	R1, #0
STRB	R1, [SP, #6]
;tft_test_driver.c,237 :: 		box_idx = 0;
MOVS	R1, #0
STRB	R1, [SP, #12]
;tft_test_driver.c,238 :: 		CurrentScreen = aScreen;
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
STR	R0, [R1, #0]
;tft_test_driver.c,240 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
ADDS	R1, R0, #2
; aScreen end address is: 0 (R0)
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
LDRH	R1, [R1, #0]
CMP	R1, R2
IT	NE
BNE	L__DrawScreen103
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
BNE	L__DrawScreen102
IT	AL
BAL	L_DrawScreen30
L__DrawScreen103:
L__DrawScreen102:
;tft_test_driver.c,241 :: 		save_bled = TFT_BLED;
MOVW	R2, #lo_addr(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
_LX	[R2, ByteOffset(GPIOE_ODR+0)]
STRB	R1, [SP, #20]
;tft_test_driver.c,242 :: 		TFT_BLED           = 0;
MOVS	R1, #0
SXTB	R1, R1
_SX	[R2, ByteOffset(GPIOE_ODR+0)]
;tft_test_driver.c,243 :: 		TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
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
BL	_TFT_Init+0
;tft_test_driver.c,244 :: 		TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 8, 9);                                  // Initialize touch panel
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
;tft_test_driver.c,245 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
MOVW	R0, #1500
SXTH	R0, R0
BL	_TP_TFT_Set_ADC_Threshold+0
;tft_test_driver.c,246 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
;tft_test_driver.c,247 :: 		display_width = CurrentScreen->Width;
MOVW	R3, #lo_addr(_CurrentScreen+0)
MOVT	R3, #hi_addr(_CurrentScreen+0)
LDR	R1, [R3, #0]
ADDS	R1, R1, #2
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
STRH	R2, [R1, #0]
;tft_test_driver.c,248 :: 		display_height = CurrentScreen->Height;
MOV	R1, R3
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_height+0)
MOVT	R1, #hi_addr(_display_height+0)
STRH	R2, [R1, #0]
;tft_test_driver.c,249 :: 		TFT_BLED           = save_bled;
LDRB	R2, [SP, #20]
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
_SX	[R1, ByteOffset(GPIOE_ODR+0)]
;tft_test_driver.c,250 :: 		}
IT	AL
BAL	L_DrawScreen31
L_DrawScreen30:
;tft_test_driver.c,252 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
L_DrawScreen31:
;tft_test_driver.c,255 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen32:
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #6
LDRH	R2, [R1, #0]
LDRH	R1, [SP, #4]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen33
;tft_test_driver.c,256 :: 		if (button_idx < CurrentScreen->ButtonsCount) {
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #8
LDRH	R2, [R1, #0]
LDRB	R1, [SP, #6]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen34
;tft_test_driver.c,257 :: 		local_button = GetButton(button_idx);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #12
LDR	R2, [R1, #0]
LDRB	R1, [SP, #6]
LSLS	R1, R1, #2
ADDS	R1, R2, R1
LDR	R1, [R1, #0]
STR	R1, [SP, #8]
;tft_test_driver.c,258 :: 		if (order == local_button->Order) {
ADDS	R1, R1, #4
LDRB	R2, [R1, #0]
LDRH	R1, [SP, #4]
CMP	R1, R2
IT	NE
BNE	L_DrawScreen35
;tft_test_driver.c,259 :: 		button_idx++;
LDRB	R1, [SP, #6]
ADDS	R1, R1, #1
STRB	R1, [SP, #6]
;tft_test_driver.c,260 :: 		order++;
LDRH	R1, [SP, #4]
ADDS	R1, R1, #1
STRH	R1, [SP, #4]
;tft_test_driver.c,261 :: 		DrawButton(local_button);
LDR	R0, [SP, #8]
BL	_DrawButton+0
;tft_test_driver.c,262 :: 		}
L_DrawScreen35:
;tft_test_driver.c,263 :: 		}
L_DrawScreen34:
;tft_test_driver.c,265 :: 		if (box_idx < CurrentScreen->BoxesCount) {
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #16
LDRH	R2, [R1, #0]
LDRB	R1, [SP, #12]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen36
;tft_test_driver.c,266 :: 		local_box = GetBox(box_idx);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #20
LDR	R2, [R1, #0]
LDRB	R1, [SP, #12]
LSLS	R1, R1, #2
ADDS	R1, R2, R1
LDR	R1, [R1, #0]
STR	R1, [SP, #16]
;tft_test_driver.c,267 :: 		if (order == local_box->Order) {
ADDS	R1, R1, #4
LDRB	R2, [R1, #0]
LDRH	R1, [SP, #4]
CMP	R1, R2
IT	NE
BNE	L_DrawScreen37
;tft_test_driver.c,268 :: 		box_idx++;
LDRB	R1, [SP, #12]
ADDS	R1, R1, #1
STRB	R1, [SP, #12]
;tft_test_driver.c,269 :: 		order++;
LDRH	R1, [SP, #4]
ADDS	R1, R1, #1
STRH	R1, [SP, #4]
;tft_test_driver.c,270 :: 		DrawBox(local_box);
LDR	R0, [SP, #16]
BL	_DrawBox+0
;tft_test_driver.c,271 :: 		}
L_DrawScreen37:
;tft_test_driver.c,272 :: 		}
L_DrawScreen36:
;tft_test_driver.c,274 :: 		}
IT	AL
BAL	L_DrawScreen32
L_DrawScreen33:
;tft_test_driver.c,275 :: 		}
L_end_DrawScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #24
BX	LR
; end of _DrawScreen
_Get_Object:
;tft_test_driver.c,277 :: 		void Get_Object(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
;tft_test_driver.c,278 :: 		button_order        = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(_button_order+0)
MOVT	R2, #hi_addr(_button_order+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,279 :: 		box_order           = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(_box_order+0)
MOVT	R2, #hi_addr(_box_order+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,281 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
; X end address is: 0 (R0)
; Y end address is: 4 (R1)
UXTH	R8, R0
UXTH	R7, R1
L_Get_Object38:
; Y start address is: 28 (R7)
; X start address is: 32 (R8)
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #8
LDRH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	CS
BCS	L_Get_Object39
;tft_test_driver.c,282 :: 		local_button = GetButton(_object_count);
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #12
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
LSLS	R2, R2, #2
ADDS	R2, R3, R2
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_local_button+0)
MOVT	R2, #hi_addr(_local_button+0)
STR	R3, [R2, #0]
;tft_test_driver.c,283 :: 		if (local_button->Active != 0) {
ADDW	R2, R3, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Get_Object41
;tft_test_driver.c,285 :: 		local_button->Width, local_button->Height) == 1) {
MOVW	R6, #lo_addr(_local_button+0)
MOVT	R6, #hi_addr(_local_button+0)
LDR	R2, [R6, #0]
ADDS	R2, #12
LDRH	R2, [R2, #0]
UXTH	R5, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #10
LDRH	R2, [R2, #0]
UXTH	R4, R2
;tft_test_driver.c,284 :: 		if (IsInsideObject(X, Y, local_button->Left, local_button->Top,
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #8
LDRH	R2, [R2, #0]
UXTH	R3, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, R2, #6
LDRH	R2, [R2, #0]
UXTH	R1, R7
UXTH	R0, R8
;tft_test_driver.c,285 :: 		local_button->Width, local_button->Height) == 1) {
PUSH	(R5)
PUSH	(R4)
BL	tft_test_driver_IsInsideObject+0
ADD	SP, SP, #8
CMP	R0, #1
IT	NE
BNE	L_Get_Object42
;tft_test_driver.c,286 :: 		button_order = local_button->Order;
MOVW	R4, #lo_addr(_local_button+0)
MOVT	R4, #hi_addr(_local_button+0)
LDR	R2, [R4, #0]
ADDS	R2, R2, #4
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(_button_order+0)
MOVT	R2, #hi_addr(_button_order+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,287 :: 		exec_button = local_button;
MOV	R2, R4
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
STR	R3, [R2, #0]
;tft_test_driver.c,288 :: 		}
L_Get_Object42:
;tft_test_driver.c,289 :: 		}
L_Get_Object41:
;tft_test_driver.c,281 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ButtonsCount ; _object_count++ ) {
MOVW	R3, #lo_addr(__object_count+0)
MOVT	R3, #hi_addr(__object_count+0)
LDRSH	R2, [R3, #0]
ADDS	R2, R2, #1
STRH	R2, [R3, #0]
;tft_test_driver.c,290 :: 		}
IT	AL
BAL	L_Get_Object38
L_Get_Object39:
;tft_test_driver.c,293 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->BoxesCount ; _object_count++ ) {
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
; Y end address is: 28 (R7)
; X end address is: 32 (R8)
STRH	R8, [SP, #4]
UXTH	R8, R7
LDRH	R7, [SP, #4]
L_Get_Object43:
; Y start address is: 32 (R8)
; X start address is: 28 (R7)
; X start address is: 28 (R7)
; X end address is: 28 (R7)
; Y start address is: 32 (R8)
; Y end address is: 32 (R8)
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #16
LDRH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	CS
BCS	L_Get_Object44
; X end address is: 28 (R7)
; Y end address is: 32 (R8)
;tft_test_driver.c,294 :: 		local_box = GetBox(_object_count);
; Y start address is: 32 (R8)
; X start address is: 28 (R7)
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #20
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
LSLS	R2, R2, #2
ADDS	R2, R3, R2
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_local_box+0)
MOVT	R2, #hi_addr(_local_box+0)
STR	R3, [R2, #0]
;tft_test_driver.c,295 :: 		if (local_box->Active != 0) {
ADDW	R2, R3, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Get_Object46
;tft_test_driver.c,297 :: 		local_box->Width, local_box->Height) == 1) {
MOVW	R6, #lo_addr(_local_box+0)
MOVT	R6, #hi_addr(_local_box+0)
LDR	R2, [R6, #0]
ADDS	R2, #12
LDRH	R2, [R2, #0]
UXTH	R5, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #10
LDRH	R2, [R2, #0]
UXTH	R4, R2
;tft_test_driver.c,296 :: 		if (IsInsideObject(X, Y, local_box->Left, local_box->Top,
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #8
LDRH	R2, [R2, #0]
UXTH	R3, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, R2, #6
LDRH	R2, [R2, #0]
UXTH	R1, R8
UXTH	R0, R7
;tft_test_driver.c,297 :: 		local_box->Width, local_box->Height) == 1) {
PUSH	(R5)
PUSH	(R4)
BL	tft_test_driver_IsInsideObject+0
ADD	SP, SP, #8
CMP	R0, #1
IT	NE
BNE	L_Get_Object47
;tft_test_driver.c,298 :: 		box_order = local_box->Order;
MOVW	R4, #lo_addr(_local_box+0)
MOVT	R4, #hi_addr(_local_box+0)
LDR	R2, [R4, #0]
ADDS	R2, R2, #4
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(_box_order+0)
MOVT	R2, #hi_addr(_box_order+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,299 :: 		exec_box = local_box;
MOV	R2, R4
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
STR	R3, [R2, #0]
;tft_test_driver.c,300 :: 		}
L_Get_Object47:
;tft_test_driver.c,301 :: 		}
L_Get_Object46:
;tft_test_driver.c,293 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->BoxesCount ; _object_count++ ) {
MOVW	R3, #lo_addr(__object_count+0)
MOVT	R3, #hi_addr(__object_count+0)
LDRSH	R2, [R3, #0]
ADDS	R2, R2, #1
STRH	R2, [R3, #0]
;tft_test_driver.c,302 :: 		}
; X end address is: 28 (R7)
; Y end address is: 32 (R8)
IT	AL
BAL	L_Get_Object43
L_Get_Object44:
;tft_test_driver.c,304 :: 		_object_count = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,305 :: 		if (button_order >  _object_count )
MOVW	R2, #lo_addr(_button_order+0)
MOVT	R2, #hi_addr(_button_order+0)
LDRSH	R2, [R2, #0]
CMP	R2, #-1
IT	LE
BLE	L_Get_Object48
;tft_test_driver.c,306 :: 		_object_count = button_order;
MOVW	R2, #lo_addr(_button_order+0)
MOVT	R2, #hi_addr(_button_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
L_Get_Object48:
;tft_test_driver.c,307 :: 		if (box_order >  _object_count )
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(_box_order+0)
MOVT	R2, #hi_addr(_box_order+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	LE
BLE	L_Get_Object49
;tft_test_driver.c,308 :: 		_object_count = box_order;
MOVW	R2, #lo_addr(_box_order+0)
MOVT	R2, #hi_addr(_box_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
L_Get_Object49:
;tft_test_driver.c,309 :: 		}
L_end_Get_Object:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Get_Object
_Process_TP_Press:
;tft_test_driver.c,312 :: 		void Process_TP_Press(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
;tft_test_driver.c,313 :: 		exec_button         = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
STR	R3, [R2, #0]
;tft_test_driver.c,314 :: 		exec_box            = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
STR	R3, [R2, #0]
;tft_test_driver.c,316 :: 		Get_Object(X, Y);
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
BL	_Get_Object+0
;tft_test_driver.c,318 :: 		if (_object_count != -1) {
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, #-1
IT	EQ
BEQ	L_Process_TP_Press50
;tft_test_driver.c,319 :: 		if (_object_count == button_order) {
MOVW	R2, #lo_addr(_button_order+0)
MOVT	R2, #hi_addr(_button_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Press51
;tft_test_driver.c,320 :: 		if (exec_button->Active != 0) {
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R2, [R2, #0]
ADDS	R2, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Press52
;tft_test_driver.c,321 :: 		if (exec_button->OnPressPtr != 0) {
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R4, [R4, #0]
ADDS	R4, #64
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Press53
;tft_test_driver.c,322 :: 		exec_button->OnPressPtr();
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R4, [R4, #0]
ADDS	R4, #64
LDR	R2, [R4, #0]
BLX	R2
;tft_test_driver.c,323 :: 		return;
IT	AL
BAL	L_end_Process_TP_Press
;tft_test_driver.c,324 :: 		}
L_Process_TP_Press53:
;tft_test_driver.c,325 :: 		}
L_Process_TP_Press52:
;tft_test_driver.c,326 :: 		}
L_Process_TP_Press51:
;tft_test_driver.c,328 :: 		if (_object_count == box_order) {
MOVW	R2, #lo_addr(_box_order+0)
MOVT	R2, #hi_addr(_box_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Press54
;tft_test_driver.c,329 :: 		if (exec_box->Active != 0) {
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R2, [R2, #0]
ADDS	R2, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Press55
;tft_test_driver.c,330 :: 		if (exec_box->OnPressPtr != 0) {
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R4, [R4, #0]
ADDS	R4, #48
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Press56
;tft_test_driver.c,331 :: 		exec_box->OnPressPtr();
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R4, [R4, #0]
ADDS	R4, #48
LDR	R2, [R4, #0]
BLX	R2
;tft_test_driver.c,332 :: 		return;
IT	AL
BAL	L_end_Process_TP_Press
;tft_test_driver.c,333 :: 		}
L_Process_TP_Press56:
;tft_test_driver.c,334 :: 		}
L_Process_TP_Press55:
;tft_test_driver.c,335 :: 		}
L_Process_TP_Press54:
;tft_test_driver.c,337 :: 		}
L_Process_TP_Press50:
;tft_test_driver.c,338 :: 		}
L_end_Process_TP_Press:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Process_TP_Press
_Process_TP_Up:
;tft_test_driver.c,340 :: 		void Process_TP_Up(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
;tft_test_driver.c,342 :: 		switch (PressedObjectType) {
IT	AL
BAL	L_Process_TP_Up57
;tft_test_driver.c,344 :: 		case 0: {
L_Process_TP_Up59:
;tft_test_driver.c,345 :: 		if (PressedObject != 0) {
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
LDR	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Up60
;tft_test_driver.c,346 :: 		exec_button = (TButton*)PressedObject;
MOVW	R4, #lo_addr(_PressedObject+0)
MOVT	R4, #hi_addr(_PressedObject+0)
LDR	R3, [R4, #0]
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
STR	R3, [R2, #0]
;tft_test_driver.c,347 :: 		if ((exec_button->PressColEnabled != 0) && (exec_button->OwnerScreen == CurrentScreen)) {
MOV	R2, R4
LDR	R2, [R2, #0]
ADDS	R2, #48
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L__Process_TP_Up107
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R2, [R2, #0]
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
CMP	R3, R2
IT	NE
BNE	L__Process_TP_Up106
L__Process_TP_Up105:
;tft_test_driver.c,348 :: 		DrawButton(exec_button);
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R2, [R2, #0]
STRH	R1, [SP, #4]
STRH	R0, [SP, #8]
MOV	R0, R2
BL	_DrawButton+0
LDRH	R0, [SP, #8]
LDRH	R1, [SP, #4]
;tft_test_driver.c,347 :: 		if ((exec_button->PressColEnabled != 0) && (exec_button->OwnerScreen == CurrentScreen)) {
L__Process_TP_Up107:
L__Process_TP_Up106:
;tft_test_driver.c,350 :: 		break;
IT	AL
BAL	L_Process_TP_Up58
;tft_test_driver.c,351 :: 		}
L_Process_TP_Up60:
;tft_test_driver.c,352 :: 		break;
IT	AL
BAL	L_Process_TP_Up58
;tft_test_driver.c,355 :: 		case 6: {
L_Process_TP_Up64:
;tft_test_driver.c,356 :: 		if (PressedObject != 0) {
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
LDR	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Up65
;tft_test_driver.c,357 :: 		exec_box = (TBox*)PressedObject;
MOVW	R4, #lo_addr(_PressedObject+0)
MOVT	R4, #hi_addr(_PressedObject+0)
LDR	R3, [R4, #0]
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
STR	R3, [R2, #0]
;tft_test_driver.c,358 :: 		if ((exec_box->PressColEnabled != 0) && (exec_box->OwnerScreen == CurrentScreen)) {
MOV	R2, R4
LDR	R2, [R2, #0]
ADDS	R2, #30
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L__Process_TP_Up109
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R2, [R2, #0]
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
CMP	R3, R2
IT	NE
BNE	L__Process_TP_Up108
L__Process_TP_Up104:
;tft_test_driver.c,359 :: 		DrawBox(exec_box);
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R2, [R2, #0]
STRH	R1, [SP, #4]
STRH	R0, [SP, #8]
MOV	R0, R2
BL	_DrawBox+0
LDRH	R0, [SP, #8]
LDRH	R1, [SP, #4]
;tft_test_driver.c,358 :: 		if ((exec_box->PressColEnabled != 0) && (exec_box->OwnerScreen == CurrentScreen)) {
L__Process_TP_Up109:
L__Process_TP_Up108:
;tft_test_driver.c,361 :: 		break;
IT	AL
BAL	L_Process_TP_Up58
;tft_test_driver.c,362 :: 		}
L_Process_TP_Up65:
;tft_test_driver.c,363 :: 		break;
IT	AL
BAL	L_Process_TP_Up58
;tft_test_driver.c,365 :: 		}
L_Process_TP_Up57:
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
LDRSH	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Up59
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
LDRSH	R2, [R2, #0]
CMP	R2, #6
IT	EQ
BEQ	L_Process_TP_Up64
L_Process_TP_Up58:
;tft_test_driver.c,368 :: 		Get_Object(X, Y);
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
BL	_Get_Object+0
;tft_test_driver.c,371 :: 		if (_object_count != -1) {
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, #-1
IT	EQ
BEQ	L_Process_TP_Up69
;tft_test_driver.c,373 :: 		if (_object_count == button_order) {
MOVW	R2, #lo_addr(_button_order+0)
MOVT	R2, #hi_addr(_button_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Up70
;tft_test_driver.c,374 :: 		if (exec_button->Active != 0) {
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R2, [R2, #0]
ADDS	R2, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Up71
;tft_test_driver.c,375 :: 		if (exec_button->OnUpPtr != 0)
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R4, [R4, #0]
ADDS	R4, #52
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Up72
;tft_test_driver.c,376 :: 		exec_button->OnUpPtr();
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R4, [R4, #0]
ADDS	R4, #52
LDR	R2, [R4, #0]
BLX	R2
L_Process_TP_Up72:
;tft_test_driver.c,377 :: 		if (PressedObject == (void *)exec_button)
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
LDR	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Up73
;tft_test_driver.c,378 :: 		if (exec_button->OnClickPtr != 0)
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R4, [R4, #0]
ADDS	R4, #60
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Up74
;tft_test_driver.c,379 :: 		exec_button->OnClickPtr();
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R4, [R4, #0]
ADDS	R4, #60
LDR	R2, [R4, #0]
BLX	R2
L_Process_TP_Up74:
L_Process_TP_Up73:
;tft_test_driver.c,380 :: 		PressedObject = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
STR	R3, [R2, #0]
;tft_test_driver.c,381 :: 		PressedObjectType = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,382 :: 		return;
IT	AL
BAL	L_end_Process_TP_Up
;tft_test_driver.c,383 :: 		}
L_Process_TP_Up71:
;tft_test_driver.c,384 :: 		}
L_Process_TP_Up70:
;tft_test_driver.c,387 :: 		if (_object_count == box_order) {
MOVW	R2, #lo_addr(_box_order+0)
MOVT	R2, #hi_addr(_box_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Up75
;tft_test_driver.c,388 :: 		if (exec_box->Active != 0) {
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R2, [R2, #0]
ADDS	R2, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Up76
;tft_test_driver.c,389 :: 		if (exec_box->OnUpPtr != 0)
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R4, [R4, #0]
ADDS	R4, #36
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Up77
;tft_test_driver.c,390 :: 		exec_box->OnUpPtr();
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R4, [R4, #0]
ADDS	R4, #36
LDR	R2, [R4, #0]
BLX	R2
L_Process_TP_Up77:
;tft_test_driver.c,391 :: 		if (PressedObject == (void *)exec_box)
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
LDR	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Up78
;tft_test_driver.c,392 :: 		if (exec_box->OnClickPtr != 0)
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R4, [R4, #0]
ADDS	R4, #44
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Up79
;tft_test_driver.c,393 :: 		exec_box->OnClickPtr();
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R4, [R4, #0]
ADDS	R4, #44
LDR	R2, [R4, #0]
BLX	R2
L_Process_TP_Up79:
L_Process_TP_Up78:
;tft_test_driver.c,394 :: 		PressedObject = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
STR	R3, [R2, #0]
;tft_test_driver.c,395 :: 		PressedObjectType = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,396 :: 		return;
IT	AL
BAL	L_end_Process_TP_Up
;tft_test_driver.c,397 :: 		}
L_Process_TP_Up76:
;tft_test_driver.c,398 :: 		}
L_Process_TP_Up75:
;tft_test_driver.c,400 :: 		}
L_Process_TP_Up69:
;tft_test_driver.c,401 :: 		PressedObject = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
STR	R3, [R2, #0]
;tft_test_driver.c,402 :: 		PressedObjectType = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,403 :: 		}
L_end_Process_TP_Up:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _Process_TP_Up
_Process_TP_Down:
;tft_test_driver.c,405 :: 		void Process_TP_Down(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
;tft_test_driver.c,407 :: 		object_pressed      = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_object_pressed+0)
MOVT	R2, #hi_addr(_object_pressed+0)
STRB	R3, [R2, #0]
;tft_test_driver.c,408 :: 		exec_button         = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
STR	R3, [R2, #0]
;tft_test_driver.c,409 :: 		exec_box            = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
STR	R3, [R2, #0]
;tft_test_driver.c,411 :: 		Get_Object(X, Y);
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
BL	_Get_Object+0
;tft_test_driver.c,413 :: 		if (_object_count != -1) {
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, #-1
IT	EQ
BEQ	L_Process_TP_Down80
;tft_test_driver.c,414 :: 		if (_object_count == button_order) {
MOVW	R2, #lo_addr(_button_order+0)
MOVT	R2, #hi_addr(_button_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Down81
;tft_test_driver.c,415 :: 		if (exec_button->Active != 0) {
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R2, [R2, #0]
ADDS	R2, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Down82
;tft_test_driver.c,416 :: 		if (exec_button->PressColEnabled != 0) {
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R2, [R2, #0]
ADDS	R2, #48
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Down83
;tft_test_driver.c,417 :: 		object_pressed = 1;
MOVS	R3, #1
MOVW	R2, #lo_addr(_object_pressed+0)
MOVT	R2, #hi_addr(_object_pressed+0)
STRB	R3, [R2, #0]
;tft_test_driver.c,418 :: 		DrawButton(exec_button);
MOVW	R2, #lo_addr(_exec_button+0)
MOVT	R2, #hi_addr(_exec_button+0)
LDR	R2, [R2, #0]
MOV	R0, R2
BL	_DrawButton+0
;tft_test_driver.c,419 :: 		}
L_Process_TP_Down83:
;tft_test_driver.c,420 :: 		PressedObject = (void *)exec_button;
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R3, [R4, #0]
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
STR	R3, [R2, #0]
;tft_test_driver.c,421 :: 		PressedObjectType = 0;
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,422 :: 		if (exec_button->OnDownPtr != 0) {
LDR	R4, [R4, #0]
ADDS	R4, #56
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Down84
;tft_test_driver.c,423 :: 		exec_button->OnDownPtr();
MOVW	R4, #lo_addr(_exec_button+0)
MOVT	R4, #hi_addr(_exec_button+0)
LDR	R4, [R4, #0]
ADDS	R4, #56
LDR	R2, [R4, #0]
BLX	R2
;tft_test_driver.c,424 :: 		return;
IT	AL
BAL	L_end_Process_TP_Down
;tft_test_driver.c,425 :: 		}
L_Process_TP_Down84:
;tft_test_driver.c,426 :: 		}
L_Process_TP_Down82:
;tft_test_driver.c,427 :: 		}
L_Process_TP_Down81:
;tft_test_driver.c,429 :: 		if (_object_count == box_order) {
MOVW	R2, #lo_addr(_box_order+0)
MOVT	R2, #hi_addr(_box_order+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	NE
BNE	L_Process_TP_Down85
;tft_test_driver.c,430 :: 		if (exec_box->Active != 0) {
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R2, [R2, #0]
ADDS	R2, #19
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Down86
;tft_test_driver.c,431 :: 		if (exec_box->PressColEnabled != 0) {
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R2, [R2, #0]
ADDS	R2, #30
LDRB	R2, [R2, #0]
CMP	R2, #0
IT	EQ
BEQ	L_Process_TP_Down87
;tft_test_driver.c,432 :: 		object_pressed = 1;
MOVS	R3, #1
MOVW	R2, #lo_addr(_object_pressed+0)
MOVT	R2, #hi_addr(_object_pressed+0)
STRB	R3, [R2, #0]
;tft_test_driver.c,433 :: 		DrawBox(exec_box);
MOVW	R2, #lo_addr(_exec_box+0)
MOVT	R2, #hi_addr(_exec_box+0)
LDR	R2, [R2, #0]
MOV	R0, R2
BL	_DrawBox+0
;tft_test_driver.c,434 :: 		}
L_Process_TP_Down87:
;tft_test_driver.c,435 :: 		PressedObject = (void *)exec_box;
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R3, [R4, #0]
MOVW	R2, #lo_addr(_PressedObject+0)
MOVT	R2, #hi_addr(_PressedObject+0)
STR	R3, [R2, #0]
;tft_test_driver.c,436 :: 		PressedObjectType = 6;
MOVS	R3, #6
SXTH	R3, R3
MOVW	R2, #lo_addr(_PressedObjectType+0)
MOVT	R2, #hi_addr(_PressedObjectType+0)
STRH	R3, [R2, #0]
;tft_test_driver.c,437 :: 		if (exec_box->OnDownPtr != 0) {
LDR	R4, [R4, #0]
ADDS	R4, #40
LDR	R4, [R4, #0]
CMP	R4, #0
IT	EQ
BEQ	L_Process_TP_Down88
;tft_test_driver.c,438 :: 		exec_box->OnDownPtr();
MOVW	R4, #lo_addr(_exec_box+0)
MOVT	R4, #hi_addr(_exec_box+0)
LDR	R4, [R4, #0]
ADDS	R4, #40
LDR	R2, [R4, #0]
BLX	R2
;tft_test_driver.c,439 :: 		return;
IT	AL
BAL	L_end_Process_TP_Down
;tft_test_driver.c,440 :: 		}
L_Process_TP_Down88:
;tft_test_driver.c,441 :: 		}
L_Process_TP_Down86:
;tft_test_driver.c,442 :: 		}
L_Process_TP_Down85:
;tft_test_driver.c,444 :: 		}
L_Process_TP_Down80:
;tft_test_driver.c,445 :: 		}
L_end_Process_TP_Down:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Process_TP_Down
_Check_TP:
;tft_test_driver.c,447 :: 		void Check_TP() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tft_test_driver.c,448 :: 		if (TP_TFT_Press_Detect()) {
BL	_TP_TFT_Press_Detect+0
CMP	R0, #0
IT	EQ
BEQ	L_Check_TP89
;tft_test_driver.c,449 :: 		if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
MOVW	R1, #lo_addr(_Ycoord+0)
MOVT	R1, #hi_addr(_Ycoord+0)
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
BL	_TP_TFT_Get_Coordinates+0
CMP	R0, #0
IT	NE
BNE	L_Check_TP90
;tft_test_driver.c,451 :: 		Process_TP_Press(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Press+0
;tft_test_driver.c,452 :: 		if (PenDown == 0) {
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_Check_TP91
;tft_test_driver.c,453 :: 		PenDown = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;tft_test_driver.c,454 :: 		Process_TP_Down(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Down+0
;tft_test_driver.c,455 :: 		}
L_Check_TP91:
;tft_test_driver.c,456 :: 		}
L_Check_TP90:
;tft_test_driver.c,457 :: 		}
IT	AL
BAL	L_Check_TP92
L_Check_TP89:
;tft_test_driver.c,458 :: 		else if (PenDown == 1) {
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_Check_TP93
;tft_test_driver.c,459 :: 		PenDown = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_PenDown+0)
MOVT	R0, #hi_addr(_PenDown+0)
STRB	R1, [R0, #0]
;tft_test_driver.c,460 :: 		Process_TP_Up(Xcoord, Ycoord);
MOVW	R0, #lo_addr(_Ycoord+0)
MOVT	R0, #hi_addr(_Ycoord+0)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Xcoord+0)
MOVT	R0, #hi_addr(_Xcoord+0)
LDRH	R0, [R0, #0]
BL	_Process_TP_Up+0
;tft_test_driver.c,461 :: 		}
L_Check_TP93:
L_Check_TP92:
;tft_test_driver.c,462 :: 		}
L_end_Check_TP:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Check_TP
_Init_MCU:
;tft_test_driver.c,464 :: 		void Init_MCU() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tft_test_driver.c,465 :: 		GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_9);
MOVW	R1, #512
MOVW	R0, #lo_addr(GPIOE_BASE+0)
MOVT	R0, #hi_addr(GPIOE_BASE+0)
BL	_GPIO_Digital_Output+0
;tft_test_driver.c,466 :: 		TFT_BLED = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
_SX	[R0, ByteOffset(GPIOE_ODR+0)]
;tft_test_driver.c,467 :: 		TFT_Set_Default_Mode();
BL	_TFT_Set_Default_Mode+0
;tft_test_driver.c,468 :: 		TP_TFT_Set_Default_Mode();
BL	_TP_TFT_Set_Default_Mode+0
;tft_test_driver.c,469 :: 		}
L_end_Init_MCU:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_MCU
_Start_TP:
;tft_test_driver.c,471 :: 		void Start_TP() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;tft_test_driver.c,472 :: 		Init_MCU();
BL	_Init_MCU+0
;tft_test_driver.c,474 :: 		InitializeTouchPanel();
BL	tft_test_driver_InitializeTouchPanel+0
;tft_test_driver.c,476 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_Start_TP94:
SUBS	R7, R7, #1
BNE	L_Start_TP94
NOP
NOP
NOP
;tft_test_driver.c,477 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;tft_test_driver.c,478 :: 		Calibrate();
BL	_Calibrate+0
;tft_test_driver.c,479 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;tft_test_driver.c,481 :: 		InitializeObjects();
BL	tft_test_driver_InitializeObjects+0
;tft_test_driver.c,482 :: 		display_width = Screen1.Width;
MOVW	R0, #lo_addr(_Screen1+2)
MOVT	R0, #hi_addr(_Screen1+2)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_width+0)
MOVT	R0, #hi_addr(_display_width+0)
STRH	R1, [R0, #0]
;tft_test_driver.c,483 :: 		display_height = Screen1.Height;
MOVW	R0, #lo_addr(_Screen1+4)
MOVT	R0, #hi_addr(_Screen1+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_height+0)
MOVT	R0, #hi_addr(_display_height+0)
STRH	R1, [R0, #0]
;tft_test_driver.c,484 :: 		DrawScreen(&Screen1);
MOVW	R0, #lo_addr(_Screen1+0)
MOVT	R0, #hi_addr(_Screen1+0)
BL	_DrawScreen+0
;tft_test_driver.c,485 :: 		}
L_end_Start_TP:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Start_TP
tft_test_driver____?ag:
L_end_tft_test_driver___?ag:
BX	LR
; end of tft_test_driver____?ag
