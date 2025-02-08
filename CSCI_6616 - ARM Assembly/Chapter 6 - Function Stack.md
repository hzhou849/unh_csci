## Functions and Stack

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

## Branch with Link
* ```LR``` R14 Link register used to store current address+1 so we have a return point when using ```BL``` branch with link
* ```BX``` required to return to what is currently in the ```LR``` register. 
* ```BL``` Stores the instruction of the next line in the ```LR``` register, then jumps to function
Example:
```asm
BL myfunc        @ Stores the address of next line Move instrcution in the LR register, jump to myfunc
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
