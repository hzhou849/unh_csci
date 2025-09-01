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
    LDR R0, =t2                     @ not necessary, to reload, just good habbit
    VLDR.f32 S1, [R0]               @ load t2 value in S1
    VMOV S2, #2.0                   @ we need to divide t2 by 2
    VDIV.f32 S0, S1, S2             @ perform s0= s1/2
    LDR R0, =tm
    VSTR.f32 S0, [R0]               @ save value tm into memory


    ///\ 4) Find height at tm; 
    // y(t) = t * Voy -(0.5) * g * t^2 
    //y(tm) = tm * Voy - [(0.5) * 9.8m * (tm)^2]
    LDR R0, =tm
    VLDR.f32 S1, [R0]               @ load S1 = tm
    LDR R0, = Voy
    VLDR.f32 S2, [R0]               @ load S2 = Voy
    LDR R0, =gravity               
    VLDR.f32 S3, [R0]               @ load S3 = gravity(9.8m/s^2)
    VMOV S4, #0.5                   @ formula constant
    VMUL.f32 S8, S1, S2             @ S8 = tm * Voy; Solve first half of equation
    VMUL.f32 S9, S4, S3             @ S9= 0.5*9.8; Solve 2nd half of equation
    VMUL.f32 S10, S1, S1            @ S10 = tm *tm; (tm^2)
    VMUL.f32 S9, S9, S10            @ combine into S9
    VSUB.f32 S0, S8, S9            @ S0 = S8(1st)-2nd(S9)
    LDR R0, =max_height
    VSTR.f32 S0, [R0]               @ save max_height into memory


    ///\ 4) Find max distance (x) when t=t2
    // x(t2) = Vox * t2
    LDR R0, =Vox
    VLDR S1, [R0]                   @load S1=Vox
    LDR R0, =t2
    VLDR S2, [R0]                   @ load S2=t2
    VMUL.f32 S0, S1, S2             @ S0 = s1 *s2
    LDR R0, =max_range
    VSTR.f32 S0, [R0]               @ save max_range in memory

    ///\ 5) Print results args S0=max_height; s1=max_range
    LDR R0, =max_height
    VLDR.f32 S0, [R0]
    LDR R1, =max_range
    VLDR.f32 S1, [R1]
    BL menu_print_values

    B continue                      @ call continue function
    
    B exit

continue:
    LDR R0, =menu_str_cont          @ load string arg to print
    BL menu_print                   @ print the options menu and prompt char

    //  Get intial velocity
    LDR R0, =menu_fmt_specifier    @ Set the menu option input format specifier %c
    LDR R1, =menu_opt           @ buffer to store stdin
    PUSH {R1}                       @ calling BL will erase R1
    BL scanf                        @ get use input Initial velocity 
    BL getchar                      @ flush the whitespace left by scanf
    POP {R1}                        @ pop R1 to have input buffer address again
    LDRB R0, [R1]   @ also save the value in memory
    
    CMP R0, #0x59                   @ 'Y'=0x59; 0x76 'N'=0x4E; 0x6E
    BEQ restart                     @ If Y restart
    CMP R0, #0x79                   @ if 'y' restart
    BEQ restart
    CMP R0, #0x4E                   @ if 'N' 
    BEQ exit
    CMP R0, #0x6E
    BEQ exit
    B continue                      @ else ask again 

    


result_out:  
///\ quick debug to print test values R0=arg1 str to print
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
    menu_fmt_specifier:  .asciz "%c"     @ Format specifier for menu option stdin
    scanf_prompt:       .asciz "Enter value > "
    input_fmt_specifier:.asciz "%f"     @ format specifier for scanf input

.align 4  @ required for each variable initialized to ensure it will line up with a 4byte boundary
    // In order for printf to work you must keep the values in single/double precision variables
    rad_convert_val:        .single 0.017453292     @ angle * rad_convert_val = radians
    gravity:                .single 9.8 @m/s^2

    input_buffer:           .single 0.0             @ input buffer for scanf
    initial_velocity_ms:    .single 0.0
    launch_angle_deg:       .single 0.0
    Vox:                    .single 0.0
    Voy:                    .single 0.0
    t2:                     .single 0.0
    tm:                     .single 0.0
    max_height:             .single 0.0
    max_range:              .single 0.0

    temp_double: .double 0.0
   


.section .note.GNU-stack, "", %progbits          @ disable GNU stack warning
.end




    