/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Program 7 - Floating Point Angle/magnitude
    Name: Howard Zhou

    File: factoral

    @Description:  Used with Program seven to calculate factoral for taylor series
                    Recursive technique used to calculate factoral
                    N!= N*(N-1) * (N-2)...* 1

    @Registers
        @input args:
            S0: N value 

        @return:
            S0: The returned calculated value


    NOTES: 
        * V<operations> have no option flags so have to manually check and provide status updates
        * pushing S1 to stack crashes, requires arm require even number single-precision registes
          ie s0, s2, etc...Since S1 is an odd-numbered register, attempting to push it directly 
          with VPUSH causes undefined behavior, leading to a segmentation fault.
          this didint work
        * trying VMOV R0, S1 then push {R0}, this seems to be working


 
=============================================================================================
*/

.global factoral
.section .text

///\ Calculate the value from input S0=N
factoral:
    PUSH {R4-R12, LR}           @ Save Gen purpose regs values to stack
    BL loop
    POP {R4-R12, LR}
    BX LR                       @ return to calling function with result in S0

loop:
    VMOV.f32 S1, S0             @ copy value passed in by prev calculation input N
    VMOV R7, S1                 @ vStack is prone to memory mis-alignment, copy to GP reg for stabilityr
    PUSH {R7, LR}               @ save the LR for this iteration
    VMOV.f32 S2, #1.0
    VSUB.f32 S0, S1, S2         @ vsubtract N-1; vsub no imeediate value support
    VCMP.f32 S0, #0.0           @ we cant use vsubs so we have to manually compare
    VMRS apsr_nzcv, FPSCR       @ copy vfpu comparison flags to APSR so we can use program flow logic
    BLNE loop                   @ while S0 !=0, set LR point

    VCMP.f32 S0, #0.0           @ on each iteration check if this is base case
    VMRS apsr_nzcv, FPSCR       @ update status flag
    BGT skip_increment          @ if S0 !=0, skip next incrmeent step
    VMOV.f32 S0, #1             @ <skip if S0 greater 0> if =0 we are at the base case ie {3 x 2 x S0=1} iter=1
skip_increment:                 @ now we can unfold recursion
    POP {R7, LR}                @ restore the LR register
    VMOV.f32 S1, R7             @
    VMUL.f32 S2, S0, S1         @ S2 = N * (N-1)...
    VMOV.f32 S0, S2             @ copy the resulting product in s0 for next iteration
    BX LR                       @ jump to iteration S1+1 = 2





