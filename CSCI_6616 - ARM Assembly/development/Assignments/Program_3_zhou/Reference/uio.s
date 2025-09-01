
@******************************************************
@ name: uio.s
@
@ description: program to read chars from stdin and
@ render to stdout.  Program has no termination.
@
@******************************************************

@ Fixed my version 
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





# ORiginal shit professor code
# .global main @entry point  
# .text @ code area
# main:	
# 	ldr r1,=prompt 		@prompt character
# 	mov r2,#1 			@print 1 char
# 	mov r0,#1 			@stdio
# 	mov r7,#4 			@write service
# 	svc 0 				@call service

# l1:	
# 	ldr r1,=inbuff 		@point at 1st char of buffer
# 	mov r2,#2 			@read one char
# 	mov r0,#0 			@read from stdio
# 	mov r7,#3 			@service for read
# 	svc 0   			@call service
# 	ldr r1,=inbuff 		@point at input buff
# 	mov r2,#2 			@buffer includes 2 chars newline
# 	mov  r0,#1  		@stdio
# 	mov r7, #4 			@service number for write
# 	svc 0 				@call service
# 	b main

# .data @data follows 
# 	inbuff:	.space 20 @buffer of 20 bytes
# 	prompt: .ascii ">" @prompt
# .end
