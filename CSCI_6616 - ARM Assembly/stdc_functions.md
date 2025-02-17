## Using stdc functions
* example to use scanf/printf
* Scanf registers:
```
* loads one char per execution, if multiple required, you must use in loop
 R0: pointer to var containing format specifier %d, %c %h etc..
 R1: dereferences pointer value of input data buffer to store char (requires actual char value not pointer ie 0x31='1'
```
* In ARM assembly, when using scanf (or any other C standard input function), the newline character \n (ASCII 0x0A) remains in the input buffer after a user presses Enter. This happens because scanf reads the user input and stops at the first whitespace character (such as a space, tab, or newline). It leaves the newline (\n) in the input buffer, which can interfere with subsequent input operations.

To handle this and flush the buffer (i.e., to remove the leftover newline), you have a couple of options. Here are some strategies:
1. Consume the newline explicitly after reading the input
One common way to flush the newline is to consume it manually by reading the input buffer after calling scanf. You can do this using a function like getchar() or reading directly from the standard input stream.
```c
#include <stdio.h>

int main() {
    char buffer[100];
    
    // Read input using scanf
    scanf("%99s", buffer);
    
    // Flush the buffer by reading the newline
    while (getchar() != '\n') {
        // Keep reading until the newline character
    }

    // Now you can safely use the input for further operations
    printf("Input received: %s\n", buffer);
    
    return 0;
}

```

#### 3. Flush stdin in ARM Assembly (Approximated Solution)
In ARM assembly, if you're interfacing directly with C library functions like scanf, you would typically need to call a system function to flush the input buffer or manually process the input.

For example, you can invoke getchar() after your scanf call to clear the buffer, as shown in the C code above, by calling the appropriate system call in ARM assembly.

You can write assembly code like this (assuming you're familiar with using system calls):

```asm
Copy
    MOV     R0, #0           // File descriptor for stdin
    BL      getchar          // Call getchar() to discard the newline
This would loop and discard all characters until the newline is consumed, ensuring that the buffer is flushed.
```

## Printf registers
```
 R0: contains address of string data var to print'
 R1-R?: args varibles used to print in string above
```
```asm
.section .text
.global main

main:
	@ Printf
	LDR R0, =prompt
	BL printf

	@ Scanf
	LDR R0, =in_format_specifer
	LDR R1, =input_data_buf
	BL scanf

	LDR R0, =result
	LDR R2, =input_data_buf @ loads address of input-data_buf
	LDR R1, [R2]			@ dereference R2 to get actual 'char' and place in R1. 
	BL printf

	@ if using scanf a extra '\n' char from user hitting enter will be captured which causes the next time 
	@ you run scanf (ie loop) to automatically run by itself again 
	@call getchar to counter_act scanf's issue with '\n' capture. this will flush the buffer
	BL getchar	

	MOV R0, #0				@ exit return code
	MOV R7, #1				@ 1=exit service code
	SVC 0

.data
.word 	@ 32bit align all variables
result: .asciz	"input data = %x\n"
prompt: .asciz	"Enter value > "
in_format_specifer: .asciz "%c"
input_data_buf: .space 4, 0 @ Reserve 4 bytes and fill with zeros

.section .note.GNU-stack, "", %progbits		@ disable GNU stack warning
.end
```
