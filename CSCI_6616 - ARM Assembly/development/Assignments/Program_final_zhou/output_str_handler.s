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
    PUSH {R4-R12, LR}               @ backup current registers

    POP {R4-R12, LR}                
    BX LR

push_fire_queue:

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

    // encode data into temp buffer

    // write the data at offset R8(tail)




.data
.align 4
    buffer:         .space FQ_CAPACITY_BYTES, 0      @ reserve 20 * 128bytes for fire string output
    fq_curr_size:   .word 0
    fq_head:        .word 0
