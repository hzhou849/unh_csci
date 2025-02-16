## Using stdc functions
* example to use scanf/printf
* Scanf registers:
```
 R0: pointer to var containing format specifier %d, %c %h etc..
 R1: dereferences pointer value of input data buffer to store char (requires actual char value not pointer ie 0x31='1'
```

* Printf registers
```
 R0: contains address of string data var to print
```
```asm
.section .text
.global main

main:
	@ Printf
	LDR R0, =prompt
	BL printf

	@ Scanf
	LDR R0, =in_format_specifer
	LDR R1, =input_data_buf
	BL scanf

	LDR R0, =result
	LDR R2, =input_data_buf @ loads address of input-data_buf
	LDR R1, [R2]			@ dereference R2 to get actual 'char' and place in R1. 
	BL printf

	MOV R0, #0				@ exit return code
	MOV R7, #1				@ 1=exit service code
	SVC 0

.data
.word 	@ 32bit align all variables
result: .asciz	"input data = %x\n"
prompt: .asciz	"Enter value > "
in_format_specifer: .asciz "%c"
input_data_buf: .space 4, 0 @ Reserve 4 bytes and fill with zeros

.section .note.GNU-stack, "", %progbits		@ disable GNU stack warning
.end
```
