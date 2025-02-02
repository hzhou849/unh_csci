/* 
 * ASM ascii printer 
 *
 * Prints a register in hex to stdout
 *
 * R0 - R2: Parameters to linux function services (syscalls)
 * R1 - is also address of byte we are writing
 * R4 - register to print
 * R5 - Loop index
 * R6 - Current character
 * R7 - Linux function number
 */

 .global _start							@ Program starting address to link
 
 _start:
	MOVW  R4, #0x12AB 					@ LSB Number to print
	MOVT R4, #0xDE65					@ MSB of number to print
	LDR  R1, =hexstr 					@ load from memory pointer to start of string
	ADD  R1, #9							@ Start of least significant digit we want memory string+9 address

	@ Loop is FOR r5=8 to 1; --r5
	MOV R5, #8							@ 8 digits to print
loop:
	AND R6, R4, #0x000000F				@ mask/extract of LSB 'B' from 0xDE6512AB and store in R6
	
	@ IF R6 >= 10 then goto letter
	CMP R6, #10 						@ check if 0-9 or A-F?
	BGE letter							@ if >10, it is A-F
	
	@ else its a number so convert to an ASCII digit
	ADD R6, #'0'						@ Add '0' which is ascii 0x30
	B cont								@ unconditional branch to cont(endif)

letter: @handle the digits A-F

	@ we use 10d to offset ten ascii character add R6 to get ascii
	@ Ex. 'A'=0x42-10d = 0x37+R6(0xB)=0x42 which is 'B' in ascii table 
	ADD R6, #('A'-10)					

cont: @end if
	STRB R6, [R1]						@ store ascii digit R6 into memory address [R1]
	SUB  R1, #1							@ decrement address for next digit (@hexstr+9)-1
	LSR  R4, #4							@ shift off 4bits(nibble) 'pop' the digit we just processed

	@ next R5
	SUBS R5, #1							@ Decrement for loop counter -1
	BNE loop							@ repeat if not done until R5 = 0

	@ Setup syscalls to print out hex number
	MOV	R0, #1							@ 1 = stdout
	LDR R1, =hexstr						@ load address of string to print
	MOV R2, #11							@ length of string 
	MOV R7, #4							@ linux write syscall
	SVC 0								@ Call linux to output string

	@ Syscall to exit and terminate program
	MOV R0, #0							@ Use return code 0
	MOV R7, #1							@ Service command code 1 terminates program
	SVC 0								@ call linux to execute syscall

.data
hexstr: .ascii "0x12345678\n"
 

