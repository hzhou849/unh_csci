//*******************************************************************************************
// Project Extra Credit: Branching Study Extra Credit
// Name: Howard Zhou
// Date: 02/21/2022
// Course: ELEC 6602/3371 - Embedded Systems
//
// Description: Branch study extra credit, demonstrate the different types of conditional branching in ASM
//                BMI, BEQ, BCS, BGT, BHI
//********************************************************************************************


void main() 
{
    asm {
        //=============================================================
        // BMI - Branch Minus
        BMI_EX1:  
            MOV R0, #1
            MOV R1, #3
            CMP R0, R1
            BMI BMI_EX1 // BRANCHES R1-R0 = 1-3 = -2; N=1 Negative TRUE

        BMI_EX2:
            MOV R0, #15
            MOV R1, #13
            CMP R0, R1
            BMI BMI_EX2 // R0-R1 = 15-13 = 2; N=0 Positive - FALSE

        //=============================================================
        // BEQ - Branch Equal 
        BEQ_EX1:
            MOV R0, #1
            MOV R1, #1
            CMP R0, R1
            BEQ BEQ_EX1   //  BRANCHES R0-R1 = 0; Z = 1 Both numbers are equal TRUE
        BEQ_EX2:
            MOV R0, #29
            MOV R1, #30
            CMP R0, R1     // R0-R1 = -1; Z = 0, Numbers are not the same FALSE
            BEQ BEQ_EX2

        //=============================================================    
        // BCS - Branch Carry is Set
        BCS_EX1: 
            MOV R0, #100
            MOV R1, #99
            CMP R0, R1 
            BCS BCS_EX1     //  BRANCHES TRUE Compare R0 is >= R1? 100 > 99
        BCS_EX2: 
            MOV R0, #100
            MOV R1, #100
            CMP R0, R1 
            BCS BCS_EX2     //  BRANCHES TRUE Compare R0 is >= R1? 100=100
        BCS_EX3:
            MOV R0, #67
            MOV R1, #21
            CMP R1, R0
            BCS BGT_EX1     // FALSE R1(21) not greater than R0(67) 

        //=============================================================
        // BGT - Branch greater than Z=0, N==V
        BGT_EX1:
            MOV R0, #70
            MOV R1, #80
            CMP R0, R1
            BGT BGT_EX1 // 70 Not greater 80; Z=0, N!=V FALSE
        BGT_EX2:
            MOV R0, #10
            MOV R1, #10
            CMP R0, R1
            BGT BGT_EX2 // FALSE; R0==R1, Z=1 
        BGT_EX3:
            MOV R0, #30
            MOV R1, #8
            CMP R0, R1
            BGT BGT_EX3 // Branches; TRUE 30 > 8, Z=0 N==V

        //=============================================================
        // BHI - Branch if Higher C=1and Z=0 
        BHI_EX1:
            MOV R0, #1
            MOV R1, #2
            CMP R0, R1
            BHI BHI_EX1 // C=0, Z=0; R0 < R1; FALSE
        BHI_EX2:
            MOV R0, #25
            MOV R1, #25
            CMP R0, R1
            BHI BHI_EX2 //  Z=1 R0=R1; FALSE
        BHI_EX3:
            MOV R0, #100
            MOV R1, #50
            CMP R0, R1
            BHI BHI_EX3 // BRANCHES; C=1 Z=0; 100 > 50 TRUE
    }
        
}