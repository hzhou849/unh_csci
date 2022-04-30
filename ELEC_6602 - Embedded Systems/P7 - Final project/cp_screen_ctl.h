/// cp_screen_intro.h
// Screens creation is handled here.

// Puddle Producktion
//  Run waddle hop Inc

#ifndef _CP_SCREEN_CTL_H
#define _CP_SCREEN_CTL_H

#include <stdint.h>

//================================================================================================
/* Prototypes */
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis);



//=================================================================================================
/* Function Definitions */

// Load the intro screen and kick off screen control handler
void load_intro_screen() {

    uint32_t x_axis = 35;
      // Hold here for button press to start
    while (GPIOC_IDR.B13 != 0 ) {
        draw_intro_screen(35, 115);

        // if (GPIOA_IDR.B13 )
    }  
}


// Intro screen control handler
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
    uint8_t pub_msg[] = "Puddle Producktions presents:";
    uint8_t dev_msg[] = "A Run Hop Games, game.";
    uint8_t intro_msg[] = "Please press Joystick down to start";

    /* Intro screen */
    TFT_Fill_Screen(CL_BLACK);

    TFT_Set_Font(TFT_defaultFont, CL_GRAY, FO_HORIZONTAL );
    // TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
    // TFT_Rectangle(0, 0, 320, 240);
    TFT_Write_Text(&intro_msg, x_axis, y_axis);


}

#endif // _CP_SCREENS_CTL_H