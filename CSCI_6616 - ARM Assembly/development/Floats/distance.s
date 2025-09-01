@ *** FIXED professor's broken code
@ stand alone version of dist 
@ calcs dist between two points in x-y plane

.fpu neon-fp-armv8 @inform asm on fpu types
.global main
.text
main: 	ldr r0,=qx0 @point at querry string
	bl printf @print querry
	ldr r0,=de @point at input format
	ldr r1,=x0 @point at input to be collected
	bl scanf @get input
	ldr r1,=x0 @reload pointer scanf modifies
	vldr s1,[r1] @load s1 with input

 	ldr r0,=qx1 @repeat for x1
	bl printf
	ldr r0,=de
	ldr r1,=x1
	bl scanf
	ldr r1,=x1
	vldr s2,[r1]

	ldr r0,=qy0 @repeat for y0
	bl printf
	ldr r0,=de
	ldr r1,=y0
	bl scanf
	ldr r1,=y0
	vldr s3,[r1]

	ldr r0,=qy1 @repeat for y1
	bl printf
	ldr r0,=de
	ldr r1,=y1
	bl scanf
	ldr r1,=y1
	vldr s4,[r1]

	vsub.f32 s6,s1,s2 @x0-x1
	vmul.f32 s7,s6,s6 @delta x squared
	vsub.f32 s6,s3,s4 @y0-y1
	vmul.f32 s8,s6,s6 @delta y squared
	vadd.f32 s10,s7,s8 @add delta x and delta y
	vsqrt.f32 s12,s10 @square root
	
	vcvt.f64.f32 d14,s12 @convert to double
	ldr r0,=res @point at result double
	vstr d14,[r0] @store result
	
	ldm r0,{r2,r3} @load r2 and r3 with result
	ldr r0,=resFmt @point at result string
	bl printf @print the result note PRINTF needs doubles
	
	mov r0,#0 @exit
	mov r7,#1
	svc 0
.data
.align 4
    res: .double 0.0
    resFmt: .asciz "Distance: %f \r\n"
    de: .asciz "%f"
    qx0: .asciz "Enter X0> "
    qy0: .asciz "Enter Y0> "
    qx1: .asciz "Enter X1> "
    qy1: .asciz "Enter Y1> "

.align 4
    x0: .single 0.0
    y0: .single 0.0
    x1: .single 0.0
    y1: .single 0.0

.end

