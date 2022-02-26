/**************************************************************************************************
 * Project 3: Push Button LEDs - Part 1 of 2
 * Name: Howard Zhou
 * Date: 2/28/2022
 * Course: ELEC-6602-Embedded Systems
 *
 * Description: 
 * Objective 1:  - Turns on Port D LEDs according to the values for the two numbers hardcoded in.
 *               - Program must start by displaying the smaller number and incrementing
 *                 it by 1 every second until it reaches the larger number.
 *               - Once smaller == larger, then it will decrement every 1 second until it reaches
 *                 lower number. Repeat indefinitely.  
 * 
 * Objective 2:  - Display the smaller or larger number on Port E, selectable by a 
 *                 push button on Port C
 * 
 * Objective 3:  - xxCreate state machine, every 15 btn presses, cycles patternsxxx NOT IT
 * 
 *               - Using two addition push buttons on Port B, have two which increase/decrease
 *                 the smaller or larger number which is currently displayed on Port E.
 * 
 * Bonus Obj:    - Rewrite Obj.1 in ASM.
 *  project->edit-project cr 81 to 8mhz hit load scheme select stm32
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


void update_PD_LED(uint16_t *target_count) {
    GPIOD_ODR = (*target_count & 0x000000FF);  // GPIOD_ODR is 32bit, must pad target_count it will be promoted to uint32
}


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

    // Decrease the PORT D LOW_NUM 
    if ( GPIOB_IDR.B0 == 1 && (PD_LOW_NUM != PD_HIGH_NUM) ) {   
        // Wait for the affect to take place on the FALLING-EDGE (button released)
        while ( GPIOB_IDR.B0 == 1) {
            Delay_ms(1);
        }
        // Decrease the displayed number on Port E from Low to High number
        if (*PE_display_mode == PE_MODE_LOW) {

            --PD_LOW_NUM;
            GPIOE_ODR = PD_LOW_NUM << 8;

            // ** UPdate the lower bound
        }
        else {
            --PD_HIGH_NUM;
            GPIOE_ODR = PD_HIGH_NUM  << 8;
            //** update the upper bound
        }
    }

    if (  GPIOB_IDR.B4 == 1 && (PD_HIGH_NUM != PD_LOW_NUM) )
    {   
        // Wait for the affect to take place on the FALLING-EDGE (button released)
        while ( GPIOB_IDR.B4 == 1 ) {
            Delay_ms(1);
        }
        // Increase the displayed number on Port E from Low to High number
        if (*PE_display_mode == PE_MODE_LOW) {

            ++PD_LOW_NUM;
            GPIOE_ODR = PD_LOW_NUM << 8;

            // UPdate the lower bound
        }
        else {
            ++PD_HIGH_NUM;
            GPIOE_ODR = PD_HIGH_NUM  << 8;
            // update the upper bound
        }
    }
}


void get_PE_display_data(uint8_t *PE_display_mode) {
    // Switch up the display for Port E from Low to High number
    if (*PE_display_mode == PE_MODE_LOW) {
        *PE_display_mode = PE_MODE_HIGH;
    }
    else {
        *PE_display_mode = PE_MODE_LOW;
    }
}



void main() {
    /* Local Variables - MikroC compiler requires all declarations up top */
    uint16_t combined_num    = 0;
    uint16_t target_count    = 0;       // Set the lower bound number
    uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
    uint8_t  temp_num        = 0;
    uint8_t  PA0_PWM_phase   = 0;
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
        // get_PE_display_data(&PE_display_mode);


        // Initialize Port A to 
        // GPIOA_ODR.B0=1;

        /* C method of 1 second sleep delay */
        for (i = 0; i < delay_time_ms; i++) {
            Delay_ms(1);
            PA0_led_counter++;


            // BOnus objective 1
            // if (PA0_PWM_phase == 0) {
            //     if (PA0_led_counter % 25 == 0 )
            //         GPIOA_ODR.B0=1;
            //     else if (PA0_led_counter % 12 == 0)
            //         GPIOA_ODR.B0=0;

            //     if (PA0_led_counter > 500) {
            //         PA0_PWM_phase++;
            //         PA0_led_counter =0;
            //     }
                

            // } 
            // else if ( PA0_PWM_phase == 1) {
            //      if (PA0_led_counter % 10 == 0 )
            //         GPIOA_ODR.B0=1;
            //     else if (PA0_led_counter % 5 == 0)
            //         GPIOA_ODR.B0=0;

            //     if (PA0_led_counter > 500) {
            //         PA0_PWM_phase++;
            //         PA0_led_counter =0;
            //     }
            // }
            // else if ( PA0_PWM_phase == 2)
            // {
            //      if (PA0_led_counter % 5 == 0 )
            //         GPIOA_ODR.B0=1;
            //     else if (PA0_led_counter % 2 == 0)
            //         GPIOA_ODR.B0=0;

            //     if (PA0_led_counter > 500)
            //     {
            //         PA0_PWM_phase++;
            //         PA0_led_counter =0;
            //     }
            // }
            //    else if ( PA0_PWM_phase == 3)
            // {
            //      if (PA0_led_counter % 5 == 0 )
            //         GPIOA_ODR.B0=1;

            //     if (PA0_led_counter > 500)
            //     {
            //         PA0_PWM_phase=0;
            //         PA0_led_counter =0;
            //     }
            // }
                
            PC_btn_check(&PE_display_mode);


        }


        
        //=================================================================================================
        /* BONUS Objective 2 - Assembly method 0f 1 second delay */
        // asm {
        //     // R3 - Unused
        //     // R5 - Temp
        //     // R10 - Temp

        //     // FIxed Registers
        //     // R0, R1 - GPIOC_IDR  
        //     // R2 - GPIOE_ODR
        //     // R4 - _PE_Display_mode
        //     // R7 - Clock
        //     // R8 - PD_LOW_NUM
        //     // R9 - PD_HIGH_NUM


        //     MOVW R7, #0x3E00 //  1 second = @ 8 instrcutions== approx 15 cycles/teration  4.8 mill approx.
        //     MOVT R7, #0x45
            
        //     // MOVW R7, #0x9F00
        //     // MOVT R7, #0x24
        //     // MOVW R7, #15872
        //     // MOVT R7, #73

        //     // Assign PC0 to R0, then to R1 for processing
        //     MOVW R0, #LO_ADDR(GPIOC_IDR+0)
        //     MOVT R0, #HI_ADDR(GPIOC_IDR+0)
        //     MOVW R2, #LO_ADDR(GPIOE_ODR+0)
        //     MOVT R2, #HI_ADDR(GPIOE_ODR+0)
        //     MOVW R4, #LO_ADDR(_PE_display_mode+0)
        //     MOVT R4, #HI_ADDR(_PE_display_mode+0)
        //     MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
        //     MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)
        //     MOVW R9, #LO_ADDR(_PD_HIGH_NUM+0)
        //     MOVT R9, #HI_ADDR(_PD_HIGH_NUM+0)
          
           

        //     _DELAY_LOOP:
        //         SUBS R7, R7, #1            // Update delay clock counter
        //         BEQ _EXIT_TIME_LOOP
        //         LDR R1, [R0]               // Load GPIOC_IDR value in R1
        //         AND R6, R1, #0x00000001    // Extract PC0 bit0
        //         CMP R6, #1                 // Check if PC0 is pressed '1'
        //         BEQ _PC0_BTN_FILTER        // Branch to PC0 Button filter in order to capture button press properly
        //         BNE _PC0_NOT_PRESSED       // Branch to Fake operation to alingn cpu tick counting

        //     _PC0_PRESSED:
        //         LDR R5, [R4]        // PE_display_mode value
        //         CMP R5, #1
        //         BEQ _SET_PE_LOW
        //         BNE _SET_PE_HI

        //     _PC0_BTN_FILTER:
        //         LDR R1, [R0]        // GPIOC_IDR value
        //         AND R6, R1, #0x00000001     // Extract PC0
        //         CMP R6, #1                  // Check if PC0 is pressed '1'
        //         BEQ _PC0_BTN_FILTER            // keep it looped to control button 
        //         BNE _PC0_PRESSED
                
        //     _PC0_NOT_PRESSED:
        //         NOP
        //         NOP
        //         B _DELAY_LOOP

        //     _SET_PE_LOW:
        //         LDR R5, [R8]
        //         LSL R5, #8 // PE_LOW_NUM shift 8 left
        //         STR R5, [R2]    // WRITE TO PE_ODR
        //         MOV R10, #0x00000000   // Store LOW_MODE flag in R1
        //         STR R10, [R4]        // update display mode flag
        //         B _DELAY_LOOP

        //     _SET_PE_HI:
        //         LDR R5, [R9]
        //         LSL R5, #8 // PE_LOW_NUM shift 8 left
        //         STR R5, [R2]  // Updates PE PE_ODR
        //         MOV R10, #0x00000001               // need to update pE mode now
        //         STR R10, [R4]
        //         B _DELAY_LOOP

        //     _EXIT_TIME_LOOP:
        //         NOP
        // }

        //=========================================================================================================


    }



}