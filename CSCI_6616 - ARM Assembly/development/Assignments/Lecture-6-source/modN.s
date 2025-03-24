@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ name: modN.s
@ description:  will compute mod N of a number by repeated subtractions until <=0
@ count of number of subs is N and remainder is value  prior to last sub
#
@ args
@ r0 contains number
@ r1 contains mod
@ returns
@ r0 remainder
@ r1 N
@
@ revision hstory
@ raa 2/6/21 origin
@ raa 2/26/25 added conditional execution
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

@ Professor's shit code, see /math_functions/modN.s for my version
.global modN
.text
modN:	mov r4,#0	@N starts at 0
cont:	sub r0,r1	@r0=r0-r1
		add r4,#1	@N=N+1
		cmp r0,#0	@compare to 0
		bgt cont	@if >0 continue
		cmp r0,#0  	@compare to 0 for even division
		beq done  	@no need to do anything else
		add r0,r1	@add back because < 0
		sub r4,#1	@roll N back
done:	mov r1,r4 	@pass back N 
		bx  lr		@return
.end


@optimized version using conditional execution
.global modN
.text
modN:	mov r4,#0	@N starts at 0
cont:	add r4,#1	@N=N+1
		subs r0,r1	@r0=r0-r1
		bgt cont	@if >0 continue
		addne r0,r1	@roll back <0
		subne r4,#1	@roll N back <0
		mov r1,r4 	@pass back N 
		bx  lr		@return
.end