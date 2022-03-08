_update_PD_LED:
;P3_LED_manip.c,63 :: 		void update_PD_LED(uint16_t *target_count) {
; target_count start address is: 0 (R0)
SUB	SP, SP, #4
; target_count end address is: 0 (R0)
; target_count start address is: 0 (R0)
;P3_LED_manip.c,64 :: 		GPIOD_ODR = (*target_count & 0x000000FF);
LDRH	R1, [R0, #0]
; target_count end address is: 0 (R0)
AND	R2, R1, #255
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,65 :: 		}
L_end_update_PD_LED:
ADD	SP, SP, #4
BX	LR
; end of _update_PD_LED
_PC_btn_check:
;P3_LED_manip.c,68 :: 		void PC_btn_check(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_manip.c,71 :: 		if (GPIOC_IDR.B0 == 1) {
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check49
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,73 :: 		while (GPIOC_IDR.B0 == 1) {
L_PC_btn_check1:
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check2
;P3_LED_manip.c,74 :: 		Delay_ms(1);
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
;P3_LED_manip.c,75 :: 		}
IT	AL
BAL	L_PC_btn_check1
L_PC_btn_check2:
;P3_LED_manip.c,77 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check5
;P3_LED_manip.c,78 :: 		GPIOE_ODR = PD_HIGH_NUM << 8;
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,79 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
;P3_LED_manip.c,80 :: 		}
IT	AL
BAL	L_PC_btn_check6
L_PC_btn_check5:
;P3_LED_manip.c,82 :: 		GPIOE_ODR = PD_LOW_NUM  << 8;
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,83 :: 		*PE_display_mode = PE_MODE_LOW;
MOVS	R1, #0
STRB	R1, [R0, #0]
;P3_LED_manip.c,84 :: 		}
L_PC_btn_check6:
;P3_LED_manip.c,85 :: 		}
IT	AL
BAL	L_PC_btn_check0
; PE_display_mode end address is: 0 (R0)
L__PC_btn_check49:
;P3_LED_manip.c,71 :: 		if (GPIOC_IDR.B0 == 1) {
;P3_LED_manip.c,85 :: 		}
L_PC_btn_check0:
;P3_LED_manip.c,88 :: 		if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check50
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
CMP	R1, R2
IT	EQ
BEQ	L__PC_btn_check51
L__PC_btn_check44:
;P3_LED_manip.c,90 :: 		while ( GPIOB_IDR.B0 == 1) {
L_PC_btn_check10:
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check11
;P3_LED_manip.c,91 :: 		Delay_ms(1);
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
;P3_LED_manip.c,92 :: 		}
IT	AL
BAL	L_PC_btn_check10
L_PC_btn_check11:
;P3_LED_manip.c,94 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check14
;P3_LED_manip.c,95 :: 		--PD_LOW_NUM;
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,96 :: 		GPIOE_ODR = PD_LOW_NUM << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,97 :: 		}
IT	AL
BAL	L_PC_btn_check15
L_PC_btn_check14:
;P3_LED_manip.c,99 :: 		--PD_HIGH_NUM;
MOVW	R2, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R2, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,100 :: 		GPIOE_ODR = PD_HIGH_NUM  << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,101 :: 		}
L_PC_btn_check15:
;P3_LED_manip.c,88 :: 		if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {
IT	AL
BAL	L__PC_btn_check46
; PE_display_mode end address is: 0 (R0)
L__PC_btn_check50:
L__PC_btn_check46:
; PE_display_mode start address is: 0 (R0)
; PE_display_mode end address is: 0 (R0)
IT	AL
BAL	L__PC_btn_check45
L__PC_btn_check51:
L__PC_btn_check45:
;P3_LED_manip.c,104 :: 		if (  GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check48
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R1, #0]
CMP	R1, R2
IT	EQ
BEQ	L__PC_btn_check47
L__PC_btn_check43:
;P3_LED_manip.c,107 :: 		while ( GPIOB_IDR.B4 == 1 ) {
L_PC_btn_check19:
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check20
;P3_LED_manip.c,108 :: 		Delay_ms(1);
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
;P3_LED_manip.c,109 :: 		}
IT	AL
BAL	L_PC_btn_check19
L_PC_btn_check20:
;P3_LED_manip.c,111 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check23
;P3_LED_manip.c,113 :: 		++PD_LOW_NUM;
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,114 :: 		GPIOE_ODR = PD_LOW_NUM << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,115 :: 		}
IT	AL
BAL	L_PC_btn_check24
L_PC_btn_check23:
;P3_LED_manip.c,117 :: 		++PD_HIGH_NUM;
MOVW	R2, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R2, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,118 :: 		GPIOE_ODR = PD_HIGH_NUM  << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,119 :: 		}
L_PC_btn_check24:
;P3_LED_manip.c,104 :: 		if (  GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
L__PC_btn_check48:
L__PC_btn_check47:
;P3_LED_manip.c,121 :: 		}
L_end_PC_btn_check:
ADD	SP, SP, #4
BX	LR
; end of _PC_btn_check
_main:
;P3_LED_manip.c,125 :: 		void main() {
SUB	SP, SP, #8
;P3_LED_manip.c,127 :: 		uint16_t combined_num    = 0;
;P3_LED_manip.c,128 :: 		uint16_t target_count    = 0;
MOVW	R0, #0
STRH	R0, [SP, #4]
;P3_LED_manip.c,129 :: 		uint8_t  count_mode      = INCREMENT_MODE;   // Default start state is increment from low to high number
; count_mode start address is: 12 (R3)
MOVS	R3, #1
;P3_LED_manip.c,130 :: 		uint8_t  temp_num        = 0;
;P3_LED_manip.c,131 :: 		uint8_t  PA0_PWM_phase   = 0;
;P3_LED_manip.c,132 :: 		uint32_t i               = 0;
;P3_LED_manip.c,135 :: 		RCC_APB2ENR |= 1 << 2; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,136 :: 		RCC_APB2ENR |= 1 << 3; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,137 :: 		RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - Port C
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
;P3_LED_manip.c,143 :: 		GPIOA_CRL = GPIO_DIR_OUTPUT;  // GPIO Port A - INPUT
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,144 :: 		GPIOB_CRL = GPIO_DIR_INPUT;   // GPIO Port B - INPUT
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,145 :: 		GPIOC_CRL = GPIO_DIR_INPUT;   // GPIO Port C - INPUT
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,147 :: 		GPIOD_CRL = GPIO_DIR_OUTPUT;  // GPIO Port D - OUTPUT
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,148 :: 		GPIOD_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,150 :: 		GPIOE_CRL = GPIO_DIR_OUTPUT;  // GPIO Port E - OUTPUT
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,151 :: 		GPIOE_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,154 :: 		if (PD_LOW_NUM > PD_HIGH_NUM) {
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	LS
BLS	L_main25
;P3_LED_manip.c,155 :: 		temp_num = PD_LOW_NUM;
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
; temp_num start address is: 16 (R4)
LDRB	R4, [R2, #0]
;P3_LED_manip.c,156 :: 		PD_LOW_NUM = PD_HIGH_NUM;
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R0, [R1, #0]
STRB	R0, [R2, #0]
;P3_LED_manip.c,157 :: 		PD_HIGH_NUM = temp_num;
STRB	R4, [R1, #0]
; temp_num end address is: 16 (R4)
;P3_LED_manip.c,158 :: 		}
IT	AL
BAL	L_main26
L_main25:
;P3_LED_manip.c,159 :: 		else if (PD_LOW_NUM == PD_HIGH_NUM) {
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	NE
BNE	L_main27
; count_mode end address is: 12 (R3)
;P3_LED_manip.c,162 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
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
;P3_LED_manip.c,163 :: 		GPIOD_ODR = combined_num;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,164 :: 		GPIOE_ODR = combined_num << 8;
LSLS	R1, R1, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,166 :: 		return;  // Exit program
IT	AL
BAL	L_end_main
;P3_LED_manip.c,167 :: 		}
L_main27:
; count_mode start address is: 12 (R3)
L_main26:
;P3_LED_manip.c,172 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
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
;P3_LED_manip.c,173 :: 		GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
MOVW	R0, #65535
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,174 :: 		GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF) << 8;
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
;P3_LED_manip.c,177 :: 		target_count = PD_LOW_NUM;
MOV	R0, R2
LDRB	R0, [R0, #0]
STRH	R0, [SP, #4]
;P3_LED_manip.c,180 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main28:
SUBS	R7, R7, #1
BNE	L_main28
NOP
NOP
NOP
; count_mode end address is: 12 (R3)
UXTB	R2, R3
;P3_LED_manip.c,183 :: 		for (;;) {
L_main30:
;P3_LED_manip.c,186 :: 		if (target_count == PD_HIGH_NUM) {
; count_mode start address is: 8 (R2)
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L_main33
; count_mode end address is: 8 (R2)
;P3_LED_manip.c,187 :: 		count_mode = DECREMENT_MODE;
; count_mode start address is: 12 (R3)
MOVS	R3, #0
;P3_LED_manip.c,188 :: 		}
; count_mode end address is: 12 (R3)
IT	AL
BAL	L_main34
L_main33:
;P3_LED_manip.c,189 :: 		else if (target_count == PD_LOW_NUM) {
; count_mode start address is: 8 (R2)
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L__main52
; count_mode end address is: 8 (R2)
;P3_LED_manip.c,190 :: 		count_mode = INCREMENT_MODE;
; count_mode start address is: 0 (R0)
MOVS	R0, #1
; count_mode end address is: 0 (R0)
UXTB	R3, R0
;P3_LED_manip.c,191 :: 		}
IT	AL
BAL	L_main35
L__main52:
;P3_LED_manip.c,189 :: 		else if (target_count == PD_LOW_NUM) {
UXTB	R3, R2
;P3_LED_manip.c,191 :: 		}
L_main35:
; count_mode start address is: 12 (R3)
; count_mode end address is: 12 (R3)
L_main34:
;P3_LED_manip.c,194 :: 		if (count_mode == INCREMENT_MODE) {
; count_mode start address is: 12 (R3)
CMP	R3, #1
IT	NE
BNE	L_main36
;P3_LED_manip.c,195 :: 		++target_count;
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,196 :: 		} else{
IT	AL
BAL	L_main37
L_main36:
;P3_LED_manip.c,197 :: 		--target_count;
LDRH	R0, [SP, #4]
SUBS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,198 :: 		}
L_main37:
;P3_LED_manip.c,201 :: 		update_PD_LED(&target_count);
ADD	R0, SP, #4
BL	_update_PD_LED+0
;P3_LED_manip.c,206 :: 		for (i = 0; i < delay_time_ms; i++) {
; i start address is: 16 (R4)
MOVS	R4, #0
; count_mode end address is: 12 (R3)
; i end address is: 16 (R4)
L_main38:
; i start address is: 16 (R4)
; count_mode start address is: 12 (R3)
MOVW	R0, #lo_addr(_delay_time_ms+0)
MOVT	R0, #hi_addr(_delay_time_ms+0)
LDRH	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_main39
;P3_LED_manip.c,207 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main41:
SUBS	R7, R7, #1
BNE	L_main41
NOP
NOP
NOP
;P3_LED_manip.c,208 :: 		PC_btn_check(&PE_display_mode);
MOVW	R0, #lo_addr(_PE_display_mode+0)
MOVT	R0, #hi_addr(_PE_display_mode+0)
BL	_PC_btn_check+0
;P3_LED_manip.c,206 :: 		for (i = 0; i < delay_time_ms; i++) {
ADDS	R4, R4, #1
;P3_LED_manip.c,209 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_main38
L_main39:
;P3_LED_manip.c,210 :: 		}
UXTB	R2, R3
; count_mode end address is: 12 (R3)
IT	AL
BAL	L_main30
;P3_LED_manip.c,211 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
