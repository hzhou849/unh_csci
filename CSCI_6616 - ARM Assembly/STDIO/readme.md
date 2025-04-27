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

## Print output - stdout,stderr
#### Registers:
R0: ```<output_mode>```		@ 1=stdout, 0=stdin 2=stderr <br>
R1: ```=<output_string>```	@ output buffer string <br>
R2: ```<length of buffer>```	
R7: ```<linux service code=4>``` @ 4=write 3=read <br>
SVC 0 				@ execution interrupt for syscall <br>

## Print output - printf()
* Printf will modify R0-R3, LR so they need to be saved
* If you need more args, R4 must be pushed to stack for additional arguments
#### Registers args
* output string = ```"messages include: %d %c"```
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
### extra variables with stack prinf
* any arg after R3 must be pushed to the stack where ```printf``` will pull from there
* Be careful of order in stack LIFO, so it will print last in first
```asm
  LDR R0, =status_str
    MOV R1, R5              @ arg1= status(R5)
    MOV R2, R7              @ arg2= head(R7)
    MOV R3, R8              @ arg3= tail(R8) is always last postion written +1
    // Printf arg R1-R3 is full, need to push to stack
    MOV R4, #CAPACITY_SIZE  @ arg5= Total_capacity_size
    PUSH {R4}               @ Push capcity size value to stack 
    MOV R4, R6              @ arg4= current size(R6)
    PUSH {R4}               @ push to stack for output
    @ R5 = arg5
    @ PUSH {R5-R8}
    BL printf
    POP {R4}...	            @ you can pop the data to delete or add SP shown below:
    ADD SP, SP, #8          @ delete the 2 x(4bytes) values pushed into stack
#status_str: .asciz "\nBuffer status: [%d]; Head_offset:[+%d]; tail_offset: [+%d]; size [%d]/total_capacity: [%d]\n"
```

## Printf with floats 
* All floats must be converted to ```doubles```.
```asm
.data 
.word @32 bit 
    test_print: .asciz "Target: %d; Track: %d; Range: %d; Azimuth: %f; Elevation %f\n"
.align 4
	double_buffer: .double 0.0


    // ** after R3 arg, you need to push to stack in order to print
    // Note print from stack is LIFO so you need to reverse azimuth and elevation
    MOV R1, R4                          @ load arg1
    MOV R2, R5                          @ load arg2
    MOV R3, R6                          @ load arg3
    VCVT.f64.f32 d0, s1                 @ Printf requires floats to be doubles
    LDR R0, =double_buffer2             @ temp double buffer to hold for conversion
    VSTR.f64 D0, [R0]                   @ write double to memory
    LDM R0, {R4, R5}                    @ load double spread into 2x32bit regs 4 &5

    VCVT.f64.f32 d1, s2
    VSTR.f64 D1, [R0]
    LDM R0, {R6, R7}
    PUSH {R6, R7}                       @ stack if LIFO PUSH  arg5 first
    PUSH {R4, R5}                       @ push arg4 (this is read first bc it is top)
    LDR R0, =test_print
    bl printf

    POP {R6, R7}                        @ remove arg 5 from stack
    POP {R4,R5}                         @ remove arg 4 from stack 
```

## How to split long string messages with one variable:
* To create a new line in code if message is too long
* string type wll be ```.ascii``` not ```z```
* ensure you need to manually align a null terminator byte \0 at the end
```asm
.data
.word @ 32 bit align all variables
	menu_str_options: 	
        	.ascii "\n\nVector Computation App:\n\n1) Enter A Magnitude \n2) Enter B Magnitude \n3) Enter A Angle \n4) Enter B Angle \n"
        	.ascii "5) Print A Mangnitude & Angle \n6) Print B Magnitude & Angle \n7) Print Vector Sum \n8) Exit\n"
        	.byte 0  @ Null terminator to end the string
	menu_str_prompt:    .asciz "Enter choice > "
	menu_str_exit:		.asciz "Application exit!\n"
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
