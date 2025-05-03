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


    Returns: 
        R0 - Status 0=ok; 1=error range is negative no fire data
        R1 - last target
        S0 - last Azimuth
        S1 - last elevation
        S2 - fire engagement time

 * ==========================================================================================
 */

.EQU OFFSET_OUT_TARGET,     0
.EQU OFFSET_OUT_AZIMUTH,    4
.EQU OFFSET_OUT_ELEVATION,  8
.EQU OFFSET_OUT_FIRE,       12

 .global calc_track_data
 .section .text

calc_track_data:
    LDR R0, =calc_data_lr
    STR LR, [R0]                        @ Save LR to memory, more reliable
    
    //  get track[1] data
    // \Call qBuffer::read_queue
    // \Returns R0 - address to ret_track_buffer
    BL read_queue                       @ Get track 1; Returns R0=ret_track_buffer
    PUSH {R0}                           @save this R0 address 
    MOV R5, R0                          @ save this address for printf below
    LDR R0, =dequeue_str                @ print dequeue message
    LDR R2, =b_head_address
    LDR R1, [R2]                        @ get the last head address
    LDRH R2, [R5, #OFFSET_TARGET]
    LDRH R4, [R5, #OFFSET_TRACKNUM]
    MOV R3, R4
    BL printf
    POP {R0}

    LDRH R4, [R0, #OFFSET_TARGET]
    LDRH R5, [R0, #OFFSET_TRACKNUM]
    LDR R6,  [R0, #OFFSET_RANGE]
    VMOV S7, R6                         @ convert range to float
    VCVT.f32.s32 S7, S7
    VLDR.f32 S8, [R0, #OFFSET_AZIMUTH]
    VLDR.f32 S9, [R0, #OFFSET_ELEVATION]



    //  get track[2] data
    BL read_queue                       @ Get track 2; Returns R0=ret_track_buffer
     PUSH {R0}                           @save this R0 address 
    MOV R5, R0                          @ save this address for printf below
    LDR R0, =dequeue_str                @ print dequeue message
    LDR R2, =b_head_address
    LDR R1, [R2]                        @ get the last head address
    LDRH R2, [R5, #OFFSET_TARGET]
    LDRH R3, [R5, #OFFSET_TRACKNUM]
    BL printf
    POP {R0}

    LDRH R7, [R0, #OFFSET_TARGET]
    LDRH R8, [R0, #OFFSET_TRACKNUM]
    LDR R9,  [R0, #OFFSET_RANGE]
    VMOV S10, R9                         @ convert range to float
    VCVT.f32.s32 S10, S10
    VLDR.f32 S11, [R0, #OFFSET_AZIMUTH]
    VLDR.f32 S12, [R0, #OFFSET_ELEVATION]

    // save necessary data if needed for later
    LDR R0, =last_target
    STRH R7, [R0]                       @ Save this target number
    LDR R0, =last_azimuth
    VSTR.f32 S11, [R0]                  @ save t2 Azimuth value
    LDR R0, =last_elevation
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
    
    // Part 1 - convert azimuth and elevation to rads for calcuation (degree * (pi /180))
    // Convert azimuth elevation to radians
    LDR R0, =rad_convert_val            @ load radian conversion constant
    VLDR.f32 S0, [R0]                   @ S0 = 0.017453292 (pi/180)
    VMUL.f32 S1, S8, S0                 @ S1 =  t1_azimuth * rad_convert_val
    VMUL.f32 S2, S9, S0                 @ S2 = t1_eleveation * rad_convert_val

    // Part 2: Calculate position (X, Y, Z axis) for both tracks
    // Z = Range * sin(elevation)
    // Y = Range * cos(elevation) * sin(Azimuth)
    // X = Range * cos(elevation) * cos(Azimuth)

    // Z1= Range* sin(elevation)
                                        @ Find sin(elevation)
    VMOV.f32 S0, S2                     @ copy T1 elevation into S0 for function arg
    VPUSH.f32 {S1, S2}                  @ save azimuth/elevation radian values
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VPOP.f32 {S1, S2}                   @ restore azimuth/elevation radian values
    VMUL.f32 S3, S7, S0                 @ Find Z; S3 = S7 * S0
    LDR R0, =Z1           
    VSTR.f32 S3, [R0]                   @ Save Z1 in memory to free up registers

    // Y1 = Range*cos(elevation) * sin(Azimuth)
                                        @ Find cos(elevation)
    VMOV.f32 S0, S2                     @ copy T1 elevation into S0 for arg
    VPUSH.f32 {S1, S2}                  @ save azimuth/elevation radian values
    BL get_cos                          @ call taylor.s::get_cos(S0); returns S0=result
    VPOP.f32 {S1, S2}                   @ restore azimuth/elevation radian values
    VMOV.f32 S3, S0                     @ move cos(elevation) to s3
                                        @ Solve sin(Azimuth)
    VMOV.f32 S0, S1                     @ copy T1 Azimuth into S0 for arg passing
    VPUSH.f32 {S1, S2}                  @ save azimuth/elevation radian values            
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VPOP.f32 {S1, S2}                   @ restore azimuth/elevation radian values
    VMUL.f32 S4, S3, S0                 @ S4 = cos(elevation) * sin(Azimuth)
    VMUL.f32 S5, S7, S4                 @ S5 = Range * S4
    LDR R0, =Y1 
    VSTR.f32 S5, [R0]                   @ Save Y1 in memory to free up registers


    // X1 = Range * cos(elevation) * cos(Azimuth)
                                        @ Solve cos(elevation)
    VMOV.f32 S0, S2                     @ copy T1 elevation into S0 for arg passing
    VPUSH.f32 {S1, S2}
    BL get_cos                         @ call taylor.s::get_cos(S0); returns S0=result
    VPOP.f32 {S1, S2}
    VMOV.f32 S3, S0                     @ Move cos(elevation) into S3 
    VMOV.f32 S0, S1                     @ solve cos(Azimuth)
    VPUSH.f32 {S1, S2}
    BL get_cos                          @ call taylor.s::get_sin(S0); returns S0=result
    VPUSH.f32 {S1, S2}
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
    VPUSH.f32 {S1, S2}
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VPOP.f32 {S1, S2}
    VMUL.f32 S3, S10, S0                @ Find Z2; S3 = S10 * S0
    LDR R0, =Z2           
    VSTR.f32 S3, [R0]                   @ Save Z2 in memory to free up registers

    // Y2=Range*cos(elevation) * sin(Azimuth)
                                        @ Find cos(elevation)
    VMOV.f32 S0, S2                     @ copy T2 elevation into S0 for arg
    VPUSH.f32 {S1, S2}
    BL get_cos                          @ call taylor.s::get_cos(S0); returns S0=result
    VPOP.f32 {S1, S2}
    VMOV.f32 S3, S0                     @ move cos(elevation) to S3
    VMOV.f32 S0, S1                     @ Solve sin(Azimuth)
    VPUSH.f32 {S1, S2}
    BL get_sin                          @ call taylor.s::get_sin(S0); returns S0=result
    VPOP.f32 {S1, S2}
    VMUL.f32 S4, S3, S0                 @ S4 = cos(elevation) * cos(Azimuth)
    VMUL.f32 S5, S10, S4                @ S5 = T2_Range * S4
    LDR R0, =Y2
    VSTR.f32 S5, [R0]                   @ save Y2 into memory

    // X2 = Range * cos(elevation) * cos(Azimuth)
                                        @ Solve cos(elevation)
    VMOV.f32 S0, S2                     @ copy T2 elevation into S0 for arg passing
    VPUSH.f32 {S1, S2}
    BL get_cos                          @ call taylor.s::get_cos(S0); returns S0=result
    VPOP.f32 {S1, S2}
    VMOV.f32 S3, S0                     @ Move cos(elevation) into S3 
    VMOV.f32 S0, S1                     @ solve cos(Azimuth)
    VPUSH.f32 {S1, S2}
    BL get_cos                          @ call taylor.s::get_sin(S0); returns S0=result
    VPOP.f32 {S1, S2}
    VMUL.f32 S4, S3, S0                 @ S4 = cos(elevation) * cos(Azimuth)
    VMUL.f32 S5, S10, S4                 @ S5 = T2_Range * S4
    LDR R0, =X2
    VSTR.f32 S5, [R0]                   @ save X1 to memory to free up registers
    


    // Part 3: Calculate velocity (Vx, Vy, Vz)
    // Vx = (X2 - X1) / 1 = m/s
    // Vy = (Y2 - Y1) / 1 = m/s
    // Vz = (X2 - X1) / 1 = m/s
    // Total speed: V = sqrt( Vx^2 + Vy^2 + Vz^2) = m/s

    
    // Load X1, Y1, Z1 data
    LDR R0, =X1
    VLDR.f32 S1, [R0]                   @ Load S1 = X1
    LDR R0, =Y1
    VLDR.f32 S2, [R0]                   @ load S2 = Y1
    LDR R0, =Z1
    VLDR.F32 S3, [R0]                   @ load S3 = Z1

    // Load X2, Y2, Z2 data
    LDR R0, =X2
    VLDR.f32 S4, [R0]                   @ load S4 = X2
    LDR R0, =Y2
    VLDR.f32 S5, [R0]                   @ load S5 = Y2
    LDR R0, =Z2
    VLDR.f32 S6, [R0]                   @ load S6 = Z2

    // Division is skipped, since we are just dividing by 1 for all velocities
    // Vx = (X2 - X1) / 1 = m/s; 
    VSUB.f32 S0, S4, S1
    LDR R0, =Vx
    VSTR.f32 S0, [R0]                   @ store Vx into memory
    VPUSH.f32 {S0}                      @ push Vx into stack for calcuation later

    // Vy = (Y2 - Y1) / 1 = m/s
    VSUB.f32 S0, S5, S2
    LDR R0, =Vy
    VSTR.f32 S0, [R0]                   @ store Vy into memory
    VPUSH.f32 {S0}                      @ push Vy into stack 

    // Vz = (X2 - X1) / 1 = m/s
    VSUB.f32 S0, S6, S3
    LDR R0, =Vz
    VSTR.f32 S0, [R0]                   @ store Vz into memory
    VPUSH.f32 {S0}                      @ push Vz into stack 

    //V = sqrt( Vx^2 + Vy^2 + Vz^2) = m/s
    
    VPOP.f32 {S3}                       @ retrieve Vz = S3 from stack
    VPOP.f32 {S2}                       @ retrieve Vy = S3 from stack
    VPOP.f32 {S1}                       @ retrieve Vx = S3 from stack

    VMUL.f32 S4, S1, S1                 @ S4 = Vx^2
    VMUL.f32 S5, S2, S2                 @ S5 = Vy^2
    VMUL.f32 S6, S3, S3                 @ S6 = Vz^2

    VADD.f32 S0, S4, S5                 @ S0 = Vx^2 + Vy^2
    VADD.f32 S0, S0, S6                 @ S0 += Vz^2
    VSQRT.f32 S0, S0                    @ get sqrt(S0)
    LDR R0, =calc_velocity
    VSTR.f32 S0, [R0]                   @ save V into memory
    


    // Part 4: Distance to engagement Zone
    // Assume missle launches from (0,0,0)
    // Using the last position (Lx, Ly, Lz) in this case X2, Y2, Z2
    // Distance between two points = Sqrt(LX^2 + LY^2 + LZ^2) 
    // if >= 100,000 otherwise it is already inside the engagement zone
    // Engagement zone is 100,000m or 100km
    // ie. distance from enagement edge = D - 100,000 = 118000 - 100,000 = 18000m
    // NOTE: negative means target it already inside the engagment zone
    

    // retrieve X2, Y2, Z2 from memory
    // Load X2, Y2, Z2 data
    LDR R0, =X2
    VLDR.f32 S1, [R0]                   @ load S4 = X2
    LDR R0, =Y2
    VLDR.f32 S2, [R0]                   @ load S5 = Y2
    LDR R0, =Z2
    VLDR.f32 S3, [R0]                   @ load S6 = Z2

    // Calculate Distance of closest point to engagement zone
    // Distance to engagement zone = sqrt(X2^2 + Y2^2 + Z^2) - R
    // R = Engagment zone is 100,000m or 100km
    VMUL.f32 S4, S1, S1                 @ S4 = X2^2
    VMUL.f32 S5, S2, S2                 @ S5 = Y2^2
    VMUL.f32 S6, S3, S3                 @ S6 = Z2^2

    VADD.f32 S0, S4, S5                 @ S0 = S4 + S5
    VADD.f32 S0, S0, S6                 @ S0 += S6
    VSQRT.f32 S0, S0                    @ sqrt(S0)

    LDR R0, =engagement_zone_m          @ load engagementzone distance
    VLDR.f32 S1, [R0]                   @ from memory (100,000m) 

    VSUB.f32 S2, S0, S1                 @ S2= engageDistance - ClosestXYZ meters
    LDR R0, =d_to_edge                  
    VSTR.f32 S2, [R0]                   @ store distance to edge to memory



    // Step 5: Caclulate the time to intercept
    // T = d_to_edge / calc_velocity  = xSeconds
    // The Stark Viper travels 10km/s meaning in order to reach 100km
    // it will require 10seconds
    // Engagement time = T - 10 = xs - 10s = x seconds
    // *Negative means its already inside and too late to fire

    LDR R0, =d_to_edge
    VLDR.f32 S1, [R0]                   @ load S1 = distance to edge value
    LDR R0, =calc_velocity
    VLDR.f32 S2, [R0]                   @ load S2 = calculated velocity 

    // T = d_to_edge(m)/calc_velocity(m/s) = x seconds
    VDIV.f32 S0, S1, S2                 @ s0 = s1/s2

    // Engagement time of the Stark viper is 10s to reach engagement zone (100km)
    LDR R0, =stark_viper_engage_time
    VLDR.f32 S3, [R0]
    VSUB.f32 S0, S0, S3                 @ Engagement time S0 = T - 10sec
    LDR R0, =engagement_t
    VSTR.f32 S0, [R0]                   @ store engagment time to memory
    B prep_ret_data




/// \Return values:
/// \R0 - status; 0=okay; 1=bad data  
/// \R1 - Target num
/// \S0 - Azimuth
/// \S1 - Elevation
/// \S2 - Fire engagement time

bad_pair:
/// \Sets R1 Return code to 1 and zeros out all  all return registers R0,R1 S0-S2
    MOV R0, #1        @ return R0=1 : bad data error
    MOV R1, #0
    VMOV.f32 S0, R1 
    VCVT.f32.s32 S0, S0
    VMOV.f32 S1, R1
    VCVT.f32.s32 S1, S1
    VMOV.f32 S2, R1
    VCVT.f32.s32 S2, S2
    B exit_calc       

prep_ret_data:  
/// \Prepare the return data in proper return registers

    LDR R0, =last_target
    LDR R1, [R0]            @ R1 = Retrieve this target number
    LDR R0, =last_azimuth
    VLDR.f32 S0, [R0]       @ S0 = retrieve last azimuth
    LDR R0, =last_elevation 
    VLDR.f32 S1, [R0]       @ S1 = retrieve last eleveation
    LDR R0, =engagement_t
    VLDR.f32 S2, [R0]       @ s2 = fire engagement time
    MOV R0, #0              @ set R0 = return code ok
    B exit_calc

exit_calc:
    // Output: {TARGET#: 1}{AZIMUTH:46.00}{ELEVATION: 30.50}{FIRE @ x.x}
    LDR R4, =calc_data_lr
    LDR LR, [R4]            @ Restore LR from memory
    BX LR 


 .data
    dequeue_str: .asciz "Retrieving data from input buffer @: %x for target: %d; track: %d\n"

 .align 4
    // constant values
    calc_data_lr: .word 0                       @ Store LR pointer address
    rad_convert_val:    .single 0.017453292      @ angle * rad_convert_val = radians
    engagement_zone_m:  .single 100000.0         @ enagagement zone distance (meters)
    stark_viper_engage_time: .single 10.0         @ missle travels 10km/s so 10secs = 100km
    double_buffer2:     .double 0.0

    // Track 1 coordinates
    X1:             .single 0.0
    Y1:             .single 0.0
    Z1:             .single 0.0

    // Track 2 coordinates
    X2:             .single 0.0
    Y2:             .single 0.0
    Z2:             .single 0.0

    // Velocities variables
    Vx:             .single 0.0
    Vy:             .single 0.0
    Vz:             .single 0.0

    calc_velocity:   .single 0.0
    d_to_edge:       .single 0.0
    engagement_t:     .single 0.0
    
    // last track record data
    last_target:      .word 0
    last_track_num:   .word 0
    last_range:       .single 0.0
    last_azimuth:     .single 0.0
    last_elevation:   .single 0.0

.word @32 bit 
   



    
    



