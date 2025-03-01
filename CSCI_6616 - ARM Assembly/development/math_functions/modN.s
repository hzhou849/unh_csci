/*===========================================================================================

File modN.s

@Description: modulus N of a number by repeated subractions until <=0
			 Count the number of subtractions is N and the remainder is value prior to last 
			 subtraction

@Registers
R0 - contains number
R1 - mod

@ Returns
R0 - Remainder
R1 - N
=============================================================================================
*/

.global main 
.section .text

main:	MOV R4, #0			@ counter N init to 0

		// Using stdin 
		MOV R0, #0			@ set read from: 0=stdin
		LDR R1, =inbuffer	@ load input buffer into R1
		MOV R2, #2			@ Read n char + '\n'
		MOV R7, #3			@ Linux service code 3=read mode
		SVC 0				@ syscall execute


cont:	SUB R0, R1			@ R0 = R0(number)-R1(mod) ie 20 mod 4 
		ADD R4, #1			@ Increment counter N++
		
		// If SUB R0-R1 == 0, we are done
		// else keep looping
		CMP R0, #0			@ Compare if Z flag 
		BGT cont			@ If R0 > 0, repeat

		CMP R0, #0			@ Check a second time if number is 0 or <0
		BEQ done			@ if number is even division ==0, done
		ADD R0, R1			@ Add back the mod number, because we subtracted too far
		SUB R4, #1			@ Roll back the count bc we went too far
		
done:	MOV R1, R4			@ Copy final value back to return register
		@ BX LR 				@ return if function call

exit:	MOV R0, #0			@ Exit return code
		MOV R7, #1			@ Exit service code=1
		SVC 0				@ execute syscall interrupt


.data
	inbuffer: 	.space 20, 0			@ allocate 20 bytes, initialize to 0
	outbuffer: 	.space 20, 0			@ allocate 20 bytes, initialize to 0

.section .note.GNU-stack, "", %progbits 		@ disable GNU stack warning

.end
