/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program 7- Vector calculation Floating point
	Name: Howard Zhou
 
	File: taylor.s
    
    Description:
        - Calculate sin(x) using taylor series:
        sin(x) =  E=(-1)^n * x^(2n+1) / (2n+1)!

        - Calculate cos(x)
        cos(x) =  E=(-1)^n * x^(2n) / (2n)! 

    Registers:
        @Local:
            R0: N
        @input: 
            S0: radian x value

        @return: S0 - the calculated value

* ==========================================================================================
*/   

.EQU NUM_ITERATIONS, 4             @ # of iterations to run taylor series (more for accuracy)

.global get_sin, get_cos
.section .text


get_sin:
    PUSH {R4-R12, LR}               @ Save caller() reg values & LR
    LDR R4, =input_radian
    VSTR.f32 S0, [R4]               @ save the input radian to memory
    VMOV.f32 S4, S0                 @ free up s0 for calculations

    ///\ sin(x) = tval1 - tval2 + tval3 - tval4
    // series1  tval1 = x(Radians)
    LDR R0, =tval1
    VSTR.f32 S4, [R0]               @ store x into tval1
    
    // series2 tval2 = x^3/3!
    MOV R0, #3                      @ set exponent n=3
    BL get_power                    @ get power, result in S0
    LDR R0, =temp1
    VSTR.f32 S0, [R0]               @ store x^3 into temp1
    VMOV.f32 S0, #3                 @ set the factorial arg =3
    BL factoral                     @ get 3!; result in S0
    LDR R0, =temp1
    VLDR.f32 S1, [R0]               @ fetch x^3 result from temp1 in memory
    VDIV.f32 S2, S1, S0                 @ s2 = x^3/3!
    LDR R0, =temp2
    VSTR.f32 S2, [R0]


    

get_power: // S0=base; R0=exponent(N)
    VMOV.f32 S0, #1                 @ initial multiplication is 1x base
    power_loop:
    CMP R0, #0                      @ while (N>0)
    BEQ power_done
    VMUL.f32 S0, S0, S4                 @ S0= S0 x S4 (ie 1x2=2, then 2x2=4, 4x2=8 etc...)
    SUBS R0, #1                     @ decrement R1 iterator -1
    B power_loop                    @ repeat
    power_done:
    BX LR

t_exit:
    POP { R4-R12, LR}               @ restore registers
    BX LR


    
    


.data
.align 4 @ align at 4byte(32bit) addressing
    temp1:        .single 0.0
    temp2:        .single 0.0
    tval1:        .single 0.0
    tval2:        .single 0.0
    tval3:        .single 0.0
    tval4:        .single 0.0
    input_radian:    .single 0.0
    curr_total: .single 0.0
.end

