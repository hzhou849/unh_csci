/*
 *Please write an assembly module that compute N! (N Factorial) recursively using the FPU.
Your assembly module must include the following;

1.  User input of N and the rendering of the result N! using the C standard library - 20 points.
2.  A recursive FPU function to calculate N! - 50 points
3. A main loop that allows for program continuation or termination. - 30 points.

Here is a mock up of the program input/output from initial start up.
Enter N> 2
2!=2
Continue (Y/N)> Y

Enter N> 3
3!=6
Continue (Y/N) > N

 
 *
  */
.section .text
.global main

.fpu neon-fp-armv8

main:
    //1 - Print initial prompt
    LDR R0, =prompt           
    BL printf
    LDR R0, =input_fmt_specifier
    LDR R1, =input_buffer
    PUSH {R1}
    BL scanf
    BL getchar
    POP {R1}
    VLDR.f32 S0, [R1]
    BL factoral

    LDR R0, =result
    VSTR.f32 S0, [R0]

    LDR R0, =input_buffer
    VLDR.f32 S1, [R0]
    VCVT.f64.f32 D1, S1
    LDM R0, {R2, R3}

    LDR R0, =result
    VLDR.f32 S0, [R0]
    VCVT.f64.f32 D1, S0
    VSTR.f64 D1, [R0]
    LDM R0, {R4, R5}
    PUSH {R4-R5}

    LDR R0, =result_str
    BL printf


continue:
    LDR R0, =menu_str_cont          
    BL printf                   

    //  Get intial velocity
    LDR R0, =menu_fmt_specifier    
    LDR R1, =menu_opt          
    PUSH {R1}                       
    BL scanf                       
    BL getchar                      
    POP {R1}                       
    LDRB R0, [R1]  
    CMP R0, #0x59                   @ 'Y'=0x59; 0x76 'N'=0x4E; 0x6E
    BEQ main                     @ If Y restart
    CMP R0, #0x79                   @ if 'y' restart
    BEQ main
    CMP R0, #0x4E                   @ if 'N' 
    BEQ exit
    CMP R0, #0x6E
    BEQ exit
    B continue                      @ else ask again 

    

///\ Calculate the value from input S0=N
factoral:
    PUSH {R4-R12, LR} 
    BL loop
    POP {R4-R12, LR}
    BX LR  
  loop:
    VMOV.f32 S1, S0
    VMOV R7, S1
    PUSH {R7, LR}
    VMOV.f32 S2, #1.0
    VSUB.f32 S0, S1, S2
    VCMP.f32 S0, #0.0 
    VMRS apsr_nzcv, FPSCR
    BLNE loop

    VCMP.f32 S0, #0.0
    VMRS apsr_nzcv, FPSCR
    BGT skip_increment
    VMOV.f32 S0, #1
  skip_increment:
    POP {R7, LR}
    VMOV.f32 S1, R7
    VMUL.f32 S2, S0, S1
    VMOV.f32 S0, S2
    BX LR
   

exit:
   
    MOV R0, #0                      @ Set the return code
    MOV R7, #1                      @ 1= Linux service exit
    SVC 0

.data
.word
    prompt:        .asciz   "\nEnter N> "
    menu_str_cont: .asciz "\nContinue? (Y/N)> "
    result_str: .asciz "%f ! =%.0f\n"
    input_fmt_specifier: .asciz "%f"
    menu_fmt_specifier: .asciz "%c"
 .align 4
    menu_opt:       .space 4,0
    input_buffer:   .single 0.0
    double_buffer:  .double 0.0
    result: .single 0.0


.section .note.GNU-stack, "", %progbits
.end

