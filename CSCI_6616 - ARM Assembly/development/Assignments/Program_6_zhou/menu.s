/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program 6 - Ring Buffer
	Name: Howard Zhou
 
	File: menu.s
 
 	Description:
		- Prints the menu to terminal
	
	Sample: 
		Ring Buffer App:
		1-Write
		2-Read
		3-Check Buffer state 0=normal, 1=full
		4-Initialize buffer to 0
		5-exit
		Enter choice > 2
		input data = 32
		Application Exit!
* ==========================================================================================
*/

.global menu_print, menu_print_exit						@ Allow external calls
.section .text

menu_print: @ print the menu and prompt
	PUSH {R4-R12, LR}				@ Save caller() reg values &LR
	LDR R0, =menu_str_options		@ load menu options string
	BL printf						@ call cstd printf for stdout
	LDR R0, =menu_str_prompt		@ load the prompt string
	BL printf

	POP {R4-R12, LR}				@ Restore caller() reg values
	BX LR							@ return to caller()

menu_print_exit: @ print the menu exit msg
	PUSH {LR}						@ Save LR; printf will overwrite LR
	LDR R0, =menu_str_exit			@ load exit message
	BL printf
	POP {LR}						@ restore LR
	BX LR							@ return to caller()

menu_print_write_full:
	PUSH {R4-R12, LR}
	LDR R0, =menu_str_full
	BL printf
    POP {R4-R12, LR}
	BX LR

menu_print_empty:
	PUSH {R4-R12, LR}
	LDR R0, =menu_str_empty
	BL printf
    POP {R4-R12, LR}
	BX LR


.data
.word @ 32 bit align all variables
	menu_str_options: 	.asciz "\nRing Buffer App:\n1) Write \n2) Read \n3) Check buffer state \n4) Initialize buffer to 0 \n5) Exit\n"
	menu_str_prompt:    .asciz "Enter choice > "
	menu_str_exit:		.asciz "Application exit!\n"
	menu_str_full:		.asciz "\n [!] WRITE FAILED - ring buffer full\n"
    menu_str_empty:     .asciz "\n [!] READ FAILED - buffer empty\n"
.end

