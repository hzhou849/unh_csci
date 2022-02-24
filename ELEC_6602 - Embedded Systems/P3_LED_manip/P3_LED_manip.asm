_update_PD_LED:
;P3_LED_manip.c,51 :: 		void update_PD_LED(uint16_t *target_count) {
; target_count start address is: 0 (R0)
SUB	SP, SP, #4
; target_count end address is: 0 (R0)
; target_count start address is: 0 (R0)
;P3_LED_manip.c,52 :: 		GPIOD_ODR = (*target_count & 0x000FFFF);  // GPIOD_ODR is 32bit, must pad target_count it will be promoted to uint32
LDRH	R2, [R0, #0]
; target_count end address is: 0 (R0)
MOVW	R1, #65535
ANDS	R2, R1
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,53 :: 		}
L_end_update_PD_LED:
ADD	SP, SP, #4
BX	LR
; end of _update_PD_LED
_PC_btn_check:
;P3_LED_manip.c,56 :: 		void PC_btn_check(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_manip.c,59 :: 		if (GPIOC_IDR.B0 == 1) {
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check69
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,61 :: 		while (GPIOC_IDR.B0 == 1 ) {
L_PC_btn_check1:
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check2
;P3_LED_manip.c,62 :: 		Delay_ms(1);
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
;P3_LED_manip.c,63 :: 		}
IT	AL
BAL	L_PC_btn_check1
L_PC_btn_check2:
;P3_LED_manip.c,65 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check5
;P3_LED_manip.c,66 :: 		GPIOE_ODR = PD_HIGH_NUM << 8;
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,67 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
;P3_LED_manip.c,68 :: 		}
IT	AL
BAL	L_PC_btn_check6
L_PC_btn_check5:
;P3_LED_manip.c,70 :: 		GPIOE_ODR = PD_LOW_NUM  << 8;
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,71 :: 		*PE_display_mode = PE_MODE_LOW;
MOVS	R1, #0
STRB	R1, [R0, #0]
;P3_LED_manip.c,72 :: 		}
L_PC_btn_check6:
;P3_LED_manip.c,73 :: 		}
IT	AL
BAL	L_PC_btn_check0
; PE_display_mode end address is: 0 (R0)
L__PC_btn_check69:
;P3_LED_manip.c,59 :: 		if (GPIOC_IDR.B0 == 1) {
;P3_LED_manip.c,73 :: 		}
L_PC_btn_check0:
;P3_LED_manip.c,76 :: 		if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check70
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
CMP	R1, R2
IT	EQ
BEQ	L__PC_btn_check71
L__PC_btn_check64:
;P3_LED_manip.c,78 :: 		while ( GPIOB_IDR.B0 == 1) {
L_PC_btn_check10:
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check11
;P3_LED_manip.c,79 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_PC_btn_check12:
SUBS	R7, R7, #1
BNE	L_PC_btn_check12
NOP
NOP
NOP
;P3_LED_manip.c,80 :: 		}
IT	AL
BAL	L_PC_btn_check10
L_PC_btn_check11:
;P3_LED_manip.c,82 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check14
;P3_LED_manip.c,84 :: 		--PD_LOW_NUM;
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,85 :: 		GPIOE_ODR = PD_LOW_NUM << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,86 :: 		}
IT	AL
BAL	L_PC_btn_check15
L_PC_btn_check14:
;P3_LED_manip.c,88 :: 		--PD_HIGH_NUM;
MOVW	R2, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R2, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,89 :: 		GPIOE_ODR = PD_HIGH_NUM  << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,90 :: 		}
L_PC_btn_check15:
;P3_LED_manip.c,76 :: 		if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {
IT	AL
BAL	L__PC_btn_check66
; PE_display_mode end address is: 0 (R0)
L__PC_btn_check70:
L__PC_btn_check66:
; PE_display_mode start address is: 0 (R0)
; PE_display_mode end address is: 0 (R0)
IT	AL
BAL	L__PC_btn_check65
L__PC_btn_check71:
L__PC_btn_check65:
;P3_LED_manip.c,93 :: 		if (  GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check68
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R1, #0]
CMP	R1, R2
IT	EQ
BEQ	L__PC_btn_check67
L__PC_btn_check63:
;P3_LED_manip.c,96 :: 		while ( GPIOB_IDR.B4 == 1 ) {
L_PC_btn_check19:
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check20
;P3_LED_manip.c,97 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_PC_btn_check21:
SUBS	R7, R7, #1
BNE	L_PC_btn_check21
NOP
NOP
NOP
;P3_LED_manip.c,98 :: 		}
IT	AL
BAL	L_PC_btn_check19
L_PC_btn_check20:
;P3_LED_manip.c,100 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check23
;P3_LED_manip.c,102 :: 		++PD_LOW_NUM;
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,103 :: 		GPIOE_ODR = PD_LOW_NUM << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,104 :: 		}
IT	AL
BAL	L_PC_btn_check24
L_PC_btn_check23:
;P3_LED_manip.c,106 :: 		++PD_HIGH_NUM;
MOVW	R2, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R2, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,107 :: 		GPIOE_ODR = PD_HIGH_NUM  << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,108 :: 		}
L_PC_btn_check24:
;P3_LED_manip.c,93 :: 		if (  GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
L__PC_btn_check68:
L__PC_btn_check67:
;P3_LED_manip.c,110 :: 		}
L_end_PC_btn_check:
ADD	SP, SP, #4
BX	LR
; end of _PC_btn_check
_get_PE_display_data:
;P3_LED_manip.c,113 :: 		void get_PE_display_data(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_manip.c,115 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_get_PE_display_data25
;P3_LED_manip.c,116 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,117 :: 		}
IT	AL
BAL	L_get_PE_display_data26
L_get_PE_display_data25:
;P3_LED_manip.c,119 :: 		*PE_display_mode = PE_MODE_LOW;
; PE_display_mode start address is: 0 (R0)
MOVS	R1, #0
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,120 :: 		}
L_get_PE_display_data26:
;P3_LED_manip.c,121 :: 		}
L_end_get_PE_display_data:
ADD	SP, SP, #4
BX	LR
; end of _get_PE_display_data
_main:
;P3_LED_manip.c,125 :: 		void main() {
SUB	SP, SP, #16
;P3_LED_manip.c,127 :: 		uint32_t i               = 0;
;P3_LED_manip.c,129 :: 		uint16_t combined_num    = 0;
;P3_LED_manip.c,130 :: 		uint16_t target_count    = PD_LOW_NUM;       // Set the lower bound number
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
STRH	R0, [SP, #4]
;P3_LED_manip.c,131 :: 		uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
MOVS	R0, #1
STRB	R0, [SP, #6]
;P3_LED_manip.c,132 :: 		uint32_t PA0_led_counter=0;
MOV	R0, #0
STR	R0, [SP, #8]
MOVS	R0, #0
STRB	R0, [SP, #12]
;P3_LED_manip.c,133 :: 		uint8_t PA0_PWM_phase = 0;
;P3_LED_manip.c,136 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
MOVW	R3, #lo_addr(_PD_LOW_NUM+0)
MOVT	R3, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R3, #0]
AND	R1, R0, #255
UXTB	R1, R1
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R0, [R0, #0]
LSLS	R0, R0, #8
UXTH	R0, R0
ORR	R2, R1, R0, LSL #0
UXTH	R2, R2
STRH	R2, [SP, #14]
;P3_LED_manip.c,144 :: 		RCC_APB2ENR |= 1 << 2; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,145 :: 		RCC_APB2ENR |= 1 << 3; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,146 :: 		RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - Port C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,147 :: 		RCC_APB2ENR |= 1 << 5; // Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,148 :: 		RCC_APB2ENR |= 1 << 6; // Enable GPIO Clock - Port E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,155 :: 		GPIOA_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,158 :: 		GPIOB_CRL = GPIO_DIR_INPUT;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,161 :: 		GPIOC_CRL = GPIO_DIR_INPUT;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,164 :: 		GPIOD_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,165 :: 		GPIOD_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,168 :: 		GPIOE_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,169 :: 		GPIOE_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,173 :: 		GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
MOVW	R0, #65535
AND	R1, R2, R0, LSL #0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,174 :: 		GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF) << 8;
MOV	R0, R3
LDRB	R1, [R0, #0]
MOVW	R0, #65535
AND	R0, R1, R0, LSL #0
UXTH	R0, R0
LSLS	R1, R0, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,177 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main27:
SUBS	R7, R7, #1
BNE	L_main27
NOP
NOP
NOP
;P3_LED_manip.c,182 :: 		for (;;) {
L_main29:
;P3_LED_manip.c,185 :: 		if (target_count == combined_num) {
LDRH	R1, [SP, #14]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L_main32
;P3_LED_manip.c,186 :: 		count_mode = DECREMENT_MODE;
MOVS	R0, #0
STRB	R0, [SP, #6]
;P3_LED_manip.c,187 :: 		}
IT	AL
BAL	L_main33
L_main32:
;P3_LED_manip.c,188 :: 		else if (target_count == PD_LOW_NUM) {
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L_main34
;P3_LED_manip.c,189 :: 		count_mode = INCREMENT_MODE;
MOVS	R0, #1
STRB	R0, [SP, #6]
;P3_LED_manip.c,190 :: 		}
L_main34:
L_main33:
;P3_LED_manip.c,193 :: 		if (count_mode == INCREMENT_MODE) {
LDRB	R0, [SP, #6]
CMP	R0, #1
IT	NE
BNE	L_main35
;P3_LED_manip.c,194 :: 		++target_count;
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,195 :: 		} else{
IT	AL
BAL	L_main36
L_main35:
;P3_LED_manip.c,196 :: 		--target_count;
LDRH	R0, [SP, #4]
SUBS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,197 :: 		}
L_main36:
;P3_LED_manip.c,200 :: 		update_PD_LED(&target_count);
ADD	R0, SP, #4
BL	_update_PD_LED+0
;P3_LED_manip.c,205 :: 		GPIOA_ODR.B0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
;P3_LED_manip.c,207 :: 		for (i = 0; i < delay_time_ms; i++) {
; i start address is: 12 (R3)
MOVS	R3, #0
; i end address is: 12 (R3)
L_main37:
; i start address is: 12 (R3)
MOVW	R0, #lo_addr(_delay_time_ms+0)
MOVT	R0, #hi_addr(_delay_time_ms+0)
LDRH	R0, [R0, #0]
CMP	R3, R0
IT	CS
BCS	L_main38
;P3_LED_manip.c,208 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main40:
SUBS	R7, R7, #1
BNE	L_main40
NOP
NOP
NOP
;P3_LED_manip.c,209 :: 		PA0_led_counter++;
LDR	R0, [SP, #8]
ADDS	R0, R0, #1
STR	R0, [SP, #8]
;P3_LED_manip.c,213 :: 		if (PA0_PWM_phase == 0) {
LDRB	R0, [SP, #12]
CMP	R0, #0
IT	NE
BNE	L_main42
;P3_LED_manip.c,214 :: 		if (PA0_led_counter % 25 == 0 )
LDR	R2, [SP, #8]
MOVS	R1, #25
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
CMP	R0, #0
IT	NE
BNE	L_main43
;P3_LED_manip.c,215 :: 		GPIOA_ODR.B0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
IT	AL
BAL	L_main44
L_main43:
;P3_LED_manip.c,216 :: 		else if (PA0_led_counter % 12 == 0)
LDR	R2, [SP, #8]
MOVS	R1, #12
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
CMP	R0, #0
IT	NE
BNE	L_main45
;P3_LED_manip.c,217 :: 		GPIOA_ODR.B0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
L_main45:
L_main44:
;P3_LED_manip.c,219 :: 		if (PA0_led_counter > 1000)
LDR	R0, [SP, #8]
CMP	R0, #1000
IT	LS
BLS	L_main46
;P3_LED_manip.c,221 :: 		PA0_PWM_phase++;
LDRB	R0, [SP, #12]
ADDS	R0, R0, #1
STRB	R0, [SP, #12]
;P3_LED_manip.c,222 :: 		PA0_led_counter =0;
MOVS	R0, #0
STR	R0, [SP, #8]
;P3_LED_manip.c,224 :: 		}
L_main46:
;P3_LED_manip.c,227 :: 		}
IT	AL
BAL	L_main47
L_main42:
;P3_LED_manip.c,228 :: 		else if ( PA0_PWM_phase == 1)
LDRB	R0, [SP, #12]
CMP	R0, #1
IT	NE
BNE	L_main48
;P3_LED_manip.c,230 :: 		if (PA0_led_counter % 10 == 0 )
LDR	R2, [SP, #8]
MOVS	R1, #10
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
CMP	R0, #0
IT	NE
BNE	L_main49
;P3_LED_manip.c,231 :: 		GPIOA_ODR.B0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
IT	AL
BAL	L_main50
L_main49:
;P3_LED_manip.c,232 :: 		else if (PA0_led_counter % 5 == 0)
LDR	R2, [SP, #8]
MOVS	R1, #5
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
CMP	R0, #0
IT	NE
BNE	L_main51
;P3_LED_manip.c,233 :: 		GPIOA_ODR.B0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
L_main51:
L_main50:
;P3_LED_manip.c,235 :: 		if (PA0_led_counter > 1000)
LDR	R0, [SP, #8]
CMP	R0, #1000
IT	LS
BLS	L_main52
;P3_LED_manip.c,237 :: 		PA0_PWM_phase++;
LDRB	R0, [SP, #12]
ADDS	R0, R0, #1
STRB	R0, [SP, #12]
;P3_LED_manip.c,238 :: 		PA0_led_counter =0;
MOVS	R0, #0
STR	R0, [SP, #8]
;P3_LED_manip.c,239 :: 		}
L_main52:
;P3_LED_manip.c,240 :: 		}
IT	AL
BAL	L_main53
L_main48:
;P3_LED_manip.c,241 :: 		else if ( PA0_PWM_phase == 2)
LDRB	R0, [SP, #12]
CMP	R0, #2
IT	NE
BNE	L_main54
;P3_LED_manip.c,243 :: 		if (PA0_led_counter % 5 == 0 )
LDR	R2, [SP, #8]
MOVS	R1, #5
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
CMP	R0, #0
IT	NE
BNE	L_main55
;P3_LED_manip.c,244 :: 		GPIOA_ODR.B0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
IT	AL
BAL	L_main56
L_main55:
;P3_LED_manip.c,245 :: 		else if (PA0_led_counter % 2 == 0)
LDR	R0, [SP, #8]
AND	R0, R0, #1
CMP	R0, #0
IT	NE
BNE	L_main57
;P3_LED_manip.c,246 :: 		GPIOA_ODR.B0=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
L_main57:
L_main56:
;P3_LED_manip.c,248 :: 		if (PA0_led_counter > 1000)
LDR	R0, [SP, #8]
CMP	R0, #1000
IT	LS
BLS	L_main58
;P3_LED_manip.c,250 :: 		PA0_PWM_phase++;
LDRB	R0, [SP, #12]
ADDS	R0, R0, #1
STRB	R0, [SP, #12]
;P3_LED_manip.c,251 :: 		PA0_led_counter =0;
MOVS	R0, #0
STR	R0, [SP, #8]
;P3_LED_manip.c,252 :: 		}
L_main58:
;P3_LED_manip.c,253 :: 		}
IT	AL
BAL	L_main59
L_main54:
;P3_LED_manip.c,254 :: 		else if ( PA0_PWM_phase == 3)
LDRB	R0, [SP, #12]
CMP	R0, #3
IT	NE
BNE	L_main60
;P3_LED_manip.c,256 :: 		if (PA0_led_counter % 5 == 0 )
LDR	R2, [SP, #8]
MOVS	R1, #5
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
CMP	R0, #0
IT	NE
BNE	L_main61
;P3_LED_manip.c,257 :: 		GPIOA_ODR.B0=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOA_ODR+0)
MOVT	R0, #hi_addr(GPIOA_ODR+0)
_SX	[R0, ByteOffset(GPIOA_ODR+0)]
L_main61:
;P3_LED_manip.c,259 :: 		if (PA0_led_counter > 1000)
LDR	R0, [SP, #8]
CMP	R0, #1000
IT	LS
BLS	L_main62
;P3_LED_manip.c,261 :: 		PA0_PWM_phase=0;
MOVS	R0, #0
STRB	R0, [SP, #12]
;P3_LED_manip.c,262 :: 		PA0_led_counter =0;
MOVS	R0, #0
STR	R0, [SP, #8]
;P3_LED_manip.c,263 :: 		}
L_main62:
;P3_LED_manip.c,264 :: 		}
L_main60:
L_main59:
L_main53:
L_main47:
;P3_LED_manip.c,266 :: 		PC_btn_check(&PE_display_mode);
MOVW	R0, #lo_addr(_PE_display_mode+0)
MOVT	R0, #hi_addr(_PE_display_mode+0)
BL	_PC_btn_check+0
;P3_LED_manip.c,207 :: 		for (i = 0; i < delay_time_ms; i++) {
ADDS	R0, R3, #1
; i end address is: 12 (R3)
; i start address is: 20 (R5)
MOV	R5, R0
;P3_LED_manip.c,269 :: 		}
MOV	R3, R5
; i end address is: 20 (R5)
IT	AL
BAL	L_main37
L_main38:
;P3_LED_manip.c,361 :: 		}
IT	AL
BAL	L_main29
;P3_LED_manip.c,365 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
