/*===========================================================================================

 File: stdio.s

 @Description: 

 @Registers
 
 stdin:
 R0: Mode  0=stdin; 1=stdout; 2=stderr
 R1: inBuffer 
 R2: length of chars to read
 R7: Linux service code 3=read; 4=write

 
=============================================================================================
*/


.global main
.section .text

main:
    @ stdin
    MOV R0, #0                  @stdin =0;
    LDR R1, =inBuffer           @ load input buffer
    MOV R2, #1                  @ capture 1 char; should be char+'\n' enter captured?
    MOV R7, #3                  @ Linux service code 3=read
    SVC 0                       @ execute

    @ stdout - extract char from inputBuffer and pass to outputBuffer
    MOV R0, #1                  @ 1=stdin
    LDR R1, =outBuffer          @ load output buffer
    MOV R2, #2                 @ length of string to write
    MOV R7, #4                  @ linux service code 4=write
    LDR R4, =inBuffer           @ load input buffer to be used below
    @ store char from above into outbuffer to be printed
    @ store byte into R5, [R4,0]= dereference R4 @offset0
    LDRB R5, [R4, #0]             @ extract char from inputbuffer
    STRB R5, [R1]               @ load byte char into dereferenced *R1=[char_R5] to print
    MOV R5, #0x0A
    STRB R5, [R1, #1]        @ store a '\n' in output string next pointer offset +1
    SVC 0         

exit:
    MOV R0, #0                  @ return value
    MOV R7, #1                  @ linux service exit code
    SVC 0              

.data
.word
    // stdio variables
    inBuffer: .space 4, 0       @ allocate 20bytes for input
    outBuffer: .space 32, 0     @ allocate 32 bytes for output


    // cstd variales

.section .note.GNU-stack, "", %progbits
.end
