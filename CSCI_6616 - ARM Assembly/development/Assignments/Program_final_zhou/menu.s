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
///\ Print values S0=MaxHeight; S1=MaxRange
    PUSH {R4-R12, LR}               @ Save register values
    @ SUB SP, SP, #8                  @ Ensure 8-byte stack alignment

    VCVT.f64.f32 D1, S0             @ Convert S0 (MaxHeight) to double in D1
    LDR R0, =double_buffer          @ Load double_buffer address
    VSTR.f64 D1, [R0]               @ Store D1 into double_buffer
    LDM R0, {R2, R3}                @ Load double_buffer into R2 and R3

    VCVT.f64.f32 D1, S1             @ Convert S1 (MaxRange) to double in D1
    LDR R0, =double_buffer          @ Load double_buffer address
    VSTR.f64 D1, [R0]               @ Store D1 into double_buffer
    LDM R0, {R4, R5}                @ Load double_buffer into R4 and R5

    PUSH {R4-R5}           @ Push MaxRange and MaxHeight onto the stack

    LDR R0, =value_str              @ Load the format string
    BL printf                       @ Call printf
    POP {R4-R5}
    @ ADD SP, SP, #16                 @ Clean up the stack (4 registers = 16 bytes)
    POP {R4-R12, LR}                @ Restore register values
    BX LR                           @ Return to caller

debug_print_result:
///\ print input S0 value
    PUSH {R0-R12, LR}
   
    VCVT.f64.f32 D1, S0             
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
   
    VCVT.f64.f32 D1, S0            
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
        .ascii "\n\nFinal Project - Jarvis 2025 Tactical Data Processor:\n"
        .byte 0  @ Null terminator to end the string
    value_str:          .asciz "\nMax Height: [ %f ]m\nMax Range:  [ %f ]m\n" 
    menu_str_prompt2:   .asciz "\nEnter launch angle degrees: "
	menu_str_prompt:    .asciz " > "
	menu_str_exit:		.asciz "\n[!] Application exit!\n\n"
    debug_str:          .asciz "\n[+] Debug float : %f\n"
    debug_calc_str:     .asciz "\n[+] Debug calculation: %f\n"
    menu_str_cont:      .asciz "\nContinue? (Y/N): "


.align 4
    double_buffer:      .double 0.0

.end

