/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou

    File: output_data_handler.s

    Description:
        - Takes fire data and encodes into output string buffer
        - Enqueues into fire queue
        - Allows read functionality to see what is written in the queue
        - {TARGET#: %d}{AZIMUTH: %.2f}{ELEVATION: %.2f}{FIRE @ %f}\n


    Data Format: each track contains:
        - An array of 128bytes * 20 slots

    Assigned Registers:
    
    Input registers:
        param[in] R1 - last target
        param[in] S0 - last Azimuth
        param[in] S1 - last elevation
        param[in] S2 - fire engagement time

    Returns :
        R0 = memory address of stored parsed track record
 * ==========================================================================================
 */

.EQU FQ_RECORD_SiZE,     128          @ Each element in buffer is 128bytes
.EQU FQ_CAPACITY_SIZE,    20          @ Total of 20 slots 
.EQU FQ_CAPACITY_BYTES, 2560          @ 20 slots * 128 = 2560 bytes

.global push_fire_queue, read_fire_queue
.section .text

encode_fire_data:
/// \ take the data values and encodes it into the fire format
/// "{TARGET#: %d}{AZIMUTH: %.2f}{ELEVATION: %.2f}{FIRE @ %f}\n"
/// \param[in] R1 - last target
/// \param[in] S0 - last Azimuth
/// \param[in] S1 - last elevation
/// \param[in] S2 - fire engagement time
///
/// \Return: R0 address of encoded str buffer

    PUSH {R4-R12, LR}               @ backup current registers
    
    // Move value to unassigned registers to free up required reg
    MOV R3, R1                      @ Move target_num to R3 for first ouput arg
    VMOV.f32 S10, S0                @ move Azimuth to S10
    VMOV.f32 S11, S1                @ move elevation to S11
    VMOV.f32 S12, S2                @ move fire engage time to S12
    
    // Load S10 Azimuth for write
    VCVT.f64.f32 D0, S10            @ printf requires floats be doubles
    LDR R0, =convert_d_buffer       @ temp buffer to hold float for conversion
    VSTR.f64 D0, [R0]               @ write double to memory
    LDM R0, {R4, R5}                @ load double spread into 2x32bit regs R4 & R5
                                    @ doubles are reg pairs {0,1}, {2,3}
                                    @ After R3, printf requires these values pushed
                                    @ into the stack 
    // Load S11 elevation
    VCVT.f64.f32 D1, S11
    LDR R0, =convert_d_buffer 
    VSTR.f64 D1, [R0]
    LDM R0, {R6, R7}

    // Load S12 Fire engagement time
    VCVT.f64.f32 D2, S12          
    LDR R0, =convert_d_buffer      
    VSTR.f64 D2, [R0]              
    LDM R0, {R8, R9}                

    
    // Push in reverse order into stack for printf
    PUSH {R8, R9}                   @ stack if LIFO push arg6 first
    PUSH {R6, R7}                   @ stack if LIFO push arg5 first
    PUSH {R4, R5}                   @ push arg4 (this is read first)

    LDR R0, =str_encoded            @ output buffer for R2 string
    MOV R1, #FQ_RECORD_SiZE         @ size of this write
    LDR R2, =str_data_fmt           @ the string to write
    BL snprintf

    // Delete or pop prior data from stack
    @ POP {R8, R9}
    @ POP {R6, R7}
    @ POP {R4, R5}
    ADD SP, SP, #24                 @ delete 4bytes*6 =24 bytes of data from stack

    POP {R4-R12, LR}       
    LDR R0, =str_encoded            @ set the return value R0 = str_encoded address         
    BX LR

push_fire_queue:
    /// \param[in] R0: String of encoded fire data

    PUSH {R4-R12, LR}               @ backup current registers
    MOV R9, R0                      @ copy address of fire track record buffer

    // Get current specs
    LDR R0, =fq_curr_size           
    LDR R3, [R0]                    @ copy current size in R3
    LDR R0, =fq_head               
    LDR R7, [R0]                    @ R7 =get current head index

    // Calculate Tail offset to write  = [( Head + currentSize ) % total_capacity] * TrackSize
    LSL R3, R3, #7                  @ get currentSize in bytes = multiply size slots *string_Size(128b); 
                                    @ left shit 7= *128
    ADD R8, R7, R3                  @ head + (current_size *128)
    MOV R0, R8                      @ curPosition(dividend)
    MOV R1, #FQ_CAPACITY_SIZE       @ capcity_slots(divisor)
    LSL R1, R1, #7                  @ Multiply capacity(slots) by 128  to get total bytes
    BL modN                         @ returns tail(R0)=remainder value
    MOV R8, R0                      @ copy tail offset mod into R8, this is the offset we need
    LDR R0, =fq_tail
    STR R8, [R0]                    @ backup the tail data


    // enqueue data at offset R8(tail) to fire queue
    LDR R0, =fire_queue              @ load the fire queue buffer
    ADD R0, R0, R8                  @ set R0= fire_queue + tail_offset
    // Setup snprintf 
    MOV R1, #FQ_RECORD_SiZE         @ set size of write
    MOV R2, R9                      @ copy address of encoded track fire data
    BL snprintf

    /// TODO: *** check memory is written correctly
    LDR R0, =str_push_msg
    BL printf
    LDR R0, =fire_queue
    ADD R0, R0, R8                  @ add the this tail offset
    BL debug_print_fire_record

    // Update the current size counter by +1 and store in memory
    LDR R0, =fq_curr_size
    LDR R6, [R0]
    ADD R6, #1
    STR R6, [R0]

    @ // Update tail to new position; Tail slot+1 = [(head+currentSize) % total_capacity] * 128bytes
    @ MOV R3, R6
    @ LSL R3, R3, #7                  @left shift by 7 = *128
    @ LDR R0, =fq_head
    @ LDR R7, [R0]                    @ get current head
    @ ADD R8, R7, R3                  @ tail = head + current size byte offset





    POP {R4-R12, LR}
    BX LR


    




.data
.word
    str_push_msg:        .asciz "Enqueue fire data @ - "
    str_data_fmt:        .asciz "{TARGET#: %d}{AZIMUTH: %.2f}{ELEVATION: %.2f}{FIRE @ %f}\n"

.align 4
    fire_queue:    .space FQ_CAPACITY_BYTES, 0    @ reserve 20 * 128bytes for fire string output
    str_encoded:    .space 128, 0                  @ string to store encoded string data
    fq_curr_size:   .word 0
    fq_head:        .word 0
    fq_tail:        .word 0
    convert_d_buffer:   .double 0.0
