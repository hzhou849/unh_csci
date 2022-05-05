/// cp_pix_render.h
// Pixel Renderer display "Engine"
// Handles the video buffer and all the image printing and manipulating

// implement double buffer technique.

#ifndef _CP_PIX_RENDER_H
#define _CP_PIX_RENDER_H

#include "cp_const_def.h"

/* Constants */
static const uint32_t Y_MAX_LENGTH      = 15;               // 240/16px = 15 blocks
static const uint32_t MAX_COL_WIDTH     = 20;               // 320/16px = 20 blocks
static const uint32_t MAX_BLOCK_COUNT   = 300;              // 20*15 = 300 blocks

static const uint8_t PX_BLOCK           = 16;               // 16x16px pixel block size


static const uint8_t SHIFT_UP           = 0xC1;
static const uint8_t SHIFT_DOWN         = 0xC2;
static const uint8_t SHIFT_LEFT         = 0xC3;
static const uint8_t SHIFT_RIGHT        = 0xC4;



/* Global variables */
static volatile uint8_t CUR_BRUSH_COLOUR = m_BLACK; 
uint8_t g_DS_BUFFER[300];
// uint8_t g_SPRITE_MASK_BUFFER[];
static int32_t offset_x = 0;
static int32_t offset_y = 0;

/* Prototypes */
void set_sprite_offset(uint32_t ofs_x, uint32_t ofs_y);
uint32_t get_offset_x();
// uint32_t get_offset_y();
void draw_cell_pos( uint32_t linear_pos, uint32_t clr_code);
void get_xy( uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var );
void load_cell_xy(uint32_t x_var, uint32_t y_var, uint32_t clr_code);
void render_rect_mask(uint32_t ul_x, uint32_t ul_y, uint32_t lr_x, uint32_t lr_y, uint8_t color_8bit);
uint32_t color_convert_32(uint8_t color_8bit);
void cleaning_buffer(uint8_t color_8bit);

// void init_arr(uint8_t *in_arr, uint32_t a_size);
// void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
// void draw_snake();
// void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);

// void dump_ds_buffer();
//=================================================================================================================


// Set the offset transform values for the current sprite in the video buffer
void set_sprite_offset(uint32_t ofs_x, uint32_t ofs_y) {
    offset_x = ofs_x;
    offset_y = ofs_y;
}

int32_t get_offset_x() {
    return offset_x;
}
int32_t get_offset_y() {
    return offset_y;
}

/// Converts a linear cell postion and sets x and y grid co-ordinates
void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var ) {

    uint32_t row = 0;
    uint32_t col = 0;
    uint32_t temp_val = *cell_pos; 


    // If value is greater than the first row size
    while (temp_val >= (MAX_COL_WIDTH) ) {
        temp_val -= MAX_COL_WIDTH-1;
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


/// Convert the 8bit compact colour code to the IDE's 32bit CL_CODE
uint32_t color_convert_32(uint8_t color_8bit) {

    if (color_8bit == m_YELLOW){
        return CL_YELLOW;
    } else if (color_8bit == m_BLACK) {
        return CL_BLACK;
    } else if (color_8bit == m_RED) {
        return CL_RED;
    } else if (color_8bit == m_NAVY) {
        return CL_NAVY;
    } else if (color_8bit == m_GREEN) {
        return CL_GREEN;
    } else {
        return CL_WHITE;
    }
}

void set_brush_color(uint8_t color_8bit) {
    uint32_t px_clr;
    px_clr = color_convert_32(color_8bit);

    TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
    CUR_BRUSH_COLOUR = color_8bit; // assign the new colour code
}

/// Draws at a cell block at specific linear array position
void draw_cell_pos( uint32_t linear_pos, uint8_t color_8bit) {
    uint32_t x_var;
    uint32_t y_var;
    uint32_t cell_pos = linear_pos;
    
    // If the draw colour has changed, update it 
    if (color_8bit != CUR_BRUSH_COLOUR) {

        // // Convert the 32bit colour code to this 8bit one
        // if (color_8bit == m_YELLOW){
        //     px_clr = CL_YELLOW;
        // } else if (color_8bit == m_BLACK) {
        //     px_clr = CL_BLACK;
        // } else if (color_8bit == m_RED) {
        //     px_clr = CL_RED;
        // }
        

        // TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
        // CUR_BRUSH_COLOUR = color_8bit; // assign the new colour code
        set_brush_color(color_8bit);
    }

    // Get the x, y coordinates from the liner array
    get_xy(&cell_pos, &x_var, &y_var );

    // debug(x_var);
    // debug(y_var);

    x_var +=offset_x; // right 2 blocks
    y_var +=offset_y; // down 1 block

    // Draw over the old pixels first
    TFT_Rectangle(
            PX_BLOCK * x_var,                           // Upper-left X
            (y_var * PX_BLOCK),                         // Upper-left Y
            PX_BLOCK + (PX_BLOCK * x_var),              // Lower-right X
            PX_BLOCK + (PX_BLOCK * y_var)               // Lower-right Y
            );

    

}


/// Debug load and draw single block at specified coordinate pixel block
void draw_cell_xy(uint32_t x_var, uint32_t y_var) {
    uint32_t linear_val = 0;

    // // Draw the sprite directly
       TFT_Rectangle(
            PX_BLOCK * x_var,                   // Upper-left X
            (y_var * PX_BLOCK),                 // Upper-left Y
            PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
            PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
        );

    // Uncomment if you want to debug- not needed anymore?
    // // Convert to linear array  x + (y * col_width)
    // linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );

    // g_DS_BUFFER[linear_val] = 1;

}



/// A rectangle mask from point X->Y just enter LxW
// + offsets
void render_rect_mask(uint32_t ul_x, uint32_t ul_y, uint32_t lr_x, uint32_t lr_y, uint8_t color_8bit) {
    // CUR_BRUSH_COLOUR = color_convert_32(color_8bit);
    // TFT_SET_Brush(1, CUR_BRUSH_COLOUR, 0, 0, 0, 0  );
    set_brush_color(color_8bit);

    TFT_Rectangle(
            PX_BLOCK * ul_x,               // Upper-left X
            PX_BLOCK * ul_y,               // Upper-left Y
            PX_BLOCK * lr_x,               // Lower-right X
            PX_BLOCK * lr_y                // Lower-right Y
        );
    }



/// Load the cell data in to the display buffer, to be drawn later
void load_cell_xy(uint32_t x_var, uint32_t y_var, uint8_t clr_code) {
    uint32_t linear_val = 0;
    uint8_t color_8bit = clr_code;

// //   Draw the sprite directly
//        TFT_Rectangle(
//             PX_BLOCK * x_var,                   // Upper-left X
//             (y_var * PX_BLOCK),                 // Upper-left Y
//             PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
//             PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
//             );

    // Convert to linear array  x + (y * col_width)
    linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );

    g_DS_BUFFER[linear_val] = color_8bit;

}


void dump_ds_buffer() {
    uint32_t i=0;

    for (i=0; i < MAX_BLOCK_COUNT  ; i++) {

        if (g_DS_BUFFER[i] != 0xFF) {
            draw_cell_pos(i, g_DS_BUFFER[i]); // pass the colour code
        }

    }
}

void cleaning_buffer(uint8_t color_8bit) {
    uint32_t i=0;

    for (i=0; i < MAX_BLOCK_COUNT  ; i++) {

        if (g_DS_BUFFER[i] != 0xFF) {
            draw_cell_pos(i, color_8bit ); // pass the colour code
        }

    }
}


// void transform_sprite_(uint8_t transform_dir) {
//     uint32_t i=0;

//     for (i=0; i < MAX_BLOCK_COUNT  ; i++) {

//         if (g_DS_BUFFER[i] != 0xFF) {
//             draw_cell_pos( i, g_DS_BUFFER[i] ); // pass the colour code
//         }

//     }
// }

#endif // _CP_PIX_RENDER_H