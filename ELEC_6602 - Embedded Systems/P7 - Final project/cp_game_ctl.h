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


/* Global variables */
// Game states flags - variables needs global tow work 
// compiler has issues with declaring variables in functions.
static volatile uint8_t game_cur_screen_run_flag        = TRUE;

static uint8_t g_GAME_MODE                              = DEV_MODE;
static uint8_t g_curr_snake_dir                         = MOVE_RIGHT;
static volatile uint8_t  g_game_clock_delay_tim3        = ON;
static volatile uint32_t g_time_count                   = 0;
static uint32_t g_game_score                            = 0;
static int32_t g_debug                                  = 0;
static int32_t g_debug2                                 = 2;
static int32_t g_rand_num                               = 999;
static uint8_t g_food_in_play                           = FALSE;
static int32_t g_fd_x_val                               = NEG_NULL;
static int32_t g_fd_y_val                               = NEG_NULL;
static int32_t init_cursor_start                        = 0x40;          // '@'; 1 char less than 'A' allow for increment algorithm
static int32_t init_cur_count                           = 1; 
static int32_t i                                               =0;    // Generic counters
static int32_t j             =0;    // Generic counters
static uint32_t i2c_status;
static uint8_t  tx_buffer_[128];
static uint8_t  rx_buffer_[256];
static int32_t hs_cursor_x = 22;
static int32_t hs_cursor_y = 4;
uint8_t init_cur = 0x40; // 'A' -1


uint8_t g_str_buffer[128];                                // General use string buffer for output text

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



// Local calls


void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);


void init_snake_sprite();
// void dump_ds_buffer();
void incr_snake_head();
void incr_snake_tail();
t_node* incr_node(t_node *_node);
void game_over();


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
uint8_t get_game_phase() {
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
    game_cur_screen_run_flag = FALSE;
    g_GAME_PHASE = PHASE_QUIT;  
}


int32_t get_init_count () {
    return init_cur_count;
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
    g_GAME_PHASE = PHASE1_READY;

    //  init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);
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
    if (g_GAME_MODE == NORMAL_MODE) {
        sprintf(g_str_buffer, "MODE: \x20 Normal" ); 
    }
    else {
        sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );       // ****Printout debugger
    }
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
    //Initialize pointer
    m_node_head = m_node_start;
    m_node_tail = m_node_start;
    g_curr_snake_dir = MOVE_RIGHT;

    // Set the Initial snake and food object
    m_node_head->node_x = 0;
    m_node_head->node_y = 1;
    print_snake(m_node_head, m_GREEN);
    generate_food();
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
     // Set the game phase mode flag
    g_GAME_PHASE = PHASE_QUIT;
    set_game_phase (PHASE_QUIT);
    
    
    // init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);

    // Set the current screen run flag
    set_cur_screen_run_flag(TRUE);

    //  // Setup screen 
    // TFT_Fill_Screen(CL_BLACK);
   
    // TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    set_brush_color(m_BLACK);

    TFT_SET_PEN(CL_GRAY, 0);
    TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );

    sprintf(g_str_buffer, "Total Time: \x20 %02d:%02d", g_t_mins, g_t_secs );
    TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

    sprintf(g_str_buffer, "Final score: \x20 %04d", g_game_score);
    TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 3*PX_BLOCK);
    
    // Game loop 
    while (cur_screen_run_flag == TRUE) {}
    
    
}

/// EEPROM - WRITE
///
void EE_write(uint8_t reg_addr, uint8_t tx_byte, uint32_t tx_size) {
    tx_buffer_[0] = reg_addr;
    tx_buffer_[1] = tx_byte;
    I2C1_Start();

    // Issue I2c start signal; Plus 1 for reg_address + user data
    I2C1_Write(0x50, tx_buffer_, 2, END_MODE_STOP);

}


/// EEPROM - READ
//
void EE_read(uint8_t reg_addr, uint32_t rx_size) {
    // Read size is +4 for the extra 2 bytes required
    // rx_buffer_[0] = reg_addr;
    I2C1_Start();
    I2C1_Write(0x50, reg_addr, 1, END_MODE_RESTART);
    I2C1_Read(0x50, rx_buffer_, rx_size +4, END_MODE_STOP);

    // return rbuffer_[0];
}


void refresh_hs_scr(uint8_t cur_dir) {
    int32_t xval = hs_cursor_x;
    int32_t yval = hs_cursor_y;
    
    
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
                ++init_cur;
            }
            break;
        case JBTN_DOWN:
            //store value in array
            ++init_cur_count;
    }
    
    // Third initial has been entered, we are done
    if (init_cur_count == 3) {
        // quit
        // g_cur_game_phase = PHASE_GAME_LOOP_OVER;
        g_GAME_PHASE = PHASE_GAME_LOOP_OVER;
    } else {
        draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY); 
    }
    
    sprintf(g_str_buffer, "Enter high score: \x20\x20 ");
    TFT_Write_Text(&g_str_buffer, 4*PX_BLOCK, 4*PX_BLOCK);
    sprintf(g_str_buffer, "%c: \x20", init_cur);
    TFT_Write_Text(&g_str_buffer, 11*PX_BLOCK, 4*PX_BLOCK);

}

/// Game over screen control PHASE = HSCORE
/// 
void game_high_score_scr() {
    uint32_t tx_count = 0;
    uint8_t byte;

    // Set the current screen run flag
    set_cur_screen_run_flag(TRUE);

    // High score loop
    TFT_Fill_Screen(CL_BLACK);
    // sprintf(g_str_buffer, "Enter High score: \x20 %04d", g_game_score);
    // TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

    I2C1_Init();
   
    GPIOB_ODR |= 0xFF00; // PB6 PB7
    Delay_ms(10);

    draw_ini_cell_xy(22,4,m_GRAY);
    Delay_ms(100);
    sprintf(g_str_buffer, "Enter high score: \x20\x20 ");
    TFT_Write_Text(&g_str_buffer, 4*PX_BLOCK, 4*PX_BLOCK);
        sprintf(g_str_buffer, "___: \x20 %d", g_game_score);
    TFT_Write_Text(&g_str_buffer, 11*PX_BLOCK, 4*PX_BLOCK);






    // Loop write single byte
    for (i = 0; i < 0x16; i++) {
        EE_write(i, (0x50 +i),1 );
        GPIOB_ODR++;
        Delay_ms(50);
    }

    // Write word
    // for (tx_count=0; tx_count != '\0'; tx_count++) {
    // for (i=0; i !='\0'; i++) {
    // for (i=0; i !='\0'; i++) {
        
    //     EE_write(i, testing[i], 1 );
    //     GPIOB_ODR++;
    //     Delay_ms(100);
    //     // sprintf(g_str_buffer, "I2C data: \x20 ");
    //     // TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, tx_count*PX_BLOCK);
    // }

    // write 0xFF to end of EEPROM
    // EE_write(++tx_count, 0xFF,1);
    

    Delay_ms(10);
    GPIOB_ODR |= 0xFF00;
    Delay_ms(10);

    for (i=0; i < 0x1; i++) {
        // rx_buffer_[i] = EE_read(i,1);
        EE_read(i,16);
        Delay_ms(100);
    } 
        Delay_ms(100);
       
        // sprintf(g_str_buffer, "I2C data: \x20 %s", rx_buffer_);
        TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 9*PX_BLOCK);
    // for (i=0; i <10; i++) {
    //     rx_buffer_[i] = EE_read(i,1);
    //     EE_read(i,1);
    //     Delay_ms(10);

    //     // TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, i*PX_BLOCK);
    // } //     // sprintf(g_str_buffer, "I2C data: \x20 %s", rx_buffer_);
    

 

     

    while (cur_screen_run_flag == TRUE) {}

}







#endif //_CP_GAME_CTL_H







////////////////////////////////////////////////////////////////////////
/// Dump the entire contents of an array at given size to serial
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