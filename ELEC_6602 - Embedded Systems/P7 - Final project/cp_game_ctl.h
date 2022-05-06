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
const static int32_t MAX_CELLS                            = 300;



// static const uint8_t m_
// static const uint8_t m_


/* Global variables */

// Game states flags
static uint8_t g_GAME_PHASE                         = PHASE1_READY;
static uint8_t g_curr_snake_dir                     = MOVE_RIGHT;
static volatile uint8_t  g_game_clock_delay_tim3    = ON;
static volatile uint32_t g_time_count               = 0;
static uint32_t g_game_score                        = 0;
static int32_t g_debug                              = 0;
static int32_t g_debug2                             = 2;
static int32_t g_rand_num                          = 999;
static uint8_t g_food_in_play                       = FALSE;
static int32_t g_fd_x_val                          = NEG_NULL;
static int32_t g_fd_y_val                          = NEG_NULL;
int32_t i=0;

uint8_t g_str_buffer[128];                                // General use string buffer for output text

static uint32_t g_t_mins            = 0;
static uint32_t g_t_secs            = 0;
static uint32_t g_t_wait            = FALSE;


// Snake info tracking
t_node g_snake_cells[MAX_CELLS];                               // track the current snake 
t_node *m_node_start          = &g_snake_cells;
t_node *m_node_end            = &g_snake_cells[MAX_CELLS-1];  // addressing is 4bytes less than allocated cells; [length-1]
t_node *m_node_head           = &g_snake_cells;    
t_node *m_node_tail           = &g_snake_cells;



//=============================================================================================================
/* Prototypes */

// External calls
void load_game_screen();
uint8_t get_game_mode();
void update_game_time();
void move_snake();
void set_curr_snake_dir();
void scr_debug(uint32_t value);  // Debugging function



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
t_node* incr_node(t_node *_node);



// Flag updating functions
void update_snake_info(int32_t head_x, int32_t head_y);
void toggle_game_clock_delay();
void set_food_in_play_flag (uint8_t state);
void set_food_xy(int32_t *x_val, int32_t *y_val);
//=============================================================================================================
/// Debugger
void scr_debug(int32_t value, int32_t value2) {
    g_debug = value;
    g_debug2 = value2;
}
//=============================================================================================================
/* Interrupt Functions */

/// Set the snake direction 
///
void set_curr_snake_dir(uint8_t new_dir) {
    g_curr_snake_dir = new_dir;
}

/// Toggle the game clock delay from timer3
///
void toggle_game_clock_delay() {
    g_game_clock_delay_tim3 = ~g_game_clock_delay_tim3;
}

// Update the game timer
///
void update_game_time () {
    g_time_count++;
}

/// Get the current game mode
///
uint8_t get_game_mode() {
    return g_GAME_PHASE;
}

/// Set g_food_in_play flag
///
void set_food_in_play_flag (uint8_t state) {
    g_food_in_play = state;
}

/// Set/Update food x y
///
void set_food_xy(int32_t *x_val, int32_t *y_val) {
    g_fd_x_val = *x_val;
    g_fd_y_val = *y_val;

    // scr_debug(g_fd_x_val, g_fd_y_val);
}



/// Move the snake
///
//  Pulls the g_curr_snake_dir to get the current direction set by the last joystick cmd
void move_snake() {
    
    int16_t temp_x = m_node_head->node_x;  
    int16_t temp_y = m_node_head->node_y;  

    if (g_curr_snake_dir == MOVE_RIGHT) {

        if (m_node_head+1 > m_node_end) {
            m_node_start->node_x = ++temp_x;
            m_node_start->node_y = temp_y;

            m_node_head = m_node_start;
        } else {
            // move snake head 1 space RIGHT
            (m_node_head+1)->node_x = ++temp_x;
            (m_node_head+1)->node_y = temp_y;
            incr_snake_head();
        }
        
        // Increment the snake head pointer

        // Boundaries      
        if (m_node_head->node_x > MAX_COL_WIDTH-1) { //0-indexed array
            m_node_head->node_x = 0;
        }
    } 
    else if (g_curr_snake_dir == MOVE_LEFT)  {

        if (m_node_head+1 > m_node_end) {
            (m_node_start)->node_x = --temp_x;
            (m_node_start)->node_y = temp_y;

            m_node_head = m_node_start;
        } else {
            // move snake head 1 space LEFT
            (m_node_head+1)->node_x = --temp_x;
            (m_node_head+1)->node_y = temp_y;
            // Increment the snake head pointer
            incr_snake_head();
        }

        // Boundaries      
        if (m_node_head->node_x < 0) {
            m_node_head->node_x = 19;
        }
       
    }
    else if (g_curr_snake_dir == MOVE_UP)  {

        if (m_node_head+1 > m_node_end) {
            (m_node_start)->node_x = temp_x;
            (m_node_start)->node_y = --temp_y;
            m_node_head = m_node_start;
        } else {
            // move snake head 1 space UP
            (m_node_head+1)->node_x = temp_x;
            (m_node_head+1)->node_y = --temp_y;
            // Increment the snake head pointer
            incr_snake_head();
        }

        // Boundaries      
        if (m_node_head->node_y < 1 ) { // status bar is row 0
            m_node_head->node_y = (MAX_ROW_LENGTH-1);
        }
    }
    else if (g_curr_snake_dir == MOVE_DOWN)  {
        if (m_node_head+1 > m_node_end) {
            (m_node_start)->node_x = temp_x;
            (m_node_start)->node_y = ++temp_y;
            m_node_head = m_node_start;
        } else {
            // move snake head 1 space DOWN
            (m_node_head+1)->node_x = temp_x;
            (m_node_head+1)->node_y = ++temp_y;
            
            // Increment the snake head pointer
            incr_snake_head();
        }

        // Boundaries      
        if (m_node_head->node_y > MAX_ROW_LENGTH-1 ) { // status bar is row 0
            m_node_head->node_y = 1;
        }

    }

}

/// Check snake collision
///
int32_t check_snake_collision(int16_t x_val, int16_t y_val, t_node * start_pos) {
    int32_t ret;
    t_node *temp_itr = start_pos;

    if (start_pos > m_node_end) {
        start_pos == m_node_start;
    }

    do {
        // scr_debug(temp_itr->node_x, temp_itr->node_y );
        // draw_cell_xy(temp_itr->node_x, temp_itr->node_y+2, m_YELLOW);
        
        if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {
            
            return TRUE; // Collision found    
        } 
        
        temp_itr = incr_node(temp_itr);
    } while (temp_itr <= m_node_head);
    
    return FALSE;
}

/// Generate food() 
///
void generate_food() {

    int32_t fd_x_val;
    int32_t fd_y_val;
    int16_t col_ret = TRUE;
    
    
    int32_t temp_time = TIM3_CNT %33;

    // Roll the dice random time to get a different random number

    do  {

        for (i=0; i <= temp_time; i++) {
            // Generate random number limited to # of screen positions
            g_rand_num = (int32_t)  (rand() % MAX_BLOCK_COUNT);// + MAX_COL_WIDTH because row 0 is reserved for info
        }   
        
        scr_debug(g_rand_num, temp_time);
        // Convert the linear random number 
        convert_lin_xy(&g_rand_num, &fd_x_val, &fd_y_val);

      

        // Check for collison 
        col_ret = check_snake_collision(&fd_x_val, &fd_y_val, m_node_tail);

        
        // If TRUE, re-generate new number, else print on screen
        if (col_ret == FALSE) {
            // Update the food in play flag
            draw_cell_pos(&g_rand_num, m_FUCHSIA);
            set_food_in_play_flag(TRUE);

            // Update current food coordinates
            set_food_xy(&fd_x_val, &fd_y_val);
        }

    } while (col_ret == TRUE);

}


/// Increment the snake head queue
///
void incr_snake_head() {
    
    if (m_node_head < m_node_end) { // array_size * sizeof(t_node)
        m_node_head++;
    } else {
        // node_head = node_restart_head; // Wrap around array if end is reached
        m_node_head = m_node_start; // Wrap around array if end is reached
    }

}

/// Increment iterator nodes - ** Compiler will aonly let you set ptr to node if you return it
///
t_node* incr_node( t_node *_node) {
    
    // array_size * sizeof(t_node)
    if (_node <= m_node_end) {  
        _node++;
    } else {
        // Wrap around array if end is reached
        _node = m_node_start; 
    }

    return _node;
}


/// Increment the snake tail queue
///
void incr_snake_tail() {
    
    if (m_node_tail != m_node_head) {

        // clear the cell data
        m_node_tail->node_x = 0xFF;
        m_node_tail->node_y = 0xFF;

        // array_size * sizeof(t_node)
        if (m_node_tail < m_node_end) { 
            m_node_tail++;
        } else {
            // Wrap around array if end is reached
            m_node_tail = m_node_start; 
        }
    }

}

/// Initialize array to 0
///
void init_arr(uint8_t *in_arr, uint32_t a_size) {
    uint32_t i=0;

    for (i=0; i < a_size; i++) {
        in_arr[i]=0xFF;
    }
}



//==========================================================================================================
/// Load the game screen
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

/// Initial Game loading screen.
///
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
///
void update_stats() {
    sprintf(g_str_buffer, "Score: \x20 %04d", g_game_score);
    TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);

    //  Update game mode - or debugging info for now
    sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );       // ****Printout debugger
    TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 0*PX_BLOCK);
}

/// Update timer and print it to screen 
///
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

/// Initialize screen
///
void init_snake_game() {
     // Set the game phase mode flag
    g_GAME_PHASE = PHASE2_PLAYING;
    
    init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);

    // Reset the current screen run flag to stay in this mode
    set_cur_screen_run_flag(TRUE);

     // Setup screen 
    TFT_Fill_Screen(CL_BLACK);

    // Set snake colour
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    set_brush_color(m_GREEN);

    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
   
    Delay_ms(100);  // Delay to allow screen to get wiped
    init_snake_sprite();

    dump_ds_buffer();


}

//==================================================================================================
/// Main Snake game
///
void start_snake_game() {
        Delay_ms(500); // Allow timers to wind up

    /* Local variables */

    /***** Main game Loop******/
    while (cur_screen_run_flag == TRUE) {
        // Hold here until TIMER3 pulse allows up to move
        // g_game_clock_delay_tim3 = ON
        
    };

    // Reset and cleanup offset on quit
    set_sprite_offset(0,0);
    // g_GAME_PHASE = QUIT;
}


/// Set the initial values of the snake
///
// ** Do not put in main game loop, this exactly sequence prevents image artifacting
void init_snake_sprite() {
    m_node_head->node_x = 0;
    m_node_head->node_y = 1;
    print_snake(m_node_head, m_GREEN);
    generate_food();
}


///  Refresh game screen - This will be the game loop
///
void screen_refresh_TIM3() {
        
    // Clean previous buffered image out and update new movement; Check is tail is going to erase body before
    if ( check_snake_collision((m_node_tail)->node_x, (m_node_tail)->node_y, m_node_tail+1) == FALSE ) {
        clean_tail(m_node_tail, m_BLACK);
    }

    draw_cell_xy(g_fd_x_val, g_fd_y_val, m_FUCHSIA); // refresh food
    Delay_ms(5);


    move_snake();
    print_snake(m_node_head, m_GREEN);
    Delay_ms(5); // Delay needed for screen to catch up                 

    // Check if snake has collided with food if true, add to tail (don't erase tail)
    if ( check_snake_collision(g_fd_x_val, g_fd_y_val, m_node_head) == FALSE ) {
         incr_snake_tail();
    } else {
        g_game_score++;
        generate_food();
    }

   
    
    
    
    // Reduce this delay with other non time sensitive operations
    Delay_ms(1);

    // if (g_food_in_play == FALSE) {
    // }

    // // Reset the food flag
    // g_food_in_play = TRUE;
    
}






#endif //_CP_GAME_CTL_H





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


//////////////////////////////////////////////////////////////////////////
// /// Dump the entire contents of an array at given size to serial
// void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
//     uint32_t i = 0;

//     for ( i=0; i < MAX_BLOCK_COUNT; i++) {
        
//         // Critical delay and waits required for write to USART
//         while ( (USART1_SR & (1 << 7 )) == 0) {}
//         Delay_ms(10);                                   
//         USART1_DR = (uint32_t)in_arr[i];
//         Delay_ms(10);
            
//     }
// }

// void debug(uint32_t val) {
//          // Critical delay and waits required for write to USART
//         while ( (USART1_SR & (1 << 7 )) == 0) {}
//         Delay_ms(10);                                   
//         USART1_DR = (uint32_t)val;
//         Delay_ms(10);
// }

// void update_snake_info(uint32_t head_x, uint32_t head_y, uint8_t tail_flag) 
// {
//     snake_info[0] = head_x;
//     snake_info[1] = head_y;
  
//     // assign current node head
//     node_head->node_x = head_x;
//     node_head->node_y = head_y;


//     // increment head
//     incr_snake_head();

//     // OPTIONAL update tail too
//     if (tail_flag == TAIL_ON) {
//     // assign node tail
//     node_tail->node_x = head_x;
//     node_tail->node_y = head_y;
//         incr_snake_tail();
//     }
// }

