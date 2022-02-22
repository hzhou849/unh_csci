//*******************************************************************************************
// Project 1: Classic Division
// Name: Howard Zhou
// Date: 02/14/2022
// Course: ELEC 6602/3371 - Embedded Systems
//
// Description: Demonstrate division by successive subtraction on two bytes
//              and bonus - reversing bits in register
//********************************************************************************************

unsigned long int dvdNumtr = 61;
unsigned long int dsrDenom = 18;

void main() {
    asm {
        // Register Values
        // R0 = Input Buffer
        // R1 = dividend/numerator
        // R2 = divisor/denominator
        // R4 = Remainder
        // R5 = Quotient
        // R6 = Remainder (FLIPPED)
        // R7 = Temporary buffer for processing remainder
        // R8 = Counter

    _START:
        // Load the C variables into ASM Registers R0 and R1
        MOVW R0, #lo_addr(_dvdNumtr+0)
        MOVT R0, #hi_addr(_dvdNumtr+0)
        LDR R1, [R0]                        // Dividend

        MOVW R0, #lo_addr(_dsrDenom+0)
        MOVT R0, #hi_addr(_dsrDenom+0)
        LDR R2, [R0]                        // Divisor

        MOV R4, #0                  // Initialize Registers R4, R5 to 0
        MOV R5, #0
        CMP R2, R1                  // If R2(Divisor) is less than R1(Dividend)
        MOV R4, R1                  // Assign the remainder/dividend into R3
        BLE START_DIVIDE            // If R2(Divisor) is less than or equal to R1(Dividend), jumpt to START_DIVIDE          
        BGT END                     // If R2(Divisor) is greater than R1(Dividend), we do not need to perfrom any division.
    
    START_DIVIDE:                   
        SUB R4, R2                  // Subract the R4 Dividend/Remainder by the Divisor R2
        ADD R5, #1                  // Increment the R5 quotient by 1
        CMP R2, R4                  // Check if we need to repeat the subtraction process
        BLE START_DIVIDE            // Loop to repeat subtraction process if Divisor is less than Dividend
        CMP R4, #0                  // Else check if remainder is equal to zero
        BEQ END                     // If remainder is equal to zero, end the application
        MOV R7, R4                  // Load the Remainder value into our temp buffer R7 to be processed
        BNE REVERSE_REM             // If not zero, branch to reverse bits function

    REVERSE_REM:
        // We could use RBIT to flip the bits, but this is more fun to code.
        AND R0, R7, #0x0001        // Extract the LSbit and into temp buffer R0
        ORR R6, R0                 // OR R7 with the extracted bit held in R0
        LSL R6, #1                 // Shift R6 << 1 to have space for the next bit.
        LSR R7, #1                 // 'Pop' the extracted bit and setup the next bit to be extracted
        ADD R8, #1                 // Increment counter to keep track of how many bits are flipping.
        CMP R8, #31                // Adjust number number of bits to reverse 32bits = 0-31 cycles
        BEQ END
        BNE REVERSE_REM
    END:

    }

}