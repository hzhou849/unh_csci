/* CSCI_6616 - ARM Assembly Programming
 * 
 * Project: Program 2 32bit counter to 64k
 * Name: Howard Zhou
 *
 * Description:
 * This program implements a 32bit counter that will count to 64k or 0xFFFF then terminate
 * 
 */

@ .section  .note.GNU-stack, “ ”, @progbits
.section .text								@ Defines memory that stores instructions
.global main								@ Defines memory entry point 

main:
	MOV R0, #0								@ Initialize R0 to 0
	MOVW R1, #0xFFFF						@ Assign LSB
	MOVT R1, #0x0000						@ Assign MSB

loop:										@ For loop if(R0 >= 0xFFF) then exit
	CMP R0, R1							@ Compare if 0 ? R0-Operand2
	BGE exit								@ Branch if R0 >= 0xFFFF

	@ 'else'
	ADD R0, #1								@ 'Else' increment R0++
	B loop									@ Unconditionally loop back to top of loop()

exit:
	MOV R0, #0								@ Set return code 0
	MOV R7, #1								@ Service command code 1=terminate program
	SVC 0									@ Interupt to execute syscall


@ .section    .note.GNU-stack, "", @progbits

