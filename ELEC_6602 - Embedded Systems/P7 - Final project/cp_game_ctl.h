/// cp_game_ctl.h
//  Game screen/engine control handler

#ifndef _CP_GAME_CTL_H
#define _CP_GAME_CTL_H

#include <stdint.h>
#include <string.h>
#include "cp_const_def.h"

/* Constants */
static const uint8_t PX_BLOCK           = 16;               // 16x16px pixel block size
static const uint32_t X_MAX_WIDTH       = 20;               // 320/16px = 20 blocks
static const uint32_t Y_MAX_LENGTH      = 15;               // 240/16px = 15 blocks
static const uint8_t MAX_BLOCK_COUNT    = 300;              // 20*15 = 300 blocks
static const uint8_t EOF_ARRAY          = 0xFF;             // End marker for display array matrix


/* Global variables */
uint8_t g_DS_BUFFER[300];

// @16px blocks; 320x240 = 20x15 blocks =300 blcoks
// typedef struct snake_t {
//     uint8_t snake_act_sprite[300];   
// } snake_t;

typedef struct cell_t {
    uint32_t x;
    uint32_t y;
} cell_t;


//=============================================================================================================
/* Prototypes */

// External calls
void load_game_screen();

// Local calls
void init_arr(uint8_t *in_arr, uint32_t a_size);
void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);
void draw_cell_pos( uint32_t linear_pos);
// void get_xy(uint32_t cell_pos, cell_t cell );
void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var );
void draw_cell_xy(uint32_t x_var, uint32_t y_var);

void duck_sprite();
void dump_ds_buffer();



//=============================================================================================================
/* Function Declarations */


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
    //    mysnake.snake_act_sprite[i] = i;
    //    value = mysnake.snake_act_sprite[i];

       
    // //    if (value == 0) {
    // //        value = \x31;
    // //    }

        
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



void load_game_screen() {
    uint32_t x_axis = 0;
    uint32_t y_axis = 0;
    uint32_t PX_BLOCK = 16;
    uint32_t i=0;

    uint32_t value = 0;

    cell_t cell;
 
    init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
    // dump_arr_memory(&g_DS_BUFFER, MAX_BLOCK_SIZE);

    // Set the current screen run flag
    set_cur_screen_run_flag(TRUE);


    // Setup screen 
    TFT_Fill_Screen(CL_NAVY);
   
    TFT_SET_PEN(CL_BLACK, 0);
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);


    // draw_cell_pos(24);
    // draw_cell_pos(45);
    // draw_cell_pos(82);
    // draw_cell_pos(19);
    // draw_cell_pos(19);
    // draw_cell_pos(39); 
    // draw_cell_pos(20);

   
    // duck_sprite();

    draw_cell_xy(0, 4);
    draw_cell_xy(0, 5);
    draw_cell_xy(0, 6);

    dump_ds_buffer();
    





    // draw_cell_pos(299);
    // draw_cell_pos(285);
    // draw_snake();

    while (cur_screen_run_flag == TRUE) {};

    
}
void draw_snake() {
    // 0, 1, 2
    g_DS_BUFFER[0] = 1;
    g_DS_BUFFER[1] = 1;
    g_DS_BUFFER[2] = 0;
    g_DS_BUFFER[3] = 1;
    g_DS_BUFFER[4] = 1;
    g_DS_BUFFER[5] = EOF_ARRAY;

    draw_block(&g_DS_BUFFER,1,1);


}

void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var ) {

    uint32_t row = 0;
    uint32_t col = 0;
    uint32_t temp_val = *cell_pos; 


    // If value is greater than the first row size
    while (temp_val >= (X_MAX_WIDTH) ) {
        temp_val -= X_MAX_WIDTH-1;
        ++row;

        if (temp_val > 0 ) {
            --temp_val; // compensate for zero-index of array by adding 1
        }
        
    }
    
    // Left over value will equal column, but since matrix is 0-indexed,
    // remainders are not zero indexed so we have to subtract 1.


    col = temp_val;

    // Set the x y pointers so they can be used
    // cell->x = col;
    // cell->y = row;

    *x_var = col;
    *y_var = row;

}


// STRUCT VER issues
// void get_xy(uint32_t *cell_pos, cell_t *cell) {

//     uint32_t row = 0;
//     uint32_t col = 0;
//     uint32_t temp_val = *cell_pos;


//     // If value is greater than the first row size
//     while (temp_val >= (X_MAX_WIDTH-1) ) {
//         temp_val -= X_MAX_WIDTH;
//         row++;
//     }
    
//     // Left over value will equal column
//     col = temp_val;

//     // Set the x y pointers so they can be used
//     (cell->x) = col;
//     (cell->y) = row;


// }



/// Draws at a cell block at specific linear array position
void draw_cell_pos( uint32_t linear_pos) {


    cell_t cell;
    uint32_t x_var;
    uint32_t y_var;
    uint32_t cell_pos = linear_pos;

    get_xy(&cell_pos, &x_var, &y_var );
    // get_xy(linear_pos, &cell );

    debug(x_var);
    debug(y_var);

    TFT_Rectangle(
            PX_BLOCK * x_var,
            (y_var * PX_BLOCK),
            PX_BLOCK + (PX_BLOCK * x_var),
            PX_BLOCK + (PX_BLOCK * y_var) 
            );

}

void draw_cell_xy(uint32_t x_var, uint32_t y_var) {
    uint32_t linear_val = 0;

    // Draw the sprite directly
    //    TFT_Rectangle(
    //         PX_BLOCK * x_var,                   // Upper-left X
    //         (y_var * PX_BLOCK),                 // Upper-left Y
    //         PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
    //         PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
    //         );

    // Convert to linear array  x + (y * col_width)
    linear_val = ( (y_var * X_MAX_WIDTH) + x_var );

    g_DS_BUFFER[linear_val] = 1;

}


void dump_ds_buffer() {

    uint32_t i=0;

    for (i=0; i < MAX_BLOCK_COUNT; i++) {
        if (g_DS_BUFFER[i] == 1) {
            draw_cell_pos(i);
        }

    }
}


void transform_ds_buffer(uint32_t shift) {

    uint32_t i=0;

    for (i=0; i < MAX_BLOCK_COUNT; i++) {
        if (g_DS_BUFFER[i] == 1) {
            draw_cell_pos(i);
        }

    }
}

void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos) {

    uint32_t i = 0;
    uint32_t col_count = 0;
    uint32_t row_count = 0;
    cell_t   cell;

    
    
    // Matrix formula to jagged array conversion is:
    // Cell Position = yArr_row * col_width + xArrPos

    for (i=0; i < MAX_BLOCK_COUNT; i++) {

        if (dp_buffer[i] == 0xFF) {
            break;      //EOF reached.
        }



        else if (dp_buffer[i] == 1) {
            // TFT_Rectangle(x_pos *i, y_pos* column, PX_BLOCK*col_count,PX_BLOCK * row_count);

            TFT_Rectangle(PX_BLOCK*i, row_count, (PX_BLOCK + (PX_BLOCK*i)),(PX_BLOCK+(PX_BLOCK*row_count))   );
        }

        // update column/row count
        col_count++;
        if (col_count > X_MAX_WIDTH-1) {
            row_count++;
        }
    }
    // TFT_Rectangle(PX_BLOCK*1 , PX_BLOCK*0 , PX_BLOCK*2,PX_BLOCK*1);


}




#endif //_CP_GAME_CTL_H



void duck_sprite() {
     TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
    draw_cell_xy(8,4);
    draw_cell_xy(9,4);
    draw_cell_xy(10,4);

    draw_cell_xy(7,5);
    draw_cell_xy(8,5);
    draw_cell_xy(9,5);

    TFT_SET_Brush(1, CL_BLACK, 0, 0 , 0 ,0);
    draw_cell_xy(10,5);


    TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
    draw_cell_xy(11,5); //face
    draw_cell_xy(2,6);
    draw_cell_xy(3,6);
    draw_cell_xy(7,6);
    draw_cell_xy(8,6);
    draw_cell_xy(9,6);
    draw_cell_xy(10,6);

    TFT_SET_Brush(1, CL_RED, 0, 0 , 0 ,0);
    draw_cell_xy(11,6);
    draw_cell_xy(12,6);
    draw_cell_xy(13,6);
    // draw_cell_xy(14,6);
    // draw_cell_xy(15,6);
    draw_cell_xy(11,7);
    draw_cell_xy(12,7);

    TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
    draw_cell_xy(1,7);
    draw_cell_xy(2,7);
    draw_cell_xy(3,7);
    draw_cell_xy(4,7);
    draw_cell_xy(8,7);
    draw_cell_xy(9,7);
    draw_cell_xy(10,7);
    draw_cell_xy(0,8);
    draw_cell_xy(1,8);
    draw_cell_xy(2,8);
    draw_cell_xy(3,8);
    draw_cell_xy(4,8);
    draw_cell_xy(5,8);
    draw_cell_xy(6,8);
    draw_cell_xy(7,8);
    draw_cell_xy(8,8);
    draw_cell_xy(9,8);
    draw_cell_xy(10,8);
    draw_cell_xy(1,9);
    draw_cell_xy(2,9);
    draw_cell_xy(3,9);
    draw_cell_xy(4,9);
    draw_cell_xy(5,9);
    draw_cell_xy(6,9);
    draw_cell_xy(7,9);
    draw_cell_xy(8,9);
    draw_cell_xy(9,9);
    draw_cell_xy(10,9);
    draw_cell_xy(2,10);
    draw_cell_xy(3,10);
    draw_cell_xy(4,10);
    draw_cell_xy(5,10);
    draw_cell_xy(6,10);
    draw_cell_xy(7,10);
    draw_cell_xy(8,10);
    draw_cell_xy(9,10);
    draw_cell_xy(10,10);
    draw_cell_xy(3,11);
    draw_cell_xy(4,11);
    draw_cell_xy(5,11);
    draw_cell_xy(6,11);
    draw_cell_xy(7,11);
    draw_cell_xy(8,11);
    draw_cell_xy(9,11);
    draw_cell_xy(4,12);
    draw_cell_xy(5,12);
    draw_cell_xy(6,12);
    draw_cell_xy(7,12);
    draw_cell_xy(8,12);
}