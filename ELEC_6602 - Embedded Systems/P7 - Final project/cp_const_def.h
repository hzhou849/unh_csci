// My list of constant definitions to use
#ifndef _CP_CONST_DEF
#define _CP_CONST_DEF



/* Generic Booleans */
static const uint8_t TRUE          = 1;
static const uint8_t FALSE         = 0;
static const uint8_t ON            = 1;
static const uint8_t OFF           = 0;
static const uint8_t TAIL_ON       = 1;
static const uint8_t TAIL_OFF      = 0;
static const uint32_t GPIO_INPUT_MASK      = 0x44444444;

/* Screen stats */
static const int32_t Y_MAX_LENGTH       = 15;               // 240/16px = 15 blocks
static const int32_t MAX_COL_WIDTH      = 20;               // 320/16px = 20 blocks
static const int32_t MAX_ROW_LENGTH      = 15;               // 320/16px = 20 blocks
static const int32_t MAX_BLOCK_COUNT    = 300;              // 20*15 = 300 blocks
static const uint8_t PX_BLOCK           = 16;               // 16x16px pixel block size
static const uint8_t INI_BLOCK           = 10;               // 16x16px pixel block size


/* Game values */

typedef struct  {
    int16_t node_x;
    int16_t node_y;
} t_node;


static const uint8_t PHASE_LOGO          = 0xF;
static const uint8_t PHASE_INTRO          = 0;
static const uint8_t PHASE1_READY         = 1; 
static const uint8_t PHASE2_PLAYING       = 2; 
static const uint8_t PHASE_QUIT           = 3; 
static const uint8_t PHASE_HSCORE           = 4; 
static const uint8_t PHASE_PRINT_TOP_TEN = 5; 
static const uint8_t NORMAL_MODE         = 0;
static const uint8_t WALL_COL_OFF        = 0x1;
static const uint8_t DEV_MODE            = 0x3;
static const uint8_t TOTAL_TIME            = 0x1A;
static const uint8_t SESSION_TIME          = 0x1F;

static const uint8_t MOVE_RIGHT    = 0x0;             
static const uint8_t MOVE_LEFT     = 0x1;             
static const uint8_t MOVE_UP       = 0x2;             
static const uint8_t MOVE_DOWN     = 0x3;             
static const uint8_t JBTN_DOWN     = 0x4;             
static const uint16_t NEG_NULL     = -1;
static const uint32_t SFX_FOOD     = 5;
static const uint32_t SFX_FOOD_HIGH     = 1;
static const uint32_t SFX_WALL     = 10;

/* Screen Constants */
static const uint32_t SCREEN_X_MAX         = 320;
static const uint32_t SCREEN_Y_MAX         = 240;
static const uint32_t HS_CURSOR_START_X     = 16;
static const uint32_t HS_CURSOR_START_Y     = 4;

/* 8-bit custom colour codes */
//* make sure you up date cp_pix_render to check for these
static const uint8_t m_BLACK            = 0;
static const uint8_t m_YELLOW           = 1;
static const uint8_t m_RED              = 2;
static const uint8_t m_NAVY             = 3;
static const uint8_t m_GRAY             = 4;
static const uint8_t m_GREEN            = 5;
static const uint8_t m_WHITE            = 6;
static const uint8_t m_FUCHSIA            = 6;

// Externs
static volatile uint8_t cur_screen_run_flag       = TRUE;
static volatile uint8_t g_GAME_PHASE             = PHASE1_READY;

void set_cur_screen_run_flag(uint8_t run_flag) {
    cur_screen_run_flag = run_flag;
}

void set_game_phase(uint8_t game_phase) {
   g_GAME_PHASE = game_phase;
}




void debug(uint32_t value) {
    Delay_ms(1);
    USART1_DR = 0xD;
    Delay_ms(1);
    USART1_DR=0xA;
    Delay_ms(1);
    USART1_DR = value;
}


#endif // _CP_CONST_DEF