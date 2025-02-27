## STDIO

## STDIN
* using ASM stdin
* R0: 1=stdio
* R1: =```<input_buffer>```
```asm
```

### .data directive strings trick for size
* you can use ```.``` - special Assembler variable that contains
the current address the assembler is on as it works.
* In this case, the current address right after the string itself
  minus(-) the address of the start of string = length

* How does it know current address is right after stirng??? is it because of .myStr_size declaration after string?
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
.myStr_size .word .-myStr   @ math operation
 

### Defining memory contents
* The first line defines 7 bytes all with the same value.
```asm
label: .byte 74, 0112, 0b00101010, 0x4a, 0x4a, 'j', 'H'+2
       .word 0x1234ABCD, -1434
       .ascii "hello world\n"
```
