/**************************************************************************************************
 * Project 3: Push Button LEDs
 * Name: Howard Zhou
 * Date: 2/28/2022
 * Course: ELEC-6602-Embedded Systems
 *
 * Description: 
 * Objective 1:  - Turns on Port D LEDs according to the values for the two numbers hardcoded in.
 *               - Program must start by displaying the smaller number and incrementing
 *                 it by 1 every second until it reaches 
 * 
 * Objective 2:  - Display the smaller or larger number on Port E, selectable by a 
 *                 push button on Port C
 * Objective 3:  - xxCreate state machine, every 15 btn presses, cycles patterns
 *               - Using two addition push buttons on Port B, have two which increase/decrease
 *                 the smaller or larger number which is currently displayed on Port E.
 * 
 * Bonus Obj:    - Rewrite Obj.1 in ASM.
 *  project->edit-project cr 81 to 8mhz hit load scheme select stm32
 **************************************************************************************************/

#include <stdint.h>

void main() {

     asm {
         L_main0:
         // 1 Second sleep 
         // 0x00BD 1AFF = 12,393,215 
         MOVW R7, #6911  //0x1AFF  
         MOVT R7, #189  // 0x00BD
         SUBS R7, R7, #1
         BNE L_main0

     }

    Delay_ms(1000);     // 1 Second delay
    Delay_ms(2000);
    Delay_us(1000000);
}