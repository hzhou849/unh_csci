/**************************************************************************************************
 * Project 2: Push Button LEDs
 * Name: Howard Zhou
 * Date: 2/21/2022
 * Course: ELEC-6602-Embedded Systems
 *
 * Description: 
 * Objective 1:  -When PA0 is pressed, the LEDs on PORTD/H turn ON Lower half is OFF. 
 *               - When button released, LEDs on the lower half of PORTD turn on and upper half turns OFF
 *               - LEDs are off in the beginning.
 *               - Display the number of times PA0 is pressed on the LEDs connected on the upper half
 *                  of PORTE
 * Objective 2:  - Press P4 turn on All lights, and when release turn off all lights
 * Objective 3:  - Create state machine, every 15 btn presses, cycles patterns
 * Objective 4:  - PA5 switches to next pattern; resets 15 count to 0.
 * 
 * Bonus Obj:    - Rewrite Obj.1 in ASM.
 * 
 ****************************************************************************************************/

#include <stdint.h>

static const uint16_t PA0_led_pattern[]     = { 0xFF00, 0xAAAA, 0x0FF0 };
static const uint16_t PA0_led_pattern_OFF[] = { 0x00FF, 0x5555, 0x0F0F };
static const uint16_t PA4_led_pattern[]     = { 0xFFFF, 0xAAAA, 0xF0F0 };


void update_btn_count(uint16_t *PA_btn_count)
{
    ++*PA_btn_count;
    GPIOE_ODR = (*PA_btn_count) << 8;   // GPIOE_ODR operates at 0xFF00;
}


void btn_manager_ON(uint32_t *gpio_mask, uint16_t *cur_off_state, uint16_t *led_state, uint16_t *PA_btn_count) {
    
    uint32_t PA_low_state = *gpio_mask & 0x00FF;
    if ( (PA_low_state >> 5 ) & 1 == 1 ) {
        *led_state = (++*led_state) % 3 ;
        *PA_btn_count = 0;
        GPIOD_ODR = PA0_led_pattern[*led_state]; // Change the state on PA5 press
        *cur_off_state = ~(PA0_led_pattern[*led_state]); // Update the off state on PA5 press too.
    }

    if ( (PA_low_state & 1 ) == 1 ) {
        GPIOD_ODR = PA0_led_pattern[*led_state];
        *cur_off_state = ~(PA0_led_pattern[*led_state]);                // Flipped LED mode
        // *cur_off_state = (PA0_led_pattern_OFF[*led_state] >> 8) & 0xFF; // Mirror LED off state
        // *cur_off_state = PA0_led_pattern_OFF[*led_state];
    }

    if ( (PA_low_state >> 4) & 1 == 1 ) {
        // Method 1, using mutliple pattern array
        // GPIOD_ODR = PA4_led_pattern[*led_state];
        // *cur_off_state = ~(PA4_led_pattern[*led_state]);

        // Method 2, fixed all LEDs on/off
        GPIOD_ODR = 0xFFFF;
        *cur_off_state = 0x0000;
    }
}


void main() {

    //********************BONUS-Objective- REQUIRED
    // To RUN, COMMENT OUT THE C SECTION BELOW
    // Register Map
    // R5 - Program counter
 
    // asm {

    //     _START:
    //         // Enable APB2 Peripherial Clock for Port A and Port D Port E
    //         MOVW R0, #LO_ADDR(RCC_APB2ENR+0)    // Load APB2 Peripheral clock into register R0
    //         MOVT R0, #HI_ADDR(RCC_APB2ENR+0)        
    //         LDR R1, [R0]
    //         ORR R1, #0x64                       // Enable Port A and Port D with mask 0x0010 00100 == 0x24
    //         STR R1, [R0]                        // Write the new value of R1 to R0 &RCC_APB2ENR

    //         // Configure pin directions for PORT A/L - Input
    //         MOVW R0, #LO_ADDR(GPIOA_CRL+0)      // *** ALWAYS MOVW before MOVT or and LO berfore HI error!!!!!
    //         MOVT R0, #HI_ADDR(GPIOA_CRL+0)
    //         MOV R3, #0x44444444
    //         STR R3, [R0]
        
    //         // Configure pin directions for PORT D H/L - Output
    //         MOVW R0, #LO_ADDR(GPIOD_CRL+0)
    //         MOVT R0, #HI_ADDR(GPIOD_CRL+0)
    //         MOV R4, #0x33333333
    //         STR R4, [R0]
    //         MOVW R0, #LO_ADDR(GPIOD_CRH+0)
    //         MOVT R0, #HI_ADDR(GPIOD_CRH+0)
    //         MOV R3, #0x33333333
    //         STR R3, [R0]

    //         // Configure pin directions for PORT E/H- Output
    //         MOVW R0, #LO_ADDR(GPIOE_CRH+0)
    //         MOVT R0, #HI_ADDR(GPIOE_CRH+0)
    //         MOV R3, #0x33333333
    //         STR R3, [R0]

    //         // Set initial state for PORT D
    //         MOVW R0, #LO_ADDR(GPIOD_ODR+0)
    //         MOVT R0, #HI_ADDR(GPIOD_ODR+0)
    //         MOV R3, #0x00000000
    //         STR R3, [R0]

    //         MOVW R0, #LO_ADDR(GPIOE_ODR+0)
    //         MOVT R0, #HI_ADDR(GPIOE_ODR+0)
    //         MOV R3, #0x00000000
    //         STR R3, [R0]
            
    //         MOV R5, #0      // Initialize R5 Button counter to zero.
        
    //     // Enter the main loop
    //     _LOOP1:
    //         MOVW R0, #LO_ADDR(GPIOA_IDR+0)
    //         MOVT R0, #HI_ADDR(GPIOA_IDR+0)
    //         LDR R1, [R0]
    //         AND R2, R1, #0x00000001            // Extract Bit0 for PA0 state
    //         CMP R2, #1
    //         BEQ PORTD_ON                       // If PA0(R1) == 1, go to on loop
    //         B _LOOP1                           // else, repeat this loop

    //     PORTD_ON:
    //         // Turn ON Port D LEDs and increment Port E count
    //         MOVW R0, #LO_ADDR(GPIOD_ODR+0)
    //         MOVT R0, #HI_ADDR(GPIOD_ODR+0)
    //         MOVW R3, #0xFF00                    // 16bits only
    //         STR R3, [R0]

    //         ADD R5, #1                          // Increment button counter

    //         // Turn ON Port D LEDs and increment Port E count
    //         MOVW R0, #LO_ADDR(GPIOE_ODR+0)
    //         MOVT R0, #HI_ADDR(GPIOE_ODR+0)
    //         MOV R3, R5                          // Move R5 counter to R3 to shift for PORTE Upper bits
    //         LSL R3, #8
    //         STR R3, [R0]
    //         B BUTTON_HOLD
            
    //     BUTTON_HOLD:
    //         // While holding down PA0
    //         MOVW R0, #LO_ADDR(GPIOA_IDR+0)
    //         MOVT R0, #HI_ADDR(GPIOA_IDR+0)
    //         LDR R1, [R0]
    //         AND R2, R1, #0x00000001             // Extract Bit0 for PA0 state
    //         CMP R2, #1
    //         BEQ BUTTON_HOLD                     // If PA0(R1) == 1, go to on loop
    //         BNE PORTD_OFF                       // else, repeat this loop
            

    //     PORTD_OFF:
    //         // Turn OFF Port D LEDs
    //         MOVW R0, #LO_ADDR(GPIOD_ODR+0)
    //         MOVT R0, #HI_ADDR(GPIOD_ODR+0)
    //         MOVW R3, #0x00FF                    // 16bits only
    //         STR R3, [R0]
    //         B _LOOP1
    // }

    
    //***************** C version *********************** 

    uint16_t led_state      = 0;
    uint16_t PA_btn_count   = 0;
    uint16_t cur_off_state  = 0;
    uint32_t pin_mask       = 0;

    // Initialize ABP2 Peripheral clock enable register 
    //- This register is required to enable the GPIO port. Peripheral clock needs to be active
    //  in order to read the peripheral register. See TM32107 Reference Manual for details.
    //  Bit  6     5   4    3    2    1     0
    //      IOPE IOPD IOPC IOPB IOPA res. AFIOEN
    RCC_APB2ENR |= 1 << 6;  // Enable GPIO Clock - Port E
    RCC_APB2ENR |= 1 << 5;  // Enable GPIO Clock - Port D 
    RCC_APB2ENR |= 1 << 2;  // Enable GPIO Clock - Port A


    // GPIO A - Configuration - INPUTS
    // CNFy b10 = input pullup/pulldown; MODEy = b00 for input mode; or b1000 == 0x4
    GPIOA_CRL = 0x44444444;

    // GPIO D - Configuration - OUTPUTS
    // Configure Config. Register LOW [pins 0-7] for GPIO Port D as outputs to power LEDs
    // CNF<y> b00 = Output push-pull; Mode<y> b11 = Output mode, 50MHz; or b0011 == 0x3 
    GPIOD_CRL = 0x33333333;
    GPIOD_CRH = 0x33333333;
    GPIOE_CRH = 0x33333333;


    // PUT PORTD/H in a know initial state
    GPIOD_ODR = 0x0000;
    GPIOE_ODR = 0x0000;
  

    //** Main loop **
    for (;;) {
        // == 0; NOT Pressed
        while (GPIOA_IDR.B0 != 1 && GPIOA_IDR.B4 !=1 && GPIOA_IDR.B5 != 1) {     // Wait until the first P0 is pressed
            if (GPIOD_ODR != cur_off_state)
                GPIOD_ODR = cur_off_state;
            Delay_ms(1);
        }

        // if (GPIOA_IDR.B0 == 1) ??? Logially make sense????
        if (GPIOA_IDR.B5 != 1 && GPIOA_IDR.B4 != 1 )
            update_btn_count(&PA_btn_count);
        
        if ( (PA_btn_count % 15 ) == 0) 
            led_state = (++led_state) % 3 ;

        pin_mask = GPIOA_IDR;
        btn_manager_ON(&pin_mask, &cur_off_state, &led_state, &PA_btn_count);

        // == 1; Pressed
        while (GPIOA_IDR.B0 != 0 || GPIOA_IDR.B4 !=0 || GPIOA_IDR.B5 !=0) {    // Delay loop why button is pressed
            Delay_ms(1); 
        }
    }

}