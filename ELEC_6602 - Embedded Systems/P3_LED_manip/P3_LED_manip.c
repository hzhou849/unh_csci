/**************************************************************************************************
 * Project 3: Push Button LEDs - Part 1 of 2 Main Objectives
 * Name: Howard Zhou
 * Date: 2/28/2022
 * Course: ELEC-6602-Embedded Systems
 *
 * **Professor Pellicano, I currently set the delay_time_ms=100 in line 55 for 100ms so that you can see the count 
 *   reach their boundary number faster, but feel free to set it back to 1000 if you want to 
 *   see a 1 second delay.
 * 
 * 
 * Description:    Two numbers LOW_NUM and HIGH_NUM are chosen from 0x0 to 0xFF (0-255)
 *                 and the application will determine which is the lower number then count
 *                 from LOW to HIGH back down to LOW and repeat. 
 *                 
 *                 ** Make sure clock is configured at 72MHz for delay to be accurate
 *                  project->edit-project load scheme STM32F107VC for proper clock speeds
 *                 LEDs count every xtime (default 1sec) from set low number to high number
 *                 - Port D displays the count
 *                 - Port E shows the current set LOW/HIGH numbers
 *                 - PORT B PB0 - Decreases current number displayed on PORT E
 *                          PB4 - Increases current number displayed on PORT E
 *                 - PORT C PC0 - Swaps between the LOW/HIGH number displayed on PORT E
 * 
 * Objective 1:  - Turns on Port D LEDs according to the values for the two numbers hardcoded in.
 *               - Program must start by displaying the smaller number and incrementing
 *                 it by 1 every second until it reaches the larger number.
 *               - Once smaller == larger, then it will decrement every 1 second until it reaches
 *                 lower number. Repeat indefinitely.  
 * 
 * Objective 2:  - Display the smaller or larger number on Port E, selectable by a 
 *                 push button on Port C
 * 
 * Objective 3:   - Using two addition push buttons on Port B, have two which increase/decrease
 *                 the smaller or larger number which is currently displayed on Port E.
 * 
 * Bonus Objectives:    -  SEE P3_LED_BONUS project
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


/* Globals - Assembly variables must be global */
uint16_t delay_time_ms  = 100;           // Set the desired sleep time in milliseconds.
uint8_t PE_display_mode = PE_MODE_LOW;   // Default PE Display mode
uint8_t PD_LOW_NUM      = 0xFF;
uint8_t PD_HIGH_NUM     = 0x33;


/* Helper Functions */
// Upates the Port D LEDs
void update_PD_LED(uint16_t *target_count) {
    GPIOD_ODR = (*target_count & 0x000000FF);
}

// Button handler and increment/decrement PORT E display
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
        }
        else {
            --PD_HIGH_NUM;
            GPIOE_ODR = PD_HIGH_NUM  << 8;
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
        }
        else {
            ++PD_HIGH_NUM;
            GPIOE_ODR = PD_HIGH_NUM  << 8;
        }
    }
}


/* Main Function */
void main() {
    /* Local Variables - MikroC compiler requires all declarations up top */
    uint16_t combined_num    = 0;
    uint16_t target_count    = 0;       
    uint8_t  count_mode      = INCREMENT_MODE;   // Default start state is increment from low to high number
    uint8_t  temp_num        = 0;
    uint8_t  PA0_PWM_phase   = 0;
    uint32_t i               = 0;                             

    /* Initial ABP2 Peripheral clock enable register */
    RCC_APB2ENR |= 1 << 2; // Enable GPIO Clock - Port A
    RCC_APB2ENR |= 1 << 3; // Enable GPIO Clock - Port B
    RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - Port C
    RCC_APB2ENR |= 1 << 5; // Enable GPIO Clock - Port D
    RCC_APB2ENR |= 1 << 6; // Enable GPIO Clock - Port E


    /* GPIO direction configuration */
    GPIOA_CRL = GPIO_DIR_OUTPUT;  // GPIO Port A - INPUT 
    GPIOB_CRL = GPIO_DIR_INPUT;   // GPIO Port B - INPUT
    GPIOC_CRL = GPIO_DIR_INPUT;   // GPIO Port C - INPUT

    GPIOD_CRL = GPIO_DIR_OUTPUT;  // GPIO Port D - OUTPUT
    GPIOD_CRH = GPIO_DIR_OUTPUT;
    
    GPIOE_CRL = GPIO_DIR_OUTPUT;  // GPIO Port E - OUTPUT
    GPIOE_CRH = GPIO_DIR_OUTPUT;

    /* Check which number is the lower number, swap them if necessary */
    if (PD_LOW_NUM > PD_HIGH_NUM) {
        temp_num = PD_LOW_NUM; 
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
        
        update_PD_LED(&target_count);

        /* Sleep/Delay time loop */
        // Button check state inside sleep loop so we don't hang up the button presses
        // and allow better response
        for (i = 0; i < delay_time_ms; i++) {
            Delay_ms(1);
            PC_btn_check(&PE_display_mode);  
        }
    }
}