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
 * BONUS Objective 1:  - Implement a software PWM using the Assembly Language to influence the 
 *                 brightness of an LED on PORTA.
 * 
 * BONUS Objective 2:  - Rewrite Objective 2 using the Assembly Language.
 *  
 **************************************************************************************************/

#include <stdint.h>

/* Constants */
static const uint32_t GPIO_DIR_OUTPUT = 0x33333333; 
static const uint32_t GPIO_DIR_INPUT  = 0x44444444;

// static const uint8_t PD_LOW_NUM = 0;  
// static const uint8_t PD_HIGH_NUM = 255; 

static const uint8_t INCREMENT_MODE = 0x01;
static const uint8_t DECREMENT_MODE = 0x00;

static const uint8_t PE_MODE_HIGH = 0x01;
static const uint8_t PE_MODE_LOW  = 0x00;


// Globals - Assembly variables must be global
uint8_t PE_display_mode = PE_MODE_LOW;       // Default PE Display mode
uint8_t PD_LOW_NUM      = 0xFF;
uint8_t PD_HIGH_NUM     = 0x33;
uint16_t delay_time_ms  = 100;


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

    uint32_t  PA0_PWM_phase   = 0;

void main() {
    /* Local Variables - MikroC compiler requires all declarations up top */
    uint16_t combined_num    = 0;
    uint16_t target_count    = 0;       // Set the lower bound number
    uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
    uint8_t  temp_num        = 0;
    uint32_t PA0_led_counter = 0;
    uint32_t i               = 0;      

    /* Merge the lower + upper number to get the full 16-bit numerical value */
    // combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);

  

    // Delay_ms(1000);     // 1 Second delay
    // Delay_ms(2000);
    // Delay_us(1000000);

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

    /* Initialize LEDs */

    // Display LOWER number on PORTD/L and HIGH number on PORT D/H
    combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);
    GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
    GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF) << 8;

    // Start with counter being the LOWER number
    target_count = PD_LOW_NUM;
    
    // Temporary hold to see the starting value before main loop starts
    Delay_ms(1000);



    /**************************Main Loop ********************************/
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

        PA0_PWM_phase = target_count % 3;  // get the PWM phase
        // get_PE_display_data(&PE_display_mode);


        // Initialize Port A to 
        // GPIOA_ODR.B0=1;

        // /* C method of 1 second sleep delay */
        // for (i = 0; i < delay_time_ms; i++) {
        //     Delay_ms(1);
        //     PA0_led_counter++;
        //     PC_btn_check(&PE_display_mode);
        // }

        

        
        //=================================================================================================
        /* BONUS Objective 2 - Assembly method 0f 1 second delay */
        asm {
            // R5 - Temp
            // R10 - Temp

            // FIxed Registers
            // R0, R1 - GPIOC_IDR  
            // R2 - GPIOE_ODR
            // R3 - GPIOA_ODR
            // R4 - _PE_Display_mode
            // R7 - Clock
            // R8 - PD_LOW_NUM
            // R9 - PD_HIGH_NUM


            /* Delay sleep values */
            //  1 second delay @  8 + 7(C code to ASM) instructions== approx 18 cycles/iteration w/ pipeline.
            // 72MHz/16CyclesPerIteration = 4.5MHz = 0x44AA20
            // 72MHz/16CyclesPerIteration = 4MHz = 0x3D0900
            // We need to account for time to update the LED during the C Main loop too, so 
            // ideally we will adjust for a few extra cycles. Based on the asm file from the compiler
            // C main loop is about 7 cycles to run loop and update the counter.
            MOVW R7, #0x0900 // #0xAA20
            MOVT R7, #0x3D   // #0x44
            
           
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
                BEQ _EXIT_TIME_LOOP
                LDR R1, [R0]               // Load GPIOC_IDR value in R1
                AND R6, R1, #0x00000001    // Extract PC0 bit0
                CMP R6, #1                 // Check if PC0 is pressed '1'
                BEQ _PC0_BTN_FILTER        // Branch to PC0 Button filter in order to capture button press properly
                BNE _PC0_NOT_PRESSED       // Branch to Fake operation to alingn cpu tick counting

            _PC0_PRESSED:
                LDR R5, [R4]                // PE_display_mode value
                CMP R5, #1
                BEQ _SET_PE_LOW
                BNE _SET_PE_HI

            _PC0_BTN_FILTER:
                LDR R1, [R0]                // GPIOC_IDR value
                AND R6, R1, #0x00000001     // Extract PC0
                CMP R6, #1                  // Check if PC0 is pressed '1'
                BEQ _PC0_BTN_FILTER            // keep it looped to control button 
                BNE _PC0_PRESSED
                
            _PC0_NOT_PRESSED:
                // NOP
                // NOP
                // B _DELAY_LOOP
                MOVW R5, #LO_ADDR(_PA0_PWM_phase+0)
                MOVT R5, #HI_ADDR(_PA0_PWM_phase+0)
                LDR R10, [R5]
                CMP R10, #0
                BEQ _UPDATE_PWM1_PA
                CMP R10, #1
                BEQ _UPDATE_PWM2_PA
                CMP R10, #2
                BEQ _UPDATE_PWM3_PA
                
                // MOVW R10, #0x08FF
                // MOVT R10, #0x003D
                // CMP R7, R10
                // BEQ _UPDATE_PWM1_PA

            _SET_PE_LOW:
                LDR R5, [R8]
                LSL R5, #8 // PE_LOW_NUM shift 8 left
                STR R5, [R2]    // WRITE TO PE_ODR
                MOV R10, #0x00000000   // Store LOW_MODE flag in R1
                STR R10, [R4]        // update display mode flag
                B _DELAY_LOOP

            _SET_PE_HI:
                LDR R5, [R9]
                LSL R5, #8 // PE_LOW_NUM shift 8 left
                STR R5, [R2]  // Updates PE PE_ODR
                MOV R10, #0x00000001               // need to update pE mode now
                STR R10, [R4]
                B _DELAY_LOOP

            _UPDATE_PWM1_PA:
                MOV R10, #3
                UDIV R5, R7, R10
                MUL R11, R5, R10
                CMP R7, R11
                BEQ _TURN_ON_PA
                BNE _TURN_OFF_PA

            _UPDATE_PWM2_PA:
                MOV R10, #10
                UDIV R5, R7, R10
                MUL R11, R5, R10
                CMP R7, R11
                BEQ _TURN_ON_PA
                BNE _TURN_OFF_PA

             _UPDATE_PWM3_PA:
                MOV R10, #20
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

        //=========================================================================================================


    }



}