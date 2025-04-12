/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program P8 - Projectile Kinematics Max height/range
	Name: Howard Zhou
 
	File: menu.s
 
 	Description:
		- Prints the menu to terminal
	
	Sample: 
	Projectile Kinematics Computation App:

    1) Enter Initial Velocity in m/s: 10.5
    2) Enter Launch Angle in degrees: 45
    Max Height: 2.81m
    Max Range: 11.247m
    
    Continue?(Y/N):N
    Enter choice > 1
    Enter value > 7
* ==========================================================================================
*/



@ Allow external calls
.global menu_print, menu_print_exit, debug_print_result
.section .text

menu_print: 
///\ print the menu string loaded into R0
	PUSH {R4-R12, LR}				@ Save caller() reg values &LR
	BL printf						@ call cstd printf for stdout
	LDR R0, =menu_str_prompt		@ load the prompt string
	BL printf

	POP {R4-R12, LR}				@ Restore caller() reg values
	BX LR							@ return to caller()

menu_print_exit: 
///\ print the menu exit msg
	PUSH {LR}						@ Save LR; printf will overwrite LR
	LDR R0, =menu_str_exit			@ load exit message
	BL printf
	POP {LR}						@ restore LR
	BX LR							@ return to caller()

menu_print_values: 
///\ Print values R0=CHAR; S0=Magnitude; S1=Angle
    PUSH {R4-R12, LR}               @ save register values
    MOV R1, R0                      @ load Char byte into R1

    VCVT.f64.f32 D1, S0             @ convert S0(magnitude) to a double in D1
    LDR R0, =double_buffer          @ load double variable into R0
    VSTR.f64 D1, [r0]               @ Write D1 into double_buffer variable
    LDM R0, {R2, R3}                @ Load R0(double_buffer) across R2 and R3 (32+32bit)

     // Value 2 - Angle
    VCVT.f64.f32 D1, S1             @ repeat for angle value
    LDR R0, =double_buffer
    VSTR.f64 D1, [R0] 
    LDM R0, {R6, R7}
    PUSH {R6, R7}                   @ additional values need to pushed to the stack to print

    LDR R0, =value_str              @ Load the print string
    BL printf                       @ now we can finally print
    POP {R6, R7}                    @ clear from the stack to prevent crashing
    POP {R4-R12, LR}
    BX LR                           @ return to calling function

debug_print_result:
///\ print input S0 value
    PUSH {R0-R12, LR}
   
    VCVT.f64.f32 D1, S0             @ repeat for angle value
    LDR R0, =double_buffer
    VSTR.f64 D1, [R0] 
    LDM R0, {R2, R3}

    LDR R0, =debug_str              @ Load the print string
    BL printf                       @ now we can finally print
    POP {R0-R12, LR}
    BX LR                           @ return to calling function

debug_print_calc:
///\ print input S0 value
    PUSH {R0-R12, LR}
   
    VCVT.f64.f32 D1, S0             @ repeat for angle value
    LDR R0, =double_buffer
    VSTR.f64 D1, [R0] 
    LDM R0, {R2, R3}

    LDR R0, =debug_calc_str          @ Load the print string
    BL printf                        @ now we can finally print
    POP {R0-R12, LR}
    BX LR                            @ return to calling function


.data
.word @ 32 bit align all variables
	menu_str_prompt1: 	
        .ascii "\n\nProjectile Kinematics Computation App:\n"
        .ascii "\nEnter Initial Velocity m/s: "
        .byte 0  @ Null terminator to end the string
    menu_str_prompt2:   .asciz "\nEnter launch angle degrees: "
	menu_str_prompt:    .asciz " > "
	menu_str_exit:		.asciz "\n[!] Application exit!\n"
    value_str:          .asciz "[+] Input values: (%c) =  Magnitude[ %f ]; Angle[ %f]\n" 
    debug_str:          .asciz "\n[+] Debug float : %f\n"
    debug_calc_str:     .asciz "\n[+] Debug calculation: %f\n"

.align 4
    double_buffer:      .double 0.0

.end

