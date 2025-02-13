/* ============================================================================================
 * Chapter 6 stack frame example
 * 
 * file: stack_frame.s
 * 
 * If we require more memory or variables than we have available registers.
 * Instead of cluttering up the .data section, we can store variables on the stack
 * Pushing on the stack isn't always practical especially if we have to access them
 * in random order instead of LIFO/
 *=============================================================================================
 */

@ Stack example: 
@ To allocate space for a stack, we SUBTRACT instructions to grow the stack by
@ amount we need.
@ Suppose we need 3 variables which are 32-bit integers (a, b, c) 
@ Therefore, we need 12bytes allocated on stack 
@ 3 variables * 4 bytes(32bit) per word = 12 bytes 

/* 
@ Since we are storing 32bits (4bytes value size)
@ offset for each address increment is +4*8 = 32bits
|0x0000 | 4bytes [31:24] - var A |
| offset + 1 | byte 2 [23: 16] |
| offset + 2 | byte 3 [15: 8]  |
| offset + 3 | byte 4 [7:0]    |
|0x0004| 4bytes(32bits)  - var B
| offset + 1 | byte 2 |
| offset + 2 | byte 3 |
| offset + 3 | byte 4 |
|0x0008| 4bytes(32bits)  - var c
| offset + 1 | byte 2 |
| offset + 2 | byte 3 |
| offset + 3 | byte 4 |
 = 12 bytes 
|0x000C| 4bytes(32bits) |

 */

@ Stack grows in descending addresses
@ Subtract Stack pointer by 12 to increase bytes
@ This moves SP down 12bytes providing more memory space
SUB SP, #12

@ Store R0, R1, R2
STR R0, [SP] 		@ Store var A
STR R1, [SP, #4]   @ Store var B (offset +4)
STR R2, [SP, #8]  	@ Store var C (offset +4)			


@ Before the end of the function, you must free up the stack
@ This is done by ADDing back the SUB value above
@ This is the responsibility of the function to restore the SP to original state
ADD SP, #12		@ Release our variables from the stack


## Frame Pointer (FP)
* Since keeping track of the stack can be hard
* C coding conventions uses ```R11``` to be the Frame Pointer(FP)
1. To create a stack frame, first set the FP start address to the next free spot on the stack:
2. Substract the SP by the amount of bytes you need 
```
SUB FP, SP, #4		@ Set the FP start address = SP-4 (next free address spot on new allocated stack)
SUB SP, #12			@ This will set the size of the Stack FRAME (12 bytes)

@ FP =start address -04=Var A; -0x04-4=8 =Varb; -0x08-4=12 for var c
STR R0, [FP]		@ Store var A
STR R1, [FP, #-4] 	@ Store var B
STR R2, [FP, #-8]	@ Store var C

* When using a stack frame FP, we need to include a list of registers we ```PUSH``` at the beginning
of a function and ```POP`` them at the end.
* Generally we tend not to use FP since it consumes cycles of CPU

#### Stack frame FP example
* Simple function that takes 2 parameters: VAR1 and VAR2
* Adds them then stores sum in variable SUM


## Macros ```.EQU```
* similar to ```#define``` macros in c
*.EQU Assembler directive allows us to define symbols that will be substituted by the Assembler
before generating the compiled code to make the code more readable. 
* keeping track of which variable is which on the stack makes the code hard to read and is error-prone. 
* we can define each variable’s offset on the stack once.
*.EQU only defines numbers, so we can’t define the whole “[SP, #4]” type string.

```asm
#define bob 10 @ C code macro
.EQU bob, 10   @ asm equivalent
```


@ Define variables to store stack variable address offsets
@ EQUs are like #define macros 
@ these numbers are the address offsets, not data values
.EQU VAR1, 0
.EQU VAR2, 4
.EQU SUM, 8

@ Assume we pass in parameter/args R0=value1, R1=value2
sum_func: 
	PUSH {R4-R12, LR}			@ Function convention to save all other registers from prev function first,
	@ Now we expand stack SP-12 becuase R4-R12, LR is stored at original SP address.
	SUB SP, #12					@ increase the stack size maek Room for three 32-bit values 4bytes *3=12bytes
	STR R0, [SP, #VAR1] 		@ Save passed-in param.
	STR R1, [SP, #VAR2]			@ save second parameter

@ Do a bunch of other work, but don't change SP
LDR R4, [SP, #VAR1]				@ Load VAR1 into R4
LDR R5, [SP, #VAR2]				@ Load VAR2 into R5
ADD R6, R4, R5					@ Add R4+R5, store in R6
STR R6, [SP, #SUM]				@ Store R6 into #SUM variable

@ On end of function, we close out the function:
LDR R0, [SP, #SUM]				@ Load sum to return value
ADD SP, #12						@ Release local vars on the stack
POP {R4-R12, PC}				@ Restore regs adnd trun 
