/*
 * File: upper.s
 *
 * function to convert strings to upper main.s will call this
 *
 * R1 - address of output string
 * R0 - address of input string
 * R4 - Original ouptut string for length calculation
 * R5 - current character being processed
 *
 * 0x30(48d) -0x39(57d) = 0-9
 * 0x41(65d) - 5A(90d) = 'A' to 'Z'
 * 0x61(97d) - 7A(122d) = 'a' to 'z'
 */

.global toupper	@ **** Global declaration allow other files to call this routine
.section .text

toupper:
	PUSH {R4-R5}					@ Save the registers we used previously
	@ optionally we can push LR if we want here too
	MOV R4, R1

loop:
	@ Loop until byte pointed by R1 is null-terminator 
	LDRB R5, [R0], #1				@ load char from R0 into R5, then inc R0 address by 1
	
	@ is the 'z' -R5 = 0? if > 'z'? it is not a letter
	CMP R5, #'z'					@ R5 - 0x7A(122d) ie. 111-122 = +1 N=1, v=0 carry to perform subtract
	BGT cont
	@ else if R5 < 'a' then goto end
	CMP R5, #'a'                   @ R5 - a=0x61 or 97d  if N and v flags are different
	BLT cont					

	@If here that means letter is lowercase so we will convert it
	SUB R5, #('a'-'A')				@ 0x61(97d) -0x41(65d) = 32 differnce, sub R5 by 32 will give its uppercase equivalent

cont: @ endif
	STRB R5, [R1], #1				@ Store R5 into R1, then increment R1 address by 1; post incr R1++
	CMP R5, #0						@ if R5 is null terminator, we are done
	BNE loop						@ continue to next char
	SUB R0, R1, R4					@ R1 iterated address - R4(starting address) = length of string
	POP {R4-R5}						@ Restore the register we use. 
	@ optionally we can POP {LR} here too 
	BX LR							@ Return to caller function

.section	.note.GNU-stack,"",%progbits
.end

