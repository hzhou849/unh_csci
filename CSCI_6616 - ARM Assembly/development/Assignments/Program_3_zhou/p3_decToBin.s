/* ==========================================================================================
 * CSCI_6616 - ARM Assembly Programming
 * 
 * Project: Program 3 Decimal to binary converter
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
 * R0 - 0=stdin; 1=stdout; 2=stderr
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
	MOV R2, #4							@ Read one char + '\n' to capture enter
	MOV R0, #0							@ set read from stdin
	MOV R7, #3							@ linux service set to read
	SVC 0								@ interrupt to execute syscall

	BL count_check						@ LR=PC+1 get count of input

convert:
	MOV R5, R0							@ store the count into R5
	CMP R5, #3	
	BGT print_nan
	@ Print output ascii
	LDR R1, =msg_decimal
	MOV R2, #11
	MOV R0, #1							@ set write to stdio
	MOV R7, #4							@ linux service call for write
	SVC 0								@ execute syscall

	LDR R1, =inbuff						@ pointer to read from input buffer 
	MOV R2, R5
	ADD R2, #1							@ buffer includes 1extra chars + '\n' newline
	MOV R4, #0x0
	STRB R4, [R1, R5]					@ add '\0' at out string
	MOV R0, #1							@ set write to stdio
	MOV R7, #4							@ linux service call for write
	SVC 0								@ execute syscall

	@ Perform conversion
	CMP R5, #1
	BEQ one_digit
	CMP R5, #2
	BEQ two_digit
	CMP R5, #3
	BEQ three_digit

@ R0 - return value of decimal number
@ R3 - hold decimal
@ R4 - 10^n mult. factor
one_digit: 
	LDRB R0, [R1]						@ Load the first ascii char into R3
	SUB R0, R0, #0x30					@ subtract 0x30;48d to get decimal num
	B dec_to_bin

two_digit:
	LDRB R3, [R1]						@ load the first ascii char into R3
	SUB R3, R3, #0x30					@ subtract 0x30;48d to get decimal num
	MOV R4, #10							@ 10^1
	MUL R0, R3, R4						@ 2 digits = n1+10^1 +n0*10^0				
	
	LDRB R3, [R1, #1]					@ Load the second digit
	SUB R3, R3, #0x30					@ substract 0x30;48d to get 2nd decimal num
	ADD R0, R0, R3						@ Add [prev_val]+ R3*10^0
	B dec_to_bin

three_digit:
	LDRB R3, [R1]						@ load the first ascii char into R3
	SUB R3, R3, #0x30					@ subtract 0x30;48d to get decimal num
	MOV R4, #100						@ 10^2
	MUL R0, R3, R4						@ 3 digits = n2*10^2+ n1*10^1 +n0*10^0
	
	LDRB R3, [R1, #1]					@ load the second ascii char into R3
	SUB R3, R3, #0x30					@ subtract 0x30;48d to get decimal num
	MOV R4, #10							@ 10^2
	MUL R7, R3, R4
	ADD R0, R0, R7						@ 2 digits = n1+10^1 +n0*10^0
	
	LDRB R3, [R1, #2]					@ Load the third digit
	SUB R3, R3, #0x30					@ substract 0x30;48d to get 2nd decimal num
	ADD R0, R0, R3						@ Add [prev_val]+ R3*10^0
	B dec_to_bin


dec_to_bin:
	@ R6 = Raw number
	@ R3 = temporary bit storage for addition
	@ R0 = return value to store converted binary bits
	@ R7 = Bit index counter 12
	@ R4 = temp. index for outbuffer 

	MOV R6, R0							@ save the prev returned decimal value out
	MOV R0, #0							@ Clear the binary register
	MOV R7, #12							@ 3 bytes/ 12bit number max (999d)
	LDR R1, =outbuff					@ output string to store value 
	SUB R4, R7, #1						@ outbuffer index is 0-index so 12-1=11
	

convert_bits:
	CMP R7, #0							@ Loop until R7 is 0
	BEQ print_binary
	SUB R7, R7, #1
	TST R6, #1							@ AND & operation on R5 lSB
	ROR R6, R6, #1						@ shift and rotate to test next bit
	BEQ bit0							@ EQ (z=0) so bit is 0
	BNE bit1							@ NE (z=0) so bit is 1

bit0:
	@ THis is to store bits in stdout buffer
	MOV R3, #0x30						@ store an ascii '0' 0x30;48d
	STRB R3, [R1, R4]					@ store bit 0 in output buffer
	SUB R4, R4, #1						@ decrement counter
	B convert_bits
bit1:
	MOV R3, #0x31						@ store ascii '1' 0x31; 49d;
	STRB R3, [R1, R4]
	SUB R4, R4, #1
	B convert_bits

	@ Done, branch to print
	BL print_binary

print_binary:
	MOV R3, R0							@ Save the results of the binary bits in R3

	LDR R1, =msg_binary
	MOV R2, #10
	MOV R0, #1							@ set write to stdio
	MOV R7, #4							@ linux service call for write
	SVC 0								@ execute syscall

	LDR R1, =outbuff					@ R0 is the decimal num pointer address for input buffer load into R1
	MOV R3, #0x0A						@ store '\n' for better formatting
	STRB R3, [R1, #13]
	MOV R2, #14							@ Read one char + '\n' to capture enter
	MOV R0, #1							@ set read from stdin
	MOV R7, #4							@ linux service 4=write
	SVC 0								@ interrupt to execute syscall

	B main

	@ syscall to exit
	MOV R0, #0							@ Set return code=0
	MOV R7, #1							@ Service code 1=exit
	SVC 0						

count_check: @ Count char and check
	MOV R0, #0						    @ R0 = Return value count of valid ascii number

cnt_loop:
	LDRB R3, [R1, R0]					@ load the count offset
	CMP R3, #0x0A						@ check for \n which is user input
	BEQ convert
	CMP R3, #'0'						@ Check if less then 0x30;48d '0' then it is NaN
	BLT print_nan						@ if nan, go to retry sequence
	CMP R3, #'9'						@ Check if greater than ascii 0x39;75d '9'; then NaN
	BGT print_nan						@ if nan, go to retry sequence
	ADD R0, #1							@ else, increment valid count +1	
	B cnt_loop

print_nan:
	LDR R1, =prompt_nan
	MOV R2, #44						@ Lenght of this string
	MOV R0, #1							@ set to stdout
	MOV R7, #4							@ linux service code 4=write
	SVC 0								@ execute syscall
	B main


.data 
	inbuff: .space 20 					@ allocate buffer memory 20bytes
	@ inbuff1: .ascii "123\n"			@ test ascii string used for GDB to bypass stdin
	outbuff: .fill 20, 1, 0				@ create a 20byte string filled with NULL
	prompt: .ascii ">"					@ declare ascii variable for prompt char
	prompt_nan: .asciz "Invalid entry, please enter number (0-999).\n" @ 44bytes
	msg_decimal: .asciz "\ndecimal: "   @ 11 bytes
	msg_binary: .asciz "\nBinary: "		@ 10 bytes

.section .note.GNU-stack, "", %progbits
.end

