_main:
;P3_LED_manip.c,24 :: 		void main() {
;P3_LED_manip.c,27 :: 		L_main0:
L_main0:
;P3_LED_manip.c,30 :: 		MOVW R7, #6911  //0x1AFF
MOVW	R7, #6911
;P3_LED_manip.c,31 :: 		MOVT R7, #189  // 0x00BD
MOVT	R7, #189
;P3_LED_manip.c,32 :: 		SUBS R7, R7, #1
SUBS	R7, R7, #1
;P3_LED_manip.c,33 :: 		BNE L_main0
BNE	L_main0
;P3_LED_manip.c,37 :: 		Delay_ms(1000);     // 1 Second delay
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main1:
SUBS	R7, R7, #1
BNE	L_main1
NOP
NOP
NOP
;P3_LED_manip.c,38 :: 		Delay_ms(2000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main3:
SUBS	R7, R7, #1
BNE	L_main3
NOP
NOP
NOP
;P3_LED_manip.c,39 :: 		Delay_us(1000000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main5:
SUBS	R7, R7, #1
BNE	L_main5
NOP
NOP
NOP
;P3_LED_manip.c,40 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
