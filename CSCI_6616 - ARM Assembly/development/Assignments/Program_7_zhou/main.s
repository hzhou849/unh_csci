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

    Formulas used:
     - Ax = A * Cos(a)  
        @ cx = ax + bx
    @ cy = ay + by

    - MAGNITUDE_C= sqrt[(ax+bx)^2 + (ay+by)^2]
    @ MAGNITUDE_C= sqrt[(cx)^2 + (cy)^2] 

    @ ANGLE_C = arctan(cy/cx)

        


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
    BL get_sin                     @ answer in rad; need to rad * 57.2957795 to covert to angle



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
    LDR R0, =f_a_angle              @ load variable to write to
    VSTR.f32 S6, [R0]               @ write A angle
    B restart

opt4:   ///\ Enter B Angle
    LDR R0, =scanf_prompt           @ load input prompt
    BL printf                       @ print prompt
    LDR R0, =input_fmt_specifier    @ set the scanf format specifier to %float       
    LDR R1, =input_buffer           @ load address of input buffer variable
    PUSH {R1}                       @ Push [input_buffer] to stack, since c calls will overwrite this value 
    BL scanf                        @ call scanf
    BL getchar                      @ flush the whitespace left by scanf
    POP {R1}                        @ Retrieve [input_buffer] address
    VLDR.f32 S6, [R1]               @ load Angle A into S6
    LDR R0, =f_b_angle              @ load variable to write to
    VSTR.f32 S6, [R0]               @ write A angle
    B restart
opt5:   ///\ Print A Magnitude & Angle
    MOV R0, #CHAR_A                 @ copy 'A' to R0
    LDR R4, =f_a_magnitude
    LDR R5, =f_a_angle
    VLDR.f32 S0, [R4]               @ Copy A Magnitude value to S0
    VLDR.f32 S1, [R5]               @ copy A angle value to S1
    BL menu_print_values
    B restart

opt6:   
///\ Print B Magnitude & Angle
    MOV R0, #CHAR_B                 @ copy 'A' to R0
    LDR R4, =f_b_magnitude
    LDR R5, =f_b_angle
    VLDR.f32 S0, [R4]               @ Copy A Magnitude value to S0
    VLDR.f32 S1, [R5]               @ copy A angle value to S1
    BL menu_print_values
    B restart

opt7:   
///\ Print Vector Sum  [ convert angle to rads= angle * pi/180 ]
    //****DEBUG *******************
    @ // Load default mag values for debugging
    @ VMOV S3, #1.0
    @ LDR R0, = f_a_magnitude
    @ VSTR.f32 S3, [R0]
    @ LDR R0, = f_b_magnitude
    @ VSTR.f32 S3, [R0]
    //*****************************

    // Print Vector A
     ///\ Print A Magnitude & Angle
    MOV R0, #CHAR_A                 @ copy 'A' to R0
    LDR R4, =f_a_magnitude
    LDR R5, =f_a_angle
    VLDR.f32 S0, [R4]                 @ Copy A Magnitude value to S0
    VLDR.f32 S1, [R5]                 @ copy A angle value to S1
    BL menu_print_values

    ///\ Print B Magnitude & Angle
    MOV R0, #CHAR_B                 @ copy 'A' to R0
    LDR R4, =f_b_magnitude
    LDR R5, =f_b_angle
    VLDR.f32 S0, [R4]                 @ Copy A Magnitude value to S0
    VLDR.f32 S1, [R5]                @ copy A angle value to S1
    BL menu_print_values




    ///\ Calculate Vector A
    LDR R0, =rad_convert_val        @ load radian conversion constant into R0
    VLDR.f32 S1, [R0] 
    LDR R1, =f_a_angle
    VLDR.f32 S2, [R1]               @ load A angle into s0 to pass for get_sin
    VMUL.f32 S0, S1, S2             @ s0 = rad_convert * inputAngle
    LDR R0, =rad_a                  @ load pointer to store a radian (for later)
    VSTR.f32 S0, [R0]               @ store converted  to memory rad_a
    VMOV.f32 S5, S0                 @ copy converted radian into S5 as well to quick use

    // Ax = A * Cos(a)  
    BL get_cos                      @ s0=answer in rad; need to rad * 57.2957795 to covert to angle
    LDR R0, =f_a_magnitude          @ load address A magnitude
    VLDR.f32 S1, [R0]               @ load value from R0 pointer
    VMUL.f32 S2, S0, S1             @ Ax= s0(cos(x)) * s1(a_mag)
    LDR R0, =ax
    VSTR.f32 S2, [R0]               @ store S2 into ax in memory
    LDR R0, =print_ax
    BL result_out

    // Ay = A * sin(a)
    LDR R0, =rad_a                  @ get angle a(radian)
    VLDR.f32 S0, [R0]               @ load angle a(rad) into s0
    BL get_sin                      @ S0 = calculate sin(a_rad)
    LDR R0, =f_a_magnitude          
    VLDR.f32 S1, [R0]               @ load A magnitude into S1
    VMUL.f32 S2, S0, S1             @  Ay = A * sin(x)
    LDR R0, =ay
    VSTR.f32 S2, [R0]               @ store Ay into ay variable
    LDR R0, =print_ay
    BL result_out

    ///\ Calculate Vector B
    LDR R0, =rad_convert_val       @ load radian conversion constant into R0
    VLDR.f32 S1, [R0] 
    LDR R1, =f_b_angle
    VLDR.f32 S2, [R1]               @ load A angle into s0 to pass for get_sin
    VMUL.f32 S0, S1, S2             @ s0 = rad_convert * inputAngle
    LDR R0, = rad_b                 @ load pointer to store a radian (for later)
    VSTR.f32 S0, [R0]               @ store converted  to memory rad_b
    VMOV.f32 S5, S0                 @ copy converted radian into S5 as well to quick use

    // Bx = B * Cos(b)  
    BL get_cos                      @ s0=answer in rad; need to rad * 57.2957795 to covert to angle
    LDR R0, =f_b_magnitude          @ load address B magnitude
    VLDR.f32 S1, [R0]               @ load value from R0 pointer
    VMUL.f32 S2, S0, S1             @ Bx= s0(cos(x)) * s1(a_mag)
    LDR R0, =bx
    VSTR.f32 S2, [R0]               @ store S2 into ax in memory
    LDR R0, =print_bx
    BL result_out

    // By = B * sin(b)
    LDR R0, =rad_b                  @ get angle a(radian)
    VLDR.f32 S0, [R0]               @ load angle a(rad) into s0
    BL get_sin                      @ S0 = calculate sin(a_rad)
    LDR R0, =f_b_magnitude          
    VLDR.f32 S1, [R0]               @ load B magnitude into S1
    VMUL.f32 S2, S0, S1             @  By = B * sin(x)
    LDR R0, =by
    VSTR.f32 S2, [R0]               @ store By into ay variable
    LDR R0, =print_by
    BL result_out

    LDR R0, =print_result           @ Print resultl banner
    BL result_out

    ///\ calculate cx = ax + ay
    LDR R0, =ax
    VLDR.f32 S1, [R0]               @ fetch ax value from memory
    LDR R0, =ay
    VLDR.f32 S2, [R0]               @ fetch ab value from memory
    VADD.f32 S0, S1, S2
    LDR R0, =cx                     
    VSTR.f32 S0, [R0]               @ store cx value in memory

    LDR R0, =print_cx
    BL result_out
    

    ///\ Caculate cy = ay + by
    LDR R0, =ay
    VLDR.f32 S1, [R0]               @ fetch ax value from memory
    LDR R0, =by
    VLDR.f32 S2, [R0]               @ fetch ab value from memory
    VADD.f32 S0, S1, S2
    LDR R0, =cy                     
    VSTR.f32 S0, [R0]               @ store cx value in memory
    LDR R0, =print_cy
    BL result_out


    ///\ Calculate MAGNITUDE_C= sqrt[(cx)^2 + (cy)^2]  or sqrt[(ax+bx)^2 + (ay+by)^2]
    LDR R0, =cx
    VLDR.f32 S4, [R0]               @ fetch cx
    MOV R0, #2
    BL get_power                    @ calc cx^2 arg1=S4
    VMOV.f32 S1, S0                 @ move cx^2 in S1
    LDR R1, =cy
    VLDR.f32 S4, [R1]               @ fetch cy
    MOV R0, #2
    BL get_power                    @ calc cy^2 arg1=S4
    VMOV.f32 S2, S0                 @ move cy^2 in S1
    VADD.f32 S3, S1, S2             @ S3 = (cx^2) + (cy^2)
    VSQRT.f32 S0, S3                @ SQRT[S3 = (cx^2) + (cy^2)]
    LDR R0, =print_calc_magnitude
    BL result_out

    ///\ Calculate ARCtan (cy/cx)
    LDR R0, =cx
    VLDR.f32 S1, [R0]               @ fetch cx
    LDR R1, =cy
    VLDR.f32 S2, [R1]               @ fetch cy
    VDIV.f32 S0, S2, S1             @ S0 = Cy/Cx
    BL get_arctan
    LDR R0, =print_arctan
    BL result_out
    B restart

opt8:   ///\ Exit
    BL exit                         @ Branch to exit


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
    input_buffer:       .single 0.0             @ input buffer for scanf
    f_a_magnitude:      .single 0.0
    f_a_angle:          .single 0.0
    f_b_magnitude:      .single 0.0
    f_b_angle:          .single 0.0
    calc_result:        .single 0.0
    rad_convert_val:    .single 0.017453292     @ angle * rad_convert_val = radians
    angle_convert_val:  .single 57.2958         @ radian * angle_convert_val = angles
    test_value:         .single 1.0
    rad_a:              .single 0.0
    rad_b:              .single 0.0
    ax:                 .single 0.0
    ay:                 .single 0.0
    bx:                 .single 0.0
    by:                 .single 0.0
    cx:                 .single 0.0
    cy:                 .single 0.0
    temp_double: .double 0.0
    print_cosa:         .asciz "\ncos(a): %f"
    print_sina:         .asciz "sin(a): %f\n"
    print_cosb:         .asciz "cos(a): %f\n"
    print_sinb:         .asciz "cos(a): %f\n"
    print_ax:           .asciz "\nax: %f\n"
    print_ay:           .asciz "ay: %f\n"
    print_bx:           .asciz "bx: %f\n"
    print_by:           .asciz "by: %f\n"
    print_result:       .asciz "\n\nFinal result calcualtion:\n"
    print_cx:           .asciz "Cx: %f\n"
    print_cy:           .asciz "Cy: %f\n"
    print_calc_magnitude: .asciz "\nMAGANITUDE C = SQRT[S3 = (cx^2) + (cy^2)]: %f\n"
    print_arctan:         .asciz "Angle A = Arctan(cy/cx): %f"


.section .note.GNU-stack, "", %progbits          @ disable GNU stack warning
.end




    