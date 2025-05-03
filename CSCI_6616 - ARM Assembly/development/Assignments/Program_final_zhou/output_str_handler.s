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
    /// \ Enqueues the fire record into the cicular buffer, will overwrite wrap around after 20 inputs
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
    LDR R4, =fq_last_tail
    STR R0, [R4]
    // Setup snprintf 
    MOV R1, #FQ_RECORD_SiZE         @ set size of write
    MOV R2, R9                      @ copy address of encoded track fire data
    BL snprintf

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

 
    POP {R4-R12, LR}
    BX LR


pop_fire_queue:
    /// \ Pop/dequeues the fire queue record from the circular queue 
    /// and updates the head
    /// \ Returns R0: Last retrieved record
    PUSH {R4-R12, LR}

    LDR R0, =fq_curr_size           @ check if queue empty
    LDR R3, [R0]
    CMP R3, #0
    BEQ fq_read_empty               @ if empty, quit

    LDR R0, =fq_head
    LDR R7, [R0]                    @ load the current head offset
    LDR R0, =fire_queue
    ADD R0, R0, R7                  @ add fire_queue +head offset to get read address
    LDR R1, =fq_head_last_fired
    STR R0, [R1]                    @ save the last fired address

    // R0 is set as fq+offset to write
    // Print the data out and save the current record in str_encoded to be returned (if needed)
    PUSH {R0, R1}                   @ save these address for after
    MOV R2, R0                      @ copy the record to R2
    MOV R1, R0                      @ copy this address to be printed out as %x
    LDR R0, =fq_send_fire_str 
    BL printf
    
    LDR R0, =str_encoded
    MOV R1, #FQ_RECORD_SiZE
    MOV R2, R0                      @ copy the current record @R0 into R2 
    BL snprintf
    POP {R0, R1}                    @ retrieve bufferOffset address


    // Delete the record 
    // R0 is already set to write address
    MOV R1, #FQ_RECORD_SiZE         @ set the write size
    LDR R2, =fq_str_empty_slot      @ set the output string
    BL snprintf

    // Increment head size
    ADD R7, #FQ_RECORD_SiZE         @ increment the headsize by +128bytes(+1 slot)
    LDR R0, =fq_head
    STR R7, [R0]                    @ write the new head offset to memory

    LDR R0, =fq_curr_size            @ decrement current size counter
    LDR R6, [R0]
    SUB R6, #1
    STR R6, [R0]                    @ save new value in memory 

    LDR R0, =str_encoded            @ return R0 the current popped fire record
    
    POP {R4-R12, LR}
    BX LR


peek_fire_queue:
    /// \prints out all records in the fire queue

    PUSH {R4-R12, LR}
    // Load head address and print all records 
    LDR R9, =fire_queue                 @ R9 = fire queue start address
    LDR R0, =fq_head                    @ retrieve current head position
    LDR R4, [R0]
    ADD R5, R9, R4                      @ R5 = current head 
    ADD R8, R9, #FQ_CAPACITY_BYTES      @ R8 = fire queue end address
    MOV R7, R9                          @ R7 = current firequeue address
    MOV R6, #0                          @ current counter
    LDR R0, =fq_last_tail           
    LDR R4, [R0]                        @ get last tail write address

  fq_loop:
    CMP R7, R8                          @ check if we reached the end
    BEQ fq_loop_done
    LDR R0, =fq_str_peek_info
    MOV R1, R6                          @ arg1: output counter
    MOV R2, R7                          @ arg2: current print address
    MOV R3, R7                          @ arg3: current string record
    BL printf
    CMP R7, R5                          @ check if this is head
    LDREQ R0, =fq_head_lbl              @ print head label
    BLEQ printf
    CMP R7, R4
    LDREQ R0, =fq_last_tail_lbl         @ print last tail written label
    BLEQ printf
    LDR R0, =fq_new_line                @ print '\n'
    BL printf
    
    ADD R7, R7, #FQ_RECORD_SiZE        @ increment current address +128 for next record
    ADD R6, #1                          @ increment loop counter
    B fq_loop

    


fq_read_empty:
    PUSH {R4-R12, LR}
    LDR R0, =fq_str_empty
    BL printf
    POP {R4-R12, LR}
    B b_tx_done
    
fq_loop_done:
    POP {R4-R12, LR}
    BX LR



.data
.word
    str_push_msg:        .asciz "Enqueue fire data @ - "
    str_data_fmt:        .asciz "{TARGET#: %d}{AZIMUTH: %.2f}{ELEVATION: %.2f}{FIRE @ %f}"
    fq_str_empty:        .asciz "\n [!] No fire records found - buffer empty\n"
    fq_str_pop:          .asciz "[+] Fire issued @: 0x%x; %s\n"
    fq_str_empty_slot:   .asciz "[ Empty Slot ]"
    fq_str_peek_info:    .asciz "%d) @0x%x: %s"
    fq_str_current_head:  .asciz "\n\nFire queue records: "
    fq_head_lbl:          .asciz " ->[HEAD]"
    fq_last_tail_lbl:    .asciz " ->[Last TAIL written]"
    fq_new_line:         .asciz "\n"
    fq_send_fire_str:    .asciz "\n[>] Sending fire record@: 0x%x -  %s \n\n"

.align 4
    fire_queue:    .space FQ_CAPACITY_BYTES, 0    @ reserve 20 * 128bytes for fire string output
    str_encoded:    .space 128, 0                  @ string to store encoded string data
    fq_curr_size:   .word 0
    fq_head:        .word 0
    fq_head_address: .word 0
    fq_head_last_fired: .word 0
    fq_tail:        .word 0
    fq_last_tail:    .word 0
    convert_d_buffer:   .double 0.0
