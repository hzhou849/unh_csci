/// cp_game_ctl.h
//  Game screen/engine control handler

#ifndef _CP_GAME_CTL_H
#define _CP_GAME_CTL_H

#include <stdint.h>
#include <string.h>
#include "cp_const_def.h"
#include "cp_pix_render.h"
// #include "cp_game_over_ctl.h"

/* Constants */
static const uint8_t EOF_ARRAY     = 0xFF;             // End marker for display array matrix
const static int32_t MAX_CELLS                            = 300;
static const uint32_t EEPROM_MAX_SIZE               =100; // 3 Initials, 4 for score = 7 chars x 10 rows = 70 Minimun
static const uint8_t init_cursor_start                        = 0x41;          // '@'; 1 char less than 'A' allow for increment algorithm


/* Global variables */
// Game states flags - variables needs global tow work 
// compiler has issues with declaring variables in functions.
static volatile uint8_t game_cur_screen_run_flag        = TRUE;

static uint8_t g_TIME_TRACK_MODE                        = TOTAL_TIME;
static uint8_t g_GAME_MODE                              = NORMAL_MODE;  // DEV_MODE 
// static uint8_t g_GAME_MODE                              = DEV_MODE;  // DEV_MODE 
static uint8_t g_curr_snake_dir                         = MOVE_RIGHT;
static volatile uint8_t  g_game_clock_delay_tim3        = ON;
static uint32_t g_game_score                            = 0;
static int32_t g_debug                                  = 0;
static int32_t g_debug2                                 = 2;
static int32_t g_rand_num                               = 999;
static uint8_t g_food_in_play                           = FALSE;
static int32_t g_fd_x_val                               = NEG_NULL;
static int32_t g_fd_y_val                               = NEG_NULL;
static int32_t init_cur_pos                           = 0; 
static uint8_t user_score_entry[7];
static int32_t i                                               =0;    // Generic counters
static int32_t j             =0;    // Generic counters
static uint32_t i2c_status;
static uint8_t  tx_buffer_[128];
static uint8_t  rx_buffer_[256];
static int32_t hs_cursor_x                              = HS_CURSOR_START_X;
static int32_t hs_cursor_y                              = HS_CURSOR_START_Y;
uint8_t init_cur                                        = init_cursor_start; // 'A' -1
int32_t game_speed                                    =1;



uint8_t g_str_buffer[256];                                // General use string buffer for output text

// Time tracking
static volatile uint32_t g_time_count                   = 0;
static volatile uint32_t g_session_count                = 0;
static uint32_t g_t_mins                                = 0;
static uint32_t g_t_secs                                = 0;
static uint32_t g_t_wait                                = FALSE;


// Snake info tracking
t_node g_snake_cells[MAX_CELLS];                        // track the current snake 
t_node *m_node_start                                    = &g_snake_cells;
t_node *m_node_end                                      = &g_snake_cells[MAX_CELLS-1];  // Actual addressing is 4bytes less than 
                                                                                        // allocated cells; [length-1]
t_node *m_node_head                                     = &g_snake_cells;    
t_node *m_node_tail                                     = &g_snake_cells;



//=============================================================================================================
/* Prototypes */

// External calls
void load_game_screen();
uint8_t get_game_phase();
void update_game_time();
void move_snake();
void set_curr_snake_dir();
void scr_debug(uint32_t value);  // Debugging function
void update_game_time ();
void update_game_speed();
void set_secret_mode ();

// Local calls
void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);
void init_snake_sprite();
void incr_snake_head();
void incr_snake_tail();
t_node* incr_node(t_node *_node);
void game_over();
int32_t get_initial_cur_pos ();

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

/// Reset game values
///
void reset_game_values () {
    i =0;    // Generic counters
    j =0;    // Generic counters
    g_session_count      = 0;
    g_game_score         = 0;
    g_debug              = 0;
    g_debug2             = 2;
    g_rand_num           = 999;
    g_food_in_play       = FALSE;
    g_fd_x_val           = NEG_NULL;
    g_fd_y_val           = NEG_NULL;
    init_cur    = init_cursor_start;         
    init_cur_pos         = 0; 

    hs_cursor_x          = HS_CURSOR_START_X;
    hs_cursor_y          = HS_CURSOR_START_Y;

    user_score_entry[3] = 0;
    user_score_entry[4] = 0;
    user_score_entry[5] = 0;
    user_score_entry[6] = 0;

}

/// Update game sped
///
void update_game_speed(uint32_t gspeed) {
    game_speed = gspeed;
}

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

/// Set the developer mode
void set_secret_mode() {
    g_GAME_MODE = DEV_MODE;
}

void update_session_time() {
    g_session_count++;
}

/// Get the current game mode
///
uint8_t get_game_phase() {
    return g_GAME_PHASE;
}

/// Get Initial curson position
int32_t get_initial_cur_pos () {
    return init_cur_pos; 
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
}

/// Play sound - High pitch
///
void play_sound1( uint32_t duration) {

    for (i=0; i < duration; i++) {
            GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
            Delay_ms(SFX_FOOD_HIGH);
    }
}

/// Play sound - High pitch
///
void play_sound2( uint32_t duration) {

    for (i=0; i < duration; i++) {
            GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
            Delay_ms(SFX_FOOD);
    }
}

/// Play sound - High pitch
///
void play_sound3( uint32_t duration) {

    for (i=0; i < duration; i++) {
            GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
            Delay_ms(SFX_WALL);
    }
}

/// Play sound - High pitch
///
void play_sfx_wall( uint32_t duration) {

    for (i=0; i < duration; i++) {
        GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
        Delay_ms(5);
    }

    for (i=0; i < duration; i++) {
        GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
        Delay_ms(10);
    }

    for (i=0; i < duration; i++) {
        GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
        Delay_ms(15);
    }
}


/// Play sound - High pitch
///
void play_sfx_food( uint32_t duration) {

    for (i=0; i < duration; i++) {
            GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
            Delay_ms(5);
    }

      for (i=0; i < duration; i++) {
            GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
            Delay_ms(3);
    }

         for (i=0; i < duration; i++) {
            GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
            Delay_ms(1);
    }
}


/// Game over
/// 
void game_over() {
    // void EXTIPA0();
    // Kill Timers
    // // TIM2_CR1 = 0; // Kill TIMER2 for game time
    TIM3_CR1 = 0; // Kill TIMER3 now
    play_sfx_wall(20);
    g_GAME_PHASE = PHASE_QUIT;  
    game_cur_screen_run_flag = FALSE;
}



/// Move the snake
///
//  Pulls the g_curr_snake_dir to get the current direction set by the last joystick cmd
void move_snake() {
    
    int16_t temp_x = m_node_head->node_x;  
    int16_t temp_y = m_node_head->node_y;  

    if (g_curr_snake_dir == MOVE_RIGHT) {

        // Increment the snake head pointer
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

        // Boundaries, Normal mode = game over     
      
        if (m_node_head->node_x > MAX_COL_WIDTH-1 ) { //0-indexed array
            
            if (g_GAME_MODE == NORMAL_MODE) {
                game_over();
            
            } else {
                m_node_head->node_x = 0;
            }
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
            if (g_GAME_MODE == NORMAL_MODE) {
            game_over();

            } else {
            m_node_head->node_x = 19;
            }
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
            if (g_GAME_MODE == NORMAL_MODE) {
                game_over();
            
            } else {
                m_node_head->node_y = (MAX_ROW_LENGTH-1);
            }
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
            if (g_GAME_MODE == NORMAL_MODE) {
                game_over();
            
            } else {
                m_node_head->node_y = 1;
            }
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
        scr_debug(temp_itr->node_x, temp_itr->node_y );
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
        
        // scr_debug(g_rand_num, temp_time);
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


/// Initial Game loading screen.
///
void load_snake_game() {

    // Set the game phase mode flag
    set_game_phase(PHASE1_READY);

    //  init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);

    // Set the current screen run flag
    set_cur_screen_run_flag(TRUE);
     // Setup screen 
    TFT_Fill_Screen(CL_BLACK);
   
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    set_brush_color(m_BLACK);

    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_AQUA, FO_HORIZONTAL );
    TFT_Write_Text("SNAKE!", 8 * PX_BLOCK, 6 * PX_BLOCK);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
    TFT_Write_Text("v.1.0", 18* PX_BLOCK, 0 * PX_BLOCK);
    TFT_Write_Text("By Howard Zhou", 13 * PX_BLOCK, 14 * PX_BLOCK);
    TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 11*PX_BLOCK);
    
    while (cur_screen_run_flag == TRUE) {};
    // Wipe the screen after
     TFT_Fill_Screen(CL_BLACK);
}


/// Update the score and print it to screen
///
void update_stats() {
    sprintf(g_str_buffer, "Score: \x20 %04d", g_game_score);
    TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);

    //  Update game mode - or debugging info for now
    if (g_GAME_MODE == NORMAL_MODE) {
        sprintf(g_str_buffer, "MODE: \x20 NORM" ); 
    }
    else {
        sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );       // ****Printout debugger
    }
    TFT_Write_Text(&g_str_buffer, 8*PX_BLOCK, 0*PX_BLOCK); // Print mode
    sprintf(g_str_buffer, "x: %d", game_speed ); 
    TFT_Write_Text(&g_str_buffer, 6*PX_BLOCK, 0*PX_BLOCK);
}


/// Update time clock and print it to screen 
///
void update_time() {

    // Print session time else print total clock time
    if (g_TIME_TRACK_MODE == SESSION_TIME) {
        g_t_secs = g_session_count % 60;

        if (g_t_secs != 0) {
            g_t_wait = FALSE;
        }
        if (g_t_secs == 0 && g_t_wait == FALSE) {
            g_t_mins++;
            g_t_wait = TRUE;
        }

        // g_t_mins -1 is becuase count starts from 1 as 0 mod x always equals zero.
        sprintf(g_str_buffer, "GTIM: \x20 %02d:%02d", g_t_mins-1, g_t_secs ); 

    } else {
        g_t_secs = g_time_count % 60;

        if (g_t_secs != 0) {
            g_t_wait = FALSE;
        }
        if (g_t_secs == 0 && g_t_wait == FALSE) {
            g_t_mins++;
            g_t_wait = TRUE;
        }
        // g_t_mins -1 is becuase count starts from 1 as 0 mod x always equals zero.
        sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs ); 
    }
    

    TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);

}


/// Initialize screen
///
void init_snake_game() {
    // init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);

     // Set the game phase mode flag
    g_GAME_PHASE = PHASE2_PLAYING;

    // Reset the current screen run flag to stay in this mode
    set_cur_screen_run_flag(TRUE);
    game_cur_screen_run_flag=TRUE;

     // Setup screen 
    TFT_Fill_Screen(CL_BLACK);

    // Set snake colour and text output
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    set_brush_color(m_GREEN);
    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
   
    Delay_ms(100);  // Delay to allow screen to get wiped
    init_snake_sprite();
}


/// Initialize the snake sprite 
///
// ** Do not put in main game loop, this exactly sequence prevents image artifacting
void init_snake_sprite() {
    
    // Reset all game variables
    reset_game_values();

    //Initialize pointer
    m_node_head = m_node_start;
    m_node_tail = m_node_start;
    g_curr_snake_dir = MOVE_RIGHT;

    // Set the Initial snake and food object
    m_node_head->node_x = 0;
    m_node_head->node_y = 1;
    print_snake(m_node_head, m_GREEN);
    generate_food();

    // Reset session timer counter
    g_session_count = 0;
}


//==================================================================================================
/// Main Snake game
///
void start_snake_game() {
    Delay_ms(500); // Allow timers to wind up


    // Game loop
    while (game_cur_screen_run_flag == TRUE) {
    // Hold here until TIMER3 pulse allows up to move
    };
}


///  Refresh game screen - This will be the game loop
///
void screen_refresh_TIM3() {
        
    // Clean previous buffered image out and update new movement; 
    // Check is tail is going to erase body before
    if ( check_snake_collision((m_node_tail)->node_x, (m_node_tail)->node_y, m_node_tail+1) == FALSE ) {
        clean_tail(m_node_tail, m_BLACK);
    }

    draw_cell_xy(g_fd_x_val, g_fd_y_val, m_FUCHSIA); // refresh food
    Delay_ms(5);
    move_snake();

    if (g_GAME_PHASE != PHASE_QUIT) {

        print_snake(m_node_head, m_GREEN);
        Delay_ms(5);                

        // Check if snake has collided with food if true, add to tail (don't erase tail)
        if ( check_snake_collision(g_fd_x_val, g_fd_y_val, m_node_head) == FALSE ) {
            incr_snake_tail();
        } else {
            // We have contact with food
            play_sfx_food(20);
            g_game_score++;
            generate_food();
        }
    }
}

/// Quit - HIGH SCORE screen
///
void game_over_scr() {

    // Update the stats one last time
      update_session_time();
        //   /* clean screen mask */
        //update direction and refresh screen here?
        render_rect_mask(0,0,20,1, m_NAVY);
        Delay_ms(50);
        //  render_rect_mask(0,10,19,0, m_BLACK);

        // /* Update time - refresh display */
        update_time();

        // /* Update score */
        update_stats();


     // Set the game phase mode flag
    // g_GAME_PHASE = PHASE_QUIT;
    set_game_phase (PHASE_QUIT);
    
    // Set the current screen run flag
    set_cur_screen_run_flag(TRUE);

    //  // Setup screen 
    set_brush_color(m_BLACK);

    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );

    sprintf(g_str_buffer, "Total Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
    TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

    sprintf(g_str_buffer, "Final score: \x20 %04d", g_game_score);
    TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 3*PX_BLOCK);
    
  
    while (cur_screen_run_flag == TRUE) {}
    
    
}



/// Converts and breaks down int number into array cells [x,y,z]
///
void convert_int_ascii(uint8_t *in_array, int32_t entry_row ) {
    int32_t temp_score = g_game_score;
    int32_t temp_val = 0;
    int32_t temp_dvdnd = 0;

     // Convert integer to ascii into invidual array
        // Write the score into the array starting at array[3]
            // y=R * 7 + 4 = 1000s
            // y=R * 7 + 5 = 100s
            // y=R * 7 + 6 = 10s
            // y=R * 7 + 7 = 1s

    int32_t num_pos_ths = (entry_row * 7) + 3;       // 1000s pos
    int32_t num_pos_hds = (entry_row * 7) + 4;       // 100s
    int32_t num_pos_ten = (entry_row * 7) + 5;       // 10s
    int32_t num_pos_one = (entry_row * 7) + 6;       // 10s

        // 0x30 = 0 Ascii 
        // Get the 1000s 
        if (temp_score >= 1000 & g_game_score <= 9999) {
            temp_dvdnd = (temp_score / 1000);
            temp_val = temp_dvdnd +0x30; 
            in_array[num_pos_ths] = temp_val; 

            // remove the 1000s from the score for 100s processing
            temp_score = temp_score - (1000 * temp_dvdnd);

        } else {
            in_array[num_pos_ths] = 0x30;  // d0;
        }

        //Get the 100s 999
        if (temp_score >= 100 ) {
            temp_dvdnd = (temp_score / 100);
            temp_val = temp_dvdnd + 0x30;
            in_array[num_pos_hds] = temp_val;

            // Remove the 100s from the score for 10s processing
            temp_score = temp_score - (100 * temp_dvdnd);

        } else {
            in_array[num_pos_hds] = 0x30;
        }

        // Get the 10s 99
        if (temp_score >= 10) {
            temp_dvdnd = (temp_score / 10);
            temp_val = temp_dvdnd + 0x30;
            in_array[num_pos_ten] = temp_val;

            // Remove the 10s from the score for 10s processing
            temp_score = temp_score - (10 * temp_dvdnd);
        }  else {
            in_array[num_pos_ten] = 0x30;
        }

         // Get the 1s 9, whatever is left should be 0-9
            in_array[num_pos_one] = temp_score + 0x30;
}


/// Refresh high score screen
///
void refresh_hs_scr(uint8_t cur_dir) {
    int32_t xval = hs_cursor_x;
    int32_t yval = hs_cursor_y;
  
    // If no score, skip this step all together
    // if (g_game_score == 0) {
    //     set_cur_screen_run_flag(FALSE); // exit this phase move to show top score list
    //     set_game_phase(PHASE_PRINT_TOP_TEN);
    //     return;
    // }

    TFT_Fill_Screen(CL_BLACK);
    switch(cur_dir) {
        case MOVE_UP:

            if (init_cur > 0x5A) { 
                init_cur = init_cursor_start;
            }
            ++init_cur;
            break;

        case MOVE_DOWN:
            if (init_cur < init_cursor_start) {
                init_cur = 0x5A;
            } else {
                --init_cur;
            }
            break;
        case JBTN_DOWN:
            //store value in array increment the cursor position
            user_score_entry[get_initial_cur_pos()] = init_cur;
            ++init_cur_pos;
            ++hs_cursor_x;

    }
    
    // Third initial has been entered, we are done add to entry array
    if (init_cur_pos >= 3) {
        // Format of entry is [A,B,C,0,1,2,3]
       
       convert_int_ascii(&user_score_entry, 0);


        set_cur_screen_run_flag(FALSE); // exit this phase move to show top score list
        set_game_phase(PHASE_PRINT_TOP_TEN);
    } else {
        draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY); 
        sprintf(g_str_buffer, "Enter high score: \x20 ");
        TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);

        if (get_initial_cur_pos() == 0) {
            sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
        } else if (get_initial_cur_pos() == 1) {
            sprintf(g_str_buffer, "%c\x20%c\x20_: \x20 %04d", user_score_entry[0], init_cur, g_game_score);
        } else if (get_initial_cur_pos() == 2) {
            sprintf(g_str_buffer, "%c\x20%c\x20%c: \x20 %04d", user_score_entry[0], user_score_entry[1], init_cur, g_game_score);
        } else {
            sprintf(g_str_buffer, "FINISHED");
        }

        TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);
        Delay_ms(200); // Small wait for the user experience
    }
    
    /// After this jump to print highschore 

}

/// Game over screen control PHASE = HSCORE
/// 
void game_high_score_scr() {
   
    set_game_phase(PHASE_HSCORE);
    // if (g_game_score > 0) {
        
        // Set the current screen run flag and phase to hscore
        set_cur_screen_run_flag(TRUE);

        // High score loop
        TFT_Fill_Screen(CL_BLACK);

        // Print the first frame of the high score animation
        draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY);
        Delay_ms(100);
        sprintf(g_str_buffer, "Enter high score: \x20 ");
        TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);
        sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
        TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);

        while (cur_screen_run_flag == TRUE) {}
    // }

    // set_game_phase(PHASE2_PLAYING); // change to restart game working
    set_game_phase(PHASE_PRINT_TOP_TEN); // change to restart game

}

void EE_write(uint8_t row, uint8_t *tx_data_in, uint32_t tx_size) {
    uint8_t tx_data_[8];
    uint8_t reg_addr=0;
        row =0;
    // tx_data_[0] = reg_addr; // reserved
    // compiler does not do conversion math from 32_t to 8_t properly
    switch (row) {
        case 0:
            reg_addr = 0;
            break;
        case 1:
            reg_addr = 7;
            break;
        case 2:
            reg_addr = 14;
            break;
        case 3: 
            reg_addr = 21;
            break;
        case 4: 
            reg_addr = 28;
            break;
        case 4: 
            reg_addr = 35;
            break;
        default:
        break;
    }


    tx_data_[0] = 0; // reserved
    // tx_buffer_[1] = 'W';
    // tx_buffer_[2] = 'T';
    // tx_buffer_[3] = 'F';
    // tx_buffer_[4] = '9';
    // tx_buffer_[5] = '7';
    // tx_buffer_[6] = '5';
    tx_data_[1] = tx_data_in[0];    // Initial 1    
    tx_data_[2] = tx_data_in[1];    // Initial 2
    tx_data_[3] = tx_data_in[2];    // Initial 3
    tx_data_[4] = tx_data_in[3];    // Score 1000s
    tx_data_[5] = tx_data_in[4];    // Score 100s
    tx_data_[6] = tx_data_in[5];    // Score 10s
    tx_data_[7] = tx_data_in[6];    // Score 1s

    // tx_data_[1] = 0x39;    // Initial 1    
    // tx_data_[2] = 0x39;    // Initial 2
    // tx_data_[3] = 0x39;    // Initial 3
    // tx_data_[4] = 0x39;    // Score 1000s
    // tx_data_[5] = 0x39;    // Score 100s
    // tx_data_[6] = 0x39;    // Score 10s
    // tx_data_[7] = 0x39;    // Score 1s

    I2C1_Start();
    Delay_ms(10);

    // Issue I2c start signal; Plus 1 for reg_address + user data
    I2C1_Write(0x50, tx_data_, tx_size+1, END_MODE_STOP);
    Delay_ms(100);

}


/// EEPROM - READ
//
void EE_read(uint8_t reg_addr, uint8_t *read_buffer, uint32_t rx_size) {
    // First 4 cells of array are empty
    // Read size is +4 for the extra 2 bytes required
    // rx_buffer_[0] = reg_addr;
    I2C1_Start();
    I2C1_Write(0x50, reg_addr, 1, END_MODE_RESTART);
    I2C1_Read(0x50, read_buffer, rx_size +4, END_MODE_STOP);

    // return rbuffer_[0];
}


/// Find by sorting where ther user score fits in the list
///
/// returns row where user score will be placed
int32_t sort_score(uint8_t *in_arr) {
    int32_t cell_pos = 0;
    int32_t row_found = -1;
    uint8_t temp_entry[7];
    uint8_t temp_ee_score[4];
    uint8_t temp_player_score[4];
    int32_t eeprom_score;
    int32_t player_score;
    

    // Data entry is fixed: [A,B,C,1,2,3,4]


    // First we need to find the row to start eliminating from
    // yRow x width of entry(7) + offset of byte
    // Top 10 rows 0-9
    for (i=0; i < 15; i++ ) {

        // Check the 1000s 
        // cell_pos = (i*7) + 3 = temp_score[0];
        // cell_pos = (i*7) + 4 = temp_score[1];
        // cell_pos = (i*7) + 5 = temp_score[2];
        // cell_pos = (i*7) + 6 = temp_score[3];
        // Copy Row i of scores from EEPROM to temp array 
        
    // I2C read leaves first 4 cells empty so need to offset +4 i =4
        temp_ee_score[0] = in_arr[(i*7) + 7];
        temp_ee_score[1] = in_arr[(i*7) + 8];
        temp_ee_score[2] = in_arr[(i*7) + 9];
        temp_ee_score[3] = in_arr[(i*7) + 10];

        // Copy the user score entry to temp arry to covert to int
        temp_player_score[0] = user_score_entry[3];
        temp_player_score[1] = user_score_entry[4];
        temp_player_score[2] = user_score_entry[5];
        temp_player_score[3] = user_score_entry[7];


        eeprom_score = atoi(temp_ee_score);
        player_score = atoi(temp_player_score);

        // sprintf(g_str_buffer, "[%d]:\x20  %d | \x20 %c | \x20 ai: %d", i, player_score, in_arr[i], eeprom_score);
        // TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, i*PX_BLOCK);

        sprintf(g_str_buffer, "atoi[%d]:\x20  %s \x20 | \x20 %c", i, user_score_entry, temp_ee_score[i]);
        TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, (i+1)*PX_BLOCK);

        // We found the row to insert the score in.
        if (player_score > eeprom_score || temp_ee_score[0] > 0x39 ) {
            row_found = i;
            sprintf(g_str_buffer, "found i [%d]", i);
            TFT_Write_Text(&g_str_buffer, 13*PX_BLOCK, (i+1)*PX_BLOCK);
            i = 999;
        } else if (i==15) {
            return -1; // nothing found
        }
    
      Delay_ms(100);
    }


    // while(GPIOB_IDR.B0 == 0) {}
    return row_found;
}

/// Final screen print the top scores screen
/// 
void print_top_score_list() {
    uint32_t tx_count = 0;
    uint8_t byte;
    uint8_t hs_buffer[128];
    uint8_t atest[4]; 
    int32_t test_num;
    int32_t row_to_write;

    //----testing
        uint8_t temp_score[12];
    int32_t int_score;

    set_cur_screen_run_flag(TRUE);


    // Setup screen 
    TFT_Fill_Screen(CL_BLACK);

    // Initialize the I2C bus
    I2C1_Init();

    // Fetch the High scores and load them into buffer
    EE_read(0, &hs_buffer, 71);

    // Sort the high scores.
    row_to_write = sort_score(&hs_buffer);

    if (row_to_write >=0 ) {
        EE_write( (uint8_t) row_to_write, &user_score_entry,7 );
    } 
    

    sprintf(g_str_buffer, "TOP SCORES:");
    TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

    // Print the user entry
    sprintf(g_str_buffer, "test: %s", user_score_entry);
    TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 4*PX_BLOCK);    

    user_score_entry[3] = 0x30+5;
    atest[0] = user_score_entry[3];
    atest[1] = user_score_entry[4];
    atest[2] = user_score_entry[5];
    atest[3] = user_score_entry[6];

    test_num = atoi(atest);
    sprintf(g_str_buffer, "atoi: %d", test_num);
    TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 5*PX_BLOCK); 

    if (test_num > 999) {
         sprintf(g_str_buffer, "test num is greater");
        TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 6*PX_BLOCK); 
    }   
   
    GPIOB_ODR |= 0xFF00; // PB6 PB7
    Delay_ms(10);

    Delay_ms(1000);

    
    // Fetch the High scores and load them into buffer
    EE_read(0, &hs_buffer, 71);
    TFT_Fill_Screen(CL_BLACK);
    sprintf(g_str_buffer, "TOP SCORES:\x20  %s | \x20 %c",hs_buffer, hs_buffer[0]);
    TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 1*PX_BLOCK);
    for (i=0; i < 5; i++ ) {

    //     // Check the 1000s 
    //     // cell_pos = (i*7) + 3 = temp_score[0];
    //     // cell_pos = (i*7) + 4 = temp_score[1];
    //     // cell_pos = (i*7) + 5 = temp_score[2];
    //     // cell_pos = (i*7) + 6 = temp_score[3];
        // Copy Row i of scores from EEPROM to temp array 
        temp_score[0] = hs_buffer[(i*7) + 2];
        temp_score[1] = hs_buffer[(i*7) + 3];
        temp_score[2] = hs_buffer[(i*7) + 4];
        temp_score[3] = hs_buffer[(i*7) + 5];
        temp_score[4] = hs_buffer[(i*7) + 6];
        temp_score[5] = hs_buffer[(i*7) + 7];
        temp_score[6] = hs_buffer[(i*7) + 8];

        sprintf(g_str_buffer, "score[%d]:\x20  %s | \x20 %c%c%c%c%c%c%c", i , temp_score, 
            hs_buffer[(i*7) + 2], 
            hs_buffer[(i*7) + 3], 
            hs_buffer[(i*7) + 4], 
            hs_buffer[(i*7) + 5], 
            hs_buffer[(i*7) + 6], 
            hs_buffer[(i*7) + 7], 
            hs_buffer[(i*7) + 8]
            );
        TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, (i+2)*PX_BLOCK);
      Delay_ms(100);
    }
     
    /// Wait here until use has finished entering highscore
    while (cur_screen_run_flag == TRUE) {}
    // set_cur_screen_run_flag(TRUE);
    // wipe the screen of eve
    // set_game_phase(PHASE2_PLAYING); // change to restart game
    set_game_phase(PHASE1_READY); // change to restart game

}




#endif //_CP_GAME_CTL_H
