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

		The example below shows the required menu system illustrating the operation of the add and subtract selections.
		In addition, the exit selection operation is illustrated.

		Note your implementation must handle negative numbers for integers.

		Make sure to use functions to implement this application.

		Here is the menu system required.

		Calculator App

		1-Add

		2-Subtract

		3-Multiply

		4-Divide

		5-Exit

		Enter Choice > 1

		Enter Operand 1 > 2

		Enter Operant 2 > 2

		2+2=4

		5-Exit

		Enter Choice > 5

		Application Exit!


		Write syscalls
		R0 - 0=stdin; 1=stdout; 3=stderr
		R2 - stores length of string
		R7 - linux service 3=read; 4=write

 * ========================================================================================== 
 */

@ Scanf registers:
@ R0: pointer to var containing format specifier %d, %c %h etc..
@ R1: input data buffer to store char ( requires actual char value ie 0x31 = '1')
@
@ Printf registers
@ R0: contains address of string data var to print
@ R1..R?: args used for variable print

@ function includes: menus.s, addOps.s, subOpbs.s

@ Define our variables
.EQU _EXIT_CODE, 1
.EQU OPTION_1, 0x31
.EQU OPTION_2, 0x32
.EQU OPTION_3, 0x33
.EQU OPTION_4, 0x34
.EQU OPTION_5, 0x35

.global main
.section .text

	// 1 - print menu 
main:
	BL menu_print				@ print menu; calls menu::menu_print()


	// 2 - get input
	@ Scanf
retry:
	LDR R0, =in_format_specifer
	LDR R1, =input_data_buf

	BL scanf
	@ if using scanf a extra '\n' char from user hitting enter will be captured which causes the next time 
	@ you run scanf (ie loop) to automatically run by itself again 
	@call getchar to counter_act scanf's issue with '\n' capture. this will flush the buffer
	BL getchar					
	
	
	


	// Load the value from scanf into R1
	LDR R0, =result
	LDR R2, =input_data_buf 	@ loads address of input-data_buf
	LDR R1, [R2]				@ dereference R2 to get actual 'char' and place in R1. 
	BL printf

	MOV R4, #5
	ADD R4, R4, #5
	SUB R4, R4, #12
	
	

	// 3 - check what is selected by user
	// if 1,2 = add subtract jump
	// if 2,3 = print message, feature not implemented yet
	// if 5 = exit

	CMP R4, #OPTION_1					@ if addition, branch to add()
	@ BEQ addOps
	
	CMP R4, #OPTION_2					@ elif 2=subract, branch to subtract()
	@ BEQ subOps
	
	CMP R4, #OPTION_3					@ elif 3=multiply, not implemented
	BEQ errmsg
	
	CMP R4, #OPTION_4				@ elif 4=divide, not implemented										
	BEQ errmsg
	
	CMP R4, #OPTION_5					@ elif 5= exit
	BEQ exit
	
errmsg: 
	LDR R0, =errStr				@ load error string for printf
	BL printf
	
	B main					@ go back to top(main)

exit:
	BL menu_print_exit			@ exit message; calls menu::menu_print()
	MOV R0, #0					@ exit return code
	MOV R7, #_EXIT_CODE			@ 1=exit service code
	SVC 0

.data
.word 	@ 32bit align all variables
	result: .asciz	"input data = %x\n"
	prompt: .asciz	"Enter value > "
	errStr: .asciz  "Option not implemented yet. Try again...\n"
	in_format_specifer: .asciz "%c"
	input_data_buf: .space 4, 0 @ Reserve 4 bytes and fill with zeros

.section .note.GNU-stack, "", %progbits		@ disable GNU stack warning
.end
