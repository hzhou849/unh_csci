/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Program 4 Add/subtract calculator
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

.global addOp
.section .text

addOp:
    PUSH {R4, R5, LR}			@ Save any previous values from caller()
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
    ADD R5, R5, #1				@ add 1 to get two's comp
    SUBNE R5, R3, R5			@ If TST N=1(!= 0), convert to proper negative number

add_add:
    // Perform addition and print result
    MOV R1, R4					@ store operand1 in printf's arg1 to be printed
    MOV R2, R5					@ store operand2 in printf's arg2 to be printed
    ADD R3, R4, R5				@ Add store to R1 which is arg1 for printf
    LDR R0, =addOp_result		@ string output arg1:operand1; arg2=op2; arg3=result
    BL printf
    POP {R4, R5, LR}			@ Restore caller() register values and LR
    BX LR						@ return to main caller()


.data
.word		@ 32bit align all variables
addOp_result: .asciz	"%d  + %d = %d"		@str: arg1=<op1>; arg2=<op2>; arg3=result
.section	.note.GNU-stack, "",%progbits
.end
