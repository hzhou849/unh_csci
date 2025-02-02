/* 
 * ASM Counter to 16
 *
 */

.section .text									@ Everything that follows is code
.global main									@ set main function address entry point

main: 
	MOV R0, #0									@ Intialize R0 to 0

@ if R0 >= 16; then exit
loop:
	CMP R0, #16 								@ Loop compare if operand2-R0
	BGE exit									@ if R0 >= 16 we exit

	ADD R0, #1									@ Else, R0++
	B loop										@ unconditionally loop back to top of loop()

exit:
	MOV R0, #0									@ Set return code 0
	MOV R7, #1									@ Service command code 1=terminate program
	SVC 0										@ Call linux to execute system call

