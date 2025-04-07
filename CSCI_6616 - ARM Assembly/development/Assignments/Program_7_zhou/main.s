/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Program 7 - Floating Point Angle/magnitude
    Name: Howard Zhou

    File: main.s

    Description:
        - Add two vectors a & b  to produce the vector sum 
        - ***NOTE: ensure .align 4(bytes) is used for each buffer variable
          instantiation to ensure you don''t get bus error if address
          falls outside of 4 byte boundary
        - In order for printf to work buffers must be .single/.double type 
          and the print value must be converted to double 64 precision starting at {R2, R3}
          additional float values need to be pushed to the stack ie 2nd float
          {R6,R7} need to be pushed to the stack:
          push {R6,R7}
        


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

    

        @ main registers:
            R0-R4 - Temprory work registers
            R5: 
            R6: 
            R7: 
            R8: 
            R9: 

            S5: A Magnitude;     S6: A Angle
            S7: B Magnitude;     S8: B Angle
 * ========================================================================================== 
 */

@ Function includes menu.s 

@ Define Constants
.EQU CHAR_A, 0x41   @ Ascii "A"
.EQU CHAR_B, 0x42   @ Ascii "B"


.section .text
.global main

.fpu neon-fp-armv8                 @ required to let assembler know to use FPU


main:

    //******************************************************
    // Debug testing functions
    @ MOV R0, #4
    LDR R0, =test_value
    VLDR.f32 S0, [R0] 
    BL get_sin                      @ answer in rad; need to rad * 57.2957795 to covert to angle



    // test factoral
    @ BL factoral
    BL debug_print_result           @ test print; input s0=arg float

    LDR R0, =test_value
    VLDR.f32 S0, [R0] 

    BL get_cos
    BL debug_print_result           @ test print; input s0=arg float

    
    //******************************************************

    MOV R5, #0
    MOV R6, #0                  @ Current size
    MOV R7, #0                  @ Initialize head
    MOV R8, #0                  @ Iniitalize tail

restart:

    // 1 - Print menu option
    BL menu_print               @ print the options menu

    // 2 - Get menu user option
    LDR R0, =menu_fmt_specifer  @ Set the menu option input format specifier
    LDR R1, =menu_opt           @ buffer to store stdin
    PUSH {R1}                   @ Push menu_opt to stack, since c calls will overwrite this value 
    BL scanf                    @ call scanf
    BL getchar                  @ flush the whitespace left by scanf
    POP {R1}                    @ Retrieve menu_opt address
    LDR R2, [R1]                @ Retrieve by dereferencing R1

    // Check what option is selected
    CMP R2, #1
    BEQ opt1
    CMP R2, #2
    BEQ opt2
    CMP R2, #3
    BEQ opt3
    CMP R2, #4
    BEQ opt4
    CMP R2, #5
    BEQ opt5
    CMP R2, #6
    BEQ opt6
    CMP R2, #7
    BEQ opt7
    CMP R2, #8
    BEQ opt8

opt1:   
///\ Enter A Magnitude
                                    @ Print the prompt
    LDR R0, =scanf_prompt           @ load input prompt
    BL printf                       @ print prompt

    // Get input float
    LDR R0, =input_fmt_specifier    @ set the scanf format specifier to %float       
    LDR R1, =input_buffer           @ load address of input buffer variable
    PUSH {R1}                       @ Push [input_buffer] to stack, since c calls will overwrite this value 
    BL scanf                        @ call scanf
    BL getchar                      @ flush the whitespace left by scanf
    POP {R1}                        @ Retrieve [input_buffer] address
    
                                    @ Load the value in S float registers
    VLDR.f32 S5, [R1]               @ load A magnitude from input_buffer into S5 reg

                                    @ Write the value to memory as well
    LDR R0, =f_a_magnitude          @ load variable to use for write
    VSTR.f32 S5, [R0]               @ write A mag value to f_a_magnitude in memory

    
    B restart                       @ return to menu

opt2:   
///\ Enter B Magnitude
    LDR R0, =scanf_prompt           @ load input prompt
    BL printf                       @ print prompt
    LDR R0, =input_fmt_specifier    @ set the scanf format specifier to %float       
    LDR R1, =input_buffer           @ load address of input buffer variable
    PUSH {R1}                       @ Push [input_buffer] to stack, since c calls will overwrite this value 
    BL scanf                        @ call scanf
    BL getchar                      @ flush the whitespace left by scanf
    POP {R1}                        @ Retrieve [input_buffer] address
    VLDR.f32 S7, [R1]               @ load B magnitude from input_buffer into S7 reg
    LDR R0, =f_b_magnitude          @ load variable to use for write
    VSTR.f32 S7, [R0]               @ write B mag value to f_a_magnitude in memory
    B restart                       @ return to menu

opt3:   
///\ Enter A Angle
    LDR R0, =scanf_prompt           @ load input prompt
    BL printf                       @ print prompt
    LDR R0, =input_fmt_specifier    @ set the scanf format specifier to %float       
    LDR R1, =input_buffer           @ load address of input buffer variable
    PUSH {R1}                       @ Push [input_buffer] to stack, since c calls will overwrite this value 
    BL scanf                        @ call scanf
    BL getchar                      @ flush the whitespace left by scanf
    POP {R1}                        @ Retrieve [input_buffer] address
    VLDR.f32 S6, [R1]               @ load Angle A into S6
    LDR R0, =f_a_angle               @ load variable to write to
    VSTR.f32 S6, [R0]               @ write A angle
    B restart

opt4:   ///\ Enter B Angle
opt5:   ///\ Print A Magnitude & Angle
    MOV R0, #CHAR_A                 @ copy 'A' to R0
    LDR R4, =f_a_magnitude
    LDR R5, =f_a_angle
    VLDR.f32 S0, [R4]                 @ Copy A Magnitude value to S0
    VLDR.f32 S1, [R5]                 @ copy A angle value to S1
    BL menu_print_values
    B restart

opt6:   
///\ Print B Magnitude & Angle
    MOV R0, #CHAR_B                 @ copy 'A' to R0
    LDR R4, =f_b_magnitude
    LDR R5, =f_b_angle
    VLDR.f32 S0, [R4]                 @ Copy A Magnitude value to S0
    VLDR.f32 S1, [R5]                @ copy A angle value to S1
    BL menu_print_values
    B restart

opt7:   
///\ Print Vector Sum 
/// S5: A Magnitude;     S6: A Angle
/// S7: B Magnitude;     S8: B Angle
                                    @ [ convert angle to rads= angle * pi/180 ]
    LDR R0, =rad_convert_val     @ load radian conversion constant into R0
    VLDR.f32 S0, [R0] 

    LDR R1, =f_a_angle
    VLDR.f32 S0, [R1]               @ load A angle into s0 to pass for get_sin
    BL get_sin                      @ answer in rad; need to rad * 57.2957795 to covert to angle
    BL debug_print_result           @ test print; input s0=arg float

    LDR R1, =f_a_angle
    VLDR.f32 S0, [R1]               @ load A angle into s0 to pass for get_sin
    BL get_cos                      @ answer in rad; need to rad * 57.2957795 to covert to angle
    BL debug_print_result           @ test print; input s0=arg float
    B restart

    @ TO get total length of angle
    @ Ax = A*Cos(a)  
    @ Ay = A* sin(a)
    @ Bx = B * cos(b)
    @ By = B * sin(b)

    /// seperate file
    @ implement factoral,
    @ setup taylor series for sin  might require recursion?
    @ setup taylor series for cos

opt8:   ///\ Exit
    BL exit                 @ Branch to exit



  



   

exit:
    LDR R0, =menu_str_exit   @ load exit message
    BL printf               
    MOV R0, #0              @ Set the return code
    MOV R7, #1              @ 1= Linux service exit
    SVC 0


.data
@ required for each variable initialized to ensure it will line up with a 4byte boundary address
.align 4 @ 32bit align all variables
    menu_opt:           .space 4,0     @ Buffer to store stdin menu option selection 
    menu_fmt_specifer:  .asciz "%d"     @ Format specifier for menu option stdin
    scanf_prompt:       .asciz "Enter value > "
    input_fmt_specifier:.asciz "%f"     @ format specifier for scanf input


.align 4  @ required for each variable initialized to ensure it will line up with a 4byte boundary
    // In order for printf to work you must keep the values in single/double precision variables
    input_buffer:       .single 0.0             @ input buffer for scanf
    f_a_magnitude:      .single 0.0
    f_a_angle:          .single 0.0
    f_b_magnitude:      .single 0.0
    f_b_angle:          .single 0.0
    calc_result:        .single 0.0
    rad_convert_val:    .single 0.017453292     @ angle * rad_convert_val = radians
    angle_convert_val:  .single 57.2958         @ radian * angle_convert_val = angles
    test_value:          .single 3.0


.section .note.GNU-stack, "", %progbits          @ disable GNU stack warning
.end




    