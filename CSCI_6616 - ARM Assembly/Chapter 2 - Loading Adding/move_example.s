/*
 * 2.1 MOV examples
 *
 *
 */

 .global _start				@ Provide program starting address

 @ Load R2 with 0x4F5D6E3A first using MOOVE and MOVT
 _start: 
	MOV R2, #0x6E3A 		@ Load LSB bits into R2
	MOVT R2, #0x4F5D		@ Load MSB into R2
	MOV R1, R2				@ Move R2 in R1

	@ Now lets see all the shifts version so of MOV
	MOV R1, R2, LSL #1		@ Logical shift left
	MOV R1, R2, LSR #1		@ Logcial shift right
	MOV R1, R2, ASR #1		@ Arithmetic shift right
	MOV R1, R2, ROR #1		@ Rotate Right
	MOV R1, R2, RRX			@ Rotate extended Right

	@ Repeat the above shifts using ASM mnemonics
	LSL R1, R2, #1			@ Logical Shift left
	LSR R1, R2, #1			@ Logical shift right
	ASR R1, R2, #1			@ Arithmetic shift right
	ROR R1, R2, #1			@ Rotate right
	RRX R1, R2				@ Rotate extended right

	@ Example that works with 8 bit immediate and shift
	MOV R1, #0xAB000000		@ Too big for #imm16 - need to test

	@ Example that can't be represented and results in error
	@ Uncomment to see error message
	@@ MOV R1, #0xABCDEF11 	@ Too big for #imm16 fits 2 bytes only???

	@ Example of MVN - Move and perform NOT operation
	MVN R1, #45				@ 0x45 = 0100 0101; ~0x45=1011 1010(0xBA)?? Confirm

	@ Example of MOV that the Assembler will change to MVN
	MOV R1, #0xFFFFFFFE    @ (-2) ???

	@ Set up the parameters to exit the program and then call Linux to do it.
	MOV R0, #0				@ Use 0 return code
	MOV R7, #1				@ R7 takes the cmd byte for sys-calls Service command code 1
	@ Call interrupt to Linux terminate by executing software interrupt 0
	@ This sends the control to interrupt handler in the linux kernel,
	@ which interprets params we've set in the various registers and does
	@ the actual work. 
	SVC 0					

/*


ARM instructions Executes on one clock cycle


objdump -s -d move_example

move_example:     file format elf32-littlearm

Contents of section .text:
 10054 3a2e06e3 5d2f44e3 0210a0e1 8210a0e1  :...]/D.........
 10064 a210a0e1 c210a0e1 e210a0e1 6210a0e1  ............b...
 10074 8210a0e1 a210a0e1 c210a0e1 e210a0e1  ................
 10084 6210a0e1 ab14a0e3 2d10e0e3 0110e0e3  b.......-.......
 10094 0000a0e3 0170a0e3 000000ef           .....p......    
Contents of section .ARM.attributes:
 0000 41130000 00616561 62690001 09000000  A....aeabi......
 0010 06080801                             ....            

00010054 <_start>:
   10054:       e3062e3a        movw    r2, #28218      @ 0x6e3a
   10058:       e3442f5d        movt    r2, #20317      @ 0x4f5d
   1005c:       e1a01002        mov     r1, r2
   10060:       e1a01082        lsl     r1, r2, #1
   10064:       e1a010a2        lsr     r1, r2, #1
   10068:       e1a010c2        asr     r1, r2, #1
   1006c:       e1a010e2        ror     r1, r2, #1
   10070:       e1a01062        rrx     r1, r2
   10074:       e1a01082        lsl     r1, r2, #1
   10078:       e1a010a2        lsr     r1, r2, #1
   1007c:       e1a010c2        asr     r1, r2, #1
   10080:       e1a010e2        ror     r1, r2, #1
   10084:       e1a01062        rrx     r1, r2
   10088:       e3a014ab        mov     r1, #-1426063360        @ 0xab000000
   1008c:       e3e0102d        mvn     r1, #45 @ 0x2d
   10090:       e3e01001        mvn     r1, #1
   10094:       e3a00000        mov     r0, #0
   10098:       e3a07001        mov     r7, #1
   1009c:       ef000000        svc     0x00000000


*/
