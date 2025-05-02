## To use snprinf


```asm
menu_test_fire_print: 
    /// \R0 - status; 0=okay; 1=bad data  
    /// \R1 - Target num
    /// \S0 - Azimuth
    /// \S1 - Elevation
    /// \S2 - Fire engagement time
    PUSH {R4-R12, LR}

    VMOV.f32 S10, S0
    VMOV.f32 S11, S1
    VMOV.f32 S12, S2
    
    // R1 already is load arg1 target
    MOV R3, R1                          @snprintf starts  arg at R3

    // Load S0 Azimuth for write 
    VCVT.f64.f32 d0, s10                @ Printf requires floats to be doubles
    LDR R0, =double_buffer             @ temp double buffer to hold for conversion
    VSTR.f64 D0, [R0]                   @ write double to memory
    LDM R0, {R4, R5}                    @ load double spread into 2x32bit regs 4 &5

    // Load S1 Eleveation
    VCVT.f64.f32 d1, s11
    VSTR.f64 D1, [R0]
    LDM R0, {R6, R7}

    // Load S1 Eleveation
    VCVT.f64.f32 d2, s12
    VSTR.f64 D2, [R0]
    LDM R0, {R8, R9}


    PUSH {R8, R9}                       @ stack if LIFO PUSH  arg6 first
    PUSH {R6, R7}                       @ stack if LIFO PUSH  arg5 first
    PUSH {R4, R5}                       @ push arg4 (this is read first bc it is top)

    
   

    LDR R0, =str_buffer                 @ R0 = string buffer to write/store R2 into
    MOV R1, #128                       @ R1 = size of the write
    LDR R2, = str_fire                  @ R2 = the string to write
    bl snprintf


    LDR R0, =str_buffer                 @ R0 = string buffer to write/store R2 into
    ADD R0, #128
    MOV R1, #128                       @ R1 = size of the write
    MOV R3, #8
    LDR R2, = str_fire                  @ R2 = the string to write
    bl snprintf

    pop {R8, R9}
    POP {R6,R7}                        @ remove arg 5 from stack
    POP {R4,R5}                         @ remove arg 4 from stack 
    @ ADD SP, SP # 16                     @ Alternatively add 4*4bytes R4-R7 pushed into stack to delete 

 // Print buffer 1
    LDR R0, =str_buffer_addr
    LDR R1, =str_buffer                 @ get the buffer address of this record
    BL printf

    LDR R0, =str_buffer
    BL printf

    
    // print buffer 2
    LDR R0, =str_buffer_addr
    LDR R1, =str_buffer                 @ get the buffer address of this record
    ADD R1, #128                        @ +offset for string 2
    BL printf
    LDR R0, =str_buffer
    ADD R0, #128
    BL printf

    POP {R4-R12, LR}
    BX LR

.data
.word @ 32 bit align all variables
    str_buffer:          .space 256
    str_fire:           .asciz "{TARGET#: %d}{AZIMUTH: %.2f}{ELEVATION: %.2f}{FIRE @ %f}\n"
    str_buffer_addr:    .asciz "Buffer address: %x; "
```
