/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou

    File: str_parser.s

    Description:
        -  Command format is ascii command string
        - {TARGET#: 1}{TRACK#: 0}{RANGE: 120000}{AZIMUTH: 45.00}{ELEVATION: 30.00}
        - Parser used to extract track data

    Data Format: each track contains:
        - Target#:  2byte
        - Track#:   2byte
        - Range:    4bytes, 32-bit
        - Azimuth:  float 4bytes
        - Elevation: float 4 bytes
        Total = 16bytes per track = 200tracks * 16bytes = 3200 bytes size in memory

    Input registers:
        R0 = input string track record

    Local Registers:
        R5 - Buffer status regsiter
        R6 - Current size

        R0 = target
        R1 = track#
        r2 = range
        S0 = Azimuth
        S1 = Elevation

 * ==========================================================================================
 */

.global sp_start
.section .text

sp_start:
///\ Ideally input R0=input_string; R1=target label
    PUSH {R4-R12, LR}
    LDR R0, =input_string               
    LDR R1, =target_label

sp_search:
    LDRB R2, [R0]               @ Load byte from input
    CMP R2, #0                  @ check end of string \null terminator
    BEQ not_found               @ if so, stop

    PUSH {R0, R1}               @ save positionss to retry if mismatch?
    MOV R3, R0                  @ R3=current input position
    MOV R4, R1                  @ R4=label  positioni

sp_compare_loop:
    LDRB R5, [R3], #1           @ Load byte and post-increment
    LDRB R6, [R4], #1           @ load and increment label
    CMP R6, #0                  @ end of label?; should be "}"
    BEQ sp_label_found          @ match found
    CMP R5, R6
    BNE sp_mismatch             @ if match was not found, rollback target label, 
                                @ and move to next string char
    B sp_compare_loop           @ match is found, continue to next char

sp_mismatch:
/// \ Match was not found and will restore both string pointers
// keep the same target pointer, increment search string to next char
// and restart search loop
    POP {R0, R1}                @ restore and continue
    ADD R0, R0, #1              @ move to next char in input
    B sp_search                

sp_label_found:
    POP {R0, R1}                @ Discard saved state
    ADD R0, R0, #8              @ skip the length of this label ("target#:")

skip_spaces:
    LDRB R2, [R0]
    CMP R2, #' '
    BNE parse_digits
    ADD R0, R0, #1
    B skip_spaces

parse_digits:
    MOV R7, #0                  @ R7 = result

parse_loop:
    LDRB R2, [R0]
    CMP R2, #'0'
    BLT end_parse
    CMP R2, #'9'
    BGT end_parse
    SUB R2, R2, #'0'            @ Convert ascii to digit
    MOV R0, #10
    MUL R6, R7, R0
    ADD R6, R7, R2
    ADD R0, R0, #1
    B parse_loop

end_parse:
    @ R6 no contains the parsed integer (e.g 1 for target)
    @ you can now store or use R6 as needed

sp_done:
    POP {R4-R12, LR}
    BX LR
    
not_found:
    @ handle case if label not found
    B sp_done


.data
.word @ 32bit align for strings
    input_string: .asciz "{TARGET#: 1}{TRACK#: 0}{RANGE: 120000}{AZIMUTH: 45.00}{ELEVATION: 30.00}"

    // Pattern matching
    target_label:   .asciz "TARGET#:" 




//=========================================================================================================

