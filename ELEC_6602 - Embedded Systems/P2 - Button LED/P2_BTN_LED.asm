_update_btn_count:
;P2_BTN_LED.c,28 :: 		void update_btn_count(uint16_t *PA_btn_count)
; PA_btn_count start address is: 0 (R0)
SUB	SP, SP, #4
; PA_btn_count end address is: 0 (R0)
; PA_btn_count start address is: 0 (R0)
;P2_BTN_LED.c,30 :: 		++*PA_btn_count;
LDRH	R1, [R0, #0]
ADDS	R1, R1, #1
STRH	R1, [R0, #0]
;P2_BTN_LED.c,31 :: 		GPIOE_ODR = (*PA_btn_count) << 8;   // GPIOE_ODR operates at 0xFF00;
LDRH	R1, [R0, #0]
; PA_btn_count end address is: 0 (R0)
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P2_BTN_LED.c,32 :: 		}
L_end_update_btn_count:
ADD	SP, SP, #4
BX	LR
; end of _update_btn_count
_btn_manager_ON:
;P2_BTN_LED.c,35 :: 		void btn_manager_ON(uint32_t *gpio_mask, uint16_t *cur_off_state, uint16_t *led_state, uint16_t *PA_btn_count) {
; PA_btn_count start address is: 12 (R3)
; led_state start address is: 8 (R2)
; cur_off_state start address is: 4 (R1)
; gpio_mask start address is: 0 (R0)
SUB	SP, SP, #4
; PA_btn_count end address is: 12 (R3)
; led_state end address is: 8 (R2)
; cur_off_state end address is: 4 (R1)
; gpio_mask end address is: 0 (R0)
; gpio_mask start address is: 0 (R0)
; cur_off_state start address is: 4 (R1)
; led_state start address is: 8 (R2)
; PA_btn_count start address is: 12 (R3)
;P2_BTN_LED.c,37 :: 		uint32_t PA_low_state = *gpio_mask & 0x00FF;
LDR	R4, [R0, #0]
; gpio_mask end address is: 0 (R0)
AND	R4, R4, #255
; PA_low_state start address is: 0 (R0)
MOV	R0, R4
;P2_BTN_LED.c,38 :: 		if ( (PA_low_state >> 5 ) & 1 == 1 ) {
LSRS	R4, R4, #5
AND	R4, R4, #1
CMP	R4, #0
IT	EQ
BEQ	L_btn_manager_ON0
;P2_BTN_LED.c,39 :: 		*led_state = (++*led_state) % 3 ;
LDRH	R4, [R2, #0]
ADDS	R4, R4, #1
STRH	R4, [R2, #0]
LDRH	R6, [R2, #0]
MOVS	R5, #3
UDIV	R4, R6, R5
MLS	R4, R5, R4, R6
STRH	R4, [R2, #0]
;P2_BTN_LED.c,40 :: 		*PA_btn_count = 0;
MOVS	R4, #0
STRH	R4, [R3, #0]
; PA_btn_count end address is: 12 (R3)
;P2_BTN_LED.c,41 :: 		GPIOD_ODR = PA0_led_pattern[*led_state]; // Change the state on PA5 press
LDRH	R4, [R2, #0]
LSLS	R5, R4, #1
MOVW	R4, #lo_addr(P2_BTN_LED_PA0_led_pattern+0)
MOVT	R4, #hi_addr(P2_BTN_LED_PA0_led_pattern+0)
ADDS	R4, R4, R5
LDRH	R5, [R4, #0]
MOVW	R4, #lo_addr(GPIOD_ODR+0)
MOVT	R4, #hi_addr(GPIOD_ODR+0)
STR	R5, [R4, #0]
;P2_BTN_LED.c,42 :: 		*cur_off_state = ~(PA0_led_pattern[*led_state]); // Update the off state on PA5 press too.
LDRH	R4, [R2, #0]
LSLS	R5, R4, #1
MOVW	R4, #lo_addr(P2_BTN_LED_PA0_led_pattern+0)
MOVT	R4, #hi_addr(P2_BTN_LED_PA0_led_pattern+0)
ADDS	R4, R4, R5
LDRH	R4, [R4, #0]
MVN	R4, R4
STRH	R4, [R1, #0]
;P2_BTN_LED.c,43 :: 		}
L_btn_manager_ON0:
;P2_BTN_LED.c,45 :: 		if ( (PA_low_state & 1 ) == 1 ) {
AND	R4, R0, #1
CMP	R4, #1
IT	NE
BNE	L_btn_manager_ON1
;P2_BTN_LED.c,46 :: 		GPIOD_ODR = PA0_led_pattern[*led_state];
LDRH	R4, [R2, #0]
LSLS	R5, R4, #1
MOVW	R4, #lo_addr(P2_BTN_LED_PA0_led_pattern+0)
MOVT	R4, #hi_addr(P2_BTN_LED_PA0_led_pattern+0)
ADDS	R4, R4, R5
LDRH	R5, [R4, #0]
MOVW	R4, #lo_addr(GPIOD_ODR+0)
MOVT	R4, #hi_addr(GPIOD_ODR+0)
STR	R5, [R4, #0]
;P2_BTN_LED.c,47 :: 		*cur_off_state = ~(PA0_led_pattern[*led_state]);                // Flipped LED mode
LDRH	R4, [R2, #0]
; led_state end address is: 8 (R2)
LSLS	R5, R4, #1
MOVW	R4, #lo_addr(P2_BTN_LED_PA0_led_pattern+0)
MOVT	R4, #hi_addr(P2_BTN_LED_PA0_led_pattern+0)
ADDS	R4, R4, R5
LDRH	R4, [R4, #0]
MVN	R4, R4
STRH	R4, [R1, #0]
;P2_BTN_LED.c,50 :: 		}
L_btn_manager_ON1:
;P2_BTN_LED.c,52 :: 		if ( (PA_low_state >> 4) & 1 == 1 ) {
LSRS	R4, R0, #4
; PA_low_state end address is: 0 (R0)
AND	R4, R4, #1
CMP	R4, #0
IT	EQ
BEQ	L_btn_manager_ON2
;P2_BTN_LED.c,58 :: 		GPIOD_ODR = 0xFFFF;
MOVW	R5, #65535
MOVW	R4, #lo_addr(GPIOD_ODR+0)
MOVT	R4, #hi_addr(GPIOD_ODR+0)
STR	R5, [R4, #0]
;P2_BTN_LED.c,59 :: 		*cur_off_state = 0x0000;
MOVS	R4, #0
STRH	R4, [R1, #0]
; cur_off_state end address is: 4 (R1)
;P2_BTN_LED.c,60 :: 		}
L_btn_manager_ON2:
;P2_BTN_LED.c,61 :: 		}
L_end_btn_manager_ON:
ADD	SP, SP, #4
BX	LR
; end of _btn_manager_ON
_main:
;P2_BTN_LED.c,64 :: 		void main() {
SUB	SP, SP, #16
;P2_BTN_LED.c,166 :: 		uint16_t led_state      = 0;
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICSmain_led_state_L0+0)
MOVT	R12, #hi_addr(?ICSmain_led_state_L0+0)
BL	___CC2DW+0
;P2_BTN_LED.c,167 :: 		uint16_t PA_btn_count   = 0;
;P2_BTN_LED.c,168 :: 		uint16_t cur_off_state  = 0;
;P2_BTN_LED.c,169 :: 		uint32_t pin_mask       = 0;
;P2_BTN_LED.c,176 :: 		RCC_APB2ENR |= 1 << 6;  // Enable GPIO Clock - Port E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,177 :: 		RCC_APB2ENR |= 1 << 5;  // Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,178 :: 		RCC_APB2ENR |= 1 << 2;  // Enable GPIO Clock - Port A
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,183 :: 		GPIOA_CRL = 0x44444444;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,188 :: 		GPIOD_CRL = 0x33333333;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,189 :: 		GPIOD_CRH = 0x33333333;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,190 :: 		GPIOE_CRH = 0x33333333;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,194 :: 		GPIOD_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,195 :: 		GPIOE_ODR = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P2_BTN_LED.c,199 :: 		for (;;) {
L_main3:
;P2_BTN_LED.c,201 :: 		while (GPIOA_IDR.B0 != 1 && GPIOA_IDR.B4 !=1 && GPIOA_IDR.B5 != 1) {     // Wait until the first P0 is pressed
L_main6:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main28
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main27
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main26
L__main25:
;P2_BTN_LED.c,202 :: 		if (GPIOD_ODR != cur_off_state)
LDRH	R1, [SP, #8]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
CMP	R0, R1
IT	EQ
BEQ	L_main10
;P2_BTN_LED.c,203 :: 		GPIOD_ODR = cur_off_state;
LDRH	R1, [SP, #8]
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
L_main10:
;P2_BTN_LED.c,204 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main11:
SUBS	R7, R7, #1
BNE	L_main11
NOP
NOP
NOP
;P2_BTN_LED.c,205 :: 		}
IT	AL
BAL	L_main6
;P2_BTN_LED.c,201 :: 		while (GPIOA_IDR.B0 != 1 && GPIOA_IDR.B4 !=1 && GPIOA_IDR.B5 != 1) {     // Wait until the first P0 is pressed
L__main28:
L__main27:
L__main26:
;P2_BTN_LED.c,208 :: 		if (GPIOA_IDR.B5 != 1 && GPIOA_IDR.B4 != 1 )
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main30
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main29
L__main24:
;P2_BTN_LED.c,209 :: 		update_btn_count(&PA_btn_count);
ADD	R0, SP, #6
BL	_update_btn_count+0
;P2_BTN_LED.c,208 :: 		if (GPIOA_IDR.B5 != 1 && GPIOA_IDR.B4 != 1 )
L__main30:
L__main29:
;P2_BTN_LED.c,211 :: 		if ( (PA_btn_count % 15 ) == 0)
LDRH	R2, [SP, #6]
MOVS	R1, #15
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
UXTH	R0, R0
CMP	R0, #0
IT	NE
BNE	L_main16
;P2_BTN_LED.c,212 :: 		led_state = (++led_state) % 3 ;
LDRH	R0, [SP, #4]
ADDS	R2, R0, #1
UXTH	R2, R2
STRH	R2, [SP, #4]
MOVS	R1, #3
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
STRH	R0, [SP, #4]
L_main16:
;P2_BTN_LED.c,214 :: 		pin_mask = GPIOA_IDR;
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
LDR	R0, [R0, #0]
STR	R0, [SP, #12]
;P2_BTN_LED.c,215 :: 		btn_manager_ON(&pin_mask, &cur_off_state, &led_state, &PA_btn_count);
ADD	R3, SP, #6
ADD	R2, SP, #4
ADD	R1, SP, #8
ADD	R0, SP, #12
BL	_btn_manager_ON+0
;P2_BTN_LED.c,218 :: 		while (GPIOA_IDR.B0 != 0 || GPIOA_IDR.B4 !=0 || GPIOA_IDR.B5 !=0) {    // Delay loop why button is pressed
L_main17:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main33
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main32
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	NE
BNE	L__main31
IT	AL
BAL	L_main18
L__main33:
L__main32:
L__main31:
;P2_BTN_LED.c,219 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main21:
SUBS	R7, R7, #1
BNE	L_main21
NOP
NOP
NOP
;P2_BTN_LED.c,220 :: 		}
IT	AL
BAL	L_main17
L_main18:
;P2_BTN_LED.c,221 :: 		}
IT	AL
BAL	L_main3
;P2_BTN_LED.c,223 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
