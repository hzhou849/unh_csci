/* ============================================================================================
 * Macro version toupper app
 * file: mainmacro.s
 * 
 * Assebmly program to convert a string to all uppercase by calling a macro
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
 * R0 - R2: Parameters to linux function service calls
 * R0 - address of input string
 * R1 - address of output string
 * R7 - linux function number
 *=============================================================================================
 */

 .include "uppermacro.s"
 .global main
 
main: 
	toupper tststr buffer	@ call our macro here, code is replaced with toupper block
@ set up the parameters to print hex number then call linux syscall
	MOV R2, R0				@ R0 is length of the string
	MOV R0, #1				@ 1=stdout
	LDR R1, =buffer			@ string to print
	MOV R7, #4				@ 4=write call
	SVC 0					@ execute syscall

	toupper tststr2, buffer @ call our macro here, code is replaced with toupper block

@ setup params to print hex
	MOV R2, R0				@ R0 is length of the string
	MOV R0, #1				@ 1=stdout
	LDR R1, =buffer			@ string to print
	MOV R7, #4				@ 4=write call
	SVC 0					@ execute syscall

@ Setup the parameters to exit the program
	MOV R0, #0				@ Return code 0
	MOV R7, #1				@ exit code=1
	SVC 0					@ execute syscall
 
 .data
 tststr:	.asciz	"this is our Test String that we will convert.\n"
 tststr2:	.asciz	"A second string to uppercase!!\n"
 buffer:	.fill 255, 1, 0
 
 .section .note.GNU-stack, "", %progbits
.end

