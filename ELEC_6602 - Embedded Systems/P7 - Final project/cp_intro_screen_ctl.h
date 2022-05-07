/// cp_screen_intro.h
// Screens creation is handler here.

// Puddle Producktion
//  Run waddle hop Inc

#ifndef _CP_INTRO_SCREEN_CTL_H
#define _CP_INTRO_SCREEN_CTL_H

#include <stdint.h>
#include "cp_const_def.h"
#include "cp_pix_render.h"



/* Global variables */
static const uint32_t SCROLL_SPEED = 3;
static const uint32_t X_SCROLL_SPEED = 1;


 const  uint8_t pub_msg[] = "PUDDLE ProDUCKtions presents:";
 const  uint8_t dev_msg[] = "A Run Hop Games, game.";
 const  uint8_t intro_msg[] = "Press Joystick/PC13 to contiue.";


//================================================================================================
/* Prototypes */

// External Calls
void load_intro_screen_simple();
// void load_game_screen();

// Local Calls
void duck_sprite();
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis);
void draw_rectangle(uint32_t x_axis, uint32_t y_axis);
void set_cur_screen_run_flag(uint8_t run_flag);
void draw_info_text(uint32_t x_axis, uint32_t y_axi);

// void duck_sprite();



//=================================================================================================
/* Function Definitions */



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


//==========================================================================================================
/// Load Duck logo the game screen
///
void load_duck_screen() {
    uint32_t x_axis = 0;
    uint32_t y_axis = 0;
    uint32_t PX_BLOCK = 16;
    uint32_t i=0;

    uint32_t value = 0;

    
    
    init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
    // dump_arr_memory(&g_DS_BUFFER, MAX_BLOCK_SIZE);

    // Set the current screen run flag
    set_cur_screen_run_flag(TRUE);


    // Setup screen 
    TFT_Fill_Screen(CL_NAVY);
   
    TFT_SET_PEN(m_BLACK, 0);
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);


   // Load the duck sprite into video buffer
    duck_sprite();

    // set the offsets
        // dump_ds_buffer();

    for (i=0; i< 20; i++) {
        
        // if (i < 1) {
        //     render_rect_mask(0, 0+6, 13+i, 9+6, m_NAVY);
        // }
        // render_rect_mask(0+ (i-1), 0+6, 13+i, 9+6, m_NAVY);
        cleaning_buffer(m_NAVY);

        // Delay_ms(10);
        set_sprite_offset(i, 6);
        dump_ds_buffer();
    }


    // hold here -may move this out later
    while (cur_screen_run_flag == TRUE) {};

    // Reset offset on quit
    set_sprite_offset(0,0);
    
}




#endif // _CP_SCREENS_CTL_H

void duck_sprite() {
    // Sprite is 12x8 dimension
    // Group the colours to reduce instruction calls for colour swapping
    // if drawing directly
    // m_YELLOW, 7 
    // m_YELLOW 47 (410-457) 47+7 = 54
    // m_BLACK, 7
    // m_RED 5

    // TFT_SET_Brush(1, m_YELLOW, 0, 0 , 0 ,0);
    load_cell_xy(8,0, m_YELLOW);
    load_cell_xy(9,0, m_YELLOW);
    load_cell_xy(10,0, m_YELLOW);

    // TFT_SET_Brush(1, m_YELLOW, 0, 0 , 0 ,0);
    load_cell_xy(2,2,m_YELLOW); //face
    load_cell_xy(3,2,m_YELLOW);
    load_cell_xy(7,2,m_YELLOW);
    load_cell_xy(8,2,m_YELLOW);


    // Black sunglasses
    // TFT_SET_Brush(1, m_BLACK, 0, 0 , 0 ,0);
    load_cell_xy(7,1, m_BLACK); // Sunglasses
    load_cell_xy(8,1, m_BLACK);
    load_cell_xy(9,1, m_BLACK);
    load_cell_xy(10,1, m_BLACK);
    load_cell_xy(11,1, m_BLACK);
    load_cell_xy(9,2, m_BLACK);
    load_cell_xy(10,2, m_BLACK);



    // TFT_SET_Brush(1, m_RED, 0, 0 , 0 ,0);
    load_cell_xy(11,2, m_RED);
    load_cell_xy(12,2, m_RED);
    load_cell_xy(13,2, m_RED);
    load_cell_xy(11,3, m_RED);
    load_cell_xy(12,3, m_RED);

    // TFT_SET_Brush(1, m_YELLOW, 0, 0 , 0 ,0);
    load_cell_xy(1,3, m_YELLOW);
    load_cell_xy(2,3, m_YELLOW);
    load_cell_xy(3,3, m_YELLOW);
    load_cell_xy(4,3, m_YELLOW);
    load_cell_xy(8,3, m_YELLOW);
    load_cell_xy(9,3, m_YELLOW);
    load_cell_xy(10,3, m_YELLOW);
    load_cell_xy(0,4, m_YELLOW);
    load_cell_xy(1,4, m_YELLOW);
    load_cell_xy(2,4, m_YELLOW);
    load_cell_xy(3,4, m_YELLOW);
    load_cell_xy(4,4, m_YELLOW);
    load_cell_xy(5,4, m_YELLOW);
    load_cell_xy(6,4, m_YELLOW);
    load_cell_xy(7,4, m_YELLOW);
    load_cell_xy(8,4, m_YELLOW);
    load_cell_xy(9,4, m_YELLOW);
    load_cell_xy(10,4, m_YELLOW);
    load_cell_xy(1,5, m_YELLOW);
    load_cell_xy(2,5, m_YELLOW);
    load_cell_xy(3,5, m_YELLOW);
    load_cell_xy(4,5, m_YELLOW);
    load_cell_xy(5,5, m_YELLOW);
    load_cell_xy(6,5, m_YELLOW);
    load_cell_xy(7,5, m_YELLOW);
    load_cell_xy(8,5, m_YELLOW);
    load_cell_xy(9,5, m_YELLOW);
    load_cell_xy(10,5, m_YELLOW);
    load_cell_xy(2,6, m_YELLOW);
    load_cell_xy(3,6, m_YELLOW);
    load_cell_xy(4,6, m_YELLOW);
    load_cell_xy(5,6, m_YELLOW);
    load_cell_xy(6,6, m_YELLOW);
    load_cell_xy(7,6, m_YELLOW);
    load_cell_xy(8,6, m_YELLOW);
    load_cell_xy(9,6, m_YELLOW);
    load_cell_xy(10,6, m_YELLOW);
    load_cell_xy(3,7,m_YELLOW);
    load_cell_xy(4,7,m_YELLOW);
    load_cell_xy(5,7,m_YELLOW);
    load_cell_xy(6,7,m_YELLOW);
    load_cell_xy(7,7,m_YELLOW);
    load_cell_xy(8,7,m_YELLOW);
    load_cell_xy(9,7,m_YELLOW);
    load_cell_xy(4,8,m_YELLOW);
    load_cell_xy(5,8,m_YELLOW);
    load_cell_xy(6,8,m_YELLOW);
    load_cell_xy(7,8,m_YELLOW);
    load_cell_xy(8,8,m_YELLOW);
}

