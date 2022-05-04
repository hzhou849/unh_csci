/// cp_game_ctl.h
//  Game screen/engine control handler

#ifndef _CP_GAME_CTL_H
#define _CP_GAME_CTL_H

#include <stdint.h>
#include <string.h>
#include "cp_const_def.h"
#include "cp_pix_render.h"

/* Constants */

static const uint8_t EOF_ARRAY          = 0xFF;             // End marker for display array matrix
static const uint8_t MOVE_RIGHT         = 0x0;             // End marker for display array matrix
static const uint8_t MOVE_LEFT         = 0x0;             // End marker for display array matrix


// static const uint8_t m_
// static const uint8_t m_


/* Global variables */
static  uint8_t GAME_PHASE = PHASE1_READY;
static volatile uint32_t time_count = 0;
static uint8_t snake_direction = MOVE_RIGHT;



//=============================================================================================================
/* Prototypes */

// External calls
void load_game_screen();
uint8_t get_game_mode();
void update_game_time();
void move_snake();



// Local calls
void init_arr(uint8_t *in_arr, uint32_t a_size);
void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);
void draw_cell_pos( uint32_t linear_pos, uint32_t clr_code);
// void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var );
void load_cell_xy(uint32_t x_var, uint32_t y_var, uint32_t clr_code);

void duck_sprite();
void snake_sprite();
void dump_ds_buffer();
// void start_snake_game();



//=============================================================================================================
/* Function Declarations */

// Update the game timer
void update_game_time () {
    time_count++;
}

/// Get the current game mode
uint8_t get_game_mode() {
    return GAME_PHASE;
}

/// Initialize array to 0
void init_arr(uint8_t *in_arr, uint32_t a_size) {
    uint32_t i=0;

    for (i=0; i < a_size; i++) {
        in_arr[i]=0xFF;
    }
}


/// Dump the entire contents of an array at given size to serial
void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
    uint32_t i = 0;

    for ( i=0; i < MAX_BLOCK_COUNT; i++) {
        
        // Critical delay and waits required for write to USART
        while ( (USART1_SR & (1 << 7 )) == 0) {}
        Delay_ms(10);                                   
        USART1_DR = (uint32_t)in_arr[i];
        Delay_ms(10);
            
    }
}

// void debug(uint32_t val) {
//          // Critical delay and waits required for write to USART
//         while ( (USART1_SR & (1 << 7 )) == 0) {}
//         Delay_ms(10);                                   
//         USART1_DR = (uint32_t)val;
//         Delay_ms(10);
// }

//==========================================================================================================
/// Load the game screen
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
        
        if (i < 1) {
            render_rect_mask(0, 0+6, 13+i, 9+6, m_NAVY);
        }
        render_rect_mask(0+ (i-1), 0+6, 13+i, 9+6, m_NAVY);

        // Delay_ms(10);
        set_sprite_offset(i, 6);
        dump_ds_buffer();
    }


    // hold here -may move this out later
    while (cur_screen_run_flag == TRUE) {};

    // Reset offset on quit
    set_sprite_offset(0,0);



    
}

void load_snake_game() {

    // Set the game phase mode flag
    GAME_PHASE = PHASE1_READY;

     init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
    // dump_arr_memory(&g_DS_BUFFER, MAX_BLOCK_SIZE);

    // Set the current screen run flag
    set_cur_screen_run_flag(TRUE);
     // Setup screen 
    TFT_Fill_Screen(CL_BLACK);
   
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    set_brush_color(m_BLACK);

    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
    TFT_Write_Text("READY?", 7 * PX_BLOCK, 6 * PX_BLOCK);
    TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 7*PX_BLOCK);
    
    while (cur_screen_run_flag == TRUE) {};
}


void start_snake_game() {


    uint8_t str_buffer[128];
    uint32_t num = 2550;
    int rand_num;

     // Set the game phase mode flag
    GAME_PHASE = PHASE2_PLAYING;
    
     init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
    // dump_arr_memory(&g_DS_BUFFER, MAX_BLOCK_SIZE);

    // Reset the current screen run flag to stay in this mode
    set_cur_screen_run_flag(TRUE);
     // Setup screen 
    TFT_Fill_Screen(CL_BLACK);
   
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    set_brush_color(m_GREEN);

    // sprintf(str_buffer, "Score: %d          Time: %d", rand);


    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
    // TFT_Write_Text(&str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
    
    // sprintf(str_buffer,"Time:");
    // TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
    // TFT_Write_Text(&str_buffer, 10*PX_BLOCK, 0*PX_BLOCK);
    // load_cell_xy(0,1, m_GREEN);
    // load_cell_xy(2,1, m_GREEN);
    // load_cell_xy(1,1, m_GREEN);
    snake_sprite();

    dump_ds_buffer();

    /* Game Loop */
    while (cur_screen_run_flag == TRUE) {
        //update direction and refresh screen here?
        rand_num = (rand() % 100);

        render_rect_mask(0,0,20,1, m_NAVY);
        //  render_rect_mask(0,10,19,0, m_BLACK);

        //  sprintf(str_buffer, "Score: %d                               Time: %d", rand_num, time_count);
        sprintf(str_buffer, "Score: %d", rand_num);
        TFT_Write_Text(&str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
        sprintf(str_buffer, "Time: %d", time_count);
        TFT_Write_Text(&str_buffer, 13*PX_BLOCK, 0*PX_BLOCK);
     
        move_snake();
        dump_ds_buffer();
        Delay_ms(200);
    };

    // Reset offset on quit
    set_sprite_offset(0,0);
}



//  for (i=0; i< 20; i++) {
        
//         if (i < 1) {
//             render_rect_mask(0, 0+6, 13+i, 9+6, m_NAVY);
//         }
//         render_rect_mask(0+ (i-1), 0+6, 13+i, 9+6, m_NAVY);

//         // Delay_ms(10);
//         set_sprite_offset(i, 6);
//         dump_ds_buffer();
//     }

void move_snake() {

    if (snake_direction == MOVE_RIGHT) {
        set_sprite_offset( (get_offset_x() + 1), (get_offset_y())  );
    }
    // dump_ds_buffer();
}













#endif //_CP_GAME_CTL_H

// void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos) {

//     uint32_t i = 0;
//     uint32_t col_count = 0;
//     uint32_t row_count = 0;
//     cell_t   cell;

    
    
//     // Matrix formula to jagged array conversion is:
//     // Cell Position = yArr_row * col_width + xArrPos

//     for (i=0; i < MAX_BLOCK_COUNT; i++) {

//         if (dp_buffer[i] == 0xFF) {
//             break;      //EOF reached.
//         }



//         else if (dp_buffer[i] == 1) {
//             // TFT_Rectangle(x_pos *i, y_pos* column, PX_BLOCK*col_count,PX_BLOCK * row_count);

//             TFT_Rectangle(PX_BLOCK*i, row_count, (PX_BLOCK + (PX_BLOCK*i)),(PX_BLOCK+(PX_BLOCK*row_count))   );
//         }

//         // update column/row count
//         col_count++;
//         if (col_count > MAX_COL_WIDTH-1) {
//             row_count++;
//         }
//     }
//     // TFT_Rectangle(PX_BLOCK*1 , PX_BLOCK*0 , PX_BLOCK*2,PX_BLOCK*1);


// }

void snake_sprite() {
     load_cell_xy(0,1, m_GREEN);
}

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