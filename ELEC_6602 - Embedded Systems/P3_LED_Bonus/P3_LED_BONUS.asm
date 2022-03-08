_update_PD_LED:
;P3_LED_BONUS.c,47 :: 		void update_PD_LED(uint16_t *target_count) {
; target_count start address is: 0 (R0)
SUB	SP, SP, #4
; target_count end address is: 0 (R0)
; target_count start address is: 0 (R0)
;P3_LED_BONUS.c,48 :: 		GPIOD_ODR = (*target_count & 0x000000FF);  // GPIOD_ODR is 32bit, must pad target_count it will be promoted to uint32
LDRH	R1, [R0, #0]
; target_count end address is: 0 (R0)
AND	R2, R1, #255
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;P3_LED_BONUS.c,49 :: 		}
L_end_update_PD_LED:
ADD	SP, SP, #4
BX	LR
; end of _update_PD_LED
_PC_btn_check:
;P3_LED_BONUS.c,52 :: 		void PC_btn_check(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_BONUS.c,54 :: 		if (GPIOC_IDR.B0 == 1) {
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check0
; PE_display_mode end address is: 0 (R0)
;P3_LED_BONUS.c,56 :: 		while (GPIOC_IDR.B0 == 1) {
L_PC_btn_check1:
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check2
;P3_LED_BONUS.c,57 :: 		Delay_ms(1);
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
;P3_LED_BONUS.c,58 :: 		}
IT	AL
BAL	L_PC_btn_check1
L_PC_btn_check2:
;P3_LED_BONUS.c,60 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check5
;P3_LED_BONUS.c,61 :: 		GPIOE_ODR = PD_HIGH_NUM << 8;
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_BONUS.c,62 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_BONUS.c,63 :: 		}
IT	AL
BAL	L_PC_btn_check6
L_PC_btn_check5:
;P3_LED_BONUS.c,65 :: 		GPIOE_ODR = PD_LOW_NUM  << 8;
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_BONUS.c,66 :: 		*PE_display_mode = PE_MODE_LOW;
MOVS	R1, #0
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_BONUS.c,67 :: 		}
L_PC_btn_check6:
;P3_LED_BONUS.c,68 :: 		}
L_PC_btn_check0:
;P3_LED_BONUS.c,69 :: 		}
L_end_PC_btn_check:
ADD	SP, SP, #4
BX	LR
; end of _PC_btn_check
_main:
;P3_LED_BONUS.c,72 :: 		void main() {
SUB	SP, SP, #8
;P3_LED_BONUS.c,74 :: 		uint16_t combined_num    = 0;
;P3_LED_BONUS.c,75 :: 		uint16_t target_count    = 0;       // Set the lower bound number
MOVW	R0, #0
STRH	R0, [SP, #4]
;P3_LED_BONUS.c,76 :: 		uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
; count_mode start address is: 12 (R3)
MOVS	R3, #1
;P3_LED_BONUS.c,77 :: 		uint8_t  temp_num        = 0;
;P3_LED_BONUS.c,78 :: 		uint32_t PA0_led_counter = 0;
;P3_LED_BONUS.c,79 :: 		uint32_t i               = 0;
;P3_LED_BONUS.c,83 :: 		RCC_APB2ENR |= 1 << 2; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,84 :: 		RCC_APB2ENR |= 1 << 3; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,85 :: 		RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - Port C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,86 :: 		RCC_APB2ENR |= 1 << 5; // Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,87 :: 		RCC_APB2ENR |= 1 << 6; // Enable GPIO Clock - Port E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,92 :: 		GPIOA_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,95 :: 		GPIOB_CRL = GPIO_DIR_INPUT;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,98 :: 		GPIOC_CRL = GPIO_DIR_INPUT;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,101 :: 		GPIOD_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,102 :: 		GPIOD_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,105 :: 		GPIOE_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,106 :: 		GPIOE_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,110 :: 		if (PD_LOW_NUM > PD_HIGH_NUM) {
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	LS
BLS	L_main7
;P3_LED_BONUS.c,111 :: 		temp_num = PD_LOW_NUM; // Store the 'higher" number
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
; temp_num start address is: 16 (R4)
LDRB	R4, [R2, #0]
;P3_LED_BONUS.c,112 :: 		PD_LOW_NUM = PD_HIGH_NUM;
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R0, [R1, #0]
STRB	R0, [R2, #0]
;P3_LED_BONUS.c,113 :: 		PD_HIGH_NUM = temp_num;
STRB	R4, [R1, #0]
; temp_num end address is: 16 (R4)
;P3_LED_BONUS.c,114 :: 		}
IT	AL
BAL	L_main8
L_main7:
;P3_LED_BONUS.c,115 :: 		else if (PD_LOW_NUM == PD_HIGH_NUM) {
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	NE
BNE	L_main9
; count_mode end address is: 12 (R3)
;P3_LED_BONUS.c,118 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
AND	R1, R0, #255
UXTB	R1, R1
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #8
UXTH	R0, R0
ORRS	R1, R0
UXTH	R1, R1
;P3_LED_BONUS.c,119 :: 		GPIOD_ODR = combined_num;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,120 :: 		GPIOE_ODR = combined_num << 8;
LSLS	R1, R1, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,122 :: 		return;  // Exit program
IT	AL
BAL	L_end_main
;P3_LED_BONUS.c,123 :: 		}
L_main9:
; count_mode start address is: 12 (R3)
L_main8:
;P3_LED_BONUS.c,128 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R2, #0]
AND	R1, R0, #255
UXTB	R1, R1
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #8
UXTH	R0, R0
ORRS	R1, R0
UXTH	R1, R1
;P3_LED_BONUS.c,129 :: 		GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
MOVW	R0, #65535
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,130 :: 		GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF) << 8;
MOV	R0, R2
LDRB	R1, [R0, #0]
MOVW	R0, #65535
AND	R0, R1, R0, LSL #0
UXTH	R0, R0
LSLS	R1, R0, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,133 :: 		target_count = PD_LOW_NUM;
MOV	R0, R2
LDRB	R0, [R0, #0]
STRH	R0, [SP, #4]
;P3_LED_BONUS.c,136 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main10:
SUBS	R7, R7, #1
BNE	L_main10
NOP
NOP
NOP
; count_mode end address is: 12 (R3)
UXTB	R2, R3
;P3_LED_BONUS.c,141 :: 		for (;;) {
L_main12:
;P3_LED_BONUS.c,144 :: 		if (target_count == PD_HIGH_NUM) {
; count_mode start address is: 8 (R2)
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L_main15
; count_mode end address is: 8 (R2)
;P3_LED_BONUS.c,145 :: 		count_mode = DECREMENT_MODE;
; count_mode start address is: 12 (R3)
MOVS	R3, #0
;P3_LED_BONUS.c,146 :: 		}
; count_mode end address is: 12 (R3)
IT	AL
BAL	L_main16
L_main15:
;P3_LED_BONUS.c,147 :: 		else if (target_count == PD_LOW_NUM) {
; count_mode start address is: 8 (R2)
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L__main22
; count_mode end address is: 8 (R2)
;P3_LED_BONUS.c,148 :: 		count_mode = INCREMENT_MODE;
; count_mode start address is: 0 (R0)
MOVS	R0, #1
; count_mode end address is: 0 (R0)
UXTB	R3, R0
;P3_LED_BONUS.c,149 :: 		}
IT	AL
BAL	L_main17
L__main22:
;P3_LED_BONUS.c,147 :: 		else if (target_count == PD_LOW_NUM) {
UXTB	R3, R2
;P3_LED_BONUS.c,149 :: 		}
L_main17:
; count_mode start address is: 12 (R3)
; count_mode end address is: 12 (R3)
L_main16:
;P3_LED_BONUS.c,152 :: 		if (count_mode == INCREMENT_MODE) {
; count_mode start address is: 12 (R3)
CMP	R3, #1
IT	NE
BNE	L_main18
;P3_LED_BONUS.c,153 :: 		++target_count;
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_BONUS.c,154 :: 		} else{
IT	AL
BAL	L_main19
L_main18:
;P3_LED_BONUS.c,155 :: 		--target_count;
LDRH	R0, [SP, #4]
SUBS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_BONUS.c,156 :: 		}
L_main19:
;P3_LED_BONUS.c,159 :: 		update_PD_LED(&target_count);
ADD	R0, SP, #4
BL	_update_PD_LED+0
;P3_LED_BONUS.c,163 :: 		PA0_PWM_phase = target_count % 3;  // get the PWM phase
LDRH	R2, [SP, #4]
MOVS	R0, #3
UDIV	R1, R2, R0
MLS	R1, R0, R1, R2
UXTH	R1, R1
MOVW	R0, #lo_addr(_PA0_PWM_phase+0)
MOVT	R0, #hi_addr(_PA0_PWM_phase+0)
STR	R1, [R0, #0]
;P3_LED_BONUS.c,189 :: 		MOVW R7, #0x2B89
STRB	R3, [SP, #0]
MOVW	R7, #11145
;P3_LED_BONUS.c,190 :: 		MOVT R7, #0x1C
MOVT	R7, #28
;P3_LED_BONUS.c,195 :: 		MOVW R0, #LO_ADDR(GPIOC_IDR+0)
MOVW	R0, #lo_addr(GPIOC_IDR+0)
;P3_LED_BONUS.c,196 :: 		MOVT R0, #HI_ADDR(GPIOC_IDR+0)
MOVT	R0, #hi_addr(GPIOC_IDR+0)
;P3_LED_BONUS.c,197 :: 		MOVW R3, #LO_ADDR(GPIOA_ODR+0)
MOVW	R3, #lo_addr(GPIOA_ODR+0)
;P3_LED_BONUS.c,198 :: 		MOVT R3, #HI_ADDR(GPIOA_ODR+0)
MOVT	R3, #hi_addr(GPIOA_ODR+0)
;P3_LED_BONUS.c,199 :: 		MOVW R2, #LO_ADDR(GPIOE_ODR+0)
MOVW	R2, #lo_addr(GPIOE_ODR+0)
;P3_LED_BONUS.c,200 :: 		MOVT R2, #HI_ADDR(GPIOE_ODR+0)
MOVT	R2, #hi_addr(GPIOE_ODR+0)
;P3_LED_BONUS.c,201 :: 		MOVW R4, #LO_ADDR(_PE_display_mode+0)
MOVW	R4, #lo_addr(_PE_display_mode+0)
;P3_LED_BONUS.c,202 :: 		MOVT R4, #HI_ADDR(_PE_display_mode+0)
MOVT	R4, #hi_addr(_PE_display_mode+0)
;P3_LED_BONUS.c,203 :: 		MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
MOVW	R8, #lo_addr(_PD_LOW_NUM+0)
;P3_LED_BONUS.c,204 :: 		MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)
MOVT	R8, #hi_addr(_PD_LOW_NUM+0)
;P3_LED_BONUS.c,205 :: 		MOVW R9, #LO_ADDR(_PD_HIGH_NUM+0)
MOVW	R9, #lo_addr(_PD_HIGH_NUM+0)
;P3_LED_BONUS.c,206 :: 		MOVT R9, #HI_ADDR(_PD_HIGH_NUM+0)
MOVT	R9, #hi_addr(_PD_HIGH_NUM+0)
;P3_LED_BONUS.c,208 :: 		_DELAY_LOOP:
_DELAY_LOOP:
;P3_LED_BONUS.c,209 :: 		SUBS R7, R7, #1            // Update delay clock counter
SUBS	R7, R7, #1
;P3_LED_BONUS.c,210 :: 		BEQ _EXIT_TIME_LOOP        // Exit this loop when counter is 0. End sleep
BEQ	_EXIT_TIME_LOOP
;P3_LED_BONUS.c,211 :: 		LDR R1, [R0]               // Load GPIOC_IDR value in R1
LDR	R1, [R0, #0]
;P3_LED_BONUS.c,212 :: 		AND R6, R1, #0x00000001    // Extract PC0 bit0
AND	R6, R1, #1
;P3_LED_BONUS.c,213 :: 		CMP R6, #1                 // Check if PC0 is pressed '1'
CMP	R6, #1
;P3_LED_BONUS.c,214 :: 		BEQ _PC0_BTN_FILTER        // Branch to PC0 Button filter in order to capture button press properly
BEQ	_PC0_BTN_FILTER
;P3_LED_BONUS.c,215 :: 		BNE _PC0_NOT_PRESSED       // Branch to Fake operation to alingn cpu tick counting
BNE	_PC0_NOT_PRESSED
;P3_LED_BONUS.c,220 :: 		_PC0_PRESSED:
_PC0_PRESSED:
;P3_LED_BONUS.c,221 :: 		LDR R5, [R4]                // Get the current PortE Display mode value
LDR	R5, [R4, #0]
;P3_LED_BONUS.c,222 :: 		CMP R5, #1                  // If 1, means PortE is currently displaying High#
CMP	R5, #1
;P3_LED_BONUS.c,223 :: 		BEQ _SET_PE_LOW             // Switch to LOW#
BEQ	_SET_PE_LOW
;P3_LED_BONUS.c,224 :: 		BNE _SET_PE_HI              // Else, swithc to High#
BNE	_SET_PE_HI
;P3_LED_BONUS.c,226 :: 		_PC0_BTN_FILTER:
_PC0_BTN_FILTER:
;P3_LED_BONUS.c,227 :: 		LDR R1, [R0]                // Get current GPIOC_IDR input state
LDR	R1, [R0, #0]
;P3_LED_BONUS.c,228 :: 		AND R6, R1, #0x00000001     // Extract PC0 bit
AND	R6, R1, #1
;P3_LED_BONUS.c,229 :: 		CMP R6, #1                  // Check if PC0 is pressed '1'
CMP	R6, #1
;P3_LED_BONUS.c,230 :: 		BEQ _PC0_BTN_FILTER         // If PC0 is held down, repeat this loop
BEQ	_PC0_BTN_FILTER
;P3_LED_BONUS.c,231 :: 		BNE _PC0_PRESSED
BNE	_PC0_PRESSED
;P3_LED_BONUS.c,238 :: 		_PC0_NOT_PRESSED:
_PC0_NOT_PRESSED:
;P3_LED_BONUS.c,239 :: 		MOVW R5, #LO_ADDR(_PA0_PWM_phase+0) // Load the PWM 'phase clock' pattern
MOVW	R5, #lo_addr(_PA0_PWM_phase+0)
;P3_LED_BONUS.c,240 :: 		MOVT R5, #HI_ADDR(_PA0_PWM_phase+0) // Load the PWM 'phase clock' pattern
MOVT	R5, #hi_addr(_PA0_PWM_phase+0)
;P3_LED_BONUS.c,241 :: 		LDR R10, [R5]               // Load it in R10 for calculation
LDR	R10, [R5, #0]
;P3_LED_BONUS.c,242 :: 		CMP R10, #0                 // PWM phase is 1-3, call corresponding PWM sequence for PORT A
CMP	R10, #0
;P3_LED_BONUS.c,243 :: 		BEQ _UPDATE_PWM1_PA         // Bright PWM Setting
BEQ	_UPDATE_PWM1_PA
;P3_LED_BONUS.c,244 :: 		CMP R10, #1
CMP	R10, #1
;P3_LED_BONUS.c,245 :: 		BEQ _UPDATE_PWM2_PA         // Med-bright PWM Setting
BEQ	_UPDATE_PWM2_PA
;P3_LED_BONUS.c,246 :: 		CMP R10, #2
CMP	R10, #2
;P3_LED_BONUS.c,247 :: 		BEQ _UPDATE_PWM3_PA         // Dim PWM Setting
BEQ	_UPDATE_PWM3_PA
;P3_LED_BONUS.c,249 :: 		_SET_PE_LOW:
_SET_PE_LOW:
;P3_LED_BONUS.c,250 :: 		LDR R5, [R8]            // Copy the current(in-case it changes during run-time)LOW_NUM into R5 for processing
LDR	R5, [R8, #0]
;P3_LED_BONUS.c,251 :: 		LSL R5, #8              // LOW_NUM shift left 8 for PortE LEDs
LSL	R5, R5, #8
;P3_LED_BONUS.c,252 :: 		STR R5, [R2]            // Write to PortE_ODR
STR	R5, [R2, #0]
;P3_LED_BONUS.c,253 :: 		MOV R10, #0x00000000    // Store LOW_MODE flag in R1 so we know what the display is current
MOV	R10, #0
;P3_LED_BONUS.c,254 :: 		STR R10, [R4]           // update display mode flag
STR	R10, [R4, #0]
;P3_LED_BONUS.c,255 :: 		B _DELAY_LOOP           // Continue the sleep loop
B	_DELAY_LOOP
;P3_LED_BONUS.c,257 :: 		_SET_PE_HI:
_SET_PE_HI:
;P3_LED_BONUS.c,258 :: 		LDR R5, [R9]            // Copy the current HIGH_NUM into R5
LDR	R5, [R9, #0]
;P3_LED_BONUS.c,259 :: 		LSL R5, #8              // HIGH_NUM shift left 8 for portE LEDs
LSL	R5, R5, #8
;P3_LED_BONUS.c,260 :: 		STR R5, [R2]            // Update PE PE_ODR
STR	R5, [R2, #0]
;P3_LED_BONUS.c,261 :: 		MOV R10, #0x00000001    // Store HIGH_MODE flag in R1 so we know what the display is current
MOV	R10, #1
;P3_LED_BONUS.c,262 :: 		STR R10, [R4]           // update display mode flag
STR	R10, [R4, #0]
;P3_LED_BONUS.c,263 :: 		B _DELAY_LOOP           // Continue the sleep loop
B	_DELAY_LOOP
;P3_LED_BONUS.c,270 :: 		_UPDATE_PWM1_PA:
_UPDATE_PWM1_PA:
;P3_LED_BONUS.c,271 :: 		MOV R10, #15                // Load the chosen divisor into R10
MOV	R10, #15
;P3_LED_BONUS.c,272 :: 		UDIV R5, R7, R10            // Divide the current clock cycle(R7) and store value in R5
UDIV	R5, R7, R10
;P3_LED_BONUS.c,273 :: 		MUL R11, R5, R10            // Verify it can divide evenly by multipying quotient by Divisor
MUL	R11, R5, R10
;P3_LED_BONUS.c,274 :: 		CMP R7, R11                 // If the Product of R11 matches the current clock cycle we know-
CMP	R7, R11
;P3_LED_BONUS.c,276 :: 		BEQ _TURN_ON_PA             // If Current clock % divisor == 0, turn on LED
BEQ	_TURN_ON_PA
;P3_LED_BONUS.c,277 :: 		BNE _TURN_OFF_PA            // Else, turn off LED.
BNE	_TURN_OFF_PA
;P3_LED_BONUS.c,280 :: 		_UPDATE_PWM2_PA:
_UPDATE_PWM2_PA:
;P3_LED_BONUS.c,281 :: 		MOV R10, #5
MOV	R10, #5
;P3_LED_BONUS.c,282 :: 		UDIV R5, R7, R10
UDIV	R5, R7, R10
;P3_LED_BONUS.c,283 :: 		MUL R11, R5, R10
MUL	R11, R5, R10
;P3_LED_BONUS.c,284 :: 		CMP R7, R11
CMP	R7, R11
;P3_LED_BONUS.c,285 :: 		BEQ _TURN_ON_PA
BEQ	_TURN_ON_PA
;P3_LED_BONUS.c,286 :: 		BNE _TURN_OFF_PA
BNE	_TURN_OFF_PA
;P3_LED_BONUS.c,289 :: 		_UPDATE_PWM3_PA:
_UPDATE_PWM3_PA:
;P3_LED_BONUS.c,290 :: 		MOV R10, #1
MOV	R10, #1
;P3_LED_BONUS.c,291 :: 		UDIV R5, R7, R10
UDIV	R5, R7, R10
;P3_LED_BONUS.c,292 :: 		MUL R11, R5, R10
MUL	R11, R5, R10
;P3_LED_BONUS.c,293 :: 		CMP R7, R11
CMP	R7, R11
;P3_LED_BONUS.c,294 :: 		BEQ _TURN_ON_PA
BEQ	_TURN_ON_PA
;P3_LED_BONUS.c,295 :: 		BNE _TURN_OFF_PA
BNE	_TURN_OFF_PA
;P3_LED_BONUS.c,297 :: 		_TURN_ON_PA:
_TURN_ON_PA:
;P3_LED_BONUS.c,298 :: 		MOV R5, #00000001
MOV	R5, #1
;P3_LED_BONUS.c,299 :: 		STR R5, [R3] // Write to PA0 LED
STR	R5, [R3, #0]
;P3_LED_BONUS.c,300 :: 		B _DELAY_LOOP
B	_DELAY_LOOP
;P3_LED_BONUS.c,301 :: 		_TURN_OFF_PA:
_TURN_OFF_PA:
;P3_LED_BONUS.c,302 :: 		MOV R5, #00000000
MOV	R5, #0
;P3_LED_BONUS.c,303 :: 		STR R5, [R3] // Write to PA0 LED
STR	R5, [R3, #0]
;P3_LED_BONUS.c,304 :: 		B _DELAY_LOOP
B	_DELAY_LOOP
;P3_LED_BONUS.c,306 :: 		_EXIT_TIME_LOOP:
_EXIT_TIME_LOOP:
;P3_LED_BONUS.c,307 :: 		NOP
NOP
;P3_LED_BONUS.c,189 :: 		MOVW R7, #0x2B89
LDRB	R3, [SP, #0]
;P3_LED_BONUS.c,309 :: 		}
UXTB	R2, R3
; count_mode end address is: 12 (R3)
IT	AL
BAL	L_main12
;P3_LED_BONUS.c,310 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
