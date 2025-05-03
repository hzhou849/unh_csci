/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou

    File: qBuffer.s

    Description:
        - Circular buffer queue to read/write data as needed for TDP 
        - Stores up to 200tracks in memory . Up to 20 targets * 10 tracks each
        -
    Data Format: each track contains:
        - Target#:  2byte
        - Track#:   2byte
        - Range:    4bytes, 32-bit
        - Azimuth:  float 4bytes
        - Elevation: float 4 bytes
        Total = 16bytes per track = 200tracks * 16bytes = 3200 bytes size in memory

    
    Local Registers:
        R5 - Buffer status regsiter
        R6 - Current size

        Return R0: last write address


    ascii command string
    {TRAGET#}{TRACK#: N}{RANGE: R}{AZIMUTH: AZ}{ELEVATION: EL}
 * ==========================================================================================
 */

/// \Constants:
.EQU TRACK_SIZE, 16                 @ Bytes modified to 16 for bitwise 2^4
.EQU CAPACITY_SIZE, 200             @ 200 slots 
.EQU CAPACITY_SIZE_BYTES, 3200      @ 200 slots * 16bytes

.EQU OFFSET_TARGET,    0            @ 2bytes; w/r must be half-word
.EQU OFFSET_TRACKNUM,  2            @ 2bytes; w/r must be half-word
.EQU OFFSET_RANGE,     4            @ 4bytes WORD
.EQU OFFSET_AZIMUTH,   8            @ 4byte float
.EQU OFFSET_ELEVATION, 12           @ 4byte float


.global write_queue, read_queue
.section .text


write_queue:   
/// \load data into circular buffer 
/// \param[in] R0 =parsed_buffer - memory variable with parsed track data

// ** TODO: add tail write  address printout  return it to R1

    PUSH {R4-R12, LR}           @ backup current registers
    MOV R9, R0                  @ copy the address of =parsed_buffer to get track data later

    // initial check to see if buffer if full
    LDR R0, =b_status           @ get buffer status value
    LDR R5, [R0]
    CMP R5, #1                  @ Check status register
    BLEQ buffer_write_full      @ print full message
   

    // Get current specs
    LDR R0, =b_curr_size        @ get current size count from memory
    LDR R3, [R0]                @ copy current size count into R3
    LDR R0, =b_head             @ current head index
    LDR R7, [R0]
    

    // Calculate Tail offset = [( Head + currentSize ) % total_capacity] * TrackSize
    LSL R3, R3, #4              @ get currentSize in bytes = Multiply size count * TRACK_SIZE(16); Left shift 4 = *16
    ADD R8, R7, R3              @  head + (current_size*16) 
    MOV R0, R8                  @ curPosition(dividend)
    MOV R1, #CAPACITY_SIZE      @ capacity (divisor)
    LSL R1, R1, #4              @ Multiply capacity(slots) by 16 to get total bytes
    BL modN                     @ returns tail(R0)=remainder value
    MOV R8, R0                  @ copy tail offset mod into R8; this is the offset we need

    // calculate tail buffer address at offset(R8) in bytes
    // Load data and write to circular buffer
    // Recall R9 =parsed_buffer address
    // Assignment: 
    //   R1 = target  2bytes HWORD
    //   R2 = track#  2bytes HWORD
    //   R3 = range      4bytes WORD
    //   S0 = Azimuth    4bytes float
    //   S1 = Elevation  4bytes float
    LDR R0, =buffer                 @ load the buffer to R0 for writing
    ADD R0, R0, R8                  @ r0 = bufferAddres + tailOffset
    LDR R1, =b_tail
    STR R0, [R1]                    @ save the tail to memory to be returned later
    LDRH R1, [R9, #OFFSET_TARGET]    
    LDRH R2, [R9, #OFFSET_TRACKNUM]
    LDR  R3, [R9, #OFFSET_RANGE]
    VLDR.f32 S0, [R9, #OFFSET_AZIMUTH]
    VLDR.f32 S1, [R9, #OFFSET_ELEVATION]


    // Perfrom write
    STRH R1, [R0, #OFFSET_TARGET]   @ STRH store 2 byteswrite to buffer @tail_offset(R8)
    STRH R2, [R0, #OFFSET_TRACKNUM] @ store 2 bytes tracking number
    STR R3, [R0, #OFFSET_RANGE]     @ 4bytes
    VSTR.f32 S0, [R0, #OFFSET_AZIMUTH]  
    VSTR.f32 S1, [R0, #OFFSET_ELEVATION]

    @ // Test data is written successfully by loading it for debugger read
    @ VLDR.f32 S5, [R0, #OFFSET_AZIMUTH]
    @ VLDR.f32 S6, [R0, #OFFSET_ELEVATION]
    
    // Update the current_size counter by +1 and store in memory
    LDR R0, =b_curr_size
    LDR R6, [R0]                @ Load value into R6
    ADD R6, #1                  @ increment currentSize  +1
    STR R6, [R0]                @ write the new size back into memory

    // Check to update status bit. We dont increment tail if tail ==head
    CMP R6, #CAPACITY_SIZE      @ check if current size == total capacity slots?
    LDREQ R0, =b_status         @ buffer if full, update to =1
    MOVEQ R1, #1
    LDREQ R1, [R0]              @ set b_status =1 (full)

    // Check if we are full and set status bit if full
    // check if  new position (Tail slot+1)  is full = [(Head + currentSize) % total_capcity] * 16bytes
    MOV R3, R6                  @ move current size into R3
    LSL R3, R3, #4              @ lshift4 = * 16
    LDR R0, =b_head
    LDR R7, [R0]                @ get head
    ADD R8, R7, R3              @ tail = head + current_size_bytes offset
    MOV R0, R8                  @ currPos(dividend)
    MOV R1, #CAPACITY_SIZE_BYTES
    BL modN                     @ r0 = return tail value
    CMP R7, R0
    // check if head(r7) == new tail(R0)                
    // Return the last write queue address 
    @ LDRNE R1, =b_tail
    @ LDRNE R0, [R1]                @ retreive the last tail write
    BNE b_tx_done               @ if head != tail, we are fine, skip
    
    // @ if head == tail, buffer full, set flag =1 then exit
    LDR R0, =b_status           
    MOV R1, #1
    STR R1, [R0]

    // Return the last write queue address 
    @ LDR R1, =b_tail
    @ LDR R0, [R1]                @ retreive the last tail write
    B b_tx_done

read_queue: /// \Read from buffer
    // ** TODO: add head read  address printout  return it to R1
    PUSH {R4-R12, LR}

    // Check to see if buffer is empty first
    LDR R0, =b_curr_size
    LDR R3, [R0]
    CMP R3, #0                          @ if currentsize == quit
    BEQ buffer_read_empty

    // Load head address and add offset
    LDR R0, =b_head
    LDR R7, [R0]                        @ R7 = head offset(bytes)
    LDR R0, =buffer
    ADD R0, R0, R7                      @ R0 = bufferAddr + headOffset
    LDR R1, =b_head_address
    STR R0, [R1]                         @ save the b_head_address for later
    LDRH R1, [R0, #OFFSET_TARGET]       @ half-word only 2bytes
    LDRH R2, [R0, #OFFSET_TRACKNUM]     @ half-word only
    LDR R3, [R0, #OFFSET_RANGE]
    VLDR.f32 S4, [R0, #OFFSET_AZIMUTH]
    VLDR.f32 S5, [R0, #OFFSET_ELEVATION]

    // Save this track record to return buffer
    PUSH {R0}                           @ save this head offset to call back after
    LDR R0, =ret_track_buffer
    STRH R1, [R0, #OFFSET_TARGET]
    STRH R2, [R0, #OFFSET_TRACKNUM]
    STR R3, [R0, #OFFSET_RANGE]
    VSTR.f32 S4, [R0, #OFFSET_AZIMUTH]
    VSTR.f32 S5, [R0, #OFFSET_ELEVATION]

    // Dequeue (write 0/null) and increment head +1slot(16bytes)
    POP {R0}                            @ restore LDR R0, =buffer + R7 headOffset
    MOV R1, #0
    STRH R1, [R0, #OFFSET_TARGET]
    STRH R1, [R0, #OFFSET_TRACKNUM]
    STR R1, [R0, #OFFSET_RANGE]
    VMOV.f32 S0, R1
    VCVT.f32.s32 S0, S0
    VSTR.f32 S0, [R0, #OFFSET_AZIMUTH]
    VSTR.f32 S0, [R0, #OFFSET_ELEVATION]

    ADD R7, #TRACK_SIZE         @ R7 still holds head offset, +TRACK_SIZE(16)
    LDR R0, =b_head
    STR R7, [R0]                @ write new head offst to mememory

    LDR R0, =b_curr_size        @ decrement current size -1 (slot)
    LDR R6, [R0]                @ deref R0 for value
    SUB R6, #1                  @ subtract currentSize -1
    STR R6, [R0]                @ write new size back into memory

    // Check if we need to remove a full status flag
    LDR R0, =b_status
    LDR R5, [R0]                @ load b_status value into R5
    CMP R5, #1                  @ if status is 1 we can clear it
    MOVEQ R5, #0                @ if status ==1 we will perform the next 2 steps
    LDREQ R5, [R0]              @ clear the buffer full status flag

    LDR R0, =ret_track_buffer    @ return track data buffer 
    B b_tx_done 



b_tx_done:
    POP {R4-R12, LR}
    BX LR                       @ return to calling function

buffer_write_full:
    PUSH {R4-R12, LR}
    LDR R0, =b_str_write_full
    BL printf
    POP {R4-R12, LR}
    B b_tx_done

buffer_read_empty:
    PUSH {R4-R12, LR}
    LDR R0, =b_str_empty
    BL printf
    POP {R4-R12, LR}
    B b_tx_done

get_queue_size:
/// \ Gets the current size of the queue
/// \Returns: R0 = size of the queue
    PUSH {R4-R12, LR}
    LDR R1, =b_curr_size
    LDR R0, [R1]
    POP {R4-R12, LR}
    BX LR


.data
.align 4
    buffer:         .space CAPACITY_SIZE_BYTES, 0   @ reserve 3200 bytes for the buffer
    b_curr_size:    .word 0 
    b_head:         .word 0
    b_head_address:         .word 0
    b_tail:         .word 0
    b_status:       .word 0
    ret_track_buffer: .space 16, 0               @ Return buffer to store retreived track record  

@ .align 4
@     scanf_ind:  .space 4,0          @ input buffer for scanf %d
@     scanf_inf:  .single 0.0         @ input buffer for scanf %f floats

.word @32bit align for strings

    b_status_str:           .asciz "\nBuffer status: [%d]; Head_offset:[+%d]; tail_offset: [+%d]; size/total_capacity: %d of %d\n"
    b_str_write_full:       .asciz "\n [!] WRITE FAILED - buffer full\n"
    b_str_empty:            .asciz "\n [!] READ FAILED - buffer empty\n"


