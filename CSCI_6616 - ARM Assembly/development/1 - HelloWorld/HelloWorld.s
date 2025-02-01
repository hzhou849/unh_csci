/*
 * Assembly program to test basic print
 *
 * LDR - can move data from memory address to a register
 *     - RAM into CPU register
 * MOV - Can only move data between two registers or save a 8-bit immediate value to a register
 * 		- data from CPU register to another CPU register
 * R0-R2 Parameters to linux servies
 * R7 - Linux function number
 * 
 * 
 * Debug with CPUlator
 * To view use objdump -s -d HelloWorld.o
 * STR transfers 32 or 64 bits of data from a register into RAM. LDR transfers data from RAM into a
 */

.global _start				@ Provide program starting

@ Address to linker
@ Setup the paramters to print string message and call Linux to execute it.
_start: 
	mov R0, #1				@ Place output to 0=stdin, 1=stdout; 2=stderr
	ldr	R1, =myString	 	@ string to printed (calls variable helloworld)
	mov R2, #13				@ Length of the string
	mov R7, #4				@ Linux system call to write
	svc 0 					@ Call linux to print

	@ Setup parameters to exit the program and allow linux to do it
	mov R0, #0				@ Use return code 0
	mov R7, #1				@ Service command code 1 terminates this program
	svc 0					@ call linux to terminate

.data
myString:	.ascii "Hello World!\n"

	 

