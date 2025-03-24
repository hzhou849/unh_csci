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
            R0-R3 - Temprory work registers
            R4: 
            R5: status 0=normal; 1=full
            R6: current_size

            if not enough registers to store this, you might have to check on the fly
            R7: head
            R8: tail
 * ========================================================================================== 
 */

 @ Function includes menu.s modN.s

 @ Define Constants
 .EQU SHIFT2, 2             @ Shift 2 = multiply by 4
 .EQU WSIZE,  4             @ Word Size 32bits=4bytes
 .EQU CAPACITY_SIZE, 8   @ We have 1024 slots but *4 addressing =4096	

.EQU OPTION_1_WRITE, 1
.EQU OPTION_2_READ,  2
.EQU OPTION_3_CHECK, 3
.EQU OPTION_4_INIT,  4
.EQU OPTION_5_EXIT,  5
 

.global main
.section .text

main:
    MOV R5, #0
    MOV R6, #0                  @ Current size
    MOV R7, #0                  @ Initialize head
    MOV R8, #0                  @ Iniitalize tail

restart:

    // 1 - Print menu option
    BL menu_print           @ print the options menu

    // 2 - Get menu user option
    LDR R0, =menu_fmt_specifer  @ Set the menu option input format specifier
    LDR R1, =menu_opt            @ buffer to store stdin
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
    CMP R6, #CAPACITY_SIZE          @ Check current size of buffer(R6) is at capacity
    BEQ opt3

    // Get user input
    LDR R0, =scanf_prompt           @ load prompt string
    BL printf                       

    LDR R0, =input_fmt_specifier    @ set scanf input specifier
    LDR R1, =input_buffer           @ set the input buffer
    BL scanf                        @ run scanf
    BL getchar                      @ flush the whitespace buffer left by scanf


    // Calculate Tail = [(Head + currentSize) % total_capacity] * 4bytes offset
    ADD R8, R7, R6          @ Get tail = head + current_size

    // Call modN() R0=arg1: N, R1=arg2: Total capacity
    MOV R0, R8              @ curPos(dividend)
    MOV R1, #CAPACITY_SIZE  @ Capacity(divisor)
    BL modN                 @ returns R0=remainder value
    MOV R3, R0              @ Copy the moded number result to R4
    LSL R8, R0, #2          @ Multiply by 4 to convert to 4byte offset address
                            @ Left shift value by 2 == R3 *4)


    // ***** DEBUG ***************************************************************
    BL debug_print
    // ****************************************************************************
    
    // Retrieve data from input buffer
    LDR R0, =input_buffer
    LDR R1, [R0]            @ retrieve byte from scanf buffer

    // Write to Ring buffer at offset(R8)
    LDR R0, =buffer         @ load the buffer to R0 for writing
    STR R1, [R0, R8]        @ write to buffer @ tail_offset(R8)

    // Update the size counter(R7) +1 
    ADD R6, #1             @ Increment size_count(R6) for next calculation

    // Update tail to new position Tail+1 slot = [(Head + currentSize) % total_capacity] * 4bytes offset
    ADD R8, R7, R6          @ Get tail = head + current_size

    // Call modN() R0=arg1: N, R1=arg2: Total capacity
    MOV R0, R8              @ curPos(dividend)
    MOV R1, #CAPACITY_SIZE  @ Capacity(divisor)
    BL modN                 @ returns R0=remainder value
    MOV R3, R0              @ Copy the moded number result to R4
    LSL R8, R0, #2          @ Multiply by 4 to convert to 4byte offset address
                            @ Left shift value by 2 == R3 *4)
    
    CMP R7, R8              @ if head == tail, buffer is full
    MOVEQ R5, #1            @ status(R5)=1; buffer is full

    // ***** DEBUG ***************************************************************
    BL debug_dump
    // ****************************************************************************
    
    BL restart

opt3:  @ Check buffer status 0=normal, 1=full
    @ status_str: .asciz "Buffer status - Head: [ %d ]; tail: [ %d ]; size [ %d ]; total_capacity: [%d ]\n"
    
    LDR R0, =status_val
    MOV R1, R5
    PUSH {R6-R8}
    BL printf
    POP {R6-R8}


    LDR R0, =status_str
    MOV R1, R7              @ arg1= head(R7)
    ADD R2, R7, R6          @ Get tail = head + current_size
 
    MOV R2, R8              @ arg2= tail(R8) is always last postion written +1
    MOV R3, R6              @ arg3= size(R6)
    MOV R4, #CAPACITY_SIZE  @ arg4
    @ R5 = arg5
    PUSH {R6-R8}
    BL printf
    POP {R6-R8}
    

    BL restart

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

   


debug_print: 
    
    // Temporarily transfer the results
    MOV R9, R0              @ Copy R0 to R9
    MOV R10, R3             @ mod result 
    MOV R11, R8             @ Result *4 

    PUSH {R0-R8, LR}
    LDR R0, =debug_str
    MOV R1, R9              @ print curPos
    MOV R2, #CAPACITY_SIZE  @ print capacity size
    MOV R3, R11             @ print mod result
    MOV R4, R11 
    BL printf
    POP {R0-R8, LR}         @ restore registers
    BX LR







opt2:   @ Read from head
opt4:   @ Initialize to 0
opt5:   @ Exit
    BL exit


@     // Debug mode pre-written values
@     MOV  R1, #0x0000
@     MOVT R1, #0x0000
@     MOV R2, #0              @ counter init to 0

@     LDR R5, =buffer 
@     LDR R0, =print_value

@     // Using stdin for input 

@ loop:
@     ADD R1, R1, #1          @ add counter value to R1 for tracking
@     STR R1, [R5, R2]        @ Store R1 value in to

@     // Check memory and print
@     LDR R4, [R5, R2]        @ load the value from buffer

@     PUSH {R0-R4}
@     MOV R1, R2              @ Copy the Counter to arg1
@     MOV R2, R4              @ copy the value to arg2
@     BL printf
@     POP {R0-R4}

@     ADD R2, R2, #WSIZE
@     CMP R2, #CAPACITY_SIZE
@     BLT loop

exit:
    LDR R0, =menu_str_exit   @ load exit message
    BL printf               
    MOV R0, #0              @ Set the return code
    MOV R7, #1              @ 1= Linux service exit
    SVC 0




.data
.word   @ 32bit align all variables
    menu_opt:    .space 4, 0             @ Buffer to store stdin menu option selection 
    menu_fmt_specifer:  .asciz "%d"     @ Format specifier for menu option stdin

    scanf_prompt: .asciz "Enter dataChar > "

    input_buffer: .space 4, 0           @ input buffer for scanf
    input_fmt_specifier: .asciz "%c"    @ format specifier for scanf input

    @ buffer:     .space 4096, 0       @ 32bits=4bytes*1024 = 4096bytes 
    buffer:     .space 64, 0           @ 32bits=4bytes*8 = 32bytes+4(last word) = 36bytes minimum

    print_value: .asciz "[%d] value: %d\n" 
    debug_str: .asciz "curPos(dividend): [ %d ]; Cap(divisor): [ %d ]; modResult:  [ %d ];  modResult * 4: [ %d ]\n"
    dump_str: .asciz "%d) [ %c ]\n" 
    status_str: .asciz "Buffer status - Head: [ %d ]; tail: [ %d ]; size [ %d ]; total_capacity: [%d ]; status=[%d]\n"
    status_val: .asciz "Status: [%d]\n"
.section .note.GNU-stack, "", %progbits     @ disable GNU stack warning
.end




    