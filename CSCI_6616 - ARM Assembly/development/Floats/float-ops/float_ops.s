/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Floating point number test builds
    Name: Howard Zhou

    File: float_ops.s

    Description:
        - Demonstrate vFPU floating point operations
        - Loading
        - Subtract, addition, multiplication, sqrt, 


        @ Write syscalls
        R0 - 0=stdin; 1=stdout; 3=stderr
        R2 - stores length of string
        R7 - linux service 3=read; 4=write

 * ========================================================================================== 
 */
.section .text
.global main

.fpu neon-fp-armv8                 @ required to let assembler know to use FPU


main:
    /// 1. Load floats variable address into Registers to work with
    LDR R0, =f1         @ pointer to f1 single precision FP number f1=0.123
    LDR R2, =f2         @ f2= -0.125
    LDR R3, =f4         @ f4 = 0.001
    LDR R4, =f5         @ f5 = -0.001

    /// 2. R0-R4 hold the address to the floats, we need to transfer them  
    //   to S_reg(float) for processing; 'v' tag=instruction for vfpu
    VLDR.F32 S0, [R0]   @ Load f1 into S0; 0.123
    VLDR.F32 S1, [R0]   @ Load f1 into S1; 0.123
    VLDR.F32 S3, [R2]   @ Load f2 into S3; -0.125
    VLDR.F32 S4, [R3]   @ Load f4 into S4; 0.001
    VLDR.F32 S5, [R4]   @ Load f5 into S5; -0.001

    /// Now we can perform operations using the vfpu

    ///\ Subtract:
    VSUB.F32 S2, S0, S1     @ Subtract: S2=S0,S1; (0.123-0.123) = 0
    
    ///\ Square root:
    VSQRT.F32 S2, S0        @ S2 = Sqrt(S0); s0=0.123

    ///\ Divide: 
    VDIV.F32 S2, S0, S1     @ S2 = S0/ S1 (0.123/0.123)
    LDR R5, =f6             @ Load f6= 1.0 into R5
    LDR R6, =f7             @ Load f7= 0.25 int R6
    
    VPUSH {S0, S1}          @ save S0, S1 
    VLDR.F32 S0, [R5]       @ load f6(1.0) into S0
    VLDR.F32 S1, [R6]       @ load f7(0.25) into S1
    VDIV.F32 S2, S0, S1     @ Divide 1.0/0.25 = 4

    VPOP {S0, S1}           @ restore S0, S1

    ///\ Multiply:
    VMUL.F32 S2, S0, S1     @ S2 = S0 * S1

    ///\ Compare:
    /// vfpu status register does not sync with CPSR status, 
    /// In order for normal program flow to work, you need to manually
    /// copy over the status using VMRS then  you can use
    /// standard program flow commands ie cmp, branch etc...

    VCMP.f32 S2, S4         @ S2-S4 updates the fpscr Vfpu status register
    VMRS apsr_nzvc, fpscr   @ COPY the vfpu status register to the CPSR status register
    BGT delta               @ this will now work after CPSR is updated with vfpu status

    ///\ Store float to memory:
    LDR R2, =buf            @ load address of 'buf' variable to R2
    VSTR.f32 S2, [R2]       @ copy the float S2 value into buf for storage.


    ///\ Convert single to double:
    VCVT.f64.f32 D1, S2     


    @storing a double to the location r2 points at
@ note again general purpose registers are used to move data
@a double is 64 bits so we need two words (32 bit)

	vstr.f64 d1,[r2] @this would load the 32 bit location r2 points at and r2+1 with the double
	nop
	nop

@double is 64 bits...ldm recovers 64 bit double from local r4 points at 
@we need two 32 bit registers to hold!

	mov r4,r2
	ldm r4,{r2,r3}

@printf needs string pointer in r0
@printf prints doubles and so 1st double is in r2,r3 more on stack!

	ldr r0,=NE0
	bl printf
	nop
	nop

@since vextor operations are depricated for the FPU below simply illustrates register loading

@1st lets load all of the single prec registers
@bank 1	
	ldr r0,=flist
	vldr s0,[r0] 
	vldr s1,[r0,#4]
	vldr s2,[r0,#8]
	vldr s3,[r0,#12]
	vldr s4,[r0,#16]
	vldr s5,[r0,#20]
	vldr s6,[r0,#24]
	vldr s7,[r0,#28]
@bank 2
	vldr s8,[r0]
	vldr s9,[r0,#4]
	vldr s10,[r0,#8]
	vldr s11,[r0,#12]
	vldr s12,[r0,#16]
	vldr s13,[r0,#20]
	vldr s14,[r0,#24]
	vldr s15,[r0,#28]

@bank 3
	vldr s16,[r0]
	vldr s17,[r0,#4]
	vldr s18,[r0,#8]
	vldr s19,[r0,#12]
	vldr s20,[r0,#16]
	vldr s21,[r0,#20]
	vldr s22,[r0,#24]
	vldr s23,[r0,#28]
@bank 4
	vldr s24,[r0]
	vldr s25,[r0,#4]
	vldr s26,[r0,#8]
	vldr s27,[r0,#12]
	vldr s28,[r0,#16]
	vldr s29,[r0,#20]
	vldr s30,[r0,#24]
	vldr s31,[r0,#28]
nop

@function call
	vpush {s0,s1,s2,s3,s4,s5}
	bl dist
	vmov s1,s0

    



    

exit:
    MOV R0, #0                      @ Set the return code
    MOV R7, #1                      @ 1= Linux service code exit
    SVC 0

// ================================================================================================
.section .data
.align 4 @ align by 32bits(bytes)

f1: .single 0.123       @ float would work here as well
f2: .single -0.125
f3: .single 0.0
f4: .single 0.001
f5: .single -0.001
f6: .single 1.0
f7: .single 0.25

@ array of sigles
flist: .single 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, .475, .5, -1, 3.0e-8

@ string format with format specifier to print floats
NE0: .asciz "Float: %f\n"

// You can use scientific notation here too
@ f1:             .single 3.0e8
@ double_val1:    .double 3.0e8
.align 4
buf: .fill 32

.section .note.GNU-stack, "", %progbits
.end


