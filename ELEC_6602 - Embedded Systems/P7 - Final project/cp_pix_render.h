/// cp_pix_render.h
// Pixel Renderer display "Engine"
// Handles the video buffer and all the image printing and manipulating

// implement double buffer technique.

#ifndef _CP_PIX_RENDER_H
#define _CP_PIX_RENDER_H

#include "cp_const_def.h"

/* Constants */
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
void cleaning_buffer (uint8_t color_8bit);
void convert_lin_xy ( int32_t *cell_pos, int32_t *x_var, int32_t *y_var );
void draw_cell_pos ( int32_t *linear_pos, uint8_t color_8bit);
void init_arr (uint8_t *in_arr, uint32_t a_size);
void load_cell_xy (int32_t x_var, int32_t y_var, int32_t clr_code);
void render_rect_mask (int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit);
void set_sprite_offset (int32_t ofs_x, int32_t ofs_y);

int32_t color_convert_32 (uint8_t color_8bit);
int32_t get_offset_x ();

void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_ini_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit );

void dump_ds_buffer(); // For large sprites; logos etc..
//=================================================================================================================


/// Initialize array to 0
///
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


/// Set the offset transform values for the current sprite in the video buffer
///
void set_sprite_offset(int32_t ofs_x, int32_t ofs_y) {
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
///
void convert_lin_xy(int32_t *cell_pos, int32_t *x_var, int32_t *y_var ) {

    int32_t row = 0;
    int32_t col = 0;
    int32_t temp_val = *cell_pos; 

    if (temp_val > MAX_BLOCK_COUNT) {
        temp_val = 300;
    }

    // Left over value will equal column, but since matrix is 0-indexed,
    // remainders are not zero indexed so we have to subtract 1.
    // If value is greater than the first row size
    while (temp_val >= (MAX_COL_WIDTH) ) {
        temp_val -= MAX_COL_WIDTH-1;
        ++row;

        if (temp_val > 0 ) {
            --temp_val; // compensate for zero-index of array by subtract 1
        }
        
    }
    

    // y=0 is off-limits
    if (row <= 0 ) {
        row = 1;
    }

    col = temp_val;

    *x_var = col;
    *y_var = row;

}

/// Convert the 8bit compact colour code to the IDE's 32bit CL_CODE
///
int32_t color_convert_32(uint8_t color_8bit) {

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
    } else if (color_8bit == m_FUCHSIA) {
        return CL_FUCHSIA;
     } else if (color_8bit == m_GRAY) {
        return CL_GRAY;
    } else {
        return CL_WHITE;
    }
}


/// Set the brush color for rectangles
///
void set_brush_color(uint8_t color_8bit) {
    int32_t px_clr;
    px_clr = color_convert_32(color_8bit);

    TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
    CUR_BRUSH_COLOUR = color_8bit; // assign the new colour code
}


/// Draws at specific linear array position cell block
///
void draw_cell_pos( int32_t *linear_pos, uint8_t color_8bit) {
    int32_t x_var;
    int32_t y_var;
    int32_t cell_pos = *linear_pos;
    
    // If the draw colour has changed, update it 
    if (color_8bit != CUR_BRUSH_COLOUR) {

        set_brush_color(color_8bit);
    }

    // Get the x, y coordinates from the liner array
    convert_lin_xy(&cell_pos, &x_var, &y_var );

    // Sprite offsets
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
///
void draw_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {

    if (color_8bit != CUR_BRUSH_COLOUR) {
    set_brush_color(color_8bit);
    }


    // Sprite offsets
    x_var +=offset_x; // right 2 blocks
    y_var +=offset_y; // down 1 block

    
    // Draw the sprite directly
       TFT_Rectangle(
            PX_BLOCK * x_var,                   // Upper-left X
            (y_var * PX_BLOCK),                 // Upper-left Y
            PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
            PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
        );
}

/// Debug load and draw single block at specified coordinate pixel block
///
void draw_ini_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {

    if (color_8bit != CUR_BRUSH_COLOUR) {
    set_brush_color(color_8bit);
    }


    // Sprite offsets
    x_var +=offset_x; // right 2 blocks
    y_var +=offset_y; // down 1 block

    
    // Draw the sprite directly
       TFT_Rectangle(
            INI_BLOCK * x_var,                   // Upper-left X
            (y_var *  PX_BLOCK),                 // Upper-left Y
            INI_BLOCK + ( INI_BLOCK * x_var),      // Lower-right X reduce this number
             PX_BLOCK + ( PX_BLOCK * y_var)       // Lower-right Y
        );
}




/// A rectangle mask from point X->Y just enter LxW + offsets
///
void render_rect_mask(int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit) {
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



/// Load the cell data in to a linear display buffer, to be drawn later
///
void load_cell_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
    int32_t linear_val = 0;
    uint8_t color_8bit = clr_code;

// //   Draw the sprite directly - Debug  sprite printout
    //    TFT_Rectangle(
    //         PX_BLOCK * x_var,                   // Upper-left X
    //         (y_var * PX_BLOCK),                 // Upper-left Y
    //         PX_BLOCK + (PX_BLOCK * x_var),      // Lower-right X
    //         PX_BLOCK + (PX_BLOCK * y_var)       // Lower-right Y
    //         );

    // Convert to linear array  x + (y * col_width)
    linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
    g_DS_BUFFER[linear_val] = color_8bit;

}


/// Dump a linear array buffer sprite
///
void dump_ds_buffer() {
    int32_t i=0;

    for (i=0; i < MAX_BLOCK_COUNT  ; i++) {

        if (g_DS_BUFFER[i] != 0xFF) {
            draw_cell_pos(i, g_DS_BUFFER[i]); // pass the colour code
        }

    }
}


/// Print snake node
///
void print_snake(t_node *node, uint8_t color_8bit) {
    draw_cell_xy(node->node_x, node->node_y, color_8bit);
}


/// Clean up the snake tail node
///
void clean_tail(t_node * node_tail,  uint8_t color_8bit) {
    print_snake(node_tail, color_8bit);
}


void cleaning_buffer(uint8_t color_8bit) {
    int32_t i=0;

    for (i=0; i < MAX_BLOCK_COUNT  ; i++) {

        if (g_DS_BUFFER[i] != 0xFF) {
            draw_cell_pos(i, color_8bit ); // pass the colour code~
        }

    }
}



#endif // _CP_PIX_RENDER_H