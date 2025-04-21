/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou

    File: main.s

    Description:
       
        - Jarvis 2025 Tactical Data processor
        - Application received input data from buffer of enemy trajectory
        - Calculate intercepting path to fire missle defence


    Formulas used:




    @ Write syscalls
        R0 - 0=stdin; 1=stdout; 3=stderr
        R2 - stores length of string
        R7 - linux service 3=read; 4=write


    @ Scanf registers:
        R0: pointer to var containing format specifier %d, %c %h etc..
        R1: input data buffer to store char ( requires actual char value ie 0x31 = '1')
    
    @ Printf registers:
        R0: contains address of string data var to print
        R1..R?: args used for variable print

 * ========================================================================================== 
 */

@ Function includes menu.s 

@ Define Constants
@ .EQU CHAR_A, 0x41   @ Ascii "A"
@ .EQU CHAR_B, 0x42   @ Ascii "B"


.section .text
.global main

.fpu neon-fp-armv8                 @ required to let assembler know to use FPU


main:
    MOV R5, #0
    MOV R6, # 0                      @ Current size
    MOV R7, # 0                      @ Initialize head
    MOV R8, # 0                      @ Iniitalize tail

restart:

    // 1 - Print inital prompt
    LDR R0, =menu_str_prompt1       @ load string arg to print
    BL menu_print                   @ print the options menu and prompt char
    BL write_buffer
    BL write_buffer
    BL read_buffer
    BL read_buffer

exit:
    LDR R0, =menu_str_exit          @ load exit message
    BL printf               
    MOV R0, #0                      @ Set the return code
    MOV R7, #1                      @ 1= Linux service exit
    SVC 0

.data
@ required for each variable initialized to ensure it will line up with a 4byte boundary address
.align 4 @ 32bit align all variables
    @ menu_opt:           .space 4,0      @ Buffer to store stdin menu option selection 
    @ menu_fmt_specifier:  .asciz "%c"     @ Format specifier for menu option stdin
    @ scanf_prompt:       .asciz "Enter value > "
    @ input_fmt_specifier:.asciz "%f"     @ format specifier for scanf input

.align 4  @ required for each variable initialized to ensure it will line up with a 4byte boundary
    // In order for printf to work you must keep the values in single/double precision variables
    
    @ rad_convert_val:        .single 0.017453292     @ angle * rad_convert_val = radians
    @ gravity:                .single 9.8 @m/s^2

    @ input_buffer:           .single 0.0             @ input buffer for scanf
    @ initial_velocity_ms:    .single 0.0
    @ launch_angle_deg:       .single 0.0
    @ Vox:                    .single 0.0
    @ Voy:                    .single 0.0
    @ t2:                     .single 0.0
    @ tm:                     .single 0.0
    @ max_height:             .single 0.0
    @ max_range:              .single 0.0

    @ temp_double: .double 0.0
   


.section .note.GNU-stack, "", %progbits          @ disable GNU stack warning
.end




    