/* ==========================================================================================
 * CSCI_6616 - ARM Assembly Programming
 * 
 * Project: Program 2 32bit counter to 64k
 * Name: Howard Zhou
 *
 * Description:
 * Program #3 will require the extension of the uio.s module we discussed in class.
 * Recall this module accepted input from STDIN and rendered the input to STDOUT infinitely.
 * Modify the program to do the following;
 * 1.  Detect if a char entered is not numeric (0-9).
 * 2.  If a non-numeric char is input prompt the user to reenter and gather this input.  
 * 3.  Accept up to 3 numeric digits.  Input maybe from 1 to 3 digits BASE 10.
 * 3.  Produce a binary representation of the decimal input and store in a register.
 * 4.  Render the converted input back out to STDOUT.
 *
 * Write syscalls
 * R0 - 0=stdin; 1=stdout; 3=stderr
 * R2 - stores length of string
 * R7 - linux service 3=read; 4=write
 * ========================================================================================== 
 */

 .section .text
 .global main							@ main entry point for gcc
 
main:
	LDR R1, =prompt						@ load prompt char into R1
	MOV R2, #1							@ length of string is 1 char
	MOV R0, #1							@ set 1=stdio
	MOV R7, #4							@ linux syscal 4=write
	SVC 0								@ interrupt to execute syscall

l1:
	LDR R1, =inbuff						@ pointer address for input buffer load into R1
	MOV R2, #5							@ Read one char + '\n' to capture enter
	MOV R0, #0							@ set read from stdin
	MOV R7, #3							@ linux service set to read
	SVC 0								@ interrupt to execute syscall

	BL count_char						@ LR=PC+1 get count of input

	LDR R1, =inbuff						@ pointer to read from input buffer 
	MOV R2, #5							@ buffer includes 2 chars + '\n' newline
	MOV R0, #1							@ set write to stdio
	MOV R7, #4							@ linux service call for write
	SVC 0								@ execute syscall

	MOV R5, #0

	@ Output will not print properly unless you null terminate the buffer
	STRB R5, [R1], #1
	STRB R5, [R1], #1
	STRB R5, [R1], #1
	STRB R5, [R1], #1
	STRB R5, [R1], #1
	B main

count_char:

exit:


.data 
	inbuff: .space 20 					@ allocate buffer memory 20bytes
	prompt: .ascii ">"					@ declare ascii variable for prompt char
	@ inbuff: .asciz "1234"

.section .note.GNU-stack, "", %progbits
.end

