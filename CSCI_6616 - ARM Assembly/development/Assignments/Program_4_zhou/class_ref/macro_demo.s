@************************************************
@Name: macro_demo.s
@Purpose: to illustrate the composition and use
@of a macro in assembly
@
@************************************************
.global main @expose entry

@define macro with name and params
.MACRO testBranch cc,reg,b2
	cmp \reg, #0 		@macro body element inserts reg param
	b \cc \b2 			@macro body element inserts cc & b2 param
.ENDM

@entry
main:	mov r0,#0

testBranch ne,r0,cont 	@macro invoked with params
@ simulates cmp r0,#0
@ bne cont

testBranch eq,r0,cont 	@macro invoked with params
@cmp r0,#0
@beq cont

cont: 	mov r0,#0 		@call exit service
 	mov r7,#1
	svc 0

.end
