## ARM Commands

* ! ldm r0!, {r5-r8}      @ recover and post increment r0?

| Command | Description | 
| ------- | ----------- |
| ADD ```<option>``` | ie ADDEQ add if previous compare eq0 then add |
| SUB ```<option>```| |
| SUBS | Subtract and update status registers |
| ---- | ---------------|
| MOV | Moves within registers LSB |
| MOVW | Similar to ```MOV``` but LSB restricts to 16-bit word only |
| MOVT | Moves top MSB bits [MSB|LSB]
| CMP | Compares r0, #16, takes R0-16 = 0? and updates status register |
| ---- | ---------------|
| Branching |           |
| beq | branch on equal of previous comparison operation,Z flag is set; if CMP=0 | 
| BNE | Branch not equal; if CMP !=0; Z flag is clear |
| ble | Branch on less than |
| bge | Branch greater or equal than|
| blt | Branch LESS than |
| bgt | Branch Greater than |
| BMI | Branch if minus; test with: ```TST R0, #0x80000000```  |
| SXTB | sign extend pad with sign a number to 32bit (only works if num is <32bit, otherwise will trncate)R4, R4 |

### Condition Code	Meaning with cmp	Status of Flags
| Comamnd | Description | 
| ------- | ----------- |
| EQ |	Equal	Z==1 |
| NE |	Not Equal	Z==0 |
| GT |	Signed Greater Than	(Z==0) && (N==V) |
| LT |	Signed Less Than	N!=V |
| GE |	Signed Greater Than or Equal	N==V |
| LE |	Signed Less Than or Equal	(Z==1) |


## CPSR - Status register

### LDR
* Load from ram/memory into register
* using ```LDRB``` or ```STRB``` will adjust the endian need to confirm????
| STR | Description |
| --- | ----------- |
| LDR | Load 32-bit wide word | 
| LDRB | Load a unsigned single byte |
| LDRSB | Load signed single byte |

### STR
* Store from register to ram/memory
| STR | Description |
| --- | ----------- |
| STRB | ```STRB R6, [R1] ``` "Store Register Byte,"  stores the least significant byte (the bottom 8 bits) of a register to a memory location specified by the address calculation within the instruction; essentially, it writes only a single byte of data to memory from a register.  |
* Example 1: contents of r1 is stored at address of [r2]
```asm
STRB R1, [R2]
```

## ```!``` Write back ( increment and save)
* When the address is calculated by the adds and shifts, the result is usually thrown
away after we’ve loaded the register.
* However When performing a loop, it is handy to keep the calculated address. This saves us doing a separate ADD on our
index register.
* The syntax for this is to put an exclamation mark (!) after the
instruction, then the Assembler will set the bit in the generated instruction
asking the CPU to save the calculated address, thus
  ```LDR R2, [R1, R3, LSL #2]!```

## Pre/POST increment pointers - POST will save the new incremented address pointed to
* YOu must store the original Register address or re-assign the pointer address again to reset the adddress increments
* Example 2: with offset  post-increment address
* 
```asm
STRB reg1, [reg2], #offset   @ store then increment reg2 address+n
STRB reg1, [reg2], #offset   @ +1 from previous

Example1:
@ R2 = 0x0001
STRB R1, [R2], #1    @ R1 = R2(0x0001) +1; R1=0x0002
STRB R1, [R2], #1    @ R1 = 0002+1;

@ you can also write pre-increment, it does the same thing as post
@ and will save the base address increments
STRB R1, [R2, #1]! == STRB R1, [R2], #1 


@ to reset address on [reg2]
ldr reg2, =var
```
The meaning of this instruction is that the contents of reg1 are stored in memory at the address reg2 + offset.

* PRE-increment adddress - DOES NOT keep stored changes to pointer
```asm
STRB reg1, [reg2, #offset]  @ the offset is incremented for this use only not saved
```
<hr>

### CMP - Compare instruction
* CMP subtracts operand2 from Rn ```<Rn> - <operand2>``` <br>
```CMP <Rn>, <Operand2?``` - Rn Register number; Operand2=Number to compare
#### Example wth branch
* if Operand2(45) - R4(45)=0 then Z flag is set, so BEQ will be 0/true and allow the branch to jump to _start 
```
CMP R4, #45
BEQ _start
```

## Bitwise operators
* Rd=Register Destination; Rs=Register Source; Operand2 is input number
```AND Rd, Rs, Operand2``` - Logical AND Rs AND Operand2, put result in Rd
```asm
  AND R6, #0xFF000000      @ Mask off high-order byte MSB
  LSR R6, #24              @ Logical shift right 24bit positions (0x000000FF)
```
```EOR``` - Exclusive OR (1,0) (0,1) only is true </br>
```ORR``` - Logical OR (1,0) (0,1), (1,1) true </br>
```BIC``` - Bit clear if Rs is 1 and Operand2 true to clear then 0. If operand2 is false, then dont' clear
```asm
x0 y0 = xBICy = 0
x0 y1 = xBICy = 0 (permssion to clear y=1, but x is already 0)
x1 y0 = xBICy = 1 (y=permission to clear if false)
x1 y1 = xBICy = 0 (permission to clear y=1)
## If Then Else
```
@ If R5 < 10 then else end if
  CMP R5, #10
    BGE else_clause
    < do stuff >
    B endif

else_clause:
  < else statments >

endif: <continue after the if/then/else>
```

## Loops

### FOR loop
* Basic for loop
```ASM
  MOV R2, #1        @ R2 hold the iterator counter
  
for_loop: 
  ADD R2, #1        @ I += 1 Increment counter
  CMP R2, #10       @ Compare if 10-R2
  BLE for_loop      @ If CMP subtract NE 0, then  R2 <= 10, so branch goto loop
```
### Reverse FOR loop
```asm
  MOV R2, #10      @ R2 
loop:
  @ Using SUBS (subtract) instead of CMP, works the same way
  SUBS R2, #1      @ Increment R2 = R2-1
  BNE loop         @ Keep looping until R2
```

### While loops
* 
```asm
@ while X < 5...
while_loop:
  CMP R4, #5      @ Our while condition if 5-R4 == GE 5?
  BGE loop_done   @ If CMP is >= 5, then we jump to loop_done
  @ perform task here
  B  loop         @ Jump back to start of loop

loop_done: @ whatever we want to do after while loop
```

## Negative numbers
* quickest way to check for negative is subtract 0 by ```num```
* ``` SUB R1=0, #5``` should equal =-5
* Test for negative number using TST and 0x8.. as mask
```asm
TST R0, #0x80000000
```
* now you can perfrom add/subtract operations

### Converting to negative or positive
#### Option 1: RSB
```RSB``` - reverse subtraction, basically performs ```(0 - <num>)``` = ```-num``` (or positive if ```-(-num)= +num```
```asm
RSB R0, R0, #0   ; R0 = 0 - R0 (effectively R0 = -R0)  
```
#### Option 2: ```MVN``` then ```ADD 1```
* since we know to convert to negative/positive we 1) flip bits then 2) add 1
* ```MVN``` - move negated will flip bits of register value, then we add 1 after
```asm
@ You can use the MVN instruction to negate the value in the register (take the two's complement), then add 1 manually to get the positive value.
MVN R1, R0       ; R1 = NOT R0 (bitwise negation)
ADD R1, R1, #1   ; R1 = R1 + 1 (two's complement)
```
