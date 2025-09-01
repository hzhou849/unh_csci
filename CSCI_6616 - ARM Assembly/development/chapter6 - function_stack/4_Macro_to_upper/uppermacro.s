/* ============================================================================================
 * Macro version toupper app
 * file: uppermacro.s
 * 
 * Assembly program to convert a string to all uppercase by calling a macro
 * Demonstrate using macros
 * - Assembler creates a copy of the code in each place where it is called,
 * substituting any parameters. Alternative to using a function
 *
 * - The file uppermacro.s defines macro to convert string to uppercase.
 * - The macro doesn't generate code, it just defines macro for assembler to hard insert 
 *   to where it is called making source file larger 
 * - There is NO object generation .o file just included by the file that uses it in the .include call
 * - 
 *  * Why use if makes file bigger? performance! Branching is expensive
 * because we have to restart the execution pipeline.
 * We also eliminate push pop calls to save registers 

 * Try to only use R0-R3 registers in macro so there is no conflict and avoids complications
 
 *
 * R1 - address of output string
 * R0 - address of input string
 * R2 - original output string far length calc.
 * R3 - current character being processed
 *=============================================================================================
 */

 @ Labels "loop" and "cont" are replaced with 1, 2
 @ This takes away readability but must be done otherwise compile error label definied more than once
 @ if macro used more than once
 @ Assmembler allows you to define numeric labels as many times desired
 @ but must be refernced with f=forward and b=backwards direction

 @ label 1 = loop
 @ label 2 = cont


@ Macro directive: .Macro <macro_name> <param1>, <param2>...
@ params used must be specified with '\param'
 .MACRO		toupper instr, outstr
	LDR	R0, =\instr
	LDR R1, =\outstr
	MOV R2, R1

@ The loop is until byte pointed to R1 is non-zero '\0' null terminator
1: 
	LDRB R3, [R0], #1		@ Load character and increment pointer

@ If R5 > 'z' then goto cont
	CMP R3, #'z'			@ is letter > 'z'
	BGT 2f					@ For macro we must use 2f=2 foward/after this line

@ Else if R5 < 'a' then got to end if
	CMP R3, #'a'
	BLT 2f					@ goto to end if

@ if we got here then letter is lower case, so convert it
	SUB R3, #('a'-'A')

2: @ end if
	STRB R3, [R1], #1		@ store char to output str; R1 address is incremented & saved.
	CMP R3, #0				@ check for null terminator '\0'
	BNE 1b					@ Jump to 1(b=before/prev)
	SUB R0, R1, R2			@ get the length by subtracting pointers
.ENDM
