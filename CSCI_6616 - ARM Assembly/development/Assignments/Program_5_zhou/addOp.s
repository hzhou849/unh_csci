/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Program 5 Q-notation Add/subtract calculator
    Name: Howard Zhou
 
    File: addOp.s
 
     Description:
        - Perform addtion operation and print output
        
    Params: 
        R1 - Operand1
        R2 - Operand2
        R3 - Sum result
        R0  - Return value
    
    Members regs:
        R4 - operand1
        R5 - operand2
        R0 - SUM/return value


* ==========================================================================================
*/

@ Constant
.EQU SCALE_FACTOR, 256
.EQU DIVISOR_CORRECTION, 100

.global addOp
.section .text

addOp:
    PUSH {R4-R8, LR}			@ Save any previous values from caller()
    // process Operand1 
    MOV R4, R1			    	@ assign operand1 to R4
    TST R1, #0x80000000			@ Check if operand 1 is a negative num
    BEQ add_cont				@ positive num; if Zero flag is set, branch to cont for operand2
    MOV R3, #0					@ SUBNE requires constant value to subtract
    MVN R4, R4  				@ convert op1 to positive; get R4, compliment 
    ADD R4, R4, #1				@ add 1 to get twos comp
    SUBNE R4, R3, R4			@ If TST N=1(!= 0), convert to proper negative number

add_cont:
    // process Operand2
    MOV R5, R2					@ assign operand2 to R5
    TST R2, #0x80000000			@ Check if operand 2 is a negative num
    BEQ add_add					@ positive num; if zero flag is set, branch to add
    MOV R3, #0					@ SUBNE requires constant value to subtract
    MVN R5, R5					@ convert op2 to positive; get R5, compliment 
    ADD R5, R5, #1				@ add 1 to get twos comp
    SUBNE R5, R3, R5			@ If TST N=1(!= 0), convert to proper negative number

add_add:
    // Perform addition and print result
    MOV R1, R4					@ store operand1 in printf arg1 to be printed
    MOV R2, R5					@ store operand2 in printf arg2 to be printed
    ADD R3, R4, R5				@ Add store to R1 which is arg1 for printf; r3 will hold the result
    LDR R0, =addOp_result		@ string output arg1:operand1; arg2=op2; arg3=result
	PUSH {R3}					@ save sum, printf will clear this register
    BL printf
    POP {R3}					@ restore sum back into R3
	
	// 11.75 in Q8.8 should be 1011.1100
	// Achieve this by mul sum * 256
	// Since the sum has been scaled we need to divide by 100 to get the correct binary decimal place
	MOV R0, #SCALE_FACTOR		@ move scale factor to R0
	MUL R1, R3, R0				@ Sum * 256
	MOV R0, #DIVISOR_CORRECTION	@ #100 to correct scale/decimal 
	UDIV R4, R1, R0				@ R2 = SUM/ 100

	LDR R0, =afterDivide 		@ Load str msg
	MOV R1, R4					@ load divide result for printf
	BL printf

	// Shift bits to outBuffer to print
	// 1011.1100 0000
	MOV R3, #17					@ 8bits + '.' + 8bits_fraction = 17 chars
	MOV R5, #16					@ output buffer is 0-index; 17-1 = 0to16
	LDR R1, =outBuffer			@ output string to write to

	convert_bits:
		CMP R3, #0				@ loop until R3 count is 0
		BEQ print_binary
		CMP R3, #9				@ at this position, insert '.' decimal point
		BEQ insert_dec		
	cont:
		SUB R3, R3, #1			@ decrement overall count
		TST R4, #1				@ test AND mask 0x1 to test LSB on result
		LSR R4, R4, #1			@ right shift for next bit
		BEQ bit0				@ EQ (z=0) so bit is 0
		BNE bit1					@ NE (z=0) so bit is 1
		
	bit0:
		MOV R0, #0x30			@ ascii '0' 0x30;48d
		STRB R0, [R1, R3]		@ write '0' to output buffer 
		@ SUB R5, R5, #1			@ decrement counter
		B convert_bits
	
	bit1:
		MOV R0, #0x31			@ ascii '1' 0x31;49d
		STRB R0, [R1, R3]		@ write '1' to output buffer 
		@ SUB R5, R5, #1			@ decrement counter
		B convert_bits

	insert_dec:
		MOV R0, #'.'			
		SUB R3, R3, #1			@ move to the next slot so not to overwrite last value in buffer
		STRB R0, [R1, R3]		@ write '.' to outbuffer
		B cont					@ resume writing bits


	print_binary:
		LDR R0, =result_msg
		LDR R1, =outBuffer
		BL printf
		


	
	
	
	
	POP {R4-R8, LR}			@ Restore caller() register values and LR
    BX LR						@ return to main caller()


.data
.word		@ 32bit align all variables
	addOp_result: 	.asciz	"%d  + %d = %d\n"		@str: arg1=<op1>; arg2=<op2>; arg3=result
	afterDivide: 	.asciz "After divide /100: %d\n"
	result_msg: 	.asciz "Q8.8: %s\n"
	outBuffer: 		.space 24, 0					@ final result string to printf
.section	.note.GNU-stack, "",%progbits
.end
