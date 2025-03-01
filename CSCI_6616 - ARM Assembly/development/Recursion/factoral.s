/*===========================================================================================

 File: factorl.s

 @Description: Recursive technique used to calculate factoral
                N!= N*(N-1) * (N-2)...* 1

 @Registers

 
=============================================================================================
*/

.global main
.section .text

@ Stack push used due to recursion
main:       
    MOV R0, #4         @ value to be passed in
    MOV R4, #0          @ initialize temp variable 
    BL factoral
    B exit

factoral:   
    MOV R1, R0          @ save value passed in
    PUSH {R1, LR}       @ save values on stack 
    SUBS R0, R1, #1          @ subtract N value by 1
    BLNE factoral       @ While R0 !=0
    @ CMP R0, #0          @ compare here to check once and bypass next line 
    @                     @ when returning recursively; can try MULS to skip this?
    MOVEQ R0, #1        @ if R0 is zero we are at the base case
    POP {R1, LR}        @ restore values from stack
    MULS R2, R0, R1      @ R2 = N * (N-1)...; using {S} should not need CMP statement above
    MOV R0, R2          @ copy R2 into R0 to be passed back in
    BX LR
    
exit:
    MOV R0, #0          @ Return value
    MOV R7, #1          @ linux service exit code
    SVC 0


.data
.word       @ 32bit align variables in memory


.section .note.GNU-stack, "", %progbits
.end
