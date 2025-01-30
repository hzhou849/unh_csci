## ARM ASSEMBLY

## Common commands
LDR loads from memory into a register </br>
STR stores register contents into memory </br>
MOV - Moves between registers only

### as compiler
```sh
# Building the object file
as -o outputFile.o asmfile.s

# Linking the object file to binary executable
ld -o binaryExec outputFile.o
```

## Object dump

```sh
# -s shows the contents of section dump
objdump -s -d move_example
```

### Using GCC 
```sh
# If you are compiling a c file, you need to generate ASM file
# -S generate assembly s file
# -O0 set optimization to 0 so regsiters aren't altered.
gcc –S –O0 main.c –o main.s

# create the object file from main.s
as –o main.o main.s

#link
gcc -o main main.o

# create the binary with debug symbols
gcc –g –O0 –o main main.s
```

## GDB debug 
| Shortcut | Description |
| -------- | ----------- |
| ```s``` | step next line of code |
| ```b <line>``` | set breakpoint on line |
| ```r``` | Run |
| ```c``` | Continue |
| ```h``` | help |
```
gdb main” and enter
 Note the terminal output and at the gbd prompt
 Type ‘h’ and examine the help available
 Type ‘l’ and note the listing
 Type ‘b 29’ and ‘r’ this will set a break point at line 29 and run to the break point
 Type ‘i r’ to examine the registers
 Type ‘c’ to continue the program
 Finally type ‘q’ to exit gdb

```




### MOV/MOVT/MVN
* MOV is used to move from register to register
* MOV - Moves the least significant (lower half byte)
* MOVT - Moves the MOST significant (TOP half byte)
* MOVN - Move and perform logical NOT ~. (one's complement)
Example:
```asm
@ We want to load R2 with hex value 0x4F5D6E3A
MOV  R2, #0x6E3A
MOVT R2, #0x4F5D
```

### Register and Shift
```LSL``` - Logical Shift left <br/>
```ASR``` - Arithmetic shift right <br/>
```ROR``` - Rotate Right<br/>
```RRX``` - Rotate extended right<br/>

* Logicial shift R2 left by 1 bit and put the result in R1
```asm
MOV R1, R2, LSL #1
```


## ARM Instructions
* execute on one clock cycle
```
/ example break down:
HEX: 0xE3a00001 0: e3a00001 mov r0, #1
BINARY: 1110|0011|1010|0000|0000|0000| 0000|0001|
ARM instruction format: |1110|001|1 101| 0| 0000| 0000 |0000 0000 0001|  
1) CONDITION = E = All instructions start with 0xe = 1110 [4 bits; 31-28]
2) OPERAND type  = 001 [3 bits; 27-25]
3) OPCODE = 1101 MOV 		[4 bits; 24-21]
4) Set Condition code =0  [1 bit; 20]
5) Operand Register = R0=0000 [4bits; 19-16]
6) Destination Register=0000 [4bits; 15-12]
7) Immediate operand = 0x0000 0000 0001 [12bits; 11-0]

// Example decode ARM instruction format
1005c:       e1a01002        mov     r1, r2
0xe1a01002
in binary: 1110|0001|1010|0000|0001|0000|0000|0010
ARM: 1110|000|1101| 0| 0000|0001|0000 0000 0010
1) COndition = E
2) Operand type = 000; means Operand is Register
3) OPCODE  MOV = 1101
4) Condition Code = 0
5) Operand register 0000 N/A
6) Destination register 0001; R1
7) Immediate Operand 0002; R2

Example 3
10098:       e3a07001        mov     r7, #1
BINARY: 1110 0011 1010 0000 0111 0000 0000 0001
ARM : 1110 001 1101 0 0000 0111 000000000001
1) COndition = E
2) Operand type = 001; means operand is value #1
3) OPCODE  MOV = 1101
4) Condition Code = 0
5) Operand register 0000 N/A
6) Destination register 0111; R7
7) Immediate Operand 0001; #1
```
| STATE | DESCRIPTION |
| ------- |-------------|
| Condition | Allows the instruction to execute depending on the bits in the CPSR |
| Operand type| Specifies what the operands are in bits 19–0. We could have specified some of these bits, sincewe used two registers and an immediate operand in this example. |
• Opcode: Which instruction are we performing, like
ADD or MUL.
• Set condition code: This is a single bit indicating if this
instruction should update the CPSR. If we don’t want
the result of this instruction to affect following branch
instructions, we would set it to 0.
• Operand register: One register to use as input.
• Destination register: Where to put the result of
whatever this instruction does.
• Immediate operand: Usually this is a small bit of
data that you can specify directly in the instruction.
So, if you want to add 1 to a register, you could have
this as 1, rather than putting 1 in another register and
adding the two registers. The format of this field is quite
complicated and requires a larger section to explain all
the details, but this is the basic idea.
## Build/Compile


###
The LDR and STR instructions use post-indexed addressing to update their address registers.

STR instructions store a word in memory.
LDR instructions load a word from memory.
