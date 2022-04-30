_EXTIPB6:
;P6_interrupts.c,59 :: 		void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
SUB	SP, SP, #8
STR	LR, [SP, #0]
;P6_interrupts.c,63 :: 		EXTI_PR.B6 = 1;                                 // Clear pending regsiter interrupt flag for PB6
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;P6_interrupts.c,66 :: 		while (GPIOB_IDR.B6 == 1) {}                    // Wait here until button release
L_EXTIPB60:
MOVW	R0, #lo_addr(GPIOB_IDR+0)
MOVT	R0, #hi_addr(GPIOB_IDR+0)
_LX	[R0, ByteOffset(GPIOB_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_EXTIPB61
IT	AL
BAL	L_EXTIPB60
L_EXTIPB61:
;P6_interrupts.c,74 :: 		temp_val = time_count-1;                         // Subtract 1 because the value timecount will be incremented in TIMER function before next use
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
SUBS	R0, R0, #1
STR	R0, [SP, #4]
;P6_interrupts.c,75 :: 		convert_int(&temp_val);
ADD	R0, SP, #4
BL	_convert_int+0
;P6_interrupts.c,76 :: 		}
L_end_EXTIPB6:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _EXTIPB6
_EXTIPA4:
;P6_interrupts.c,79 :: 		void EXTIPA4() iv IVT_INT_EXTI4 ics ICS_AUTO {
;P6_interrupts.c,80 :: 		EXTI_PR.PA4 = 1;                                // Clear interrupt pending regsiter
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
_SX	[R0, ByteOffset(EXTI_PR+0)]
;P6_interrupts.c,82 :: 		while (GPIOA_IDR.B4 == 1) {}                    // Hold here until button is released
L_EXTIPA42:
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
_LX	[R0, ByteOffset(GPIOA_IDR+0)]
CMP	R0, #0
IT	EQ
BEQ	L_EXTIPA43
IT	AL
BAL	L_EXTIPA42
L_EXTIPA43:
;P6_interrupts.c,83 :: 		timer_run_flag = ~timer_run_flag;               // Flip the flag switch to toggle the timer counter on PORTD
MOVW	R0, #lo_addr(P6_interrupts_timer_run_flag+0)
MOVT	R0, #hi_addr(P6_interrupts_timer_run_flag+0)
LDR	R0, [R0, #0]
MVN	R1, R0
MOVW	R0, #lo_addr(P6_interrupts_timer_run_flag+0)
MOVT	R0, #hi_addr(P6_interrupts_timer_run_flag+0)
STR	R1, [R0, #0]
;P6_interrupts.c,85 :: 		}
L_end_EXTIPA4:
BX	LR
; end of _EXTIPA4
_TIMER2_ISR:
;P6_interrupts.c,88 :: 		void TIMER2_ISR() iv IVT_INT_TIM2 {
;P6_interrupts.c,90 :: 		TIM2_SR &=  ~(1 << 0);                              // Bit[0] = UIF update intrpt flag. 1 to reset
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,92 :: 		if (timer_run_flag == 1) {
MOVW	R0, #lo_addr(P6_interrupts_timer_run_flag+0)
MOVT	R0, #hi_addr(P6_interrupts_timer_run_flag+0)
LDR	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_TIMER2_ISR4
;P6_interrupts.c,93 :: 		GPIOD_ODR &= 0x00FF;                            // Wipe previous value
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,94 :: 		GPIOD_ODR |= ((time_count++) << 8) & 0xFF00;    // Pass the current timer value (shift 8 for High bank) then increment
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
LSLS	R0, R0, #8
AND	R1, R0, #65280
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, R1, LSL #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
STR	R1, [R0, #0]
;P6_interrupts.c,96 :: 		if (time_count > TIMER_COUNTER_MAX ) {
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
LDR	R0, [R0, #0]
CMP	R0, #99
IT	LS
BLS	L_TIMER2_ISR5
;P6_interrupts.c,97 :: 		time_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(P6_interrupts_time_count+0)
MOVT	R0, #hi_addr(P6_interrupts_time_count+0)
STR	R1, [R0, #0]
;P6_interrupts.c,98 :: 		}
L_TIMER2_ISR5:
;P6_interrupts.c,99 :: 		}
L_TIMER2_ISR4:
;P6_interrupts.c,100 :: 		}
L_end_TIMER2_ISR:
BX	LR
; end of _TIMER2_ISR
_USART1_ISR:
;P6_interrupts.c,103 :: 		void USART1_ISR() iv IVT_INT_USART1 {
;P6_interrupts.c,105 :: 		rx_buffer = USART1_DR;                          // RXNE bit interrupt is reset by reading data register
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_rx_buffer+0)
MOVT	R0, #hi_addr(_rx_buffer+0)
STR	R1, [R0, #0]
;P6_interrupts.c,108 :: 		while ( (USART1_SR & (1 << 7 )) == 0) {}
L_USART1_ISR6:
MOVW	R0, #lo_addr(USART1_SR+0)
MOVT	R0, #hi_addr(USART1_SR+0)
LDR	R0, [R0, #0]
AND	R0, R0, #128
CMP	R0, #0
IT	NE
BNE	L_USART1_ISR7
IT	AL
BAL	L_USART1_ISR6
L_USART1_ISR7:
;P6_interrupts.c,109 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_USART1_ISR8:
SUBS	R7, R7, #1
BNE	L_USART1_ISR8
NOP
NOP
NOP
;P6_interrupts.c,110 :: 		USART1_DR = rx_buffer;
MOVW	R0, #lo_addr(_rx_buffer+0)
MOVT	R0, #hi_addr(_rx_buffer+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,111 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_USART1_ISR10:
SUBS	R7, R7, #1
BNE	L_USART1_ISR10
NOP
NOP
NOP
;P6_interrupts.c,114 :: 		if (rx_buffer >= ASCII_READABLE_CHAR_START) {     // ASCII characters that are not special/invisible
MOVW	R0, #lo_addr(_rx_buffer+0)
MOVT	R0, #hi_addr(_rx_buffer+0)
LDR	R0, [R0, #0]
CMP	R0, #32
IT	CC
BCC	L_USART1_ISR12
;P6_interrupts.c,115 :: 		GPIOE_ODR = (++usart_count) << 8;
MOVW	R0, #lo_addr(P6_interrupts_usart_count+0)
MOVT	R0, #hi_addr(P6_interrupts_usart_count+0)
LDR	R0, [R0, #0]
ADDS	R1, R0, #1
MOVW	R0, #lo_addr(P6_interrupts_usart_count+0)
MOVT	R0, #hi_addr(P6_interrupts_usart_count+0)
STR	R1, [R0, #0]
MOVW	R0, #lo_addr(P6_interrupts_usart_count+0)
MOVT	R0, #hi_addr(P6_interrupts_usart_count+0)
LDR	R0, [R0, #0]
LSLS	R1, R0, #8
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,116 :: 		}
L_USART1_ISR12:
;P6_interrupts.c,117 :: 		}
L_end_USART1_ISR:
BX	LR
; end of _USART1_ISR
_MY_SWIER_ISR:
;P6_interrupts.c,120 :: 		void MY_SWIER_ISR() iv IVT_INT_EXTI15_10 {
;P6_interrupts.c,121 :: 		Delay_ms(SW_INT_DELAY_MS);
MOVW	R7, #50879
MOVT	R7, #45
NOP
NOP
L_MY_SWIER_ISR13:
SUBS	R7, R7, #1
BNE	L_MY_SWIER_ISR13
NOP
NOP
NOP
;P6_interrupts.c,122 :: 		EXTI_PR |= 1 << 15;                             // Clear the interrupt pending register.
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32768
MOVW	R0, #lo_addr(EXTI_PR+0)
MOVT	R0, #hi_addr(EXTI_PR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,123 :: 		GPIOD_ODR = (GPIOD_ODR & 0xFF00)  + ( (~GPIOD_ODR) & 0x00FF);
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
AND	R1, R0, #65280
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R0, #0]
MVN	R0, R0
AND	R0, R0, #255
ADDS	R1, R1, R0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,124 :: 		}
L_end_MY_SWIER_ISR:
BX	LR
; end of _MY_SWIER_ISR
_initClock72MHz:
;P6_interrupts.c,132 :: 		void initClock72MHz() {
SUB	SP, SP, #4
;P6_interrupts.c,136 :: 		RCC_CR = 0x05010081;
MOVW	R1, #129
MOVT	R1, #1281
MOVW	R0, #lo_addr(RCC_CR+0)
MOVT	R0, #hi_addr(RCC_CR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,143 :: 		RCC_CFGR = 0x091D8402; // IDE Scheme
MOVW	R1, #33794
MOVT	R1, #2333
MOVW	R0, #lo_addr(RCC_CFGR+0)
MOVT	R0, #hi_addr(RCC_CFGR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,150 :: 		RCC_CFGR2 = 0x00010644;
MOVW	R1, #1604
MOVT	R1, #1
MOVW	R0, #lo_addr(RCC_CFGR2+0)
MOVT	R0, #hi_addr(RCC_CFGR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,151 :: 		}
L_end_initClock72MHz:
ADD	SP, SP, #4
BX	LR
; end of _initClock72MHz
_convert_int:
;P6_interrupts.c,154 :: 		void convert_int(uint32_t *int_num) {
; int_num start address is: 0 (R0)
SUB	SP, SP, #16
STR	LR, [SP, #0]
; int_num end address is: 0 (R0)
; int_num start address is: 0 (R0)
;P6_interrupts.c,156 :: 		uint32_t temp_val  = 0;
;P6_interrupts.c,157 :: 		uint32_t ascii_msb = 0;
ADD	R11, SP, #4
ADD	R10, R11, #12
MOVW	R12, #lo_addr(?ICSconvert_int_ascii_msb_L0+0)
MOVT	R12, #hi_addr(?ICSconvert_int_ascii_msb_L0+0)
BL	___CC2DW+0
;P6_interrupts.c,158 :: 		uint32_t ascii_lsb = 0;
;P6_interrupts.c,159 :: 		uint32_t new_line_LF = 0xA;
;P6_interrupts.c,162 :: 		if (*int_num > TIMER_COUNTER_MAX ) {
LDR	R1, [R0, #0]
CMP	R1, #99
IT	LS
BLS	L_convert_int15
; int_num end address is: 0 (R0)
;P6_interrupts.c,163 :: 		return;
IT	AL
BAL	L_end_convert_int
;P6_interrupts.c,164 :: 		}
L_convert_int15:
;P6_interrupts.c,166 :: 		temp_val = *int_num;                        // Extract the MSB, convert to ASCII
; int_num start address is: 0 (R0)
LDR	R2, [R0, #0]
; temp_val start address is: 8 (R2)
; int_num end address is: 0 (R0)
; temp_val end address is: 8 (R2)
;P6_interrupts.c,167 :: 		while (temp_val >= 10) {
L_convert_int16:
; temp_val start address is: 8 (R2)
; int_num start address is: 0 (R0)
CMP	R2, #10
IT	CC
BCC	L_convert_int17
;P6_interrupts.c,168 :: 		temp_val /= 10;
MOVS	R1, #10
UDIV	R1, R2, R1
MOV	R2, R1
;P6_interrupts.c,169 :: 		ascii_msb = temp_val + ASCII_HEX_0;;
ADDS	R1, #48
STR	R1, [SP, #4]
;P6_interrupts.c,170 :: 		}
; temp_val end address is: 8 (R2)
IT	AL
BAL	L_convert_int16
L_convert_int17:
;P6_interrupts.c,173 :: 		if ( *int_num > 0 ) {                       // Extract the LSB, convert and set the LSB
LDR	R1, [R0, #0]
CMP	R1, #0
IT	LS
BLS	L_convert_int18
;P6_interrupts.c,174 :: 		temp_val = (*int_num %10);
LDR	R3, [R0, #0]
; int_num end address is: 0 (R0)
MOVS	R2, #10
UDIV	R1, R3, R2
MLS	R1, R2, R1, R3
;P6_interrupts.c,175 :: 		ascii_lsb = temp_val + ASCII_HEX_0;
ADDS	R1, #48
STR	R1, [SP, #8]
;P6_interrupts.c,176 :: 		}
L_convert_int18:
;P6_interrupts.c,178 :: 		Write_data_char (&new_line_LF, NO_NEW_LINE);
ADD	R1, SP, #12
MOV	R0, R1
MOVS	R1, #0
BL	_write_data_char+0
;P6_interrupts.c,179 :: 		write_data_char (&ascii_msb, NO_NEW_LINE);
ADD	R1, SP, #4
MOV	R0, R1
MOVS	R1, #0
BL	_write_data_char+0
;P6_interrupts.c,180 :: 		write_data_char (&ascii_lsb, NEW_LINE_EN);
ADD	R1, SP, #8
MOV	R0, R1
MOVS	R1, #1
BL	_write_data_char+0
;P6_interrupts.c,181 :: 		}
L_end_convert_int:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _convert_int
_write_data_char:
;P6_interrupts.c,185 :: 		void write_data_char(uint32_t *tx_char, uint8_t new_line) {
; new_line start address is: 4 (R1)
; tx_char start address is: 0 (R0)
SUB	SP, SP, #4
; new_line end address is: 4 (R1)
; tx_char end address is: 0 (R0)
; tx_char start address is: 0 (R0)
; new_line start address is: 4 (R1)
STRB	R1, [SP, #0]
; tx_char end address is: 0 (R0)
; new_line end address is: 4 (R1)
MOV	R1, R0
LDRB	R0, [SP, #0]
;P6_interrupts.c,189 :: 		while( (USART1_SR & (1 << 7)) == 0) {}      // Extract the MSB, conver the MSB
L_write_data_char19:
; new_line start address is: 0 (R0)
; tx_char start address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_SR+0)
MOVT	R2, #hi_addr(USART1_SR+0)
LDR	R2, [R2, #0]
AND	R2, R2, #128
CMP	R2, #0
IT	NE
BNE	L_write_data_char20
IT	AL
BAL	L_write_data_char19
L_write_data_char20:
;P6_interrupts.c,191 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char21:
SUBS	R7, R7, #1
BNE	L_write_data_char21
NOP
NOP
NOP
;P6_interrupts.c,192 :: 		USART1_DR = *tx_char;
LDR	R3, [R1, #0]
; tx_char end address is: 4 (R1)
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P6_interrupts.c,194 :: 		if (new_line == NEW_LINE_EN) {
CMP	R0, #1
IT	NE
BNE	L_write_data_char23
; new_line end address is: 0 (R0)
;P6_interrupts.c,195 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char24:
SUBS	R7, R7, #1
BNE	L_write_data_char24
NOP
NOP
NOP
;P6_interrupts.c,196 :: 		USART1_DR = CHAR_CR;
MOV	R3, #13
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P6_interrupts.c,197 :: 		Delay_ms(10);
MOVW	R7, #54463
MOVT	R7, #1
NOP
NOP
L_write_data_char26:
SUBS	R7, R7, #1
BNE	L_write_data_char26
NOP
NOP
NOP
;P6_interrupts.c,198 :: 		USART1_DR = CHAR_LF;
MOV	R3, #10
MOVW	R2, #lo_addr(USART1_DR+0)
MOVT	R2, #hi_addr(USART1_DR+0)
STR	R3, [R2, #0]
;P6_interrupts.c,199 :: 		}
L_write_data_char23:
;P6_interrupts.c,200 :: 		}
L_end_write_data_char:
ADD	SP, SP, #4
BX	LR
; end of _write_data_char
_main:
;P6_interrupts.c,203 :: 		void main() {
SUB	SP, SP, #4
;P6_interrupts.c,206 :: 		initClock72MHz();
BL	_initClock72MHz+0
;P6_interrupts.c,209 :: 		USART1_CR1 &= ~(1 << 13);                  // Diasable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,211 :: 		AFIO_MAPR    = 0x00000000;                 // Bit[2] USART1 Remap 0: No remap remap timer2 stuff
MOVS	R1, #0
MOVW	R0, #lo_addr(AFIO_MAPR+0)
MOVT	R0, #hi_addr(AFIO_MAPR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,212 :: 		RCC_APB2ENR |= 0x00000001;                 // Alt. function bit to enable USART1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,215 :: 		RCC_APB2ENR |= 1 << 2;                     // Enable GPIO Clock PORT A  Interrupt test
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,216 :: 		RCC_APB2ENR |= 1 << 3;                     // Enable GPIO Clock PORT B
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,217 :: 		RCC_APB2ENR |= 1 << 5;                     // Enable GPIO Clock PORT D
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,218 :: 		RCC_APB2ENR |= 1 << 6;                     // Enable GPIO Clock PORT E
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,219 :: 		RCC_APB2ENR |= 1 << 14;                    // Enable USART1 Clock for USART and
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16384
MOVW	R0, #lo_addr(RCC_APB2ENR+0)
MOVT	R0, #hi_addr(RCC_APB2ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,223 :: 		GPIOA_CRH &= ~(0xFF << 4);                 // Shift 4 bits left to clear out bits PA9/PA10 mask with FFFF F00F
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R1, [R0, #0]
MOVW	R0, #61455
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,224 :: 		GPIOA_CRH |=  (0x0B << 4);                 // USART1 Tx/PA9 set CNF=AF output push-pull b10; MODE: 50Hz b11; = b1011 = 0x0b
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #176
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,225 :: 		GPIOA_CRH |=  (0x04 << 8);                 // USART1 Rx/PA10 set CNF=input-floating b01; MODE: input b00; = b0100 = 0x04
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(GPIOA_CRH+0)
MOVT	R0, #hi_addr(GPIOA_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,227 :: 		GPIOA_CRL |=  0x44444444 << 16;            // PA1 input CNF=input-floating b01; MODE: input b00 = 0x0100;
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17476
ORRS	R1, R0
MOVW	R0, #lo_addr(GPIOA_CRL+0)
MOVT	R0, #hi_addr(GPIOA_CRL+0)
STR	R1, [R0, #0]
;P6_interrupts.c,228 :: 		GPIOB_CRL |= (uint32_t) (0x04 << 24);      // PB6 input CNF=input-floating b01; MODE: input b00 = 0x0100;
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIOB_CRL+0)
MOVT	R0, #hi_addr(GPIOB_CRL+0)
STR	R1, [R0, #0]
;P6_interrupts.c,230 :: 		GPIOD_CRL = 0x33333333;                    // PD0:7   CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRL+0)
MOVT	R0, #hi_addr(GPIOD_CRL+0)
STR	R1, [R0, #0]
;P6_interrupts.c,231 :: 		GPIOD_CRH = 0x33333333;                    // PD8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOD_CRH+0)
MOVT	R0, #hi_addr(GPIOD_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,232 :: 		GPIOE_CRH = 0x33333333;                    // PE8:15  CNF=GP output push-pull; b00; MODE: 50MHz b11 = 0x0011;
MOV	R1, #858993459
MOVW	R0, #lo_addr(GPIOE_CRH+0)
MOVT	R0, #hi_addr(GPIOE_CRH+0)
STR	R1, [R0, #0]
;P6_interrupts.c,236 :: 		USART1_BRR = 0x00000506;                   // Clock=72MHz, oversample=16; 72MHz / (16*56,000) = 80.357
MOVW	R1, #1286
MOVW	R0, #lo_addr(USART1_BRR+0)
MOVT	R0, #hi_addr(USART1_BRR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,240 :: 		USART1_CR1 &= ~(1 << 13);                  // Disable USART for configuration
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,241 :: 		USART1_CR1 |= 1 << 5;                      // ENABLE USART1 TXNE interrupt
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,242 :: 		USART1_CR1 &= ~(1 << 12);                  // Force 8 data bits. Mbit set to 0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #4096
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,243 :: 		USART1_CR1 &= ~(3 << 9);                   // Force no Parity & no parity control
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R1, [R0, #0]
MVN	R0, #1536
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,244 :: 		USART1_CR2 &= ~(3 << 12);                  // Force 1 stop bit
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
LDR	R1, [R0, #0]
MVN	R0, #12288
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR2+0)
MOVT	R0, #hi_addr(USART1_CR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,245 :: 		USART1_CR3 &= ~(3 << 8);                   // Force no flow control and no DMA for USART1
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
LDR	R1, [R0, #0]
MVN	R0, #768
ANDS	R1, R0
MOVW	R0, #lo_addr(USART1_CR3+0)
MOVT	R0, #hi_addr(USART1_CR3+0)
STR	R1, [R0, #0]
;P6_interrupts.c,246 :: 		USART1_CR1 |=  3 << 2;                     // Rx, Tx Enable
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #12
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,248 :: 		Delay_ms(100);                             // Allow time for USART1 to complete initialization
MOVW	R7, #20351
MOVT	R7, #18
NOP
NOP
L_main28:
SUBS	R7, R7, #1
BNE	L_main28
NOP
NOP
NOP
;P6_interrupts.c,249 :: 		USART1_CR1 |= 1 << 13;                     // **NOTE: USART1 Enable must be done after configuration is complete.
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(USART1_CR1+0)
MOVT	R0, #hi_addr(USART1_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,253 :: 		RCC_APB1ENR |= 1 << 0;                     // Enable TIMER2 Clock;
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,257 :: 		TIM2_CR1 = 0x0000;                         // Disable the timer for config/setup.s
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,259 :: 		TIM2_PSC = 7999;                           // Counter clock freq is equal to clk_PSC / (PSC[15:0] + 1)
MOVW	R1, #7999
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;P6_interrupts.c,262 :: 		TIM2_ARR = 9000;                           // Set the auto-reload register to the value calculated above
MOVW	R1, #9000
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,264 :: 		TIM2_DIER |= 1 << 0;                       // Allow timer Update interrupt enable
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
STR	R1, [R0, #0]
;P6_interrupts.c,266 :: 		TIM2_CR1 = 0x0001;                         // After timer setup, enable TIMER2; bit4=0 counting up.
MOVS	R1, #1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,271 :: 		AFIO_EXTICR2 |= 0x00000000;                // PA4 as External interrupt; Pin4/EXTI4[3:0] PortA=b0000
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,272 :: 		AFIO_EXTICR2 |= 0x00000100;                // PB6 as Enternal interrupt; Pin6/EXTI6[3:0] PortB=b0001
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #256
MOVW	R0, #lo_addr(AFIO_EXTICR2+0)
MOVT	R0, #hi_addr(AFIO_EXTICR2+0)
STR	R1, [R0, #0]
;P6_interrupts.c,274 :: 		EXTI_RTSR    |= 1 << 4;                    // Set Edge trigger register for interrupt on rising edge for PA4 and PB6
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,275 :: 		EXTI_RTSR    |= 1 << 6;                    // Mask to enable TR6 and TR4 (EXTI6 and EXTI4) b1=rising trigger enabled
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #64
MOVW	R0, #lo_addr(EXTI_RTSR+0)
MOVT	R0, #hi_addr(EXTI_RTSR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,276 :: 		EXTI_IMR     |= 0x00000050;                // Set interrupt request from TR6 and TR4 to not masked (cpu CANNOT ignore it)
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #80
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,291 :: 		NVIC_ISER0 |= 1 << 10;                    // Enable NVIC interrupt set enable registers for EXTI1 line zero (PA1)
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P6_interrupts.c,292 :: 		NVIC_ISER0 |= (long int) 1 << 23;         // Enable NVIC interrupt set enable registers for EXTI6 PB6
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8388608
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P6_interrupts.c,293 :: 		NVIC_ISER0 |= (uint32_t) 1 << 28;         // Enable NVIC interrupt enable for TIM2 global interrupt vector mapping 28
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #268435456
MOVW	R0, #lo_addr(NVIC_ISER0+0)
MOVT	R0, #hi_addr(NVIC_ISER0+0)
STR	R1, [R0, #0]
;P6_interrupts.c,294 :: 		NVIC_ISER1   |= 1 << 5;                    // USART1: ISER1 interrupts vector: vector IRQ37 = ISER1; #63-32; 32+5 =37
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #32
MOVW	R0, #lo_addr(NVIC_ISER1+0)
MOVT	R0, #hi_addr(NVIC_ISER1+0)
STR	R1, [R0, #0]
;P6_interrupts.c,297 :: 		EXTI_IMR |= 1 << 10;                       // Interrupt mask register - not masked; cpu cannot ignore this IRQ
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(EXTI_IMR+0)
MOVT	R0, #hi_addr(EXTI_IMR+0)
STR	R1, [R0, #0]
;P6_interrupts.c,298 :: 		NVIC_ISER1.B8 = 1;                         // EXTI-15_10 is position 40 on NVIC table ISER1 63:32 bit[0] is
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ISER1+0)
MOVT	R1, #hi_addr(NVIC_ISER1+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #8, #1
STR	R0, [R1, #0]
;P6_interrupts.c,316 :: 		NVIC_IPR10 |= 0xFF << 0;
MOVW	R0, #lo_addr(NVIC_IPR10+0)
MOVT	R0, #hi_addr(NVIC_IPR10+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #255
MOVW	R0, #lo_addr(NVIC_IPR10+0)
MOVT	R0, #hi_addr(NVIC_IPR10+0)
STR	R1, [R0, #0]
;P6_interrupts.c,320 :: 		rx_buffer = USART1_DR;
MOVW	R0, #lo_addr(USART1_DR+0)
MOVT	R0, #hi_addr(USART1_DR+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_rx_buffer+0)
MOVT	R0, #hi_addr(_rx_buffer+0)
STR	R1, [R0, #0]
;P6_interrupts.c,323 :: 		for (;;) {
L_main30:
;P6_interrupts.c,326 :: 		if  (EXTI_SWIER.B10 != 1) {
MOVW	R0, #lo_addr(EXTI_SWIER+0)
MOVT	R0, #hi_addr(EXTI_SWIER+0)
_LX	[R0, ByteOffset(EXTI_SWIER+0)]
CMP	R0, #0
IT	NE
BNE	L_main33
;P6_interrupts.c,327 :: 		EXTI_SWIER |= 1 << 10;              // ENable SWIER_EXTI line 10 trigger to blink PORTD/L LEDs on differnt interval
MOVW	R0, #lo_addr(EXTI_SWIER+0)
MOVT	R0, #hi_addr(EXTI_SWIER+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1024
MOVW	R0, #lo_addr(EXTI_SWIER+0)
MOVT	R0, #hi_addr(EXTI_SWIER+0)
STR	R1, [R0, #0]
;P6_interrupts.c,328 :: 		}
L_main33:
;P6_interrupts.c,329 :: 		Delay_ms(1);
MOVW	R7, #11999
MOVT	R7, #0
NOP
NOP
L_main34:
SUBS	R7, R7, #1
BNE	L_main34
NOP
NOP
NOP
;P6_interrupts.c,330 :: 		}
IT	AL
BAL	L_main30
;P6_interrupts.c,331 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
