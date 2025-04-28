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

    // Check if track data is correct?
    CMP R4, R7        @ Make sure the 2 track records match, if not, return bad data pair
    BNE bad_pair            
    // step 1 - convert azimuth and elevation to rads for calcuation (degree * (pi /180))
    // R4: T1 Target num *
    // R5: T1 Track num  *
    // R6: t1 range      * 
    // S4: t1 range float
    // S5: t1 azimuth
    // S6: t1 azimuth
    //
    // R7: t2 target num  
    // R8: t2 track num   *
    // R9: range          *
    // S7: range float
    // S8: t2 azimuth
    // S9: t2 elevation 

    LDR R0, =rad_convert_val           @ load radian conversion constant
    VLDR.f32 S0, [R0]                   @ S0 = 0.017453292
    VMUL.f32 S1, S5, S0                 @ S1 =  t1_azimuth * rad_convert_val
    VMUL.f32 S2, S6, S0                 @ S2 = t1_eleveation * rad_convert_val




    
    // step 2: Calculate position (X, Y, Z axis) for both tracks
    // Z = Range * sin(elevation)
    // Y = Range * cos(elevation) * sin(Azimuth)
    // X = Range * cos(elevation) * cos(Azimuth)

    // step 3: Calculate velocity (Vx, Vy, Vz)
    // Vx = (x2 - X1) / 1 = m/s
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
    t1_target:      .word 0
    t1_track_num:   .word 0
    t1_range:       .single 0.0
    t1_azimuth:     .single 0.0
    t1_elevation:   .single 0.0

    t2_target:      .word 0
    t2_track_num:   .word 0
    t2_range:       .single 0.0
    t2_azimuth:     .single 0.0
    t2_elevation:   .single 0.0

.word @32 bit 
    test_print: .asciz "Target: %d; Track: %d; Range: %d; Azimuth: %f; Elevation %f\n"



    
    



