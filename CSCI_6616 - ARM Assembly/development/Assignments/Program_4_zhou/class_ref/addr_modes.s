@*********************************************
@
@ Name: addr_modes.s
@ Illustrates register indirect, with offs,
@ post & pre incr addressing modes
@
@ Expected r1 sequence is 1,2,1,3
@
@ Rev
@ 1/30/22 RA Origin
@*********************************************
.global main
.text
main: 	mov r4,#4
	ldr r0,=words
	ldr r1,[r0] @register indirect
	ldr r1,[r0,r4] @register indirect with offset
	ldr r1,[r0],#4 @register indirect with post incr
	ldr r1,[r0,#4]!@register indirect with pre inc
	nop @no operation
	nop
	nop
words: .word 0x1,0x2,0x3,0x4,0x5

.end
