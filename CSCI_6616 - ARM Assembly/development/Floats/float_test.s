/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Floating point number test builds
    Name: Howard Zhou

    File: float.s

    Description:
        - LDR STR flaoting point numbers


        @ Write syscalls
        R0 - 0=stdin; 1=stdout; 3=stderr
        R2 - stores length of string
        R7 - linux service 3=read; 4=write

 * ========================================================================================== 
 */
.section .text
.global main

.fpu neon-fp-armv8                 @ required to let assembler know to use FPU


main:
    LDR R0, =f1                    @ Load address of double variable
    LDR R2, =double_val1

    VLDR.f32 S0, [R0]
    @ VSTR.f32 S2, [R2]
    VLDR.F64 D1, [R2]              @ Load the float value in D0 (64-bit register)

    @ MOV R3, #0

    @ LDR R0, =NEO
    @ BL printf

exit:
    MOV R0, #0                      @ Set the return code
    MOV R7, #1                      @ 1= Linux service code exit
    SVC 0

.section .data
NEO: .asciz "Float: %f\n"

.align 4
f1:             .single 3.0e8
double_val1:    .double 3.0e8
buf: .fill 32

.section .note.GNU-stack, "", %progbits
.end


