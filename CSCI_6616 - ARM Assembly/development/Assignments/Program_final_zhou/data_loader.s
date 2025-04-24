/* ==========================================================================================
    CSCI_6616 - ARM Assembly Programming
    Project: Final Project - Jarvis Tactical Data Processor
    Name: Howard Zhou

    File: data_loader.s

    Description:
        - Simulates the serial device to load incoming tracking data
        - Reads track_data.txt and loads data into a data buffer
        - {TARGET#: 1}{TRACK#: 0}{RANGE: 120000}{AZIMUTH: 45.00}{ELEVATION: 30.00}
        - Parser used to extract track data

    Data Format: each track contains:
        - Target#:  2byte
        - Track#:   2byte
        - Range:    4bytes, 32-bit
        - Azimuth:  float 4bytes
        - Elevation: float 4 bytes
        Total = 16bytes per track = 200tracks * 16bytes = 3200 bytes size in memory

    Input registers:
        R0 param[in] - pointer to input string track record

    Local Registers:
        R5 - Buffer status regsiter
        R6 - Current size
        R9 - Field category: 
           0 = target
           1 = track#
           2 = range
           3 = Azimuth
           4 = Elevation

 * ==========================================================================================
 */

.global load_data
.section .text

load_data:
    PUSH {R4-R12, LR}
    
    //  FILE *f = fopen ("input.txt", "r");
    LDR R0, =file_name
    LDR R1, =read_mode
    BL fopen                    @ create the file descripter
    MOV R4, R0                 @ Save file pointer to R4

read_loop:
    // fgets(buffer, 256, f); fetch line
    LDR R0, =line_buffer        @ buffer to load data into
    MOV R1, #256                @ size of buffer
    MOV R2, R4                  @ file pointer file.txt* (this address gets updated after each fgets call)
    BL fgets
    CMP R0, #0                  @ R0 is the return value. 0=EOF
    BEQ end_loop

    // Parse the data
    BL sp_start                 @ arg R0=track data string to parse           

    // Print the file 
    LDR R0, =output_str
    LDR R1, =line_buffer
    BL printf

    B read_loop

end_loop:

    POP {R4-R12, LR}
    BX LR



.data
file_name:  .asciz "track_data.txt"
read_mode:  .asciz "r"
line_buffer:    .space 256, 0
fgets_fmt_specifier:      .asciz "%s"
output_str:     .asciz "Read line: %s\n"




