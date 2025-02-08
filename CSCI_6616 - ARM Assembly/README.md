## ARM ASSEMBLY

## Hex ascii values
| HEX address | Decimal | Ascii chars |
| ----------- | ------- | ----------- |
| 0x30 to 0x39 | 48-57 | 0-9 |
| 0x41 to 0x5A | 65-90 | A-Z |
| 0x61 to 0x7A | 97-122 | a-z |

Add to linker?
* for ```missing .note.GNU-stack section implies executable stack mean assembly  Error: ```
```
-z noexecstack
```

## Directive Segments
Data segment − It is represented by ```.data``` section and the .bss. The .data section is used to declare the memory region, where data elements are stored for the program. This section cannot be expanded after the data elements are declared, and it remains static throughout the program. <br>

The .bss section is also a static memory section that contains buffers for data to be declared later in the program. This buffer memory is zero-filled. <br>

Code segment − It is represented by ```.text section```. This defines an area in memory that stores the instruction codes. This is also a fixed area.


## Build / Compiling
### ```as``` compiler
* NOTE: when using this method, GDB will not be reliable
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
* Works better with GDB
* your asm file must have ```.global main``` and function ```main``` as gcc requires main function to be the entry way
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

## Common commands
```LDR``` loads from memory into a register </br>
```STR``` stores register contents into memory </br>
```MOV``` - Moves between registers only



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
```
LDR R1, =helloworld

These constants the Assembler creates are placed at the end of the
.text section which is where the Assembly instructions go. Not in the .data
section. This makes them read-only in normal circumstances, so they can’t
be modified. Any data that you want to modify should go in a .data section.
```
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
.fill <repeat_num_cycles>, <size_bytes>, <values>

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

STR instructions store a word in memory(RAM).
LDR instructions load a word from memory/RAM.

### LDR
* pre-indexed addressing. This is because the address is calculated and then the data is retrieved using the calculated address
* post-indexed addressing, the data is retrieved first using the base register, then any offset shifting and adding is done
example:
```asm
@ load the address of mynumber into R1 (pointer address)
LDR R1, =mynumber
@ load the word stored at mynumber into R2 (dereference pointer)
LDR R2, [R1] .data
mynumber: .WORD 0x1234ABCD
```
#### LDR address offset

```LDR r1, [pc, #20]```
means pc+20

```asm
Type Meaning
B   Unsigned byte
SB  Signed byte
H   Unsigned halfword (16 bits)
SH  Signed halfword (16 bits)
–   Omitted for word

LDR {type} Rt, =<label>

ex. LDR R1, =string
These constants the Assembler creates are placed at the end of the
.text section which is where the Assembly instructions go. Not in the .data
section. 

ex.2 LDR R1, =0x1234ABCD

This assembles into
The GNU Assembler is helping us out by putting the constant we want
into memory, then creating a PC relative instruction to load it.
ldr r1, [pc, #8]
.word 0x1234abcd
```

#### LDR example with ARRAY
* an array of ten words (4 bytes each) defined by
```asm
arr1: .FILL 10, 4, 0
Let’s load the array’s address into R1:
LDR R1, =arr1
```
* To access elements and load the first element
``` LDR R2, [R1]```
* To load element 3, its position 2(0-indexed) Each word is 4-bytes, so we need to multiply by 4
* Address 8 will hold the third element

ie if base address of R1 = 0x1000, element 3 will be at 0x10008
|  Address|  Element  |
| --- | --- |
| 0x...     | eN |
| 0x1008-11 | e2 |
| 0x1004-07 | e1 |
| 0x1000-03 | e0 |

```asm
LDR R2, [R1, #(2*4)]
```
* To load using a register as an offset
```asm
@ The 3rd element is at 0index 2 so get the address and assign it to R3
MOV R3, #(2 * 4)
@ Add the offset in R3 to R1 to get our element.
LDR R2, [R1, R3]
```
* To count address offset 8th from the end ie 0xFF-8 = 0xF8
```asm
-8 two's complent: 0x0000 1000(0x08) = 0x1111 1000(0xF8)
which will be the 8th address from the bottom
LDR R2, [R1, #-(2*4)]
LDR R2, [R1, -R3]
```
* You can also use LSL left shift by 2 positions since left shift means x2 and right=divide /2
```asm
@ Suppose our array is of WORDs but we only
@ want the low order byte.
MOV R3, #2
@ Shift R3 left by 2 positions to multiply
@ by 4 to get the correct address.
LDR R2, [R1, R3, LSL #2]
```

### LDR Write back
* When the address is calculated by the adds and shfits, the result is not kept(thrown away) after we've loaded the register.
  If this is a loop we may want to keep the calculated address, this saves us from doing a seperate ```ADD``` operation on our index register.
* ``` ! ``` after the instruction tells assembler to set the bit in generated instructino telling CPU to save calculated address
```asm
LDR R2, [R1, R3, LSL #2]!  @ Updates R1 with the value calculated. 
```

### LDR Post-index addressing
* THink pre/post increment, consume the value then update (post) vs update value then increment(pre-inc)
* Recall post-indexed addressing, the data is retrieved first using the base register, then any offset shifting and adding is done
* Example: Load R1 with the memory pointed to by R2, then do R2=R2+R3
```asm
LDR R1, [R2] R3
```
* Example 2: Load R1 with the memory pointed to by R2, then do R2=R2+2 (post increment)
```asm
LDR R1, [R2], #2
```
* Ex.3 Load R1 with memory pointed at by R2, then do R2=R2 + (R3 shifted 2 Left)
```asm
LDR R1, [R2], R3, LSL #2
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
