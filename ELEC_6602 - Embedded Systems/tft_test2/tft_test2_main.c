/*
 * Project name:
     tft_test2.mcpar
 * Generated by:
     Visual TFT
 * Date of creation
     4/25/2022
 * Test configuration:
     MCU:             STM32F107VC
     Dev.Board:       EasyMx_PRO_v7_for_STM32_ARM_9A
     Oscillator:      72000000 Hz
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 */
#include <stdint.h> 
// RUN & HOP games /  puddle duck production
static const uint32_t SCREEN_X_MAX =320;
static const uint32_t SCREEN_Y_MAX =240;
static const uint32_t TRUE = 1;
static const uint32_t FALSE  =0;

    uint8_t pub_msg[] = "Puddle Producktions presents:";
    uint8_t dev_msg[] = "A Run Hop Games, game.";
    uint8_t intro_msg[] = "Please press Joystick down to start";
// Intro screen control handler
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {

    /* Intro screen */

    TFT_Set_Font(TFT_defaultFont, CL_GRAY, FO_HORIZONTAL );
    // TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
    // TFT_Rectangle(0, 0, 320, 240);
    TFT_Write_Text(&intro_msg, x_axis, y_axis);

    TFT_Fill_Screen(CL_BLACK);

}


// Load the intro screen and kick off screen control handler
void load_intro_screen() {
    
    uint8_t scroll_dir = 1;
    uint8_t intro_screen_run_flag = 1;
    uint32_t x_axis = 35;
    uint32_t y_axis = 115;
      // Hold here for button press to start
    while (intro_screen_run_flag == TRUE ) {
       
      
        if (scroll_dir == 1 ) {
             if (y_axis > (SCREEN_Y_MAX-5) || x_axis > (SCREEN_X_MAX -30) ) {
                 scroll_dir = 0;
             }
            
            x_axis+=5;
            y_axis+=5;

        }
        else {

              if (y_axis < 10 || x_axis < 10) {
            scroll_dir = 1;
        }

            x_axis-=5;
            y_axis-=5;
        }

        draw_intro_screen(x_axis, y_axis);

        // if (GPIOA_IDR.B13 )
    }  
}



#include "tft_test2_objects.h"

void main() {
    
    unsigned int counter = 0;
    Start_TP();
    RCC_APB2ENR |= 1 << 2;
    GPIOA_CRL = 0x44444444;
    GPIOA_CRH = 0x44444444;

    TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
    TFT_Rectangle(0,0,320, 240);

    load_intro_screen();


// Enable gradient from black to white color, left-right orientation
  while (1) {
       
        TFT_Set_Brush(1, CL_AQUA, 0, 0, 0, 0);
        TFT_Rectangle(counter+50,0,counter+100, 50);
        

        if (GPIOA_IDR.B0 == 1) {
            if (counter < 240-50) {
                TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
                TFT_Rectangle(counter+50,0,counter+100, 50);
            }


            counter+=25;

        }
        Delay_ms(10);
        

        //if (counter >= 320) {
        //    counter -=25;
        //}

    Check_TP();
  }
}