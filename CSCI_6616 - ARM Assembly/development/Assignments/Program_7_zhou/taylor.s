/* ==========================================================================================
	CSCI_6616 - ARM Assembly Programming
	Project: Program 7- Vector calculation Floating point
	Name: Howard Zhou
 
	File: taylor.s
    
    Description:
        - This version of the taylor series is broken up for easier computing over recursive ver
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

.EQU NUM_ITERATIONS, 4             @ # of iterations to run taylor series 0-index so +1(more for accuracy)

.global get_sin, get_cos
.section .text


get_sin:
    PUSH {R4-R12, LR}               @ Save caller() reg values & LR
    LDR R4, =input_radian
    VSTR.f32 S0, [R4]               @ save the input radian to memory
    VMOV.f32 S4, S0                 @ free up s0 for calculations

    ///\ series N0  = x(Radians)
    MOV R8, #0                      @ offset to write tval_list
    LDR R6, =tval_list              @ list to store results
    VSTR.f32 S4, [R6]               @ store n0 = x into tval_list, post increment+4 for next
    ADD R6, #4                      @ manual add becuase VSTR does not support post-inc
    
    ///\ series N1 to N3 = x^3/3! to x^7/3!
    MOV R7, #3                      @ start n1=3 of taylor series
    MOV R2, #1                      @ number of iterations
  t_loop:
    CMP R2,#NUM_ITERATIONS
    BEQ t_done                      @ we are finshed with this iteration
    MOV R0, R7                      @ set exponent n=3
    BL get_power                    @ get power, result in S0
    LDR R0, =temp1
    VSTR.f32 S0, [R0]               @ store x^3 into temp1
    VMOV.f32 S0, R7                 @ set the factorial arg =3
    VCVT.f32.S32 S0, S0             @ convert interger R7 into float
    BL factoral                     @ get 3!; result in S0
    LDR R0, =temp1
    VLDR.f32 S1, [R0]               @ fetch x^3 result from temp1 in memory
    VDIV.f32 S2, S1, S0             @ s2 = x^3/3!
    LDR R0, =temp2
    VSTR.f32 S2, [R0]
    ADDS R2, #1                     @ increment counter +1
    ADDS R7, #2                     @ increment n+2 for 3,5,7... 
    VSTR.f32 S2, [R6]    @ write result to tval_list +offset(+4)
    ADD R6, #4                      @ manually update R8 offset +4, since vstr cannot do post inc.
    B t_loop                        @ run another loop of taylor sin(x)n+1

    ///\ Calculate: sin(x) = tval1 - tval2 + tval3 - tval4
    t_done:
    LDR R6, =tval_list              @ reload values at 0 offset
    VLDR.f32 S1, [R6]               @ retrieve n0
    ADD R6, #4                      @ manual add +4 because vops does not support increment
    VLDR.f32 S2, [R6]               @ retrieve n1
    ADD R6, #4
    VLDR.f32 S3, [R6]               @ retrieve n2
    ADD R6, #4
    VLDR.f32 S4, [R6]               @ retrieve n3

    VSUB.f32 S0, S1, S2             @ s0 = val1-val2
    VADD.f32 S0, S0, S3             @ s0 = (val1-val2) +val3
    VSUB.f32 s0, s0, s4             @ s0 = [(val1-val2) +val3] -val4

    ///\ return S0 with result
    POP {R4-R12, LR}
    BX LR


get_power: // S0=base; R0=exponent(N)
    VMOV.f32 S0, #1                 @ initial multiplication is 1x base
    power_loop:
    CMP R0, #0                      @ while (N>0)
    BEQ power_done
    VMUL.f32 S0, S0, S4             @ S0= S0 x S4 (ie 1x2=2, then 2x2=4, 4x2=8 etc...)
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
    tval5:        .single 0.0
    tval_list:    .single 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
    input_radian:    .single 0.0
    curr_total: .single 0.0
.end

