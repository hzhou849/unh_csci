## ARM ASSEMBLY

Add to linker?
* for ```missing .note.GNU-stack section implies executable stack mean assembly  Error: ```
```
-z noexecstack
```

## Segments
Data segment − It is represented by ```.data``` section and the .bss. The .data section is used to declare the memory region, where data elements are stored for the program. This section cannot be expanded after the data elements are declared, and it remains static throughout the program. <br>

The .bss section is also a static memory section that contains buffers for data to be declared later in the program. This buffer memory is zero-filled. <br>

Code segment − It is represented by ```.text section```. This defines an area in memory that stores the instruction codes. This is also a fixed area.

## Common commands
```LDR``` loads from memory into a register </br>
```STR``` stores register contents into memory </br>
```MOV``` - Moves between registers only

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
* ASR shifts and pads with the sign 1=negative 0=positive
```
ASR 1 = 
1111 1111 1010 101>0
F     F    A    A              
>1111 1111 1101 0101
F     F    D    5   


ASR 1=
1100 111>1
C      F
>1110 0111
E     7
```
```LSL``` - Logical Shift left <br/>
```ASR``` - Arithmetic shift right <br/>
```ROR``` - Rotate Right<br/>
```RRX``` - Rotate extended right<br/>

* Logicial shift R2 left by 1 bit and put the result in R1
```asm
MOV R1, R2, LSL #1
```

## Addressing
```
0xFFFF FFFF 0000 0000
0xFFFF FFFF 0000 0008
0xFFFF FFFF 0000 0010
0xFFFF FFFF 0000 0018
________________________32bits
0xFFFF FFFF 0000 0020
+32bits
0xFFFF FFFF 0000 0040 

0000 0000 0010 0000
0000 0000 0110 0000
```


## .data directive
```asm
.data
inbuff: .space 20 @ declare buffer with size 20
myword: .word 0x1234567, 0xABCD1234 @ array size word

```

### Defining memory contents
* The first line defines 7 bytes all with the same value.
```asm
label: .byte 74, 0112, 0b00101010, 0x4a, 0x4a, 'j', 'H'+2
       .word 0x1234ABCD, -1434
       .ascii "hello world\n"
```

#### Types of memory definition
| Directive | Description |
| --------- | ----------- |
| .ascii | A string contained in double quotes |
| .asciz | A zero-byte terminated ascii string |
| .byte | 1-byte integers |
| .double | Double-precision floating-point values |
| .float | Floating-point values |
| .octa | 16-byte integers |
| .quad | 8-byte integers |
| .short | 2-byte integers |
| .word | 4-byte integers |

## FILL Repeat
* If we want to define a larger set of memory, there are a couple of
mechanisms to do this without having to list and count them all out:
#### Method 1
* ie. to fill an array with zeros
```asm
.fill repeat, <size>, <values>

@ creates a block of memory with ten 4-byte words all with a value of zero.
zeros: .fill  10, 4, 0
```

#### Method 2
```asm
rpn: .rept 3
.byte 0, 1, 2
.endr
is translated to
.byte 0, 1, 2
.byte 0, 1, 2
.byte 0, 1, 2
```

## ASCII Escape character sequence codes
| Escape | character sequence Description |
| ------ | ------------------------------ |
| \b | Backspace (ASCII code 8) |
| \f | Formfeed (ASCII code 12) |
| \n | New line (ASCII code 10) |
| \r | Return (ASCII code 13) |
| \t | Tab (ASCII code 9) |
| \ddd | An octal ASCII code (ex \123) |
| \xdd | A hex ASCII code (ex \x4F) |
| \\ | The “\” character |
| \” |The double quote character |
| \anything-else | anything-else |


## LDR STR
The LDR and STR instructions use post-indexed addressing to update their address registers.

STR instructions store a word in memory.
LDR instructions load a word from memory.



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
