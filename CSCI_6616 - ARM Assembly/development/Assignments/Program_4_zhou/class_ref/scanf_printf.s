@**************************************************************
@ Name: scanf_printf.s
@ 
@ Description: Demo of scanf and printf c std input functions
@
@ Scanf registers:
@ R0: pointer to var containing format specifier %d, %c %h etc..
@ R1: input data buffer to store char
@
@ Printf registers
@ R0: contains address of string data var to print
@
@ Rev History
@ RAA 1/17/20 Origin
@*************************************************************



@ Scanf registers:
@ R0: pointer to var containing format specifier %d, %c %h etc..
@ R1: input data buffer to store char
@
@ Printf registers
@ R0: contains address of string data var to print
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
	LDR R2, =input_data_buf
	LDR R1, [R2]			@ dereference R2 and place in R1
	BL printf

	MOV R0, #0				@ exit return code
	MOV R7, #1				@ 1=exit service code
	SVC 0

.data
.word 	@ 32bit align all variables
result: .asciz	"input data = %x\n"
prompt: .asciz	"Enter value > "
in_format_specifer: .asciz "%c"
input_data_buf: .space 4, 0 @ Reserve 4 bytes and fill with zeros


@ Professor's shit code ver formated:
.section .note.GNU-stack, "", %progbits		@ disable GNU stack warning
.end
.global main 			@c entry point
.text 					@ code follows
main: ldr r0,=inp 		@r0 contains input prompt address
      bl printf 		@invoke printf
      
	  ldr r0,=inpf 		@ r0 contains input format string address
      ldr r1,=inp_d 	@r1 contains input data address
      bl scanf 			@invoke scanf
      
	  ldr r0,=res 		@r0 contains res address
      ldr r2,=inp_d 	@r2 contains data address
      ldr r1,[r2] 		@dereference r2 and place into r1
      bl printf 		@invoke printf
      
	  mov r0,#0 		@exit sucess code
      mov r7,#1 		@exit service
      svc 0 			@call service
.data @data follows
.word @32 bit align
@ascii null terminated strings
res: .asciz "input data = %d\n" 
inp: .asciz "input > "
inpf: .asciz "%d"
inp_d: .space 4,0 @reserve 4 bytes and fill will zeros
.end @end of the file
     
      
