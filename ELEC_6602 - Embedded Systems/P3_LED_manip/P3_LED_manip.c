/**************************************************************************************************
 * Project 3: Push Button LEDs
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

uint8_t PD_LOW_NUM  = 0x00;
static const uint8_t PD_HIGH_NUM = 0x02;

// static const uint8_t PD_LOW_NUM = 0;  
// static const uint8_t PD_HIGH_NUM = 255; 

static const uint8_t INCREMENT_MODE = 0x01;
static const uint8_t DECREMENT_MODE = 0x00;

static const uint8_t PE_MODE_HIGH = 0x01;
static const uint8_t PE_MODE_LOW = 0x00;



void update_PD_LED(uint16_t *target_count) {
    GPIOD_ODR = (*target_count & 0x000FFFF);  // GPIOD_ODR is 32bit, must pad target_count it will be promoted to uint32
}


void PC_btn_check(uint8_t *PE_display_mode) {
    if (GPIOC_IDR.B0 == 1)
    {
        while (GPIOC_IDR.B0 == 1)
        {
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


void get_PE_display_data(uint8_t *PE_display_mode) {
    // Switch up the display for Port E from Low to High number
    if (*PE_display_mode == PE_MODE_LOW) {
        *PE_display_mode = PE_MODE_HIGH;
    }
    else {
        *PE_display_mode = PE_MODE_LOW;
    }
}

    // Assembly variables ust be global
    uint8_t  PE_display_mode = PE_MODE_LOW;       // Default PE Display mode
void main() {
    /* Local Variables - MikroC compiler requires all declarations up top */
    uint32_t i               = 0;                             
    uint32_t time_ms         = 1000;             // Default 1000ms; 1second
    uint16_t combined_num    = 0;
    uint16_t target_count    = PD_LOW_NUM;       // Set the lower bound number
    uint8_t  count_mode      = INCREMENT_MODE;   // Default start state
    


    /* Merge the lower + upper number to get the full 16-bit numerical value */
    combined_num = (PD_LOW_NUM & 0x00FF) | (PD_HIGH_NUM << 8);

    // /* ASM declarations */
    // asm {

    //     MOVW R7, #0x8D7F // half 1 second 6mill approx.
    //     MOVT R7, #0x5E

    //     // Assign PC0 to R0, then to R1 for processing
    //     MOVW R0, #LO_ADDR(GPIOC_IDR+0)
    //     MOVT R0, #HI_ADDR(GPIOC_IDR+0)
    //     MOVW R2, #LO_ADDR(GPIOE_ODR+0)
    //     MOVT R2, #HI_ADDR(GPIOE_ODR+0)
    //     MOVW R4, #LO_ADDR(_PE_display_mode+0)
    //     MOVT R4, #HI_ADDR(_PE_display_mode+0)
    //     MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
    //     MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)

    // }

    

    //  asm {
    //      L_main0:
    //      // 1 Second sleep 
    //      // 0x00BD 1AFF = 12,393,215 
    //      MOVW R7, #6911  //0x1AFF  
    //      MOVT R7, #189  // 0x00BD
    //      SUBS R7, R7, #1
    //      BNE L_main0

    //  }

    // Delay_ms(1000);     // 1 Second delay
    // Delay_ms(2000);
    // Delay_us(1000000);

   

    /* Initial ABP2 Peripheral clock enable register */
    RCC_APB2ENR |= 1 << 4; // Enable GPIO Clock - PORT C
    RCC_APB2ENR |= 1 << 5; // Enable GPIO Clock - Port D
    RCC_APB2ENR |= 1 << 6; // Enable GPIO Clock - Port E


    /* GPIO direction configuration */
     // GPIO Port C - INPUT
    GPIOC_CRL = GPIO_DIR_INPUT;    

    // GPIO Port D - OUTPUT
    GPIOD_CRL = GPIO_DIR_OUTPUT;
    GPIOD_CRH = GPIO_DIR_OUTPUT;

    // GPIO Port E - OUTPUT
    GPIOE_CRL = GPIO_DIR_OUTPUT;
    GPIOE_CRH = GPIO_DIR_OUTPUT;


    /* Initialize LEDs */
    GPIOD_ODR = (combined_num & 0x0000FFFF);     // Pad for 32-bit ODR
    GPIOE_ODR = (PD_LOW_NUM & 0x0000FFFF);
    
    // Temporary hold to see the starting value before main loop starts
    Delay_ms(100);



    /**************************Main Loop ********************************/
    for (;;) {


        
        // Check if we have hit target number
        if (target_count == combined_num) {
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
        // get_PE_display_data(&PE_display_mode)

        // 1 Second sleep/delay
        // for (i = 0; i < 1000; i++)
        // {
        //     Delay_ms(1);
        //     PC_btn_check(&PE_display_mode);
        // }
        
        // 1 second with ASM
        asm {

            MOVW R7, #0x8D7F // half 1 second 6mill approx.
            MOVT R7, #0x5E

            // Assign PC0 to R0, then to R1 for processing
            MOVW R0, #LO_ADDR(GPIOC_IDR+0)
            MOVT R0, #HI_ADDR(GPIOC_IDR+0)
            MOVW R2, #LO_ADDR(GPIOE_ODR+0)
            MOVT R2, #HI_ADDR(GPIOE_ODR+0)
            MOVW R4, #LO_ADDR(_PE_display_mode+0)
            MOVT R4, #HI_ADDR(_PE_display_mode+0)
            MOVW R8, #LO_ADDR(_PD_LOW_NUM+0)
            MOVT R8, #HI_ADDR(_PD_LOW_NUM+0)
            
            
           

            _DELAY_LOOP:
                SUBS R7, R7, #1
                BEQ _EXIT_TIME_LOOP
                // BNE _DELAY_LOOP
                LDR R1, [R0]        // GPIOC_IDR value
                AND R6, R1, #0x00000001     // Extract PC0
                CMP R6, #1                  // Check if PC0 is pressed '1'
                BEQ _PC0_PRESSED            // Branch to PC0 Pressed if 1, otherwise do nothing
                BNE _PC0_NOT_PRESSED        // Branch to Fake operation to alingn cpu tick counting

            _PC0_PRESSED:
                LDR R5, [R4]        // PE_display_mode value
                CMP R5, #1
                BEQ _SET_PE_LOW
                BNE _SET_PE_HI

                // LSL R5, #8          // Shift it by 8 bits for PORT E/H 
                // STR R5, [R2]             // Store 
                // B _DELAY_LOOP

            _PC0_NOT_PRESSED:
                MOV R8, #0
                B _DELAY_LOOP

            _SET_PE_LOW:
                // LSL R8, #8  // PE_LOW_NUM shift 8 left 
                MOVW R8, #0x3333
                STR R8, [R2]
                MOV R9, #0x00000000
                STR R9, [R4]        // update display mode
                B _DELAY_LOOP

            _SET_PE_HI:
                MOVW R8, #0xFFFF
                STR R8, [R2]  // Updates PE light
                 MOV R9, #0x00000001               // need to update pE mode now
                STR R9, [R4]
                B _DELAY_LOOP

            _EXIT_TIME_LOOP:
                NOP



        }
        

          //  asm {
    //      L_main0:
    //      // 1 Second sleep 
    //      // 0x00BD 1AFF = 12,393,215 
    //      MOVW R7, #6911  //0x1AFF  
    //      MOVT R7, #189  // 0x00BD
    //      SUBS R7, R7, #1
    //      BNE L_main0

    //  }

    }



}