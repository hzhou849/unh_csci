/*
 * File: main.s
 * 
 * Arm program To uppper with functions BL BX and stack 
 * 
 * R0 - R2 Params to linux syscalls
 * R1 - Address of output string
 * R0 - Address of input string
 * R5 - Current char being processed
 * R7 - Linux command number
 *
 */
.section .text
.global main							@ Main entry point for gcc
main:		
	LDR R0, =instr						@ Start address of input string
	LDR R1, =outstr						@ address of output stirng					
	BL toupper							@ Store next line address in LR and jump to toupper

	@ setup params to printout string to terminal
	MOV R2, R0 							@ return code is the length fo the string
	MOV R0, #1							@ 1=stdout
	LDR R1, =outstr						@ load the address of outstr to print into R1
	MOV R7, #4							@ linux syscall to write to
	SVC 0								@ system call execute

	@ setup params to exit the program
	MOV R0, #0							@ return code =0
	MOV R7, #1							@ linux syscall to exit
	SVC 0								@ syscall execute

.data
	instr:	.asciz	"This is out Test String that we will convert.\n"
	outstr: .fill 255, 1, 0				@ intialize memory 255 times 1 byte with zeros

@ Rememdy warning message:
@ /usr/bin/ld: warning: main.o: missing .note.GNU-stack section implies executable stack
@ /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
.section	.note.GNU-stack,"",%progbits
.end
