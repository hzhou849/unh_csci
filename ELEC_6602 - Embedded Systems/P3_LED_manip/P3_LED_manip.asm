_update_PD_LED:
;P3_LED_manip.c,49 :: 		void update_PD_LED(uint16_t *target_count) {
; target_count start address is: 0 (R0)
SUB	SP, SP, #4
; target_count end address is: 0 (R0)
; target_count start address is: 0 (R0)
;P3_LED_manip.c,50 :: 		GPIOD_ODR = (*target_count & 0x000000FF);  // GPIOD_ODR is 32bit, must pad target_count it will be promoted to uint32
LDRH	R1, [R0, #0]
; target_count end address is: 0 (R0)
AND	R2, R1, #255
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,51 :: 		}
L_end_update_PD_LED:
ADD	SP, SP, #4
BX	LR
; end of _update_PD_LED
_PC_btn_check:
;P3_LED_manip.c,54 :: 		void PC_btn_check(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_manip.c,57 :: 		if (GPIOC_IDR.B0 == 1) {
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check51
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,59 :: 		while (GPIOC_IDR.B0 == 1) {
L_PC_btn_check1:
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOC_IDR+0)
MOVT	R1, #hi_addr(GPIOC_IDR+0)
_LX	[R1, ByteOffset(GPIOC_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check2
;P3_LED_manip.c,60 :: 		Delay_ms(1);
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
;P3_LED_manip.c,61 :: 		}
IT	AL
BAL	L_PC_btn_check1
L_PC_btn_check2:
;P3_LED_manip.c,63 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check5
;P3_LED_manip.c,64 :: 		GPIOE_ODR = PD_HIGH_NUM << 8;
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,65 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
;P3_LED_manip.c,66 :: 		}
IT	AL
BAL	L_PC_btn_check6
L_PC_btn_check5:
;P3_LED_manip.c,68 :: 		GPIOE_ODR = PD_LOW_NUM  << 8;
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,69 :: 		*PE_display_mode = PE_MODE_LOW;
MOVS	R1, #0
STRB	R1, [R0, #0]
;P3_LED_manip.c,70 :: 		}
L_PC_btn_check6:
;P3_LED_manip.c,71 :: 		}
IT	AL
BAL	L_PC_btn_check0
; PE_display_mode end address is: 0 (R0)
L__PC_btn_check51:
;P3_LED_manip.c,57 :: 		if (GPIOC_IDR.B0 == 1) {
;P3_LED_manip.c,71 :: 		}
L_PC_btn_check0:
;P3_LED_manip.c,74 :: 		if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check52
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R1, #0]
CMP	R1, R2
IT	EQ
BEQ	L__PC_btn_check53
L__PC_btn_check46:
;P3_LED_manip.c,76 :: 		while ( GPIOB_IDR.B0 == 1) {
L_PC_btn_check10:
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check11
;P3_LED_manip.c,77 :: 		Delay_ms(1);
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
;P3_LED_manip.c,78 :: 		}
IT	AL
BAL	L_PC_btn_check10
L_PC_btn_check11:
;P3_LED_manip.c,80 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check14
;P3_LED_manip.c,82 :: 		--PD_LOW_NUM;
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R2, #0]
SUBS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,83 :: 		GPIOE_ODR = PD_LOW_NUM << 8;
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
;P3_LED_manip.c,91 :: 		}
L_PC_btn_check15:
;P3_LED_manip.c,74 :: 		if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {
IT	AL
BAL	L__PC_btn_check48
; PE_display_mode end address is: 0 (R0)
L__PC_btn_check52:
L__PC_btn_check48:
; PE_display_mode start address is: 0 (R0)
; PE_display_mode end address is: 0 (R0)
IT	AL
BAL	L__PC_btn_check47
L__PC_btn_check53:
L__PC_btn_check47:
;P3_LED_manip.c,94 :: 		if (  GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L__PC_btn_check50
MOVW	R1, #lo_addr(_PD_LOW_NUM+0)
MOVT	R1, #hi_addr(_PD_LOW_NUM+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R1, #0]
CMP	R1, R2
IT	EQ
BEQ	L__PC_btn_check49
L__PC_btn_check45:
;P3_LED_manip.c,97 :: 		while ( GPIOB_IDR.B4 == 1 ) {
L_PC_btn_check19:
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
MOVW	R1, #lo_addr(GPIOB_IDR+0)
MOVT	R1, #hi_addr(GPIOB_IDR+0)
_LX	[R1, ByteOffset(GPIOB_IDR+0)]
CMP	R1, #0
IT	EQ
BEQ	L_PC_btn_check20
;P3_LED_manip.c,98 :: 		Delay_ms(1);
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
;P3_LED_manip.c,99 :: 		}
IT	AL
BAL	L_PC_btn_check19
L_PC_btn_check20:
;P3_LED_manip.c,101 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
CMP	R1, #0
IT	NE
BNE	L_PC_btn_check23
;P3_LED_manip.c,103 :: 		++PD_LOW_NUM;
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,104 :: 		GPIOE_ODR = PD_LOW_NUM << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,107 :: 		}
IT	AL
BAL	L_PC_btn_check24
L_PC_btn_check23:
;P3_LED_manip.c,109 :: 		++PD_HIGH_NUM;
MOVW	R2, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R2, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R2, #0]
ADDS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R2, #0]
;P3_LED_manip.c,110 :: 		GPIOE_ODR = PD_HIGH_NUM  << 8;
LSLS	R2, R1, #8
UXTH	R2, R2
MOVW	R1, #lo_addr(GPIOE_ODR+0)
MOVT	R1, #hi_addr(GPIOE_ODR+0)
STR	R2, [R1, #0]
;P3_LED_manip.c,112 :: 		}
L_PC_btn_check24:
;P3_LED_manip.c,94 :: 		if (  GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
L__PC_btn_check50:
L__PC_btn_check49:
;P3_LED_manip.c,114 :: 		}
L_end_PC_btn_check:
ADD	SP, SP, #4
BX	LR
; end of _PC_btn_check
_get_PE_display_data:
;P3_LED_manip.c,117 :: 		void get_PE_display_data(uint8_t *PE_display_mode) {
; PE_display_mode start address is: 0 (R0)
SUB	SP, SP, #4
; PE_display_mode end address is: 0 (R0)
; PE_display_mode start address is: 0 (R0)
;P3_LED_manip.c,119 :: 		if (*PE_display_mode == PE_MODE_LOW) {
LDRB	R1, [R0, #0]
CMP	R1, #0
IT	NE
BNE	L_get_PE_display_data25
;P3_LED_manip.c,120 :: 		*PE_display_mode = PE_MODE_HIGH;
MOVS	R1, #1
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,121 :: 		}
IT	AL
BAL	L_get_PE_display_data26
L_get_PE_display_data25:
;P3_LED_manip.c,123 :: 		*PE_display_mode = PE_MODE_LOW;
; PE_display_mode start address is: 0 (R0)
MOVS	R1, #0
STRB	R1, [R0, #0]
; PE_display_mode end address is: 0 (R0)
;P3_LED_manip.c,124 :: 		}
L_get_PE_display_data26:
;P3_LED_manip.c,125 :: 		}
L_end_get_PE_display_data:
ADD	SP, SP, #4
BX	LR
; end of _get_PE_display_data
_main:
;P3_LED_manip.c,129 :: 		void main() {
SUB	SP, SP, #8
;P3_LED_manip.c,131 :: 		uint16_t combined_num    = 0;
;P3_LED_manip.c,132 :: 		uint16_t target_count    = 0;       // Set the lower bound number
MOVW	R0, #0
STRH	R0, [SP, #4]
;P3_LED_manip.c,133 :: 		uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
; count_mode start address is: 12 (R3)
MOVS	R3, #1
;P3_LED_manip.c,134 :: 		uint8_t  temp_num        = 0;
;P3_LED_manip.c,135 :: 		uint8_t  PA0_PWM_phase   = 0;
;P3_LED_manip.c,136 :: 		uint32_t PA0_led_counter = 0;
;P3_LED_manip.c,137 :: 		uint32_t i               = 0;
;P3_LED_manip.c,150 :: 		RCC_APB2ENR |= 1 << 2; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,151 :: 		RCC_APB2ENR |= 1 << 3; // Enable GPIO Clock - Port B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,152 :: 		RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - Port C
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,153 :: 		RCC_APB2ENR |= 1 << 5; // Enable GPIO Clock - Port D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,154 :: 		RCC_APB2ENR |= 1 << 6; // Enable GPIO Clock - Port E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,161 :: 		GPIOA_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,164 :: 		GPIOB_CRL = GPIO_DIR_INPUT;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,167 :: 		GPIOC_CRL = GPIO_DIR_INPUT;
MOV	R1, #1145324612
MOVW	R0, #lo_addr(GPIOC_CRL+0)
MOVT	R0, #hi_addr(GPIOC_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,170 :: 		GPIOD_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,171 :: 		GPIOD_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,174 :: 		GPIOE_CRL = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRL+0)
MOVT	R0, #hi_addr(GPIOE_CRL+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,175 :: 		GPIOE_CRH = GPIO_DIR_OUTPUT;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,179 :: 		if (PD_LOW_NUM > PD_HIGH_NUM) {
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	LS
BLS	L_main27
;P3_LED_manip.c,180 :: 		temp_num = PD_LOW_NUM; // Store the 'higher" number
MOVW	R2, #lo_addr(_PD_LOW_NUM+0)
MOVT	R2, #hi_addr(_PD_LOW_NUM+0)
; temp_num start address is: 16 (R4)
LDRB	R4, [R2, #0]
;P3_LED_manip.c,181 :: 		PD_LOW_NUM = PD_HIGH_NUM;
MOVW	R1, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R1, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R0, [R1, #0]
STRB	R0, [R2, #0]
;P3_LED_manip.c,182 :: 		PD_HIGH_NUM = temp_num;
STRB	R4, [R1, #0]
; temp_num end address is: 16 (R4)
;P3_LED_manip.c,183 :: 		}
IT	AL
BAL	L_main28
L_main27:
;P3_LED_manip.c,184 :: 		else if (PD_LOW_NUM == PD_HIGH_NUM) {
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	NE
BNE	L_main29
; count_mode end address is: 12 (R3)
;P3_LED_manip.c,187 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
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
;P3_LED_manip.c,188 :: 		GPIOD_ODR = combined_num;
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,189 :: 		GPIOE_ODR = combined_num << 8;
LSLS	R1, R1, #8
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,191 :: 		return;  // Exit program
IT	AL
BAL	L_end_main
;P3_LED_manip.c,192 :: 		}
L_main29:
; count_mode start address is: 12 (R3)
L_main28:
;P3_LED_manip.c,197 :: 		combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
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
;P3_LED_manip.c,198 :: 		GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
MOVW	R0, #65535
ANDS	R1, R0
UXTH	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P3_LED_manip.c,199 :: 		GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF) << 8;
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
;P3_LED_manip.c,202 :: 		target_count = PD_LOW_NUM;
MOV	R0, R2
LDRB	R0, [R0, #0]
STRH	R0, [SP, #4]
;P3_LED_manip.c,205 :: 		Delay_ms(1000);
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main30:
SUBS	R7, R7, #1
BNE	L_main30
NOP
NOP
NOP
; count_mode end address is: 12 (R3)
UXTB	R2, R3
;P3_LED_manip.c,210 :: 		for (;;) {
L_main32:
;P3_LED_manip.c,213 :: 		if (target_count == PD_HIGH_NUM) {
; count_mode start address is: 8 (R2)
MOVW	R0, #lo_addr(_PD_HIGH_NUM+0)
MOVT	R0, #hi_addr(_PD_HIGH_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L_main35
; count_mode end address is: 8 (R2)
;P3_LED_manip.c,214 :: 		count_mode = DECREMENT_MODE;
; count_mode start address is: 12 (R3)
MOVS	R3, #0
;P3_LED_manip.c,215 :: 		}
; count_mode end address is: 12 (R3)
IT	AL
BAL	L_main36
L_main35:
;P3_LED_manip.c,216 :: 		else if (target_count == PD_LOW_NUM) {
; count_mode start address is: 8 (R2)
MOVW	R0, #lo_addr(_PD_LOW_NUM+0)
MOVT	R0, #hi_addr(_PD_LOW_NUM+0)
LDRB	R1, [R0, #0]
LDRH	R0, [SP, #4]
CMP	R0, R1
IT	NE
BNE	L__main54
; count_mode end address is: 8 (R2)
;P3_LED_manip.c,217 :: 		count_mode = INCREMENT_MODE;
; count_mode start address is: 0 (R0)
MOVS	R0, #1
; count_mode end address is: 0 (R0)
UXTB	R3, R0
;P3_LED_manip.c,218 :: 		}
IT	AL
BAL	L_main37
L__main54:
;P3_LED_manip.c,216 :: 		else if (target_count == PD_LOW_NUM) {
UXTB	R3, R2
;P3_LED_manip.c,218 :: 		}
L_main37:
; count_mode start address is: 12 (R3)
; count_mode end address is: 12 (R3)
L_main36:
;P3_LED_manip.c,221 :: 		if (count_mode == INCREMENT_MODE) {
; count_mode start address is: 12 (R3)
CMP	R3, #1
IT	NE
BNE	L_main38
;P3_LED_manip.c,222 :: 		++target_count;
LDRH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,223 :: 		} else{
IT	AL
BAL	L_main39
L_main38:
;P3_LED_manip.c,224 :: 		--target_count;
LDRH	R0, [SP, #4]
SUBS	R0, R0, #1
STRH	R0, [SP, #4]
;P3_LED_manip.c,225 :: 		}
L_main39:
;P3_LED_manip.c,228 :: 		update_PD_LED(&target_count);
ADD	R0, SP, #4
BL	_update_PD_LED+0
;P3_LED_manip.c,236 :: 		for (i = 0; i < delay_time_ms; i++) {
; i start address is: 16 (R4)
MOVS	R4, #0
; count_mode end address is: 12 (R3)
; i end address is: 16 (R4)
L_main40:
; i start address is: 16 (R4)
; count_mode start address is: 12 (R3)
MOVW	R0, #lo_addr(_delay_time_ms+0)
MOVT	R0, #hi_addr(_delay_time_ms+0)
LDRH	R0, [R0, #0]
CMP	R4, R0
IT	CS
BCS	L_main41
;P3_LED_manip.c,237 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main43:
SUBS	R7, R7, #1
BNE	L_main43
NOP
NOP
NOP
;P3_LED_manip.c,291 :: 		PC_btn_check(&PE_display_mode);
MOVW	R0, #lo_addr(_PE_display_mode+0)
MOVT	R0, #hi_addr(_PE_display_mode+0)
BL	_PC_btn_check+0
;P3_LED_manip.c,236 :: 		for (i = 0; i < delay_time_ms; i++) {
ADDS	R4, R4, #1
;P3_LED_manip.c,294 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_main40
L_main41:
;P3_LED_manip.c,386 :: 		}
UXTB	R2, R3
; count_mode end address is: 12 (R3)
IT	AL
BAL	L_main32
;P3_LED_manip.c,390 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
