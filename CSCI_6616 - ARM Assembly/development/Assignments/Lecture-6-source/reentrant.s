@***********************************************************************
@ Name: reentrant.s
@
@ Description:  This module demonstrates a reentrant function use in
@ assembly.  The module implements the Fibonacci Series or the following
@ sequence: 0,1,1,2,3,5,8 or x[n-2]+n[n-1] with base case of x[0]=0
@ x[1]=1
@
@ Revision History
@
@ RAA 2/23/22 Origin
@
@***********************************************************************
.global main
main:	
	mov r4,#0		@counter for number in series we are calculating
	ldr r5,=buf 	@output buffer

cont:	
	mov r0,r4 		@r0 is the register fib works on
	bl fib 			@ call fib
	strb r0,[r5],#1 @store result
	adds r4,#1 		@next number
	cmp r4,#10 		@all 10 complete?
	bne cont
	nop
	nop
	mov r0,#0 		@exit service
	mov r7,#1
	svc 0
@************************************************************************
@ Name: fib
@
@ Description: Calc the Fibonacci Series x[n-2]+x[n-1] with base cases
@ x[0]=0 & x[1]=1
@
@ Revision History
@ RAA 2/23/22 Origin
@
@************************************************************************
fib:  
	push {r4,r5,lr} @ must store lr and all registers being used
    cmp r0,#0 		@ base case 0 return 0
    beq done
    cmp r0,#1 @ base case 1 return 1
    beq done
    mov r4,r0 @save r0 to r4
    sub r0,#1 @n-1
    bl fib @call function again
    mov r5,r0 @save result 1
    mov r0,r4 @restor ro orignal value
    sub r0,#2 @n-2
    bl fib @call function again
    add r0,r5 @add x[n-1]+x[n-2]
done: 
	pop {r4,r5,lr} @restor register
    bx lr @return

.data 	  
	buf: .space 100 @space to hold series in bytes
.end
	
	
