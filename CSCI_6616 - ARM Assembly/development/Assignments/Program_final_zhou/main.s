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

.EQU OPTION_1_EXECUTE, 1
@ .EQU OPTION_2_READ,  2
@ .EQU OPTION_3_CHECK, 3
@ .EQU OPTION_4_INIT,  4
.EQU OPTION_5_EXIT,  5


.section .text
.global main

.fpu neon-fp-armv8                 @ required to let assembler know to use FPU


main:
    MOV R5, #0
    MOV R6, # 0                      @ Current size
    MOV R7, # 0                      @ Initialize head
    MOV R8, # 0                      @ Iniitalize tail

   

    // TODO::
    // 1) convert range to float
    // 2) check how to store decimal value to buffer? can the ring buffer be a single? or just aligned by 4?


restart:
    // 1 - Print inital prompt
    LDR R0, =menu_str_main_menu     @ load  string arg to print
    BL menu_print                   @ print the options menu and prompt char

    // 2 - get user input
    LDR R0, =menu_fmt_specifier      @ set menu option format specifier %c
    LDR R1, =menu_opt               @ buffer to store stdin
    PUSH {R1}                       @ save this since c calls alter R1
    BL scanf
    BL getchar                      @ flush whitespace left by scanf
    POP {R1}                        @ retrieve menu_opt address
    LDR R0, [R1]                    @ load user input char data


    // Check the menu option selected
    CMP R0, #OPTION_1_EXECUTE
    BEQ opt1
    CMP R0, #OPTION_5_EXIT
    BEQ exit

opt1: /// \Execute
/// Loads data and processes track data for every entry until list is finished
    BL load_data                    @ loads data from text file into queue
  next_track: 
    @ BL check_empty                  @ check if head is empty just call =b_curr_size
    CMP R0, #1
    BEQ restart                     @ branch back to restart application
    BL calc_track_data              @ return R0 status 0=ok; 1=error
    @ BL print_fire_output            @ [in] R0: 1=bad_data

    B exit
   
exit: /// \Exit and quit application
    LDR R0, =menu_str_exit          @ load exit message
    BL printf               
    MOV R0, #0                      @ Set the return code
    MOV R7, #1                      @ 1= Linux service exit
    SVC 0

.data
@ required for each variable initialized to ensure it will line up with a 4byte boundary address
.align 4 @ 32bit align all variables
    buffertest: .space 16, 0
    menu_opt:           .space 4,0      @ Buffer to store stdin menu option selection 
    menu_fmt_specifier:  .asciz "%d"     @ Format specifier for menu option stdin
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




    