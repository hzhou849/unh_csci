/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program 4 Add/subtract calculator
	Name: Howard Zhou

	File: calc.s

	Description:
		- Create a menu driven application that we will build out over the  term to implement a calculator.
		- The calculator implemented will only be capable of integer arithmetic for now.
		- All numbers will be whole numbers without a fractional part.
		- This assignment will focus on implementing the menu system along and the add or subtract selection.
		- floating-point capability added to this application later.


		@ Write syscalls
		R0 - 0=stdin; 1=stdout; 3=stderr
		R2 - stores length of string
		R7 - linux service 3=read; 4=write


		@ Scanf registers:
			R0: pointer to var containing format specifier %d, %c %h etc..
			R1: input data buffer to store char ( requires actual char value ie 0x31 = '1')
		
		@ Printf registers:
			R0: contains address of string data var to print
			R1..R?: args used for variable print

		@ main registers:
			R0-R3 - Temprory work registers
			R4 - Operand1
			R5 - Operand2
			R6 - Menu option value
 * ========================================================================================== 
 */



@ function includes: menus.s, addOps.s, subOpbs.s

@ Define our variables
.EQU _EXIT_CODE, 1
.EQU OPTION_1, 1
.EQU OPTION_2, 2
.EQU OPTION_3, 3
.EQU OPTION_4, 4
.EQU OPTION_5, 5

.global main
.section .text

main:
	BL menu_print				@ print menu; calls menu::menu_print()

	// 1 - Get menu option 
	LDR R0, =in_fmt_specifer	@ Set the format specifier (%d)
	LDR R1, =operand1
	BL scanf					@ call scanf to get value into R1 buffer
	BL getchar					@ flush whitespace in buffer left by scanf				
	LDR R4, =operand1			@ loads address of scanf input-data_buf; R4=operand1
	LDR R6, [R4]				@ de-reference R4 to get actual 'char' and place in R6.

	// 3 - check what is selected by user
	CMP R6, #OPTION_1			@ if addition, branch to add()
	BEQ opt1
	CMP R6, #OPTION_2			@ elif 2=subract, branch to subtract()
	BEQ opt2
	CMP R6, #OPTION_3			@ elif 3=multiply, not implemented
	BEQ errmsg
	CMP R6, #OPTION_4			@ elif 4=divide, not implemented										
	BEQ errmsg
	CMP R6, #OPTION_5			@ elif 5= exit
	BEQ exit
	B errmsg					@ else, if invalid entry, goto errmsg

opt1: @ Addition
	BL getOperands
	LDR R1, [R4]				@ addOp arg1=copy operand 1 into R1
	LDR R2, [R5]				@ addOp arg2=R2	
	BL addOp					@ Branch to addOp.s 
	B main						@ Restart main loop
	
opt2: @ Subtraction
	BL getOperands
	LDR R1, [R4]				@ addOp arg1=copy operand 1 into R1
	LDR R2, [R5]				@ addOp arg2=R2	
	BL subOp					@ branch to subOp.s
	B main						@ restart main loop

opt3:
	@ TODO: later implementation
opt4:
	@ TODO: later implementation


getOperands: @ Get operands from user input
	PUSH {LR}					@ Save LR on stack 
	LDR R0, =opPrompt			@ load op prompt string
	MOV R1, #1					@ arg for operand 1 
	BL printf					@ print operand prompt str
	LDR R0, =in_fmt_specifer	@ Set the format specifier (%d)
	LDR R1, =operand1			
	BL scanf					@ call scanf to get value into R1 buffer
	MOV R0, #0					@ 0=FD for stdin
	BL getchar					@ flush whitespace in buffer left by scanf
	LDR R0, =opStr				@ String essage wtih variable to be printed
	LDR R4, =operand1			@ load operand address; R4=operand1
	MOV R1, #1					@ arg1: operand count
	LDR R2, [R4]				@ arg2: defrence and get oprand1 value; prints %x
	LDR R3, [R4]				@ arg3: same to print %d value
	BL printf

		@ //3 - get input - operand2
	LDR R0, =opPrompt			@ load op prompt string
	MOV R1, #2					@ arg for operand 1 
	BL printf					@ print operand prompt str
	LDR R0, =in_fmt_specifer	@ Set the format specifier (%d)
	LDR R1, =operand2			
	BL scanf					@ call scanf to get value into R1 buffer
	MOV R0, #0					@ 0=FD for stdin
	BL getchar					@ flush whitespace in buffer left by scanf
	LDR R0, =opStr				@ String essage wtih variable to be printed
	LDR R5, =operand2			@ load operand2 address; R5=operand2
	MOV R1, #2					@ arg1: operand count
	LDR R2, [R5]				@ arg2: defrence and get oprand1 value; prints %x
	LDR R3, [R5]				@ arg3: same to print %d value
	BL printf
	POP {LR}					@ Restore LR from stack 
	BX LR						@ return


errmsg: 
	LDR R0, =errStr				@ load error string for printf
	BL printf
	B main						@ go back to top(main)

exit:
	BL menu_print_exit			@ exit message; calls menu::menu_print()
	MOV R0, #0					@ exit return code
	MOV R7, #_EXIT_CODE			@ 1=exit service code
	SVC 0

.data
.word 	@ 32bit align all variables
	opStr: .asciz	"Operand[%d] = 0x%x; %dd\n"
	result: .asciz  ""
	opPrompt: .asciz	"\nEnter operand %d > "
	errStr: .asciz  "\nOption selected not recognized. Try again...\n"
	in_fmt_specifer: .asciz "%ld"
	inBuffer: .space 4, 0 @ Reserve 4 bytes and fill with zeros
	operand1: .word 0x12345678  @ Reserve 4 bytes and fill with zeros
	operand2: .word 0x12345678 @ Reserve 4 bytes and fill with zeros

.section .note.GNU-stack, "", %progbits		@ disable GNU stack warning
.end
