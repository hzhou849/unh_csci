## Functions and Stack

## Function register management convention
#### Register function conventions

```R0-R3``` - These are the function parameters. The
function can use these for any other purpose modifying
them freely. If the calling<source_func> routine needs them saved, it
must save them itself. <br>

```LR``` - Link register; The called routine must preserve this address. <br>

```R4 to R12 ``` - These can be used freely by the called routine,
but if it is responsible for saving them. That means the
calling routine can assume these registers are intact. <br>

```SP:``` This can be freely used by the called routine. The
routine must POP the stack the same number of times
that it PUSHes, so it is intact for the calling routine.<br>

```R0``` return value <br>

```CPSR:``` Neither routine can make any assumptions
about the CPSR. As far as the called routine is
concerned, all the flags are unknown; similarly, they
are unknown to the caller when the function returns.<br>
* Example 
```asm
1. PUSH: {LR, R4-R12}  @ registers to save on stack from caller
     < do some work> 
2. POP : {LR, R4-R12}  @ restore registers to former state
3. Use BX to return to caller function stored in LR
```

### Stacks
* ```push``` Adds element to the area
* '''pop'''' Returns and remove the element most recently added
* ARM32 instructions set has two instructions to manipulate the stack Load multiple ```LDM``` and Store multiple ```STM``` should be synonomous with push and pop
* LIFO queue
* Raspbian runs an 8MB stack
* ```R13``` Special purpose register for stack pointer ```SP``` register
* Stores stack pointer's current location
```asm
<reglist> = R2-R4 for range; or R2, R3, R4
push {reglist}; Push onto current stack pointer address
pop {R0-R4, R6, R9-R12}; pop at current SP address and store into reglist
```
![image](https://github.com/user-attachments/assets/fce4a2bf-8f08-40b7-adf6-ee036b5f16f3)

* The downside is bandwidth between the CPU and memory is limited, so
PUSHing and POPing more registers does take extra execution cycles. The
trade-off in speed vs. maintainability is a subjective decision depending on
the circumstances.

## Branch with Link
* ```LR``` R14 Link register used to store current address+1 so we have a return point when using ```BL``` branch with link
* ```BX``` required to return to what is currently in the ```LR``` register. 
* ```BL``` Stores the instruction of the next line LR= (PC+1) in the ```LR``` register, then jumps to function
Example:
```asm
BL myfunc        @ Stores the address of next line Move LR= (PC+1)instrcution in the LR register, jump to myfunc
MOV R1, #4       @ < this adddress is stored in LR 
@ <some other code...>

func:
  @do some work
  BX LR        @ Return back to LR -> MOV instruciton above
```

### Nested functions requires Stack
* Since the LR can only hold 1 address at a time, nested functions will overwrite the prev. return address
* We use stack to pop LIFO addresses
Example:
```asm
main:
  BL myfunc        @ Store address of next line has return point in LR {0xAA01}, jump to my func
  MOV R1, #4       @ Address 0xAA01
  < more code>

myfunc:            
  PUSH {LR}        @ Push current LR (MOV instruction above) into stack     stack: {0xAA01}
  @ <do stuff>
  BL myfunc2       @ Overwrite LR with next line address {0xAA08} then jump to myfunc2
  @ <do more stuff after return from myfunc2>     @ address here is 0xAA08; after myfunc2 we are here
  POP {LR}         @  stack: {0xAA01} pop what is in the stack into LR=0xAA01
  BX LR            @ jump back to what is in LR, so jump back to 0xAA01

myfunc2:
  @ <do stuff>    
  BX LR          @ jump back what is in LR=AA08  stack: {0xAA01}
```

## Return values 
* Simply assign return values to R0, R1, R2, R3, or push them onto the stack if more are neeeded, once returned from function, just pop them from the stack

## Register management convention for functions
| Register | Description |
| -------- | ----------- |
| R0 - R3 | Used for function args/params; My be used for anything freely. If calling routine needs to save them, it must save them manually |
| R4 - R12 | Can be used freely by the called routine, but if it is responsible for saving them. Calling routine can assume these registers are intact |
| SP | used freely by called routine; The routine must pop the same number times it pushes so it is intact for the calling routine |
| LR | Called routine must preseve this as disccussed above |
| CPSR | Neither routine can make any assuptions about the CPSR; this is abstracted to function |

## Summary of the function call Algorithm
#### Calling routine
1. If we need any of R0-R4, save them
2. Move first four params into R0-R4
3. Push any additional params onto stack
4. Use BL to call the function
5. Evaluate the return code in R0
6. Restore any of R0-R4  taht we saved.

#### Called function
1. Push LR and R4-R12 on to the stack
2. Do our work
3. Put our return code into R0
4. Pop LR and R4-R12
5. Use BX instuctions to return execution to caller

## Examples of STACK and STACK FRAMES(FP)

 * If we require more memory or variables than we have available registers.
 * Instead of cluttering up the .data section, we can store variables on the stack
 * Pushing on the stack isn't always practical especially if we have to access them
 * in random order instead of LIFO/


### Stack example: 
* To allocate space for a stack, we SUBTRACT instructions to grow the stack by amount we need.
* Suppose we need 3 variables which are 32-bit integers (a, b, c) 
* Therefore, we need 12bytes allocated on stack 
* 3 variables * 4 bytes(32bit) per word = 12 bytes 

```asm 
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
```


## Frame Pointer (FP)
* Since keeping track of the stack can be hard
* C coding conventions uses ```R11``` to be the Frame Pointer(FP)
1. To create a stack frame, first set the FP start address to the next free spot on the stack:
2. Substract the SP by the amount of bytes you need

```asm
SUB FP, SP, #4		@ Set the FP start address = SP-4 (next free address spot on new allocated stack)
SUB SP, #12			@ This will set the size of the Stack FRAME (12 bytes)

@ FP =start address -04=Var A; -0x04-4=8 =Varb; -0x08-4=12 for var c
STR R0, [FP]		@ Store var A
STR R1, [FP, #-4] 	@ Store var B
STR R2, [FP, #-8]	@ Store var C
```
* When using a stack frame FP, we need to include a list of registers we ```PUSH``` at the beginning
of a function and ```POP`` them at the end.
* Generally we tend not to use FP since it consumes cycles of CPU

#### Stack frame FP example
* Simple function that takes 2 parameters: VAR1 and VAR2
* Adds them then stores sum in variable SUM


## Macros 

### ```.EQU``` For variables
* similar to ```#define``` macros in c
*.EQU Assembler directive allows us to define symbols that will be substituted by the Assembler
before generating the compiled code to make the code more readable. 
* keeping track of which variable is which on the stack makes the code hard to read and is error-prone. 
* we can define each variable’s offset on the stack once.
*.EQU only defines numbers, so we can’t define the whole “[SP, #4]” type string.

```asm
@ #define bob 10 @ C code macro
@ .EQU bob, 10   @ asm equivalent

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
	SUB SP, #12				@ increase the stack size maek Room for three 32-bit values 4bytes *3=12bytes
	STR R0, [SP, #VAR1] 			@ Save passed-in param.
	STR R1, [SP, #VAR2]			@ save second parameter

@ Do a bunch of other work, but don't change SP
LDR R4, [SP, #VAR1]				@ Load VAR1 into R4
LDR R5, [SP, #VAR2]				@ Load VAR2 into R5
ADD R6, R4, R5					@ Add R4+R5, store in R6
STR R6, [SP, #SUM]				@ Store R6 into #SUM variable

@ On end of function, we close out the function:
LDR R0, [SP, #SUM]				@ Load sum to return value
ADD SP, #12					@ Release local vars on the stack
POP {R4-R12, PC}				@ Restore regs adnd trun 
```

## Macro .include blocks
 * Assembler creates a copy of the code in each place where it is called,
   substituting any parameters. Alternative to using a function
 * The macro doesn't generate code, it just defines macro for assembler to hard insert 
   to where it is called making source file larger 
 * There is NO object generation .o file just included by the file that uses it in the .include call
 
 * Why use if makes file bigger? performance! Branching is expensive because we have to restart the execution pipeline.
 * We also eliminate push pop calls to save registers 
 * Try to only use R0-R3 registers in macro so there is no conflict and avoids complications

Calling file
```asm

 .include "uppermacro.s"
 .global main
 
main: 
	toupper tststr buffer	@ call our macro here, code is replaced with toupper block
```

Macro definition file
```asm
@ Macro directive: .Macro <macro_name> <param1>, <param2>...
@ params used must be specified with '\param'
 .MACRO		toupper instr, outstr
	LDR	R0, =\instr
	LDR R1, =\outstr
	MOV R2, R1

@ Function labels must be numerical in macros and use 'f' and 'b' to refer
@ forward, backwards reference
1:
	CMP R3, #'z'			@ is letter > 'z'
	BGT 2f				@ For macro we must use 2f=2 foward/after this line

2: 
	STRB R3, [R1], #1		@ store char to output str; R1 address is incremented & saved.
	CMP R3, #0			@ check for null terminator '\0'
	BNE 1b				@ Jump to 1(b=before/prev)
	SUB R0, R1, R2			@ get the length by subtracting pointers


.ENDM
```







  
