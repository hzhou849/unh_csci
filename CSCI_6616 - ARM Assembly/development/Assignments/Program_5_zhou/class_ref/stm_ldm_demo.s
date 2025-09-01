@*****************************************************************
@ Name: stm_ldm_demo.s
@
@ Description:  Assembly module to demo multiple load and store
@ instructions
@
@ Revision History
@ RAA 2/19/21 Origin
@
@******************************************************************
.global main
.text
main:   ldr r0,=buf @pt at buffer space
	mov r1,#0xA
	mov r2,#0xB
	mov r3,#0xC
	mov r4,#0xD @4 regs with A to D
	stm r0,{r1-r4} @store to buf
	ldr r0,=buf @ reload ptr
	ldm r0!,{r5-r8} @ recover and post increment r0
	stm r0,{r5-r8} @r0 is now r0+16 bytes
	ldmda r0,{r5-r8} @ decrement after each xfer - reverse register contents
	nop
	mov r0,#0 @ exit
	mov r7,#1
	svc 0
.data
buf: .space 100
.end
