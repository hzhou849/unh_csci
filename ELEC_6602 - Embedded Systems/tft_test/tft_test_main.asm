_main:
;tft_test_main.c,19 :: 		void main() {
;tft_test_main.c,21 :: 		Start_TP();
BL	_Start_TP+0
;tft_test_main.c,23 :: 		while (1) {
L_main0:
;tft_test_main.c,24 :: 		Check_TP();
BL	_Check_TP+0
;tft_test_main.c,25 :: 		}
IT	AL
BAL	L_main0
;tft_test_main.c,26 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
