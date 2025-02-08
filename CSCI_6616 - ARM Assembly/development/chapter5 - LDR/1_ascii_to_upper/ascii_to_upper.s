/*
 * Chapter 5 - ascii_to_upper
 *
 *	Assembly program to convert a string to all uppercase. 
 *
 * RO-R2	- Parameters for Linux functions syscalls
 * R3 		- address of output string
 * R4		- address of input string
 * R5		- current character being processed
 * R7 		- Linux function number 1=terminate; 4=write
 * 
 * (48)0x30 to (57) 0x39 = '0' - '9'
 * (65)0x41 to (90) 0x5A = 'A' - 'Z'
 * (97)0x61 to (122)0x7A = 'a' - 'z'
 * \0 null = 0x0
 * <Rn> - <operand2>
 */

.section .text
.global main							@ Provide program start address

main:
	LDR R4, =instr						@ start address of input string
	LDR R3, =outstr						@ address of output string

loop: @ Loop until byte pointed to by R1 is non-zero
	LDRB R5, [R4], #1					@ Load char from deref[R4] into R5, then inc 1 ie. post increm. ie i++
	CMP R5, #'z'						@  R5- ('z'(0x7A; d122) ) if > 122 then we know its not lower alphabet
	BGT cont
	CMP R5, #'a'						@ R5 - ('a'(0x41; 65))  if < 65 we know its also not lower alphabet
	BLT cont

	@ endif if we don''t branch, we conver the letter
	@ we know the difference between upper and llower is (a-A) or (97-65)=32
	@ so if m=109d, we just need to subtract it by 32 to get uppercase M=109-32=77or0x4D
	SUB R5, #('a' -'A')					@ R5= R5 - (0x7A;97d - 0x5A;65d); => 32

cont: @ endif
	STRB R5, [R3], #1					@ Store char byte to deref[R3] or outstr post incre R3++
	CMP R5, #0							@ if Not equal null terminator, keep looping 
	BNE loop

	@ Setup parameters to printout our hex number
	MOV R0, #1							@ 1=stdout
	LDR R1, =outstr						@ address of string to print
	
	SUB R2, R3, R1						@ R2= length of string; R3=has been incremented by line 38 so it has the end position 
										@ This difference R3-R1 will get you string length
										@Get length by subtracting pointers [R3=outstr] - [R1=outstr] ???
	MOV R7, #4							@ Linux syscall for write command
	SVC 0 								@ Call interrupt for syscall

	@ Setup parameters to terminate and exit
	MOV R0, #0							@ Return code =0
	MOV R7, #1							@ 1=terminate
	SVC 0 								@ interrupt for syscall

.data
	instr: .asciz	"This is our Test String that we will convert.\n" 		@ asciz=zero-byte null terminated string
	outstr: .fill 255, 1, 0													@ create a string size 255times, 1byte with 0s

.end

										


