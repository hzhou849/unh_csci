## ARM Commands

| Command | Description | 
| ------- | ----------- |
| MOV | Moves within registers |
| CMP | Compares r0, #16, takes R0-16 = 0? and updates status register |
| ---- | ---------------|
| Branching |           |
| beq | branch on equal of previous comparison operation,Z flag is set; if CMP=0 | 
| BNE | Branch not equal; if CMP !=0; Z flag is clear |
| ble | Branch on less than |
| bge | Branch greater or equal than|
| blt | Branch LESS than |
| bgt | Branch Greater than |

### CMP - Compare instruction
* CMP subtracts operand2 from Rn
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
```EOR``` - Exclusive OR (1,0) (0,1)
```ORR``` - Logical OR (1,0) (0,1), (0,0)
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
