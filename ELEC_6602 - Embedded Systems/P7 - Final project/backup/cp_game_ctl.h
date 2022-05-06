/// cp_game_ctl.h
//  Game screen/engine control handler

#ifndef _CP_GAME_CTL_H
#define _CP_GAME_CTL_H

#include <stdint.h>
#include <string.h>
#include "cp_const_def.h"
#include "cp_pix_render.h"

/* Constants */

static const uint8_t EOF_ARRAY     = 0xFF;             // End marker for display array matrix



// static const uint8_t m_
// static const uint8_t m_


/* Global variables */

// Game states flags
static uint8_t g_GAME_PHASE                       = PHASE1_READY;
static uint8_t g_curr_snake_dir             = MOVE_RIGHT;
static volatile uint8_t  g_game_clock_delay_tim3  = ON;
static volatile uint32_t g_time_count             = 0;
static uint32_t g_game_score                      = 0;
static int32_t g_debug                            = 0;
static uint32_t g_rand_num                          = 999;



uint8_t g_str_buffer[128];                                // General use string buffer for output text
t_node g_snake_cells[50];                               // track the current snake 

static uint32_t g_t_mins            = 0;
static uint32_t g_t_secs            = 0;
static uint32_t g_t_wait            = FALSE;


// Snake info tracking
t_node *node_start = &g_snake_cells;
t_node *node_end = &g_snake_cells[50];
t_node *node_head = &g_snake_cells;    
t_node *node_tail = &g_snake_cells;    

static int16_t snake_info[16];
static int16_t *s_head_x = &snake_info[0];
static int16_t *s_head_y = &snake_info[1];
static int16_t *s_tail_x = &snake_info[2];
static int16_t *s_tail_y = &snake_info[3];
static int16_t *s_length = &snake_info[4];
static int16_t *s_food_x = &snake_info[5];
static int16_t *s_food_y = &snake_info[6];


//=============================================================================================================
/* Prototypes */

// External calls
void load_game_screen();
uint8_t get_game_mode();
void update_game_time();
void move_snake();
void set_curr_snake_dir();
void scr_debug(uint32_t * value);  // Debugging function



// Local calls
void init_arr(uint8_t *in_arr, uint32_t a_size);
void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);

void duck_sprite();
void init_snake_sprite();
void dump_ds_buffer();
void incr_snake_head();
void incr_snake_tail();

// Flag updating functions
void update_snake_info(int32_t head_x, int32_t head_y);
void toggle_game_clock_delay();

//=============================================================================================================
/* Interrupt Functions */
/// Set the snake direction 
void set_curr_snake_dir(uint8_t new_dir) {
    g_curr_snake_dir = new_dir;
}

/// Toggle the game clock delay from timer3
void toggle_game_clock_delay() {
    g_game_clock_delay_tim3 = ~g_game_clock_delay_tim3;
}

// Update the game timer
void update_game_time () {
    g_time_count++;
}

/// Get the current game mode
uint8_t get_game_mode() {
    return g_GAME_PHASE;
}

void move_snake() {
    
    int32_t sprit_offset_x = get_offset_x();
    int32_t sprit_offset_y = get_offset_y();
    int16_t temp_x = node_head->node_x;  
    int16_t temp_y = node_head->node_y;  

    if (g_curr_snake_dir == MOVE_RIGHT) {
        
        
        // sprit_offset_x++;
        // *s_head_x++;


        // g_debug = sprit_offset_x;

        // move snake head 1 space right
        (node_head+1)->node_x = ++temp_x;
        (node_head+1)->node_y = temp_y;
        
        incr_snake_head();

        // Increment the snake head pointer

        // Delete the tail - skip if we touch food box
        //if food_flag != TRUE
        // node_tail->node_x = 0xFF;
        // node_tail->node_y = 0xFF;

        // Increment the tail pointer
        // incr_snake_tail();

        // if (sprit_offset_x >=19) {
        //     sprit_offset_x = 0;
        // }
        if (node_head->node_x >=19) {
            node_head->node_x = 0;
        }
    } 
    else if (g_curr_snake_dir == MOVE_LEFT)  {
        sprit_offset_x--;
        s_head_x--;
        
        if (sprit_offset_x <=0) {
            sprit_offset_x = 19;
        }
    }
    else if (g_curr_snake_dir == MOVE_UP)  {
        sprit_offset_y--;
        s_head_y--;
        
        if (sprit_offset_y <=0) {
            sprit_offset_y = 15;
        }

    }
    else if (g_curr_snake_dir == MOVE_DOWN)  {
          sprit_offset_y++;
          s_head_y++;
        
        if (sprit_offset_y >=15) {
            sprit_offset_y = 0;
        }


    } else {
        // No movement
        sprit_offset_x = 0;
        sprit_offset_y = 0;  
    }

    // set_sprite_offset( sprit_offset_x, sprit_offset_y);
    
}

/// Generate food() 
void  generate_food() {
    g_rand_num = (uint32_t) (rand() % MAX_BLOCK_COUNT);// + MAX_COL_WIDTH because row 0 is reserved for info
    

    // Convert linear number to x,y coordinates
    get_xy(&g_rand_num, &s_food_x, &s_food_y);
}

/// Increment the snake head queue
void incr_snake_head() {
    
    if (node_head <= node_end) { // array_size * sizeof(t_node)
        node_head++;
    } else {
        node_head = node_start; // Wrap around array if end is reached
    }

}

/// Increment the snake tail queue
void incr_snake_tail() {
    
    // clear the cell data
    node_tail->node_x = 0xFF;
    node_tail->node_y = 0xFF;
    
    if (node_tail <= node_end) { // array_size * sizeof(t_node)
        node_tail++;
    } else {
        node_tail = node_start; // Wrap around array if end is reached
    }

}

void update_snake_info(uint32_t head_x, uint32_t head_y, uint8_t tail_flag) 
{
    snake_info[0] = head_x;
    snake_info[1] = head_y;
  
    // assign current node head
    node_head->node_x = head_x;
    node_head->node_y = head_y;


    // increment head
    incr_snake_head();

    // OPTIONAL update tail too
    if (tail_flag == TAIL_ON) {
    // assign node tail
    node_tail->node_x = head_x;
    node_tail->node_y = head_y;
        incr_snake_tail();
    }
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

void load_snake_game() {

    // Set the game phase mode flag
    g_GAME_PHASE = PHASE1_READY;

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

/// Update the score and print it to screen
void update_stats() {
    sprintf(g_str_buffer, "Score: \x20 %05d", g_game_score);
    TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);

    //  Update game mode - or debugging info for now
    sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d",g_debug );       // ****Printout debugger
    TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 0*PX_BLOCK);
}

/// Update timer and print it to screen 
void update_time() {
    g_t_secs = g_time_count % 60;
    if (g_t_secs != 0) {
        g_t_wait = FALSE;
    }
    if (g_t_secs == 0 && g_t_wait == FALSE) {
        g_t_mins++;
        g_t_wait = TRUE;
    }
    sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins, g_t_secs );
    TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);
}


/// initialize screen
void init_snake_game() {
     // Set the game phase mode flag
    g_GAME_PHASE = PHASE2_PLAYING;
    
    init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
    // dump_arr_memory(&g_DS_BUFFER, MAX_BLOCK_SIZE);

    // Reset the current screen run flag to stay in this mode
    set_cur_screen_run_flag(TRUE);
     // Setup screen 
    TFT_Fill_Screen(CL_BLACK);
   
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    set_brush_color(m_GREEN);

    // sprintf(g_str_buffer, "Score: %d          Time: %d", rand);


    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
   
    Delay_ms(100);  // Delay to allow screen to get wiped
    init_snake_sprite();

    dump_ds_buffer();

}

//==================================================================================================
/// Main Snake game
void start_snake_game() {

    /* Local variables */
    // uint8_t g_str_buffer[128];
    uint32_t num = 2550;
    // int rand_num;

   


    /***** Game Loop******/
    while (cur_screen_run_flag == TRUE) {
        // Hold here until TIMER3 pulse allows up to move
        // g_game_clock_delay_tim3 = ON;

       
       

        // // Things to do while waiting
        // while (g_game_clock_delay_tim3 == ON) {
        //     /* clean screen mask */
        //     //update direction and refresh screen here?
        //     render_rect_mask(0,0,20,1, m_NAVY);
        //     Delay_ms(100);
        //     //  render_rect_mask(0,10,19,0, m_BLACK);
        //     // /* Update time */
        //     update_time();

        //     // /* Update score */
        //     update_score();

        //     // Update game mode
        //     sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d",g_debug );
        //     TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 0*PX_BLOCK);
            

        // }

    
     
        // Clean previous buffered image out and update new movement
        // cleaning_buffer(m_BLACK);                       
        // move_snake();
        // dump_ds_buffer();

        // Delay will be on so do any additional house keeping here while waiting.
        // update coordinates for snake
        
    };

    // Reset and cleanup offset on quit
    set_sprite_offset(0,0);
    // g_GAME_PHASE = QUIT;
}

void screen_refresh_TIM3() {
        
        
    generate_food();
    
    // Clean previous buffered image out and update new movement
    // cleaning_buffer(m_BLACK);      
    clean_tail(node_tail, m_BLACK);


    move_snake();
    print_snake(node_head, m_GREEN);
    Delay_ms(100); // Delay needed for screen to catch up                 
    // dump_ds_buffer();
    incr_snake_tail();
    Delay_ms(50);
}






#endif //_CP_GAME_CTL_H

void scr_debug(uint32_t * value) {
    g_debug = *value;
}


void init_snake_sprite() {
    //  load_cell_xy(0,1, m_GREEN);
    //  update_snake_info(0,1);

    node_head->node_x = 0;
    node_head->node_y = 1;
    
    print_snake(node_head, m_GREEN);


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