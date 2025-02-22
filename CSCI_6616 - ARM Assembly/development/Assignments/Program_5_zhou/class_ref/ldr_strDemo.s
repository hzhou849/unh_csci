@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Name:  ldr_strDemo.s
@ Description:  Illustrate addressing offset and indexing modes
@
@ Revision History
@ RAA 1/30/21 Origin
@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
.global main  @entry point
.global memArray  @test array area
.text @code follows
main:   
	mov r0,#10 			@r0 contains 10 initial data
	mov r2,#4 			@r2 contains 4 index
	ldr r1,=memArray 	@r1 ptr to start of mem
	str r0,[r1] 		@ immediate r0 to memArray @10 into mem
	mov r0,#12 			@r0 contains 12
	str r0,[r1,r2,lsl#2] @immediate index store to r1+r2*4 no update of r1
	mov r0,#0 			 @r0=0
	ldr r0,[r1] 		 @immediate index get contents of r1 should be 10
	ldr r0,[r1,r2,lsl#2] @immediate index  should be 12 r1+r2*4
	mov r0,#11 			 @r0=11
	str r0,[r1],r2,lsl#2 @post index r1+r2*4 should equal 11 now
	mov r0,#14 			 @r0=14
	str r0,[r1,r2,lsl#2]! @preindex r1+r2*4=14 BUT r1 is also updated to r1=r1+r2*4 NOTE .word aligns on  16 bit boudries!
	mov r0,#0 @exit service
	mov r7,#1
	svc 0
.data @data follows
.word @align on  even boundries
memArray: .space  8192 @8k empty array
.end