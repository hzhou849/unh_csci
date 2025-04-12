/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project:  P8 - Projectile Kinematics Max height/range
    Name: Howard Zhou

    File: main.s

    Description:
       
        - Calculate max Height and range with user input inital velocity
          and launch angle


    Formulas used:

        // Inital velocities
        V_o,x = V_o * cos(a)
        V_o,y = V_o * sin(a)


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

    //  Get intial velocity
    LDR R0, =input_fmt_specifier    @ Set the menu option input format specifier %f
    LDR R1, =input_buffer           @ buffer to store stdin
    PUSH {R1}                       @ calling BL will erase R1
    BL scanf                        @ get use input Initial velocity 
    BL getchar                      @ flush the whitespace left by scanf
    POP {R1}                        @ pop R1 to have input buffer address again
    VLDR.f32 S5, [R1]               @ load the inputvalue into S5 reg
    LDR R0, =initial_velocity_ms    @ also save the value in memory
    VSTR.f32 S5, [R0]               @ write to pointer R0

    // Print prompt2 and get launch angle
    LDR R0, =menu_str_prompt2       @ print launch angle string
    BL menu_print                      
    LDR R0, =input_fmt_specifier    @ set fmt specifier to %f
    LDR R1, =input_buffer           
    PUSH {R1}                       @ save R1 for retrieval after scanf call
    BL scanf
    BL getchar                      @ call getchar to flush whitespace in buffer
    POP {R1}                        @ restore R1 with pointer to input_buffer
    VLDR.f32 S6, [R1]               @ load input angle into S6reg
    LDR R0, =launch_angle_deg       @ save angle into memory so we dont lose it
    VSTR.f32 S6, [R0]

    ///\ 1) Solve for initial velocities
    // Vox = Vo * cos(a)
    LDR R0, =launch_angle_deg
    VLDR.f32 S0, [R0]               @ load the launch agle from mermoy into R0 for calculation
    LDR R0, =rad_convert_val        @ load the radian conversion value to convert
    VLDR.f32 S7, [R0]
    VMUL.f32 S0, S7, S0             @ multiply S0 = launch_angle*rad_convert 
    BL get_cos                      @ get cos(S0); return S0 
    LDR R0, =initial_velocity_ms
    VLDR.f32 S1, [R0]               @ load initial velocity from memory
    VMUL.f32 S2, S1, S0             @ S2 = initialVel * cos(a)
    LDR R0, =Vox                    @ load Vox address to save result
    VSTR.f32 S2, [R0]               @ save Vox in memory
    
    // Voy = Vo * sin(a)
    LDR R0, =launch_angle_deg
    VLDR.f32 S0, [R0]               @ load launch angle into S0
    LDR R0, =rad_convert_val        @ load the radian conversion value to convert
    VLDR.f32 S7, [R0]
    VMUL.f32 S0, S7, S0             @ multiply S0 = launch_angle*rad_convert 
    BL get_sin                      @ get sin(S0); return S0
    LDR R0, =initial_velocity_ms
    VLDR.f32 S1, [R0]
    VMUL.f32 S2, S1, S0             @ S2 = initVel * sin(a)
    LDR R0, =Voy
    VSTR.f32 S2, [R0]               @ save Voy into memory

    ///\ 2) Calculate max time t2 with Height formula: 
    // t = Voy/(0.5)g
    LDR R0, =Voy
    VLDR.f32 S1, [R0]               @ load Voy into S1 from memory
    VMOV S2, #0.5                   @ constant value from equation 
    LDR R0, =gravity
    VLDR.f32 S7, [R0]               @ load gravity(9.8m/s^2) into S7
    VMUL.f32 S0, S2, S7             @ S0 = 0.5 *gravity
    VDIV.f32 S5, S1, S0             @ S5 = Voy/S0
    LDR R0, =t2
    VSTR.f32 S5, [R0]               @ save t2 into memory

    ///\ 3) We need max height; We know t2 is max time, therfore
    /// (t2-t1)/2 = tm; The time of max height
    // y(t) = t * Voy -(0.5) * g * t^2 


    ///\ 4) Find max distance (x) when t=t2
    // x(t2) = Vox * t2



    



    
    B exit



result_out:  // R0=arg1 str to print
    PUSH {R0-R12, LR}
    VCVT.f64.f32 D1, S0             @ convert input to double
    LDR R6, =temp_double            @ load double variable buffer
    VSTR.f64 D1, [R6]               @ copy double into  buffer
    LDM R6, {R2, R3}                @ copy value into two gp register
    BL printf                       @ R0 is already set to output string
    POP {R0-R12, LR}
    BX LR


    BL debug_print_result           @ test print; input s0=arg float
    B restart

exit:
    LDR R0, =menu_str_exit          @ load exit message
    BL printf               
    MOV R0, #0                      @ Set the return code
    MOV R7, #1                      @ 1= Linux service exit
    SVC 0

.data
@ required for each variable initialized to ensure it will line up with a 4byte boundary address
.align 4 @ 32bit align all variables
    menu_opt:           .space 4,0      @ Buffer to store stdin menu option selection 
    menu_fmt_specifer:  .asciz "%d"     @ Format specifier for menu option stdin
    scanf_prompt:       .asciz "Enter value > "
    input_fmt_specifier:.asciz "%f"     @ format specifier for scanf input

.align 4  @ required for each variable initialized to ensure it will line up with a 4byte boundary
    // In order for printf to work you must keep the values in single/double precision variables
    rad_convert_val:    .single 0.017453292     @ angle * rad_convert_val = radians

    input_buffer:           .single 0.0             @ input buffer for scanf
    initial_velocity_ms:    .single 0.0
    launch_angle_deg:       .single 0.0
    Vox:                    .single 0.0
    Voy:                    .single 0.0
    gravity:                .single 9.8 @m/s^2
    t2:                     .single 0.0
    tm:                     .single 0.0

    temp_double: .double 0.0
   


.section .note.GNU-stack, "", %progbits          @ disable GNU stack warning
.end




    