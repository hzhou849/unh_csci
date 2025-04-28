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


    Local Registers:
        R5 - Current counter
        R6 - File descriptor
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
    MOV R6, R0                  @ Save file pointer to R4
    MOV R5, #0                  @ counter for lines loaded

read_loop:
    // fgets(buffer, 256, f); fetch line
    LDR R0, =line_buffer        @ buffer to load data into
    MOV R1, #256                @ size of buffer
    MOV R2, R6                  @ file pointer file.txt* (this address gets updated after each fgets call)
    BL fgets
    CMP R0, #0                  @ R0 is the return value. 0=EOF
    BEQ end_loop

    // Call str_parser.s to parse the data
    /// \Returns: R0 return address =parsed_buffer
    BL str_parser               @ arg R0=track data string to parse 

    // Calls qBuffer::write_queue Load the parsed data into the queue buffer
    BL write_queue              @ taks R0 = parsed string datga          

    // Print the file 
    LDR R0, =output_str
    MOV R1, R5                  @ current counter
    LDR R2, =line_buffer        @ current string loaded
    BL printf

    ADD R5, #1                  @ increment loop counter
    B read_loop

end_loop:

    POP {R4-R12, LR}
    BX LR



.data
file_name:  .asciz "track_data.txt"
read_mode:  .asciz "r"
line_buffer:    .space 256, 0
fgets_fmt_specifier:      .asciz "%s"
output_str:     .asciz " %d) Data loaded: %s\n"




