/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou
 
	File: menu.s
 
 	Description:
		- Terminal manager that handles outputs to the teriminal
	
* ==========================================================================================
*/


@ Allow external calls
.global menu_print, menu_print_exit, debug_print_result
.section .text

menu_print: 
/// \print the menu string loaded into R0
/// \param[in] R0: address of string buffer to be printed

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


print_fire_output: 
    // placeholder to print output data later
    PUSH {R4-R12, LR}
    BX LR

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


menu_test_fire_print: 
/// \param[in] R0 - status; 0=okay; 1=bad data  
/// \param[in] R1 - Target num
/// \param[in] S0 - Azimuth
/// \param[in] S1 - Elevation
/// \param[in] S2 - Fire engagement time
    PUSH {R4-R12, LR}
    MOV R8, R0                          @ backup R0 for later
    MOV R9, R1                          @ backup R1 for later
    VMOV.f32 S8, S0
    VMOV.f32 S9, S1
    VMOV.f32 S10, S2
    
    // R1 already is load arg1 target

    // Load S0 Azimuth for write 
    VCVT.f64.f32 d0, s8                 @ Printf requires floats to be doubles
    LDR R0, =double_buffer              @ temp double buffer to hold for conversion
    VSTR.f64 D0, [R0]                   @ write double to memory
    LDM R0, {R2, R3}                    @ load double spread into 2x32bit regs 4 &5

    // Load S1 Eleveation
    VCVT.f64.f32 d1, s9
    VSTR.f64 D1, [R0]
    LDM R0, {R4, R5}

    // Load S1 Eleveation
    VCVT.f64.f32 d2, s10
    VSTR.f64 D2, [R0]
    LDM R0, {R6, R7}
    PUSH {R6, R7}                       @ stack if LIFO PUSH  arg5 first
    PUSH {R4, R5}                       @ push arg4 (this is read first bc it is top)
    LDR R0, =str_fire
    bl printf

    @ POP {R6,R7}                         @ remove arg 5 from stack
    @ POP {R4,R5}                         @ remove arg 4 from stack 
    ADD SP, SP, #16                  @ Alternatively add 4*4bytes R4-R7 pushed into stack to delete 

    MOV R0, R8                          @ Restore R0 and R1 registers
    MOV R1, R9
    POP {R4-R12, LR}
    BX LR


 // Debug test print  if working
debug_print_fire_record:
/// \param[in] R0: string of fire record
    PUSH {R0-R12,  LR}
    MOV R1, R0                      @ copy the address of str_encoded %x
    MOV R2, R0                      @ copy the address again for %s output
    LDR R0, =test_print_fire_record @ 
    BL printf

    POP {R0-R12, LR}
    BX LR

.data
.word @ 32 bit align all variables
	menu_str_main_menu: 	
        .ascii "\n\nFinal Project - Jarvis 2025 Tactical Data Processor:\n"
        .ascii "\n 1) execute\n 2) display fire output buffer\n 3) Send(Pop) next fire record\n"
        .ascii " 5) exit\n"
        .byte 0  @ Null terminator to end the string
	menu_str_prompt:    .asciz " > "
	menu_str_exit:		.asciz "\n[!] Application exited successfully!\n\n"
    debug_str:          .asciz "\n[+] Debug float : %f\n"
    debug_calc_str:     .asciz "\n[+] Debug calculation: %f\n"
    test_print: .asciz "Target: %d; Track: %d; Range: %d; Azimuth: %f; Elevation %f\n"
    str_fire:           .asciz "{TARGET#: %d}{AZIMUTH: %.2f}{ELEVATION: %.2f}{FIRE @ %f}\n"
    test_print_fire_record: .asciz "Queue address: 0x%x; %s\n\n"



.align 4
    double_buffer:      .double 0.0

.end

