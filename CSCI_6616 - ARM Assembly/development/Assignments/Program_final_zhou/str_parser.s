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
        R9 - Field category: 
           0 = target
           1 = track#
           2 = range
           0 = Azimuth
           1 = Elevation

 * ==========================================================================================
 */
.EQU OFFSET_TARGET,    0            @ 2bytes; w/r must be half-word
.EQU OFFSET_TRACKNUM,  2            @ 2bytes; w/r must be half-word
.EQU OFFSET_RANGE,     4
.EQU OFFSET_AZIMUTH,   8
.EQU OFFSET_ELEVATION, 12

.global sp_start
.section .text

sp_start:
/// \ Ideally input R0=input_string; R1=target label
    PUSH {R4-R12, LR}
    LDR R6, =input_string               
    LDR R1, =target_label
    MOV R9, #0                  @ field counter 0-4; Five categories
    MOV R8, #0
    MOV R4, #1                  @ multiplier start at 1

sp_search:
/// \ Start parsing through the string to extract numbers for each category.
// Looking for '{' to start set and '}' to end each field 
// ':' followed by 'space' means expecting number until '}' is met
// Due to the volume an speed required to process, this method is chosen over
// a substring search method
    
    MOV R5, #0                  @ initialize our temp result register to 0
    LDRB R2, [R6], #1           @ load char from string into R2
    CMP R2, #0                  @ check end of string; /null
    BEQ not_found               @ no/bad data exit
    CMP R2, #'{'               
    BEQ sp_parse_field          @ we found the open bracket, new field, start parsing
    BNE sp_search               @ if not, skip to next character 

    // Keep parsing until we find a ':' followed by a space ' ' 
    sp_parse_field:
    LDRB R2, [R6], #1           @ load the next char byte to compare
    CMP R2, #'}'                @ we are done with this field
    BEQ sp_search               @ this field is finished, parse the next
    CMP R2, #' '
    BEQ wsp_found               @ whitespace found, we can safely look for number
    B sp_parse_field            @ keep parsing

    wsp_found:                  @ whitespace is found
    @ LDRB R2, [R6], #1            @ this read should now have a ' ', next should be a number
    CMP R9, #2                  @ if fields 0,1=int; 2,3=float
    LDR R1, =num_index_address
    STR R6, [R1]                @ save the current index with the numbers into memory
    BLT convert_integer         @ R9 = 0 or 1 convert int
    @ BGE convert_float           @ R0 >=2 convert to float

convert_integer:
/// \ Fields 0=target, 1=track# are integers
// Read is first performed and pushed into stack since we dont know how 
// large the number is to convert. Ie 154 is push to stack 4-5-1 so 
// can multiply them by the number of 10^n accordingly
// Return R5 - result ineger

    LDRB R2, [R6], #1            @ read the current byte,
    CMP R2, #'}'
    MOVEQ R3, #0                @ R3 will be used in build_integer funciton to count digit position
    BEQ build_integer
    SUB R2, R2, #'0'            @ quick way to convert ascii to integer
    PUSH {R2}                   @ push the number to stack to get the correct order
    ADD R8, #1                  @ counter to keep track                     
    B convert_integer           @ repeat for next digit

  // Completed the current field read, reconstruct number
  build_integer:
    CMP R8, #0                  @ While R8 >=0
    BEQ write_int
    ADD R3, #1                  @ increment digit position index
    POP {R2}                    @ pop 4-5-1 from stack
    BL get_multiplier           @ arg R3=current index;  return r0=multiplier
    MUL R1, R2, R0              @ R1 = R2 * multiplier[R0]
    ADD R5, R1                  @ R5 += R1
    SUB R8, R8, #1              @ decrement digit counter
    B build_integer             @ repeat until done

  // Integer is done
  write_int:
    CMP R9, #0                  @ Target# field
    BEQ store_target
    CMP R9, #1                  @ this is a track number
    BEQ store_track            

  store_target:
    LDR R0, =parsed_buffer      @ store the target number in the buffer
    STRH R5, [R0, #OFFSET_TARGET]
    B int_done 

  store_track:
    LDR R0, =parsed_buffer      @ store the track number in the buffer
    STRH R5, [R0, #OFFSET_TRACKNUM]
    B int_done

  int_done:
    ADD R9, #1                  @ increment Field counter(R9) +1
    B sp_search                 @ start the next field


    



sp_done:
    POP {R4-R12, LR}
    BX LR
    
not_found:
    @ handle case if label not found
    @ null all data in fields and print error
    LDR R0, =str_not_found
    BL printf
    MOV R0, #0
    B sp_done

get_multiplier:
/// \ R8 param[in] - the count of digit position
// returns R0 - the 10s multiplier based on position
    CMP R3, #4
    MOVEQ R0, #1000
    CMP R3, #3
    MOVEQ R0, #100
    CMP R3, #2
    MOVEQ R0, #10
    CMP R3, #1
    MOVEQ R0, #1
    CMP R3, #0        @ should never come to this
    MOVEQ R0, #0
    BX LR


.data
    num_index_address: .word 0
    parsed_buffer: .space 16, 0  @ Buffer per track is 16bytes

.word @ 32bit align for strings
    input_string: .asciz "{TARGET#: 154}{TRACK#: 0}{RANGE: 120000}{AZIMUTH: 45.00}{ELEVATION: 30.00}"
    str_not_found:      .asciz "[!] No/bad data from track input\n"

    // Pattern matching
    target_label:   .asciz "TARGET#:" 



