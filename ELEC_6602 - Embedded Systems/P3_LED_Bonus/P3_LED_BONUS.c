/**************************************************************************************************
 * Project 3: Push Button LEDs Part 2/2 - BONUS OBJECTIVES
 * Name: Howard Zhou
 * Date: 2/28/2022
 * Course: ELEC-6602-Embedded Systems
 *
 * Description:     ** Make sure clock is configured at 72MHz for delay to be accurate
 *                  project->edit-project load scheme STM32F107VC for proper clock speeds

 *                  - Bonus portion of the assignment P3, Objective 1 is ported over to this version
 *                    in C and Bonus objectives will be implemented in Assembly.
 *                  
 * TO USE:          - Press PC0 to switch between high/low values in PortE
 *                  - PA0 LED brightness cycles between dim, medium and bright.
 * 
 * BONUS Objective 1:  - Implement a software PWM using the Assembly Language to influence the 
 *                       brightness of an LED on PORTA.
 * 
 * BONUS Objective 2:  - Rewrite Objective 2 using the Assembly Language.
 *  
 **************************************************************************************************/

#include <stdint.h>

/* Constants */
static const uint32_t GPIO_DIR_OUTPUT = 0x33333333; 
static const uint32_t GPIO_DIR_INPUT  = 0x44444444;

static const uint8_t INCREMENT_MODE = 0x01;
static const uint8_t DECREMENT_MODE = 0x00;

static const uint8_t PE_MODE_HIGH = 0x01;
static const uint8_t PE_MODE_LOW  = 0x00;


// Globals - Assembly variables must be global
uint8_t PE_display_mode = PE_MODE_LOW;       // Default PE Display mode
uint8_t PD_LOW_NUM      = 0xFF;
uint8_t PD_HIGH_NUM     = 0x33;
uint16_t delay_time_ms  = 100;
uint32_t  PA0_PWM_phase = 0;


/* Helper functions */

// Update the LEDs on PORT D
void update_PD_LED(uint16_t *target_count) {
    GPIOD_ODR = (*target_count & 0x000000FF);  // GPIOD_ODR is 32bit, must pad target_count it will be promoted to uint32
}

// Button handler C
void PC_btn_check(uint8_t *PE_display_mode) {
    // Capture the button press (pressed down)
    if (GPIOC_IDR.B0 == 1) {   
        // Wait for the affect to take place on the FALLING-EDGE (button released)
        while (GPIOC_IDR.B0 == 1) {
            Delay_ms(1);
        }
        // Switch up the display for Port E from Low to High number
        if (*PE_display_mode == PE_MODE_LOW) {
            GPIOE_ODR = PD_HIGH_NUM << 8;
            *PE_display_mode = PE_MODE_HIGH;
        }
        else {
            GPIOE_ODR = PD_LOW_NUM  << 8;
            *PE_display_mode = PE_MODE_LOW;
        }
    }
}
    

void main() {
    /* Local Variables - MikroC compiler requires all declarations up top */
    uint16_t combined_num    = 0;
    uint16_t target_count    = 0;       // Set the lower bound number
    uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
    uint8_t  temp_num        = 0;
    uint32_t PA0_led_counter = 0;
    uint32_t i               = 0;      

    /* Initial ABP2 Peripheral clock enable register */

    RCC_APB2ENR |= 1 << 2; // Enable GPIO Clock - Port B
    RCC_APB2ENR |= 1 << 3; // Enable GPIO Clock - Port B
    RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - Port C
    RCC_APB2ENR |= 1 << 5; // Enable GPIO Clock - Port D
    RCC_APB2ENR |= 1 << 6; // Enable GPIO Clock - Port E


    /* GPIO direction configuration */
    // GPIO Port A - INPUT
    GPIOA_CRL = GPIO_DIR_OUTPUT;   

    // GPIO Port B - INPUT
    GPIOB_CRL = GPIO_DIR_INPUT;    

    // GPIO Port C - INPUT
    GPIOC_CRL = GPIO_DIR_INPUT;    

    // GPIO Port D - OUTPUT
    GPIOD_CRL = GPIO_DIR_OUTPUT;
    GPIOD_CRH = GPIO_DIR_OUTPUT;

    // GPIO Port E - OUTPUT
    GPIOE_CRL = GPIO_DIR_OUTPUT;
    GPIOE_CRH = GPIO_DIR_OUTPUT;


    /* Check which number is the lower number, swap them if necessary */
    if (PD_LOW_NUM > PD_HIGH_NUM) {
        temp_num = PD_LOW_NUM; // Store the 'higher" number
        PD_LOW_NUM = PD_HIGH_NUM;
        PD_HIGH_NUM = temp_num;
    }
    else if (PD_LOW_NUM == PD_HIGH_NUM) {
        // If the two numbers are equal, display the number ons PORT D H &L and PORT E to alert an error 
        // and exit the application.
        combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
        GPIOD_ODR = combined_num;
        GPIOE_ODR = combined_num << 8;

        return;  // Exit program
    }

    /* Initialize LEDs  & other misc config*/

    // Display LOWER number on PORTD/L and HIGH number on PORT D/H
    combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
    GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
    GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF) << 8;

    // Start with counter being the LOWER number
    target_count = PD_LOW_NUM;
    
    // Temporary hold to see the starting initial value before main loop starts
    Delay_ms(1000);



    /************************** Main Loop ********************************/
    for (;;) {
        
        // Check if we have hit target number
        if (target_count == PD_HIGH_NUM) {
            count_mode = DECREMENT_MODE;
        }
        else if (target_count == PD_LOW_NUM) {
            count_mode = INCREMENT_MODE; 
        }

        // Increment / Decrement counter
        if (count_mode == INCREMENT_MODE) {
            ++target_count;
        } else{
            --target_count;
        }
        
        // Update PORT E Display
        update_PD_LED(&target_count);

        // Change the PortA LED PWM brightness cycle after sleep
        // Cycles throught one of three modes (dim, medium, bright)
        PA0_PWM_phase = target_count % 3;  // get the PWM phase
        

        /* BONUS Objective 2 - Assembly method 0f 1 second delay */
        asm {
            // Temporarily used registers
            // R5
            // R10 
            // R11 

            // FIxed Registers
            // R0, R1 - GPIOC_IDR  
            // R2     - GPIOE_ODR
            // R3     - GPIOA_ODR
            // R4     - _PE_Display_mode
            // R7     - Clock
            // R8     - PD_LOW_NUM
            // R9     - PD_HIGH_NUM


            /* Delay sleep values */
            // 1 second delay @  approximately 30 + 9(C code to ASM) instructions== approx 39 cycles/iteration w/ pipeline.
            // 72MHz/39 CyclesPerIteration = 1,846,153Hz = 0x1C2B89
            // We need to account for time to update the LED during the C Main loop too, so 
            // ideally we will adjust for a few extra cycles. Based on the asm file from the compiler
            // C main loop is about 9 cycles to run loop and update the counter.
            // Alter these values if you want to speedup/down the sleep delay.
            MOVW R7, #0x2B89
            MOVT R7, #0x1C
           

           /* Pre-load registers for faster processing time */
            // Assign PC0 to R0, then to R1 for processing
            MOVW R0, #LO_ADDR(GPIOC_IDR+0)
            MOVT R0, #HI_ADDR(GPIOC_IDR+0)
            MOVW R3, #LO_ADDR(GPIOA_ODR+0)
            MOVT R3, #HI_ADDR(GPIOA_ODR+0)
            MOVW R2, #LO_ADDR(GPIOE_ODR+0)
            MOVT R2, #HI_ADDR(GPIOE_ODR+0)
            MOVW R4, #LO_ADDR(_PE_display_mode+0)
            MOVT R4, #HI_ADDR(_PE_display_mode+0)
            MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
            MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)
            MOVW R9, #LO_ADDR(_PD_HIGH_NUM+0)
            MOVT R9, #HI_ADDR(_PD_HIGH_NUM+0)

            _DELAY_LOOP:
                SUBS R7, R7, #1            // Update delay clock counter
                BEQ _EXIT_TIME_LOOP        // Exit this loop when counter is 0. End sleep
                LDR R1, [R0]               // Load GPIOC_IDR value in R1
                AND R6, R1, #0x00000001    // Extract PC0 bit0
                CMP R6, #1                 // Check if PC0 is pressed '1'
                BEQ _PC0_BTN_FILTER        // Branch to PC0 Button filter in order to capture button press properly
                BNE _PC0_NOT_PRESSED       // Branch to Fake operation to alingn cpu tick counting


            /* BONUS OBJECTIVE 2 */
            // Handle PC0 button press to switch the value on PORT E
            _PC0_PRESSED:
                LDR R5, [R4]                // Get the current PortE Display mode value
                CMP R5, #1                  // If 1, means PortE is currently displaying High#
                BEQ _SET_PE_LOW             // Switch to LOW#
                BNE _SET_PE_HI              // Else, swithc to High#


            // PC0 Button Filter is used so the change of state is applied on the 
            // the falling edge signal of button press.
            _PC0_BTN_FILTER:
                LDR R1, [R0]                // Get current GPIOC_IDR input state
                AND R6, R1, #0x00000001     // Extract PC0 bit
                CMP R6, #1                  // Check if PC0 is pressed '1'
                BEQ _PC0_BTN_FILTER         // If PC0 is held down, repeat this loop
                BNE _PC0_PRESSED            


            /* BONUS OBJECTIVE 1 */
            // Since we are sleeping for 1 second, use this time to modulate the PWM signal
            // For PORT A. A PWM phase value is read and the corresponding brightness for that value 
            // is set here 
            _PC0_NOT_PRESSED:
                MOVW R5, #LO_ADDR(_PA0_PWM_phase+0) // Load the PWM 'phase clock' pattern 
                MOVT R5, #HI_ADDR(_PA0_PWM_phase+0) // Load the PWM 'phase clock' pattern 
                LDR R10, [R5]               // Load it in R10 for calculation
                CMP R10, #0                 // PWM phase is 1-3, call corresponding PWM sequence for PORT A
                BEQ _UPDATE_PWM1_PA         // Bright PWM Setting
                CMP R10, #1
                BEQ _UPDATE_PWM2_PA         // Med-bright PWM Setting
                CMP R10, #2
                BEQ _UPDATE_PWM3_PA         // Dim PWM Setting

            _SET_PE_LOW:
                LDR R5, [R8]            // Copy the current(in-case it changes during run-time)LOW_NUM into R5 for processing
                LSL R5, #8              // LOW_NUM shift left 8 for PortE LEDs
                STR R5, [R2]            // Write to PortE_ODR
                MOV R10, #0x00000000    // Store LOW_MODE flag in R1 so we know what the display is current
                STR R10, [R4]           // update display mode flag
                B _DELAY_LOOP           // Continue the sleep loop

            _SET_PE_HI:
                LDR R5, [R9]            // Copy the current HIGH_NUM into R5
                LSL R5, #8              // HIGH_NUM shift left 8 for portE LEDs
                STR R5, [R2]            // Update PE PE_ODR
                MOV R10, #0x00000001    // Store HIGH_MODE flag in R1 so we know what the display is current
                STR R10, [R4]           // update display mode flag
                B _DELAY_LOOP           // Continue the sleep loop

            // PA0 - LED Brightness setting - Bright
            // Control a on/off period for LED PWM.
            // PWM is acheived by finding a common multiple of the current clock cycle 
            // similar to using a modulus % of the current clock cycle.
            // Mod divisor is chosen to determine desired brightness on the PortA LED PA0.
            _UPDATE_PWM1_PA:
                MOV R10, #15                // Load the chosen divisor into R10
                UDIV R5, R7, R10            // Divide the current clock cycle(R7) and store value in R5
                MUL R11, R5, R10            // Verify it can divide evenly by multipying quotient by Divisor
                CMP R7, R11                 // If the Product of R11 matches the current clock cycle we know- 
                                            // that we have a perfect 'Modulus' division
                BEQ _TURN_ON_PA             // If Current clock % divisor == 0, turn on LED 
                BNE _TURN_OFF_PA            // Else, turn off LED.

            // PA0 - LED Brightness setting - Medium
            _UPDATE_PWM2_PA:
                MOV R10, #5             
                UDIV R5, R7, R10
                MUL R11, R5, R10
                CMP R7, R11
                BEQ _TURN_ON_PA
                BNE _TURN_OFF_PA

            // PA0 - LED Brightness setting - Dim
             _UPDATE_PWM3_PA:
                MOV R10, #1            
                UDIV R5, R7, R10
                MUL R11, R5, R10
                CMP R7, R11
                BEQ _TURN_ON_PA
                BNE _TURN_OFF_PA

            _TURN_ON_PA:
                MOV R5, #00000001
                STR R5, [R3] // Write to PA0 LED
                B _DELAY_LOOP
            _TURN_OFF_PA:
                MOV R5, #00000000
                STR R5, [R3] // Write to PA0 LED
                B _DELAY_LOOP
            
            _EXIT_TIME_LOOP:
                NOP
        }
    }
}