@**************************************************************************
@ Name:  mirror.s
@ 
@ Description: module will mirror 5 chars from STDIN to STDOUT
@ Also provides count of chars & prints terminating string.
@ Illustate Linx service call, mov, add, ldr b, bl, bx, b{cc} along with
@ sub instruction modification of CPSR flags.  Assembler directives 
@ global, text, data, end, space, ascii illustrated
@
@ Revision History
@ RAA Origin 1/12/21
@
@*************************************************************************

@ My revised version, still needs some work to work properly
.section .text
.global main

main:
	MOV R5, #5							@ R5 will count input chars

l1:
	LDR R1, =prompt						@ load &prompt from mem into R1
	MOV R2, #1							@ 1 @print one char (no newline for prompt)
	MOV R0, #1							@ set stdout
	MOV R7, #4							@ linux syscall 4=write
	SVC 0								@ execute syscall

	LDR R1, =inbuff						@ load &inbuff address in R1
	MOV R2, #2							@ set length = Read 1char + '\n'
	MOV R0, #0							@ Read from stdio should be '0'- prof's mistake
	MOV R7, #3							@ linux service code for read
	SVC 0								@ execute syscall

	LDR R1, =inbuff						@ load &inbuff addres into R1
	MOV R2, #2							@ set length = 2 chars (<char> + '\n') newline
	MOV R0, #1							@ set write to stdout
	MOV R7, #4							@ linux service 4=write
	SVC 0								@ execute syscall
	BL cnt_print						@ Branch to function cnt_print: and store next line LR=PC+1

	SUB R5, R5, #1						@ Decrement 1 count from counter R5 
	CMP R5, #0							@ this was missing from professor's code
	BEQ term							@ If R5=0; we've reached the end of our char limit
	B l1								@ else, jump back up to beginning of this function l1

term: @brief: terminate and exit the program
	LDR R1, =prompt2					@ Load &prompt2 string for exit message
	MOV R2, #15							@ length of &prompt2 string
	MOV R0, #1							@ set output to stdout
	MOV R7, #4							@ linux service code 4=write
	SVC 0

	MOV R0, #0							@ Set return code=0
	MOV R7, #1							@ linux service code 1=terminate
	SVC 0								

cnt_print:	@ brief: function to print and count
	LDR R1, =cntprnt1					@ Load &cntprnt1 var from memory
	MOV R2, #7							@ set length to 7 chars
	MOV R0, #1							@ set output to stdout
	MOV R7, #4							@ linux service 4=write
	SVC 0								@ execute syscall

	LDR R1, =inbuff						@ Load &inbuff into R1
	MOV R6, #'0'						@ move value 0x30 to R6
	ADD R6, R6, R5						@ make count ascii?? R6=0x30 + R5(count)???
	STR R6, [R1]						@ store R6(count) value into R1=inbuff
	MOV R2, #1							@ set length =1
	MOV R0, #1							@ set stdout
	MOV R7, #4							@ linux service 4=write
	SVC 0 								@ execute syscall

	LDR R1, =cntprnt2					@ Load @cntprnt2 var from memory
	MOV R2, #2							@ set length to 2 chars
	MOV R0, #1							@ set output to stdout
	MOV R7, #4							@ linux service 4=write
	SVC 0 								@ execute linux call
	BX LR								@ Branch Exchange back to LR=(line 50 - SUB R5, R5, #1)


.data
	inbuff:		.space 20 					@ Declare buffer size 20bytes
	prompt:		.ascii ">"					@ terminal prompt character
	prompt2: 	.ascii "Terminating! \r\n" 	@ Exit message
	cntprnt1:	.ascii "Count: "			@ Counting prompt
	cntprnt2:	.ascii "\r\n"				@ terminating chars
	mywords:	.word  0x12345678, 0xABCD1234, 0xFFFFFFFF  @ declare array 32 word

.section .note.GNU-stack, "", %progbits
.end





/* Professor's shit code - broken
.global main @entry point  
.text @ code area
main:         mov r5,#5 @r5 will count our input characters
l1:	      ldr r1,=prompt @prompt character
              mov r2,#beq term @1 @print 1 char
              mov r0,#1 @stdio
              mov r7,#4 @write service
              svc 0 @call service

              ldr r1,=inbuff @point at 1st char of buffer
              mov r2,#2 @read one char
              mov r0,#1 @read from stdio
              mov r7,#3 @service for read
              svc 0   @call service

	      ldr r1,=inbuff @point at input buff
              mov r2,#2 @buffer includes 2 chars inclding newline
              mov  r0,#1  @stdio
              mov r7, #4 @service number for write
              svc 0 @call service
              bl cnt_print @call function lr=pc+1, pc=address of cnt_print
			  
	      subs r5,r5,#1 @r5=r5-1
	      beq term @char 5 terminate this is the if
              b l1 @unconditional loop  this is the else
term:	      ldr r1,=prompt2 @point at exit string
	      mov r2,#15  @number of chars
	      mov r0, #1 @stdio 
              mov r7,#4 @write chars
              svc 0 @call service
              mov r0,#0 @return code for sucess
	      mov r7,#1 @service to terminate
              svc 0 @call service

@this is a function to print our count

cnt_print:    ldr r1,=cntprnt1 @point at count print prompt
	      mov r2,#7 @7 chars
              mov r0,#1 @stdio
              mov r7,#4 @write
              svc 0 @call service

	      ldr r1,=inbuff @point at in buff
              mov r6,#'0' @mov 0x30  to r6
              add r6,r6,r5 @make count ascii
              str r6,[r1] @count to inbuff
              mov r2,#1 @1 char
              mov r0,#1 @stdio
              mov r7,#4 @write
              svc 0 @call service
			  
              ldr r1,=cntprnt2 @print cr lf
              mov r2,#2 @ 2 chars
              mov r0,#1 @stdio
              mov r7,#4 @write
              svc 0 @call service
              bx lr @branch and exchange pc=lr

.data @data follows 
inbuff:       .space 20 @buffer of 20 bytes
prompt:       .ascii ">" @prompt
prompt2:      .ascii "Terminating! \r\n" @exit prompt
cntprnt1:     .ascii "Count: " @counting promt
cntprnt2:     .ascii "\r\n" @terminating chars
mywords:      .word 0x12345678,0xABCD1234,0xFFFFFFFF
.end
*/