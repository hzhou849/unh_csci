_update_PD_LED:
;P3_LED_manip.c,48 :: 		void update_PD_LED(uint16_t *target_count) {
; target_count start address is: 0 (R0)
SUB	SP, SP, #4
; target_count end address is: 0 (R0)
; target_count start address is: 0 (R0)
;P3_LED_manip.c,49 :: 		GPIOD_ODR = (*target_count & 0x000FFFF);  // GPIOD_ODR is 32bit, must pad target_count it will be promoted to uint32
LDRH	R2, [R0, #0]
; target_count end address is: 0 (R0)
MOVW	R1, #65535
ANDS	R2, R1
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,50 :: 		}
L_end_update_PD_LED:
ADD	SP, SP, #4
BX	LR
; end of _update_PD_LED
_PC_btn_check:
;P3_LED_manip.c,53 :: 		void PC_btn_check(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_manip.c,54 :: 		if (GPIOC_IDR.B0 == 1)
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check0
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,56 :: 		while (GPIOC_IDR.B0 == 1)
L_PC_btn_check1:
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check2
;P3_LED_manip.c,58 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_PC_btn_check3:
SUBS	R7, R7, #1
BNE	L_PC_btn_check3
NOP
NOP
NOP
;P3_LED_manip.c,59 :: 		}
IT	AL
BAL	L_PC_btn_check1
L_PC_btn_check2:
;P3_LED_manip.c,62 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check5
;P3_LED_manip.c,63 :: 		GPIOE_ODR = PD_HIGH_NUM << 8;
MOVW	R2, #512
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,64 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,65 :: 		}
IT	AL
BAL	L_PC_btn_check6
L_PC_btn_check5:
;P3_LED_manip.c,67 :: 		GPIOE_ODR = PD_LOW_NUM  << 8;
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,68 :: 		*PE_display_mode = PE_MODE_LOW;
MOVS	R1, #0
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,69 :: 		}
L_PC_btn_check6:
;P3_LED_manip.c,70 :: 		}
L_PC_btn_check0:
;P3_LED_manip.c,71 :: 		}
L_end_PC_btn_check:
ADD	SP, SP, #4
BX	LR
; end of _PC_btn_check
_get_PE_display_data:
;P3_LED_manip.c,74 :: 		void get_PE_display_data(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_manip.c,76 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_get_PE_display_data7
;P3_LED_manip.c,77 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,78 :: 		}
IT	AL
BAL	L_get_PE_display_data8
L_get_PE_display_data7:
;P3_LED_manip.c,80 :: 		*PE_display_mode = PE_MODE_LOW;
; PE_display_mode start address is: 0 (R0)
MOVS	R1, #0
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,81 :: 		}
L_get_PE_display_data8:
;P3_LED_manip.c,82 :: 		}
L_end_get_PE_display_data:
ADD	SP, SP, #4
BX	LR
; end of _get_PE_display_data
_main:
;P3_LED_manip.c,86 :: 		void main() {
SUB	SP, SP, #8
;P3_LED_manip.c,88 :: 		uint32_t i               = 0;
;P3_LED_manip.c,89 :: 		uint32_t time_ms         = 1000;             // Default 1000ms; 1second
;P3_LED_manip.c,90 :: 		uint16_t combined_num    = 0;
;P3_LED_manip.c,91 :: 		uint16_t target_count    = PD_LOW_NUM;       // Set the lower bound number
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
STRH	R0, [SP, #4]
;P3_LED_manip.c,92 :: 		uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
; count_mode start address is: 16 (R4)
MOVS	R4, #1
;P3_LED_manip.c,97 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
MOVW	R3, #lo_addr(_PD_LOW_NUM+0)
MOVT	R3, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R3, #0]
AND	R0, R0, #255
UXTB	R0, R0
ORR	R2, R0, #512
UXTH	R2, R2
; combined_num start address is: 20 (R5)
UXTH	R5, R2
;P3_LED_manip.c,137 :: 		RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - PORT C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,138 :: 		RCC_APB2ENR |= 1 << 5; // Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,139 :: 		RCC_APB2ENR |= 1 << 6; // Enable GPIO Clock - Port E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,144 :: 		GPIOC_CRL = GPIO_DIR_INPUT;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,147 :: 		GPIOD_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,148 :: 		GPIOD_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,151 :: 		GPIOE_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,152 :: 		GPIOE_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,156 :: 		GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
MOVW	R0, #65535
AND	R1, R2, R0, LSL #0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,157 :: 		GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF);
MOV	R0, R3
LDRB	R1, [R0, #0]
MOVW	R0, #65535
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,160 :: 		Delay_ms(100);
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main9:
SUBS	R7, R7, #1
BNE	L_main9
NOP
NOP
NOP
; combined_num end address is: 20 (R5)
; count_mode end address is: 16 (R4)
UXTB	R2, R4
UXTH	R3, R5
;P3_LED_manip.c,165 :: 		for (;;) {
L_main11:
;P3_LED_manip.c,170 :: 		if (target_count == combined_num) {
; combined_num start address is: 12 (R3)
; count_mode start address is: 8 (R2)
LDRH	R0, [SP, #4]
CMP	R0, R3
IT	NE
BNE	L_main14
; count_mode end address is: 8 (R2)
;P3_LED_manip.c,171 :: 		count_mode = DECREMENT_MODE;
; count_mode start address is: 16 (R4)
MOVS	R4, #0
;P3_LED_manip.c,172 :: 		}
; count_mode end address is: 16 (R4)
IT	AL
BAL	L_main15
L_main14:
;P3_LED_manip.c,173 :: 		else if (target_count == PD_LOW_NUM) {
; count_mode start address is: 8 (R2)
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L__main20
; count_mode end address is: 8 (R2)
;P3_LED_manip.c,174 :: 		count_mode = INCREMENT_MODE;
; count_mode start address is: 0 (R0)
MOVS	R0, #1
; count_mode end address is: 0 (R0)
UXTB	R4, R0
;P3_LED_manip.c,175 :: 		}
IT	AL
BAL	L_main16
L__main20:
;P3_LED_manip.c,173 :: 		else if (target_count == PD_LOW_NUM) {
UXTB	R4, R2
;P3_LED_manip.c,175 :: 		}
L_main16:
; count_mode start address is: 16 (R4)
; count_mode end address is: 16 (R4)
L_main15:
;P3_LED_manip.c,178 :: 		if (count_mode == INCREMENT_MODE) {
; count_mode start address is: 16 (R4)
CMP	R4, #1
IT	NE
BNE	L_main17
;P3_LED_manip.c,179 :: 		++target_count;
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,180 :: 		} else{
IT	AL
BAL	L_main18
L_main17:
;P3_LED_manip.c,181 :: 		--target_count;
LDRH	R0, [SP, #4]
SUBS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,182 :: 		}
L_main18:
;P3_LED_manip.c,185 :: 		update_PD_LED(&target_count);
ADD	R0, SP, #4
BL	_update_PD_LED+0
;P3_LED_manip.c,198 :: 		MOVW R7, #0x8D7F // half 1 second 6mill approx.
STRB	R4, [SP, #0]
MOVW	R7, #36223
;P3_LED_manip.c,199 :: 		MOVT R7, #0x5E
MOVT	R7, #94
;P3_LED_manip.c,202 :: 		MOVW R0, #LO_ADDR(GPIOC_IDR+0)
MOVW	R0, #lo_addr(GPIOC_IDR+0)
;P3_LED_manip.c,203 :: 		MOVT R0, #HI_ADDR(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
;P3_LED_manip.c,204 :: 		MOVW R2, #LO_ADDR(GPIOE_ODR+0)
MOVW	R2, #lo_addr(GPIOE_ODR+0)
;P3_LED_manip.c,205 :: 		MOVT R2, #HI_ADDR(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
;P3_LED_manip.c,206 :: 		MOVW R4, #LO_ADDR(_PE_display_mode+0)
MOVW	R4, #lo_addr(_PE_display_mode+0)
;P3_LED_manip.c,207 :: 		MOVT R4, #HI_ADDR(_PE_display_mode+0)
MOVT	R4, #hi_addr(_PE_display_mode+0)
;P3_LED_manip.c,208 :: 		MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
MOVW	R8, #lo_addr(_PD_LOW_NUM+0)
;P3_LED_manip.c,209 :: 		MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)
MOVT	R8, #hi_addr(_PD_LOW_NUM+0)
;P3_LED_manip.c,214 :: 		_DELAY_LOOP:
_DELAY_LOOP:
;P3_LED_manip.c,215 :: 		SUBS R7, R7, #1
SUBS	R7, R7, #1
;P3_LED_manip.c,216 :: 		BEQ _EXIT_TIME_LOOP
BEQ	_EXIT_TIME_LOOP
;P3_LED_manip.c,218 :: 		LDR R1, [R0]        // GPIOC_IDR value
LDR	R1, [R0, #0]
;P3_LED_manip.c,219 :: 		AND R6, R1, #0x00000001     // Extract PC0
AND	R6, R1, #1
;P3_LED_manip.c,220 :: 		CMP R6, #1                  // Check if PC0 is pressed '1'
CMP	R6, #1
;P3_LED_manip.c,221 :: 		BEQ _PC0_PRESSED            // Branch to PC0 Pressed if 1, otherwise do nothing
BEQ	_PC0_PRESSED
;P3_LED_manip.c,222 :: 		BNE _PC0_NOT_PRESSED        // Branch to Fake operation to alingn cpu tick counting
BNE	_PC0_NOT_PRESSED
;P3_LED_manip.c,224 :: 		_PC0_PRESSED:
_PC0_PRESSED:
;P3_LED_manip.c,225 :: 		LDR R5, [R4]        // PE_display_mode value
LDR	R5, [R4, #0]
;P3_LED_manip.c,226 :: 		CMP R5, #1
CMP	R5, #1
;P3_LED_manip.c,227 :: 		BEQ _SET_PE_LOW
BEQ	_SET_PE_LOW
;P3_LED_manip.c,228 :: 		BNE _SET_PE_HI
BNE	_SET_PE_HI
;P3_LED_manip.c,234 :: 		_PC0_NOT_PRESSED:
_PC0_NOT_PRESSED:
;P3_LED_manip.c,235 :: 		MOV R8, #0
MOV	R8, #0
;P3_LED_manip.c,236 :: 		B _DELAY_LOOP
B	_DELAY_LOOP
;P3_LED_manip.c,238 :: 		_SET_PE_LOW:
_SET_PE_LOW:
;P3_LED_manip.c,240 :: 		MOVW R8, #0x3333
MOVW	R8, #13107
;P3_LED_manip.c,241 :: 		STR R8, [R2]
STR	R8, [R2, #0]
;P3_LED_manip.c,242 :: 		MOV R9, #0x00000000
MOV	R9, #0
;P3_LED_manip.c,243 :: 		STR R9, [R4]        // update display mode
STR	R9, [R4, #0]
;P3_LED_manip.c,244 :: 		B _DELAY_LOOP
B	_DELAY_LOOP
;P3_LED_manip.c,246 :: 		_SET_PE_HI:
_SET_PE_HI:
;P3_LED_manip.c,247 :: 		MOVW R8, #0xFFFF
MOVW	R8, #65535
;P3_LED_manip.c,248 :: 		STR R8, [R2]  // Updates PE light
STR	R8, [R2, #0]
;P3_LED_manip.c,249 :: 		MOV R9, #0x00000001               // need to update pE mode now
MOV	R9, #1
;P3_LED_manip.c,250 :: 		STR R9, [R4]
STR	R9, [R4, #0]
;P3_LED_manip.c,251 :: 		B _DELAY_LOOP
B	_DELAY_LOOP
;P3_LED_manip.c,253 :: 		_EXIT_TIME_LOOP:
_EXIT_TIME_LOOP:
;P3_LED_manip.c,254 :: 		NOP
NOP
;P3_LED_manip.c,198 :: 		MOVW R7, #0x8D7F // half 1 second 6mill approx.
LDRB	R4, [SP, #0]
;P3_LED_manip.c,272 :: 		}
UXTB	R2, R4
; combined_num end address is: 12 (R3)
; count_mode end address is: 16 (R4)
IT	AL
BAL	L_main11
;P3_LED_manip.c,276 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
