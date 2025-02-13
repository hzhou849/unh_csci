/* ============================================================================================
 * Macro version toupper app
 * file: mainmacro.s
 * 
 * Assebmly program to convert a string to all uppercase by calling a macro
 * Demonstrate using macros
 * - Assembler creates a copy of the code in each place where it is called,
 * substituting any parameters. Alternative to using a function
 *
 * R0 - R2: Parameters to linux function service calls
 * R0 - address of input string
 * R1 - address of output string
 * R7 - linux function number
 *=============================================================================================
 */

 .include "uppermacro.s"
 .global main
 
main: toupper tststr buffer
@ set up the parameters to print hex number then call linux syscall
	MOV R2, R0				@ R0 is length of the string
	MOV R0, #1				@ 1=stdout
	LDR R1, =buffer			@ string to print
	MOV R7, #4				@ 4=write call
	SVC 0					@ execute syscall

@ Call it a second time with second string
	toupper tststr2, buffer

@ setup params to print hex
	MOV R2, R0				@ R0 is length of the string
	MOV R0, #1				@ 1=stdout
	LDR R1, =buffer			@ string to print
	MOV R7, #4				@ 4=write call
	SVC 0					@ execute syscall
 
 

