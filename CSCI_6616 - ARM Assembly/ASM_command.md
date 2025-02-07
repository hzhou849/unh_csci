## ARM Commands

| Command | Description | 
| ------- | ----------- |
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
|  |  |

### LDR
* Load from ram/memory into register
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

* Example 2: with offset 
```asm
STRB reg1, [reg2], #offset
```
The meaning of this instruction is that the contents of reg1 are stored in memory at the address reg2 + offset.
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
