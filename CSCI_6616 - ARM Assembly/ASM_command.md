## ARM Commands

| Command | Description | 
| ------- | ----------- |
| MOV | Moves within registers |
| CMP | Compares r0, #16, takes R0-16 = 0? and updates status register |
| ---- | ---------------|
| Branching |           |
| beq | branch on equal of previous comparison operation, relys on status reg flag | 
| BNE | Branch not equal |
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

