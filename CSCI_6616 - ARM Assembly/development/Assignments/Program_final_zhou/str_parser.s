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
        R0 param[in] - pointer to input string track record

    Assigned Registers:
        R5 - Buffer status regsiter
        R6 - Input string we are processing
        R9 - Field category: 
           0 = target
           1 = track#
           2 = range
           3 = Azimuth
           4 = Elevation

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
/// \ Ideally input R0=input_string
    PUSH {R4-R12, LR}
    MOV R6, R0                  @ Load the input string into R6 for processing
    @ LDR R6, =input_string               
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
    MOV R8, #0                  @ reset counter for converting counter
    CMP R9, #2                  @ if fields Target(0),Track#(1)=int; Range(2),Az(3),Ele(4)=float
    LDR R1, =num_index_address  @ **** TODO: delete not needed
    STR R6, [R1]                @ *** TODO: delete save the current index with the numbers into memory
    BLE convert_integer         @ R9 = 0,1,2  convert int 
    BGT convert_float           @ R0 >=2 convert to float

convert_float:
/// \Converts ascii number to floats
/// Fields 3=Azimuth; 4=elevation
/// Read is first performed then pushed into stack since we dont
/// know how large the number is to convert. There for we can 
/// multiply them with the correct 10^n to get the position

    LDRB R2, [R6], #1           @ read current byte
    CMP R2, #'.'
    CMP R2, #'}'
    MOVEQ R3, #0                @ R3 will be counter used to construct the digit position
    BEQ build_float
    SUB R2, R2, #'0'            @ quick way to convert ascii to integer




  build_float:
    CMP R8, #0                  @ while R8 > 0
    BEQ write_to_mem
    ADD R3, #1                  @ increment digit position index
    POP {R2}                    @ pop 2-1- . -5 -4
    CMP R2, #'.'                @ if we got radix, we have fraction
    BEQ constuct_frac           @ skip to construct fraction
    BL get_multiplier           @ arg R3=current digit index; return= R0 multiplier 10^n
    MUL R1, R2, R0              @ R1 = R2 * multiplier[R0]
    ADD R5, R1                  @ R5 += R1 accumulate number segment
    SUB R8, R8, #1

  construct_frac:
  // Construct the fraction portion and convert to float
  // We have fraction, we need to reset R3 back to 0 to process integer portion after
  // R8 is still decremented for when we go back out to process the integer portion after
  // We also need to reset r5=0 when were done 
    MOV R3, #0                  @ Reset R3 digit index since we have the fraction portion
    SUB R8, R8, #1              @ We still need to decrement R8 to keep the stack count aligned
    VMOV.f32 S0, R5             @ Move R5 into S0 float register
    VCVT.f32.s32 S0, S0         @ convert S0 to signed float32; required to work
    VMOV S1, #100               
    VDIV.f32 S2, S0, S1         @ S2 = S0/100 to get 0.xx fraction 
    LDR R0, =fraction_f
    VSTR.f32 S2, [R0]           @ store fraction to memery
    MOV R5, #0                  @ we need to reset this to process integer after
    B build_float               @ resume back to build integer portion
  

  // reset r5 to zero when done


convert_integer:
/// \Fields 0=target, 1=track# are integers
/// \Return R5 - result ineger
// Read is first performed and pushed into stack since we dont know how 
// large the number is to convert. Ie 154 is push to stack 4-5-1 so 
// can multiply them by the number of 10^n accordingly

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
    CMP R8, #0                  @ While R8 > 0
    BEQ write_to_mem
    ADD R3, #1                  @ increment digit position index
    POP {R2}                    @ pop 4-5-1 from stack
    BL get_multiplier           @ arg R3=current index;  return r0=multiplier
    MUL R1, R2, R0              @ R1 = R2 * multiplier[R0]
    ADD R5, R1                  @ R5 += R1
    SUB R8, R8, #1              @ decrement digit counter
    B build_integer             @ repeat until done

  // Integer is done, write to memory
  // R9 - param[in] key used to determin which part of buffer to write to 
  write_to_mem:
    CMP R9, #0                  @ Target# field
    BEQ store_target
    CMP R9, #1                  @ Write track number
    BEQ store_track            
    CMP R9, #2                  @ Write Range
    BEQ store_range  
    @ TODO:: range needs to be converted to float since it will be multiplied.          

  store_target:
    LDR R0, =parsed_buffer      @ store the target number in the buffer
    STRH R5, [R0, #OFFSET_TARGET]
    B int_done 

  store_track:
    LDR R0, =parsed_buffer      @ store the track number in the buffer
    STRH R5, [R0, #OFFSET_TRACKNUM]
    B int_done

  store_range:
    LDR R0, =parsed_buffer      @ store Range as float in the buffer
    STR R5, [R0, #OFFSET_RANGE]
    

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
/// Gets the proper 10^n place for the digit postion
/// \param[in] R3 - the count of digit position
/// \returns   R0 - the 10s multiplier based on position
//  Did not implement with loop because 0 digits and ones are exception cases
    CMP R3, #7
    MOVEQ R0, #0x4240   @ 100,000 is too large for MOV 
    MOVTEQ R0, #0xF
    CMP R3, #6
    MOVEQ R0, #0x86A0   @ 10,000 is too large for MOV
    MOVTEQ R0, #0x1
    CMP R3, #5
    MOVEQ R0, #10000
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
.align 4
    fratcion_f:      .single 0.0
    integer_f:       .single 0.0

.word @ 32bit align for strings
    input_string: .asciz "{TARGET#: 154}{TRACK#: 0}{RANGE: 120000}{AZIMUTH: 45.00}{ELEVATION: 30.00}"
    str_not_found:      .asciz "[!] No/bad data from track input\n"

    // Pattern matching
    target_label:   .asciz "TARGET#:" 



