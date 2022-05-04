/// cp_screen_intro.h
// Screens creation is handler here.

// Puddle Producktion
//  Run waddle hop Inc

#ifndef _CP_INTRO_SCREEN_CTL_H
#define _CP_INTRO_SCREEN_CTL_H

#include <stdint.h>

/// My headers
#include "cp_const_def.h"



/* Global variables */
static const uint32_t SCROLL_SPEED = 3;
static const uint32_t X_SCROLL_SPEED = 1;

static volatile uint8_t cur_screen_run_flag = TRUE;
 const  uint8_t pub_msg[] = "PUDDLE ProDUCKtions presents:";
 const    uint8_t dev_msg[] = "A Run Hop Games, game.";
 const    uint8_t intro_msg[] = "Press Joystick/PC13 to contiue.";


//================================================================================================
/* Prototypes */

// External Calls
void load_intro_screen_simple();
// void load_game_screen();

// Local Calls
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis);
void draw_rectangle(uint32_t x_axis, uint32_t y_axis);
void set_cur_screen_run_flag(uint8_t run_flag);
void draw_info_text(uint32_t x_axis, uint32_t y_axi);

// void duck_sprite();



//=================================================================================================
/* Function Definitions */


void set_cur_screen_run_flag(uint8_t run_flag) {
    cur_screen_run_flag = run_flag;
}


/// Load the intro screen and kick off screen control handler
// Simple bounce 
void load_intro_screen_simple() {
    

    uint8_t scroll_dir = 5; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
    uint32_t volatile x_axis = 55;
    uint32_t volatile y_axis = 115;

    uint32_t  prev_val = 0;
    uint32_t  prev_val2 = 0;

    // Hold here for button press to start

    // Initial background set to black
    TFT_Fill_Screen(CL_BLACK);

    while (cur_screen_run_flag == TRUE ) {

        // Draw this rectangle to cover old text, reduces complexity by avoiding full fill()
        draw_rectangle(x_axis, y_axis);         
        
        if (scroll_dir == 1 ) {
            if (y_axis > (SCREEN_Y_MAX-20) || x_axis > (SCREEN_X_MAX -30) ) {
                scroll_dir = 0;
            }
            x_axis+=X_SCROLL_SPEED;
            y_axis+=SCROLL_SPEED;

        }
        else {

            if (y_axis < 10 || x_axis < 2) {
            scroll_dir = 1;
        }
            x_axis-=X_SCROLL_SPEED;
            y_axis-=SCROLL_SPEED;
        }
        draw_intro_screen(x_axis, y_axis);

    }  
}

/// Load the intro screen and kick off screen control handler
// Multi-angle direction phases
void load_intro_screen() {
    
    uint8_t rotation = 0;
    uint8_t scroll_dir = 1; // 1=Down/Right, 2=Up/Right, 3=Up/left, 4, Down/Left
    uint32_t volatile x_axis = 35;
    uint32_t volatile y_axis = 115;

    uint32_t  prev_val = 0;
    uint32_t  prev_val2 = 5;
    uint32_t counter = 1;
    
    

    // Hold here for button press to start

    // Initial background set to black
    TFT_Fill_Screen(CL_BLACK);

    draw_info_text( 10,220);


    while (cur_screen_run_flag == TRUE ) {
        
        // Draw rectangle to cover old text; Reduces CPU usage by avoiding fill()
        draw_rectangle(x_axis, y_axis);

        // Phase 1: Scroll Down/Right
        if (scroll_dir == 1){
            x_axis+=X_SCROLL_SPEED;  
            y_axis+=SCROLL_SPEED;

            // We reached end of screen, move to next phase
            if ( x_axis > (SCREEN_X_MAX -200) || y_axis > (SCREEN_Y_MAX-42) ) {
              if (rotation == 0) {
                scroll_dir = 2;
                }
                else {
                    scroll_dir = 4;
                }
            }
            
        }
        // Phase 2: Scroll Up/Right 
        else if (scroll_dir == 2) {
            x_axis += X_SCROLL_SPEED;  
            y_axis -= SCROLL_SPEED;

            // We reached end of screen, move to next phase
            if (x_axis > (SCREEN_X_MAX -200) || y_axis <10   ) {
                if (rotation == 0) {
                    scroll_dir = 3;
                }
                else {
                    scroll_dir = 1;
                }
            }
        }

        // Phase 3: Scroll Up/Left
        else if (scroll_dir == 3) {
            x_axis -= X_SCROLL_SPEED;  
            y_axis -= SCROLL_SPEED;

             // We reached end of screen, move to next phase
            if ( x_axis < 10 || y_axis < 10 ) {

                if (rotation == 0) {
                    scroll_dir = 4; //4
                }
                else {
                    scroll_dir = 1;
                }

              
            }

        }
        // Phase 4: Scroll Down/Left 
        else if (scroll_dir == 4) {
            x_axis -= X_SCROLL_SPEED;  
            y_axis += SCROLL_SPEED;

             // We reached end of screen, move to next phase
            if ( x_axis < 10 || y_axis > (SCREEN_Y_MAX-42)) {
                
                if (rotation == 0) {
                    scroll_dir = 1;
                } else {
                    scroll_dir = 3;
                    x_axis + 10;
                }

                //seems to be working without this.
                //     if (counter % 3 == 0) { //2
                //     rotation = ~rotation; // change direction 
                //     counter = 2;
                // }
            }
        }

        counter++;
        if (counter == 5) {
            rotation = ~rotation; // change direction 
            counter = 0;
        }

        draw_intro_screen(x_axis, y_axis);
        
    }  
}



void draw_info_text(uint32_t x_axis, uint32_t y_axis) {
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
    TFT_Write_Text(&intro_msg, x_axis, y_axis);
}

void draw_rectangle(uint32_t x_axis, uint32_t y_axis) {

    TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
    TFT_Rectangle(x_axis, y_axis, x_axis+255, y_axis+15);   // 15 is miny to hide text
    // TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
    // TFT_Rectangle(10, 10, 320, 240);
}


// Intro screen control handler
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {
  

    /* Intro screen */

    TFT_Set_Font(TFT_defaultFont, CL_YELLOW, FO_HORIZONTAL );
    // TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
    // TFT_Rectangle(x_axis, y_axis, 10, 240);
    TFT_Write_Text(&pub_msg, x_axis, y_axis);
    // TFT_Write_Text(&intro_msg, x_axis+3, y_axis+20);

    // TFT_Fill_Screen(CL_BLACK);
    Delay_ms(10);

}




#endif // _CP_SCREENS_CTL_H




// void duck_sprite() {
//      TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
//     draw_cell_xy(8,4);
//     draw_cell_xy(9,4);
//     draw_cell_xy(10,4);

//     draw_cell_xy(7,5);
//     draw_cell_xy(8,5);
//     draw_cell_xy(9,5);

//     TFT_SET_Brush(1, CL_BLACK, 0, 0 , 0 ,0);
//     draw_cell_xy(10,5);


//     TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
//     draw_cell_xy(11,5); //face
//     draw_cell_xy(2,6);
//     draw_cell_xy(3,6);
//     draw_cell_xy(7,6);
//     draw_cell_xy(8,6);
//     draw_cell_xy(9,6);
//     draw_cell_xy(10,6);

//     TFT_SET_Brush(1, CL_RED, 0, 0 , 0 ,0);
//     draw_cell_xy(11,6);
//     draw_cell_xy(12,6);
//     draw_cell_xy(13,6);
//     // draw_cell_xy(14,6);
//     // draw_cell_xy(15,6);
//     draw_cell_xy(11,7);
//     draw_cell_xy(12,7);

//     TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
//     draw_cell_xy(1,7);
//     draw_cell_xy(2,7);
//     draw_cell_xy(3,7);
//     draw_cell_xy(4,7);
//     draw_cell_xy(8,7);
//     draw_cell_xy(9,7);
//     draw_cell_xy(10,7);
//     draw_cell_xy(0,8);
//     draw_cell_xy(1,8);
//     draw_cell_xy(2,8);
//     draw_cell_xy(3,8);
//     draw_cell_xy(4,8);
//     draw_cell_xy(5,8);
//     draw_cell_xy(6,8);
//     draw_cell_xy(7,8);
//     draw_cell_xy(8,8);
//     draw_cell_xy(9,8);
//     draw_cell_xy(10,8);
//     draw_cell_xy(1,9);
//     draw_cell_xy(2,9);
//     draw_cell_xy(3,9);
//     draw_cell_xy(4,9);
//     draw_cell_xy(5,9);
//     draw_cell_xy(6,9);
//     draw_cell_xy(7,9);
//     draw_cell_xy(8,9);
//     draw_cell_xy(9,9);
//     draw_cell_xy(10,9);
//     draw_cell_xy(2,10);
//     draw_cell_xy(3,10);
//     draw_cell_xy(4,10);
//     draw_cell_xy(5,10);
//     draw_cell_xy(6,10);
//     draw_cell_xy(7,10);
//     draw_cell_xy(8,10);
//     draw_cell_xy(9,10);
//     draw_cell_xy(10,10);
//     draw_cell_xy(3,11);
//     draw_cell_xy(4,11);
//     draw_cell_xy(5,11);
//     draw_cell_xy(6,11);
//     draw_cell_xy(7,11);
//     draw_cell_xy(8,11);
//     draw_cell_xy(9,11);
//     draw_cell_xy(4,12);
//     draw_cell_xy(5,12);
//     draw_cell_xy(6,12);
//     draw_cell_xy(7,12);
//     draw_cell_xy(8,12);
// }