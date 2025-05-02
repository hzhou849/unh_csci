/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou

    File: main.s

    Description:
       
        - Jarvis 2025 Tactical Data processor
        - Application received input data from buffer of enemy trajectory
          Calculates intercepting path to fire missle defence
        - main file to kick off process


 * ========================================================================================== 
 */


.EQU OPTION_1_EXECUTE, 1
.EQU OPTION_2_READ,  2
@ .EQU OPTION_3_CHECK, 3
@ .EQU OPTION_4_INIT,  4
.EQU OPTION_5_EXIT,  5


.section .text
.global main
.fpu neon-fp-armv8                  @ required to let assembler know to use FPU

main:
    MOV R5, #0
    MOV R6, # 0                     @ Current size
    MOV R7, # 0                     @ Initialize head
    MOV R8, # 0                     @ Iniitalize tail

restart:
    // 1 - Print inital prompt
    LDR R0, =menu_str_main_menu     @ load  string arg to print
    BL menu_print                   @ print the options menu and prompt char

    // 2 - get user input
    LDR R0, =menu_fmt_specifier     @ set menu option format specifier %c
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

opt1: /// \ Execute the TDP 
/// Loads data and processes track data for every entry until list is finished

    BL load_data                    @ loads data from text file into queue
  next_track: 
    BL get_queue_size              @ check if queue current size is empty
    CMP R0, #0
    BEQ restart                     @ branch back to restart application
    BL calc_track_data              @ return R0 status 0=ok; 1=error
    BL encode_fire_data             @ encode the fire data first so we don't lose it 
    @ BL menu_test_fire_print         @ call menu.s  don't print this yet encode first
    BL debug_print_fire_record


    B next_track                    @ repeat for next record
    @ B exit

opt2: /// \ Read Output fire queue
    B restart
   
exit: /// \Exit and quit application
    LDR R0, =menu_str_exit          @ load exit message from menu.s
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




    