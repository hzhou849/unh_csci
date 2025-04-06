/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Program 6 - Ring Buffer
    Name: Howard Zhou

    File: main.s

    Description:
        - Ring buffer implementation  with head/tail
        - Fixed size array that wraps when reachs memory end
        - buffer is full when write pointer is +1 of read pointer
        - Calculation is done by tail(write) head(read) pointers
          * tailPointer = (HeadPosition + currentSize) % bufferCapacity
          * head = (head + 1) % buffer_capacity
        - NOTE: we actually have 1024 element size so calculations use 1024
          to get the element position then *4 to get addressing


        @ Write syscalls
        R0 - 0=stdin; 1=stdout; 3=stderr
        R2 - stores length of string
        R7 - linux service 3=read; 4=write


        @ Scanf registers:
            R0: pointer to var containing format specifier %d, %c %h etc..
            R1: input data buffer to store char ( requires actual char value ie 0x31 = '1')
        
        @ Printf registers:
            R0: contains address of string data var to print
            R1..R?: args used for variable print

        @ main registers:
            R0-R4 - Temprory work registers
            R5: status 0=normal; 1=full
            R6: current_size
            R7: head
            R8: tail
 * ========================================================================================== 
 */

 @ Function includes menu.s modN.s

 @ Define Constants
 .EQU SHIFT2, 2                 @ Shift 2 = multiply by 4
 .EQU WSIZE,  4                 @ Word Size 32bits=4bytes
@  .EQU CAPACITY_SIZE, 8          @ We have 1024 slots but *4 addressing =4096	
 .EQU CAPACITY_SIZE, 1024          @ We have 1024 slots but *4 addressing =4096	

.EQU OPTION_1_WRITE, 1
.EQU OPTION_2_READ,  2
.EQU OPTION_3_CHECK, 3
.EQU OPTION_4_INIT,  4
.EQU OPTION_5_EXIT,  5
 

.section .text
.global main

main:
    MOV R5, #0
    MOV R6, #0                  @ Current size
    MOV R7, #0                  @ Initialize head
    MOV R8, #0                  @ Iniitalize tail

restart:

    // 1 - Print menu option
    BL menu_print               @ print the options menu

    // 2 - Get menu user option
    LDR R0, =menu_fmt_specifer  @ Set the menu option input format specifier
    LDR R1, =menu_opt           @ buffer to store stdin
    PUSH {R1}                   @ Push menu_opt to stack, since c calls will overwrite this value 
    BL scanf                    @ call scanf
    BL getchar                  @ flush the whitespace left by scanf
    POP {R1}                    @ Retrieve menu_opt address
    LDR R2, [R1]                @ Retrieve by dereferencing R1

    // Check what option is selected
    CMP R2, #OPTION_1_WRITE
    BEQ opt1
    CMP R2, #OPTION_2_READ
    BEQ opt2
    CMP R2, #OPTION_3_CHECK
    BEQ opt3
    CMP R2, #OPTION_4_INIT
    BEQ opt4
    CMP R2, #OPTION_5_EXIT
    BEQ opt5

opt1:   @ Write to tail
    // Check if size_count is at capacity 
    // Method 1: check based on size counter vs total capacity
    @ MOV R0, R6                      @ Move size count to R0 for calculation
    @ LSL R0, R0, #2                  @ mutliply size by *4 to get byte_offset; Lshift2
    @ MOV R1, #CAPACITY_SIZE          @ move capacity to R1 for calculation
    @ LSL R1, R1, #2
    @ CMP R0, R1                      @ Check current size of buffer(R6) is at capacity

    // Method 2: Checking if tail +1 equals head since tail was updated below after write
    // we only need to check status register R5 is set?
    CMP R5, #1                      @ check status register
    BLEQ menu_print_write_full		@ print message buffer is full
    BEQ opt3                        @ print status 

    // Get user input
    LDR R0, =scanf_prompt           @ load prompt string
    BL printf                       
    LDR R0, =input_fmt_specifier    @ set scanf input specifier
    LDR R1, =input_buffer           @ set the input buffer
    BL scanf                        @ run scanf
    BL getchar                      @ flush the whitespace buffer left by scanf

    // Calculate Tail = [(Head + currentSize) % total_capacity] * 4bytes offset
    MOV R3, R6                      @ Copy size count into R3
    LSL R3, R3, #2                  @ Multiply size count *4 by left-shift 2
    ADD R8, R7, R3                  @ Get tail = head + (current_size*4)

    // Call modN() R0=arg1: N, R1=arg2: Total capacity
    MOV R0, R8                      @ curPos(dividend)
    MOV R1, #CAPACITY_SIZE          @ Capacity(divisor)
    LSL R1, R1, #2                  @ Multiply capacity by 4 to get total bytes
    BL modN                         @ returns R0=remainder value
    MOV R8, R0                      @ copy the mod% result into R8
    
    // Retrieve data from input buffer
    LDR R0, =input_buffer
    LDR R1, [R0]                    @ retrieve byte from scanf buffer

    // Write to Ring buffer at offset(R8)
    LDR R0, =buffer                 @ load the buffer to R0 for writing
    STR R1, [R0, R8]                @ write to buffer @ tail_offset(R8)

    // Update the current_size counter(R6) +1 
    ADD R6, #1                      @ Increment size_count(R6) for next calculation

    // Check to update status bit
    CMP R6, #CAPACITY_SIZE          @ Check if size == capacity?
    MOVEQ R5, #1                    @ if full, update R5 status register

    // Update tail to new position Tail+1 slot = [(Head + currentSize) % total_capacity] * 4bytes offset
    MOV R3, R6                      @ move current size to R3
    LSL R3, R3, #2                  @ Multiply size count *4 by left-shift 2
    ADD R8, R7, R3                  @ Get tail = head + current_size
    MOV R0, R8                      @ curPos(dividend)
    MOV R1, #CAPACITY_SIZE          @ Capacity(divisor)
    BL modN                         @ returns R0=remainder value
    MOV R3, R0                      @ Copy the moded number result to R4
    CMP R7, R8                      @ if head == tail, buffer is full
    MOVEQ R5, #1                    @ status(R5)=1; buffer is full

    BL debug_dump                   @ dump buffer contents
    BL restart

opt2:   @ Read from head

    // 0 check to see if size is 
    MOV R0, R6              @ copy size to R0
    LSL R0, R0, #2          @ multiply size *4 to get byte_offset
    CMP R0, #0              @ Check if buffer is empty
    BLEQ menu_print_empty   @ if empty, print error message
    BLEQ opt3               @ if empty, print status and restart loop

    // read head index(R7)
    MOV R3, R7              @ Copy current Head ptr into R3
    LDR R0, =buffer
    LDR R2, [R0, R3]

    // dequeue and print element
    LDR R0, =read_value     @ load read_value string
    MOV R1, R3              @ arg1= head_offset value
                            @ arg2= R2 read value already loaded
    BL printf               @ print read message

    LDR R0, =buffer         @ load buffer to write
    MOV R1, #0
    STR R1, [R0, R7]        @ write a 0/null to current head position

    // update new head by incrementing by 1; head=(head+1) % capacity
    ADD R7, #4              @ increment head +4bytes
    MOV R0, R7              @ arg1= head ptr to R0 to be passed in mod()
    MOV R1, #CAPACITY_SIZE  @ arg2= capacity_size to mod
    LSL R1, R1, #2          @ multiply capacity *4 for total bytes to compare
    BL modN                 @ return R0=remainder value
    MOV R7, R0              @ update the new head pointer +1 slot

    // decrement the current size by 1
    SUB R6, #1              @ Decrement size_count(R6) for next transaction calculations

    // Check if need to remove full status register R5
    CMP R5, #1              @ see if R5 is set
    MOVEQ R5, #0            @ if set, clear bit

    BL debug_dump           @ dump buffer contents
    BL restart


opt3:  @ Check buffer status 0=normal, 1=full
    LDR R0, =status_str
    MOV R1, R5              @ arg1= status(R5)
    MOV R2, R7              @ arg2= head(R7)
    MOV R3, R8              @ arg3= tail(R8) is always last postion written +1
    
    // Printf arg R1-R3 is full, need to push to stack
    MOV R4, #CAPACITY_SIZE  @ arg5= Total_capacity_size
    PUSH {R4}               @ Push capcity size value to stack 
    MOV R4, R6              @ arg4= current size(R6)
    PUSH {R4}               @ push to stack for output
    BL printf
    ADD SP, SP, #8          @ delete the 2 x(4bytes) values pushed into stack
    BL restart


opt4:   @ Initialize to 0
    // 0 - print message wiping buffer
    // 1 - load buffer address to Register
    MOV R1, #0              @ null value to write
    MOV R2, #0              @ Iterator count
    LDR R0, =buffer         @ pointer to buffer
    // restart all values
    MOV R5, #0              @ reset status
    MOV R6, #0              @ reset current size   
    MOV R7, #0              @ reset head
    MOV R8, #0              @ reset tail
  wipe_loop:
    CMP R2, #CAPACITY_SIZE  @ check if iterator == capacity size
    BLEQ debug_dump         @ if done, print output and restart
    BEQ restart

    LSL R3, R2, #2          @ multiply iterator by 4 to get byte offset
    STR R1, [R0, R3]        @ write 0 value to buffer+byte_offset(R3)
    ADD R2, #1              @ increment iterator counter
    B wipe_loop             @ repeat



opt5:   @ Exit
    BL exit

debug_dump:
    PUSH {R4-R8, LR}
    LDR R0, =buffer
    MOV R1, #0              @ init counter
  dump_loop:    
    CMP R1, #CAPACITY_SIZE  @ check if we are at capacity size +1
    BGE dump_done
    LSL R3, R1, #2          @ take counter * 4 to get word offset
    LDR R2, [R0, R3]        @ retreive word from buffer
    PUSH {R0-R3}            @ backup registers for printf
    LDR R0, =dump_str       @ load dump string
    BL printf               @ print
    POP {R0-R3}             @ restore registers
    ADD R1, #1              @ increment counter by 1
    BL dump_loop            @ repeat
  dump_done:
    POP {R4-R8, LR}
    BX LR

exit:
    LDR R0, =menu_str_exit   @ load exit message
    BL printf               
    MOV R0, #0              @ Set the return code
    MOV R7, #1              @ 1= Linux service exit
    SVC 0


.data
.word   @ 32bit align all variables
    menu_opt:           .space 4, 0     @ Buffer to store stdin menu option selection 
    menu_fmt_specifer:  .asciz "%d"     @ Format specifier for menu option stdin
    scanf_prompt:       .asciz "Enter dataChar > "

    input_buffer:       .space 4, 0     @ input buffer for scanf
    input_fmt_specifier:.asciz "%x"     @ format specifier for scanf input

    buffer:   .space 4096, 0          @ 32bits=4bytes*1024 = 4096bytes 
    @ buffer:     .space 64, 0            @ DEbug buffer; 32bits=4bytes*8 = 32bytes+4(last word) = 36bytes minimum

    read_value: .asciz "\nRetrieved value from head_offset: +%d; value: [%x]\n"
    print_value:.asciz "[%d] value: %d\n" 
    dump_str:   .asciz "%d) [ 0x%x ];\t offset_byte: +%d\n" 
    status_str: .asciz "\nBuffer status: [%d]; Head_offset:[+%d]; tail_offset: [+%d]; size/total_capacity: %d of %d\n"
    status_val: .asciz "Status: [%d]\n"

.section .note.GNU-stack, "", %progbits     @ disable GNU stack warning
.end




    