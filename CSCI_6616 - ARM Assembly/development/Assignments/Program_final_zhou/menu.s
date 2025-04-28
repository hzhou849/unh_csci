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


 @ @ // FOr printf 
    @ @ // ** after R3 arg, you need to push to stack in order to print
    @ @ // Note print from stack is LIFO so you need to reverse azimuth and elevation
    @ MOV R1, R4                          @ load arg1
    @ MOV R2, R5                          @ load arg2
    @ MOV R3, R6                          @ load arg3
    @ VCVT.f64.f32 d0, s1                 @ Printf requires floats to be doubles
    @ LDR R0, =double_buffer2             @ temp double buffer to hold for conversion
    @ VSTR.f64 D0, [R0]                   @ write double to memory
    @ LDM R0, {R4, R5}                    @ load double spread into 2x32bit regs 4 &5

    @ VCVT.f64.f32 d1, s2
    @ VSTR.f64 D1, [R0]
    @ LDM R0, {R6, R7}
    @ PUSH {R6, R7}                       @ stack if LIFO PUSH  arg5 first
    @ PUSH {R4, R5}                       @ push arg4 (this is read first bc it is top)
    @ LDR R0, =test_print
    @ bl printf

    @ //  MEthod 1
    @ ADD SP, #16                         @ delete 2x(8bytes 64bit) pushed into stack
    @ // method 2
    @ @ POP {R6, R7}                        @ remove arg 5 from stack
    @ @ POP {R4,R5}                         @ remove arg 4 from stack 


.data
.word @ 32 bit align all variables
	menu_str_main_menu: 	
        .ascii "\n\nFinal Project - Jarvis 2025 Tactical Data Processor:\n"
        .ascii "\n1) execute\n"
        .ascii "5) exit\n"
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

