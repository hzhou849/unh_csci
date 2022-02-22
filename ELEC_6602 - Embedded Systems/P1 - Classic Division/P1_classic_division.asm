_main:
;P1_classic_division.c,14 :: 		void main() {
;P1_classic_division.c,26 :: 		_START:
_START:
;P1_classic_division.c,28 :: 		MOVW R0, #lo_addr(_dvdNumtr+0)
MOVW	R0, #lo_addr(_dvdNumtr+0)
;P1_classic_division.c,29 :: 		MOVT R0, #hi_addr(_dvdNumtr+0)
MOVT	R0, #hi_addr(_dvdNumtr+0)
;P1_classic_division.c,30 :: 		LDR R1, [R0]                        // Dividend
LDR	R1, [R0, #0]
;P1_classic_division.c,32 :: 		MOVW R0, #lo_addr(_dsrDenom+0)
MOVW	R0, #lo_addr(_dsrDenom+0)
;P1_classic_division.c,33 :: 		MOVT R0, #hi_addr(_dsrDenom+0)
MOVT	R0, #hi_addr(_dsrDenom+0)
;P1_classic_division.c,34 :: 		LDR R2, [R0]                        // Divisor
LDR	R2, [R0, #0]
;P1_classic_division.c,36 :: 		MOV R4, #0                  // Initialize Registers R4, R5 to 0
MOV	R4, #0
;P1_classic_division.c,37 :: 		MOV R5, #0
MOV	R5, #0
;P1_classic_division.c,38 :: 		CMP R2, R1                  // If R2(Divisor) is less than R1(Dividend)
CMP	R2, R1
;P1_classic_division.c,39 :: 		MOV R4, R1                  // Assign the remainder/dividend into R3
MOV	R4, R1
;P1_classic_division.c,40 :: 		BLE START_DIVIDE            // If R2(Divisor) is less than or equal to R1(Dividend), jumpt to START_DIVIDE
BLE	START_DIVIDE
;P1_classic_division.c,41 :: 		BGT END                     // If R2(Divisor) is greater than R1(Dividend), we do not need to perfrom any division.
BGT	END
;P1_classic_division.c,43 :: 		START_DIVIDE:
START_DIVIDE:
;P1_classic_division.c,44 :: 		SUB R4, R2                  // Subract the R4 Dividend/Remainder by the Divisor R2
SUB	R4, R4, R2, LSL #0
;P1_classic_division.c,45 :: 		ADD R5, #1                  // Increment the R5 quotient by 1
ADD	R5, R5, #1
;P1_classic_division.c,46 :: 		CMP R2, R4                  // Check if we need to repeat the subtraction process
CMP	R2, R4
;P1_classic_division.c,47 :: 		BLE START_DIVIDE            // Loop to repeat subtraction process if Divisor is less than Dividend
BLE	START_DIVIDE
;P1_classic_division.c,48 :: 		CMP R4, #0                  // Else check if remainder is equal to zero
CMP	R4, #0
;P1_classic_division.c,49 :: 		BEQ END                     // If remainder is equal to zero, end the application
BEQ	END
;P1_classic_division.c,50 :: 		MOV R7, R4                  // Load the Remainder value into our temp buffer R7 to be processed
MOV	R7, R4
;P1_classic_division.c,51 :: 		BNE REVERSE_REM             // If not zero, branch to reverse bits function
BNE	REVERSE_REM
;P1_classic_division.c,53 :: 		REVERSE_REM:
REVERSE_REM:
;P1_classic_division.c,55 :: 		AND R0, R7, #0x0001        // Extract the LSbit and into temp buffer R0
AND	R0, R7, #1
;P1_classic_division.c,56 :: 		ORR R6, R0                 // OR R7 with the extracted bit held in R0
ORR	R6, R6, R0, LSL #0
;P1_classic_division.c,57 :: 		LSL R6, #1                 // Shift R6 << 1 to have space for the next bit.
LSL	R6, R6, #1
;P1_classic_division.c,58 :: 		LSR R7, #1                 // 'Pop' the extracted bit and setup the next bit to be extracted
LSR	R7, R7, #1
;P1_classic_division.c,59 :: 		ADD R8, #1                 // Increment counter to keep track of how many bits are flipping.
ADD	R8, R8, #1
;P1_classic_division.c,60 :: 		CMP R8, #31                // Adjust number number of bits to reverse 32bits = 0-31 cycles
CMP	R8, #31
;P1_classic_division.c,61 :: 		BEQ END
BEQ	END
;P1_classic_division.c,62 :: 		BNE REVERSE_REM
BNE	REVERSE_REM
;P1_classic_division.c,63 :: 		END:
END:
;P1_classic_division.c,67 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
