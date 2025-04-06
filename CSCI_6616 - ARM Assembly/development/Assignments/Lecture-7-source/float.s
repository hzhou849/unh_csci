@***********************************************************************************
@ Name:  float.s
@ 
@ Description:  Program to illustrate FP number encoding
@ and FP operations
@
@ Revision History
@ 2/12/21 RAA Origin
@ 3/5/22 RAA expanded to show FP ops
@ 3/9/22 RAA added delta check example
@ 4/3/23 RAA updated to correct comment errors & mark vector fpu ops depricated
@************************************************************************************
.global main

.fpu neon-fp-armv8 @needed to tell assembler we have a FP available!

@ below illustrates the need to use the Integer or General Purpose Registers to
@ load the floating point registers
@ note standard label loading into r1-r4

main: 	ldr r0,=f1 @pointer at a single precision FP number
     	ldr r2,=f2 @point at zero

	ldr r3,=f4
	ldr r4,=f5
     
@load loads the single precision registers with data...
@ note dereferencing r0-r4

@the 'v' tags the instruction for the vfpu
@note f32 indicates Single Precision 
     
      	vldr.f32 s3,[r2]
      	vldr.f32 s0,[r0] @1.5 to s0
      	vldr.f32 s1,[r0] @1.5 to S1
	vldr.f32 s4,[r3]
	vldr.f32 s5,[r4]

@subtract s2=s0-s1
@ note all instructions tagged with v are for the vfpu

@	vsub.f32 s2,s0,s1 @fp add sp float

@here is a  squareroot

@	vsqrt.f32 s2,s0

@here is a divide!
@	vdiv.f32 s2,s0,s1

@here is a mult
	vmul.f32 s2,s0,s1

@compare to 0 as a single precision float
@you should never do this for real...need to compare to see if in interval

@      	vcmp.f32 s3,s2
@	vmrs apsr_nzvc,fpscr
@	beq delta

@this is the way to test for a value - -delta<=x<=delta
@
@	s2-s4 gt positive delta

	vcmp.f32 s2,s4

@results in fpscr needs to be moved to the cpsr	 to control program flow

      	vmrs apsr_nzvc,fpscr

@conditional branch

	bgt delta

@here is s2-s5 or negative delta

	vcmp.f32 s2,s5
	vmrs apsr_nzvc,fpscr

@conditional branch

	blt delta
     
      	nop
delta:	nop

@store note that we again use the general purpose registers to point to where to move the data
      
zero: 	ldr r2,=buf

@vstr counter part to str we have seen

	vstr.f32 s2,[r2] @moves s2 to the memory location r2 points at

@ here we are converting to a double s2 to a double in d1

	vcvt.f64.f32 d1,s2

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
	
@exit
	mov r0,#0
	mov r7,#1
	svc 0 


@data section...alignment needs to be on word boundries!
.data

.align 4 @ Aligns by 32bit(4bytes)
f1: .single 0.123 @.float would work here as well
f2: .single -0.0125
f3: .single 0.0
f4: .single 0.001
f5: .single -0.001

@a buffer of singles
flist: .single 1.0, 2.0, 1.0, 2.0, 1.0, 2.0, .475, .5, -1, 3.0e-8

@note %f specifier for float

NE0:.asciz "FLOAT: %f\r\n"

.align 4
buf: .fill 32

.end
