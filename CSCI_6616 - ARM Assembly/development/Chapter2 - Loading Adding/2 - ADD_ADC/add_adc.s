/* Add instructions
 *
 * Rd = Register Destination; Rs = Reg. Source
 * 1. ADD{S} Rd, Rs, Operand2
 * 2. ADD{S} Rd, Rs, #imm12
 * 3. ADD{S} Rd, Rs1, Rs2
 * 4. ADC{S} Rd, Rs, Operand2
 * 5. ADC{S} Rd, Rs1, Rs2
 *
 * These instructions all add their second and third parameters and put
the result in their first parameter Register Destination (Rd).
The case with three registers is a special case of Operand2, just
with a shift of 0 applied. The registers Rd and Source Register (Rs) can be
the same. If you just want to add 1 to R1, you can specify
ADD R1, #1
The Assembler compiles this as
ADD R1, R1, #1
 * 
 */

/*  @ Example of ADD/ADC instructions  */
.global _start				@ Provide program starting address

@ Calculate Two's complement of 2 to get -2
@ Multiply 2 by -1 by using MVN and then adding 1

_start: 
	MVN R0, R0, #2
	MVN R0, #2
	ADD R0, #1

	@ Setup parameters to exit the program then call linux to do it
	@ R0 is the return code and will be what we calculated above
	MOV R7, #1 				@ Service command code
	SVC 0					@ Sys call linux to terminate



0010
1101
+  1 
----
  1110 FE = 254 or -2 two's compliment  
Here we use the MVN instruction to calculate the one’s complement
of our number, in this case 2, then we add 1 to get the two’s complement
form. We use R0 since this will be the return code returned via the Linux
terminate command. To see the return code, type
echo $?
after running the program and it prints out 254. If you examine the bits,
you will see this is the two’s complement form for –2 in 1 byte.

