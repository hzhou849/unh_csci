## ARM ASSEMBLY

## Build/Compile

## Common commands
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

# create the binary with debug symbols
gcc –g –O0 main.c –o main
```

## GDB debug 
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


###
The LDR and STR instructions use post-indexed addressing to update their address registers.

STR instructions store a word in memory.
LDR instructions load a word from memory.
