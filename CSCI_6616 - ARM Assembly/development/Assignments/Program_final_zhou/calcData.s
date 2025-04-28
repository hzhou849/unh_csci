/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou

    File: calcData.s

    Description:
        - Calculate the Fire delay with track data from circular queue. 
        
    Data Format: each track contains:
        - Target#:  2byte
        - Track#:   2byte
        - Range:    4bytes, 32-bit
        - Azimuth:  float 4bytes
        - Elevation: float 4 bytes
        Total = 16bytes per track = 200tracks * 16bytes = 3200 bytes size in memory

    
    Local Registers:
        R4
        R5
        R6
        R7
        R8
        R9

    Returns: 
        R0 - Status 0=ok; 1=error range is negative no fire data

 * ==========================================================================================
 */

 .global calc_track_data
 .section .text

calc_track_data:
    PUSH {R4-R12, LR}               @ save caller data to stack
    //  get track[1] data
    // \Call qBuffer::read_queue
    // \Returns R0 - address to ret_track_buffer
    BL read_queue                       @ Get track 1; Returns R0=ret_track_buffer
    LDRH R4, [R0, #OFFSET_TARGET]
    LDRH R5, [R0, #OFFSET_TRACKNUM]
    LDR R6,  [R0, #OFFSET_RANGE]
    VMOV S7, R6                         @ convert range to float
    VCVT.f32.s32 S7, S7
    VLDR.f32 S8, [R0, #OFFSET_AZIMUTH]
    VLDR.f32 S9, [R0, #OFFSET_ELEVATION]



    //  get track[2] data
    BL read_queue                       @ Get track 2; Returns R0=ret_track_buffer
    LDRH R7, [R0, #OFFSET_TARGET]
    LDRH R8, [R0, #OFFSET_TRACKNUM]
    LDR R9,  [R0, #OFFSET_RANGE]
    VMOV S10, R9                         @ convert range to float
    VCVT.f32.s32 S10, S10
    VLDR.f32 S11, [R0, #OFFSET_AZIMUTH]
    VLDR.f32 S12, [R0, #OFFSET_ELEVATION]

    // save necessary data if needed for later
    LDR R0, =t2_target
    STRH R7, [R0]                       @ Save this target number
    LDR R0, =t2_azimuth
    VSTR.f32 S11, [R0]                  @ save t2 Azimuth value
    LDR R0, =t2_elevation
    VSTR.f32 S12, [R0]                  @ save t2 elevation value
    

    // Check if track data is correct?
    CMP R4, R7        @ Make sure the 2 track records match, if not, return bad data pair
    BNE bad_pair       

    // Registers used      
    // R4: T1 Target num *
    // R5: T1 Track num  *
    // R6: T1 range      * 
    // S7: T1 range float
    // S8: T1 azimuth
    // S9: T1 elevation
    //
    // R7: T2 target num  
    // R8: T2 track num   *
    // R9: range          *
    // S10: range float
    // S11: T2 azimuth
    // S12: T2 elevation 

    


    /// \First track 1
    // S1: T1 azimuth radian
    // S2: T1 elevation radian
    // S7: T1 Range
    
    // step 1 - convert azimuth and elevation to rads for calcuation (degree * (pi /180))
    // Convert azimuth elevation to radians
    LDR R0, =rad_convert_val            @ load radian conversion constant
    VLDR.f32 S0, [R0]                   @ S0 = 0.017453292 (pi/180)
    VMUL.f32 S1, S8, S0                 @ S1 =  t1_azimuth * rad_convert_val
    VMUL.f32 S2, S9, S0                 @ S2 = t1_eleveation * rad_convert_val


    // step 2: Calculate position (X, Y, Z axis) for both tracks
    // Z = Range * sin(elevation)
    // Y = Range * cos(elevation) * sin(Azimuth)
    // X = Range * cos(elevation) * cos(Azimuth)

    // Z1= Range* sin(elevation)
                                        @ Find sin(elevation)
    VMOV.f32 S0, S2                     @ copy T1 elevation into S0 for function arg
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VMUL.f32 S3, S7, S0                 @ Find Z; S3 = S7 * S0
    LDR R0, =Z1           
    VSTR.f32 S3, [R0]                   @ Save Z1 in memory to free up registers

    // Y1 = Range*cos(elevation) * sin(Azimuth)
                                        @ Find cos(elevation)
    VMOV.f32 S0, S2                     @ copy T1 elevation into S0 for arg
    BL get_cos                          @ call taylor.s::get_cos(S0); returns S0=result
    VMOV.f32 S3, S0                     @ move cos(elevation) to s3
                                        @ Solve sin(Azimuth)
    VMOV.f32 S0, S1                     @ copy T1 Azimuth into S0 for arg passing            
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VMUL.f32 S4, S3, S0                 @ S4 = cos(elevation) * sin(Azimuth)
    VMUL.f32 S5, S7, S4                 @ S5 = Range * S4
    LDR R0, =Y1 
    VSTR.f32 S5, [R0]                   @ Save Y1 in memory to free up registers


    // X1 = Range * cos(elevation) * cos(Azimuth)
                                        @ Solve cos(elevation)
    VMOV.f32 S0, S2                     @ copy T1 elevation into S0 for arg passing
    BL get_sin                          @ call taylor.s::get_cos(S0); returns S0=result
    VMOV.f32 S3, S0                     @ Move cos(elevation) into S3 
    VMOV.f32 S0, S1                     @ solve cos(Azimuth)
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VMUL.f32 S4, S3, S0                 @ S4 = cos(elevation) * cos(Azimuth)
    VMUL.f32 S5, S7, S4                 @ S5 = T1_Range * S4
    LDR R0, =X1
    VSTR.f32 S5, [R0]                   @ save X1 to memory to free up registers

    /// \Second track 2
    // S1: T1 azimuth radian
    // S2: T1 elevation radian
    // S10: T2 Range
    // Convert azimuth elevation to radians

    LDR R0, =rad_convert_val            @ load radian convertsion
    VLDR.f32 S0, [R0]                   @ S0 = 0.017453292 (pi/180)
    VMUL.f32 S1, S11, S0                @ T2 Azimuth radians
    VMUL.f32 S2, S12, S0                @ T2 elevation radians

    // Z2= Range* sin(elevation)
    VMOV.f32 S0, S2                     @ copy T2 elevation into S0 for function arg
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VMUL.f32 S3, S10, S0                @ Find Z2; S3 = S10 * S0
    LDR R0, =Z2           
    VSTR.f32 S3, [R0]                   @ Save Z2 in memory to free up registers

    // Y2=Range*cos(elevation) * sin(Azimuth)
                                        @ Find cos(elevation)
    VMOV.f32 S0, S2                     @ copy T2 elevation into S0 for arg
    BL get_cos                          @ call taylor.s::get_cos(S0); returns S0=result
    VMOV.f32 S3, S0                     @ move cos(elevation) to S3
    VMOV.f32 S0, S1                     @ Solve sin(Azimuth)
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VMUL.f32 S4, S3, S0                 @ S4 = cos(elevation) * cos(Azimuth)
    VMUL.f32 S5, S10, S4                @ S5 = T2_Range * S4
    LDR R0, =Y2
    VSTR.f32 S5, [R0]                   @ save Y2 into memory

    // X2 = Range * cos(elevation) * cos(Azimuth)
                                        @ Solve cos(elevation)
    VMOV.f32 S0, S2                     @ copy T2 elevation into S0 for arg passing
    BL get_sin                          @ call taylor.s::get_cos(S0); returns S0=result
    VMOV.f32 S3, S0                     @ Move cos(elevation) into S3 
    VMOV.f32 S0, S1                     @ solve cos(Azimuth)
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VMUL.f32 S4, S3, S0                 @ S4 = cos(elevation) * cos(Azimuth)
    VMUL.f32 S5, S10, S4                 @ S5 = T2_Range * S4
    LDR R0, =X2
    VSTR.f32 S5, [R0]                   @ save X1 to memory to free up registers
    


    // step 3: Calculate velocity (Vx, Vy, Vz)
    // Vx = (X2 - X1) / 1 = m/s
    // Vy = (Y2 - Y1) / 1 = m/s
    // Vz = (X2 - X1) / 1 = m/s
    //
    // Total speed: V = sqrt( Vx^2 + Vy^2 + Vz^2) = 2826m/s


    // Step 4: Distance to engagement Zone
    // Assume missle launches from (0,0,0)
    // D = Sqrt(X^2 + Y^2 + Z^2) >= 100,000 otherwise it is already inside the engagement zone
    // Engagement zone is 100,000m or 100km
    // d_edge = D - 100,000 = 105,000 - 100,000 = -5000m
    // negative means target it already inside the engagment zone
    // 

    // Step 5: Caclulate the time to intercept
    // T = d_edge / V  = xSeconds
    //
    // The Stark Viper travels 10km/s meaning in order to reach 100km
    // it will require 10seconds
    //
    // Engagement time = T - 10 = 1.77s - 10s = -8.23seconds
    // *Negative means its already inside and too late to fire

    // Output: {TARGET#: 1}{AZIMUTH:46.00}{ELEVATION: 30.50}{FIRE @ x.x}
bad_pair:
    MOV R0, #1          @ return R0=1 : bad data error

exit_calc:
    POP {R4-R12, LR}
    BX LR 




 .data
 .align 4
    rad_convert_val:        .single 0.017453292     @ angle * rad_convert_val = radians
    double_buffer2:  .double 0.0
    @ t1_target:      .word 0
    @ t1_track_num:   .word 0
    @ t1_range:       .single 0.0
    @ t1_azimuth:     .single 0.0
    @ t1_elevation:   .single 0.0
    X1:             .single 0.0
    Y1:             .single 0.0
    Z1:             .single 0.0

    X2:             .single 0.0
    Y2:             .single 0.0
    Z2:             .single 0.0
    

    t2_target:      .word 0
    t2_track_num:   .word 0
    t2_range:       .single 0.0
    t2_azimuth:     .single 0.0
    t2_elevation:   .single 0.0

.word @32 bit 
    test_print: .asciz "Target: %d; Track: %d; Range: %d; Azimuth: %f; Elevation %f\n"



    
    



