## STDIO

## Read Input -  STDIN
#### Register args
* R0: ```0=stdin``` - read mode
* R1: ```=<input_buffer>``` - allow enough size in input buffer for '\n' or will overflow
* R2: ```<length_of_string>``` - Note: +1 for '\n' 
* R7: ```3``` - Linux service code 3=read mode
```asm
		MOV R0, #0			@ set read from: 0=stdin
		LDR R1, =inbuffer	@ load input buffer into R1
		MOV R2, #2			@ Read n char + '\n'
		MOV R7, #3			@ Linux service code 3=read mode
		SVC 0				@ syscall execute
```

## Read input - scanf
#### Register args
R0: ```=<format_specifier>``` <br>
R1: ```=<input_buffer``` <br>

* With scanf this will simplify the code alot more 
* Sometimes might capture extra character, allow extra buffer size for '\n' or '\0'
* if '\n' is captured by mistake and causing auto enter issues use:
```asm
MOV R0, #0    @ 0=FD for stdin
BL getchar    @ flush whitespace in buffer left by scanf
```
* example - scanf
```asm
LDR R0, =<format_specifier>	@ %s, %d, %c etc...
LDR R1, =<inputBuffer>		@ pointer to .data variable
BL scanf			@ branch scanf call
```

## Print output - stdio
#### Registers args
* output string = "messages include: %d %c"
R0: ```=<output_string>``` pointer to output string variable <br>
R1: ```arg1``` arg for output_string <br>
Rx: ```arg<x>``` <br>
* example:
```asm
LDR R0, =opStr		@ String message wtih variable to be printed
MOV R1, #1		@ arg1: operand counter
MOV R2, R4		@ arg2: derefence and get oprand1 value; prints %c
BL printf
.data
.word 	@ 32bit align all variables
	opStr: .asciz	"Operand[%d] = str: %s\n"
```


## Calculate size of string using .data directive strings trick for size
* you can use ```.``` this is special Assembler variable that contains
the current address the assembler is on as it works.
* In this case, the current address right after the string itself
  minus(-) the address of the start of string = length
```asm
myStr = the start address is 0x0002 to 0x0x008 
'.'   = the address end of myStr was declared or start myStr_size @ ie 0x0009
@ Math operation performed: [(.) - myStr]
so 0009 - 0002 = 7 (bytes: 2,3,4, 5,6,7,8) = length of myStr=7
```
* What happens if we declare myStr_size after anoter variable will the size be correct?
* Assuming this is calculated at compile time??? need to test this!!!!!!
  
* Example:
```asm
@ Get the size of string myStr load into R2

LDR R2, =myStr_size      @ get pointer to mystr
LDR R2, [R2]        @ derefernce the address arithmentic and load in R2

@ perform write myStr and pass size=R2

.data
.myStr .asciz "This is my string blah...\n"
.myStr_size .word .-myStr   @ math operation performed is: [(.) - myStr] = 
 

### Defining memory contents
* The first line defines 7 bytes all with the same value.
```asm
label: .byte 74, 0112, 0b00101010, 0x4a, 0x4a, 'j', 'H'+2
       .word 0x1234ABCD, -1434
       .ascii "hello world\n"
```
