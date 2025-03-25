/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Program 6 - Ring Buffer
    Name: Howard Zhou
 
    File: modN.s
 
    File modN.s

    @Description: modulus N of a number by repeated subractions until <=0
                Count the number of subtractions is N and the remainder is value prior to last 
                subtraction

    @Registers
    @ args in from main.s
    param[in]R0 - tail number (dividend)
    param[in]R1 - capacity   (divisor)

    This function
    R0-R3 temp values
    R4 - Increment counter
    R5 - curPos
    R6 - Buffer capacity size
    

    @ Returns
    R0 - Remainder
    R1 - N


* ==========================================================================================
*/

.global modN
.section .text

modN:   @ Takes R0 as arg1; R1(arg2)= totalCapcity
    PUSH {R4-R8, LR}
    MOV R4, #0          @ counter N; init=0
    MOV R5, R0          @ Copy curPos
    MOV R6, R1          @ copy capacity size
    
    
cont:// If R1-R0 == 0, we are done; else keep looping
    SUB R5, R5, R6  	@ curPos - totalCapacity 
    ADD R4, #1          @ Increment counter +1
    CMP R5, #0          @ Check if R3 == 0
    BGT cont            @ if R3 > 0, repeat

    CMP R5, #0          @ If we are here, we are either R3 =< 0
    BEQ done            @ If we R3 == 0, branch to done

    // Only here if R3 <0
    ADD R5, R6          @ Oversubtracted into <0, add back capacity value
    SUB R4, #1          @ undo the count/remainder

done: 
    MOV R0, R5          @ Copy the count/remainder back as the return value
    POP {R4-R8, LR }    @ restore values
    BX LR               @ return to main()  

