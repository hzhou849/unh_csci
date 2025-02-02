/* 
 * Example of ADD/ADC/ADS
 * 
 * Usage: ADD{S} Rd, Rs, Operand2
 * Rd = Reg. Destination
 * Rs = Reg. source
 * Operand2 = number to add to register
 * ex. ADD R1, #2 == ADD R1, R1, #2 ==> Add 2 to register R1
 */
.arch armv6
 .global _start					@ Provide starting address

/* Find -2 using two's complement */
_start:
	MVN R0, #2					@ Assign R0 to value 2 and apply NOT 0000 0010 to 1111 1101
	ADD R0, #0x001					@ Add 1 for two's complement 1111 1101 + 1 = 1111 1110
	MOV R1, #3

	@ Simple loop - Z flag is set to 0 which processor takes as "true"
	MOV R1, #1					@ assign R1 to value 1
		@ B _start				@ Branch to _start (restarts function)
	
	@ Compare subtracts
	CMP R4, #45					@ if 45-R4 = 0, z flag set and allow BEQ is true
	BEQ _start

	@ For








	@ Apply program exit protocol
	@ R0 is used  as return exit code for user to read with echo $? in terminal
	MOV R7, #1					@ Service command code 1
	svc 0						@ Call linux terminate

