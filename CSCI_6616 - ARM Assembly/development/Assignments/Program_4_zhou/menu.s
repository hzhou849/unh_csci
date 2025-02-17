/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program 4 Add/subtract calculator
	Name: Howard Zhou
 
	File: menu.s
 
 	Description:
		- Prints the menu to terminal
	Calculator App:
	1-Add
	2-Subtract
	3-Multiply
	4-Divide
	5-exit
	Enter choice > 2
	input data = 32
	Application Exit!


	
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

* ==========================================================================================
*/

.global menu_print, menu_print_exit
.section .text

menu_print:	@ print the menu and prompt
	PUSH {R4-R12, LR}				@ Save source/caller() register values & LR
	LDR R0, =menu_options			@ load menu options string
	BL printf						@ call cstd printf to output to terminal
	LDR R0, =menu_prompt			@ load the prompt msg to be printed 
	BL printf						

	POP {R4-R12, LR}				@ Restore source() registers
	BX LR							@ return to caller()

menu_print_exit: @ Prints the menu exit msg
	PUSH {LR}						@ LR will be overwritten by printf, need to save it
	LDR R0, =menu_exit_msg			@ load the exit message string into R0
	BL printf						@ call cstd printf
	POP {LR}
	BX LR							@ return to caller()


.data
	menu_options:	.asciz "\nCalculator App:\n\n1-Add\n2-Subtract\n3-Multiply\n4-Divide\n5-exit\n\n"
	menu_prompt: 	.asciz "Enter choice > "
	menu_exit_msg:	.asciz "Application Exit!\n"

.section .note.GNU-stack, "",%progbits
.end
