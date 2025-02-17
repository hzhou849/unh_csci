/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program 4 Add/subtract calculator
	Name: Howard Zhou
 
	File: addOps.s
 
 	Description:
		- Perform addtion 
		
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

.global addOp
.section .text

addOp:
	PUSH {R4, R5, LR}			@ Save any previous values from caller()
	
	// Operand1 
	MOV R4, R1					@ assign operand1 to R4
	TST R4, 0x80000000			@ Check if operand 1 is a negative num
	SUBNE, R4, #0, R4			@ If TST N=1(!= 0), convert to negative number
	
	MOV R3, R5					@ assign operand2 to R5
	TST R5, 0x80000000			@ Check if operand 2 is a negative num
	SUBNE, R4, #0, R4			@ If TST N=1(!= 0), convert to negative number

addNum:
	// 1. perform addition and print result
	ADD R1, R4, R5				@ Add store to R1 which is arg1 for printf
	LDR R0, =addOps_result		@ string output arg1:operand1; arg2=op2; arg3=result
	BL printf

	POP {R4, R5, LR}			@ Restore caller() register values and LR
	
	BX LR						@ return to main caller()



.data
.word		@ 32bit align all variables
addOps_result: .asciz	"%d  + %d = %d"		@str: arg1=<op1>; arg2=<op2>; arg3=result
.section	.note.GNU-stack, "",%progbits
.end
