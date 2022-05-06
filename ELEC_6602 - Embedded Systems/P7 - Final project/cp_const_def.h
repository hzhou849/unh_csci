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


/* Game values */

typedef struct  {
    int16_t node_x;
    int16_t node_y;
} t_node;


static const uint8_t PHASE_INTRO          = 0;
static const uint8_t PHASE1_READY         = 1; 
static const uint8_t PHASE2_PLAYING       = 2; 
static const uint8_t PHASE3_PLAYING       = 3; 

static const uint8_t MOVE_RIGHT    = 0x0;             // End marker for display array matrix
static const uint8_t MOVE_LEFT     = 0x1;             // End marker for display array matrix
static const uint8_t MOVE_UP       = 0x2;             // End marker for display array matrix
static const uint8_t MOVE_DOWN     = 0x3;             // End marker for display array matrix
static const uint16_t NEG_NULL     = -1;

/* Screen Constants */
static const uint32_t SCREEN_X_MAX         = 320;
static const uint32_t SCREEN_Y_MAX         = 240;

/* 8-bit custom colour codes */
//* make sure you up date cp_pix_render to check for these
static const uint8_t m_BLACK            = 0;
static const uint8_t m_YELLOW           = 1;
static const uint8_t m_RED              = 2;
static const uint8_t m_NAVY             = 3;
static const uint8_t m_GRAY             = 3;
static const uint8_t m_GREEN            = 4;
static const uint8_t m_WHITE            = 5;
static const uint8_t m_FUCHSIA            = 6;



// CL_AQUA Aqua color 
// CL_BLACK Black color 
// CL_BLUE Blue color 
// CL_FUCHSIA Fuchsia color 
// CL_GRAY Gray color 
// CL_GREEN Green color 
// CL_LIME Lime color 
// CL_MAROON Maroon color 
// CL_NAVY Navy color 
// CL_OLIVE Olive color 
// CL_PURPLE Purple color 
// CL_RED Red color 
// CL_SILVER Silver color 
// CL_TEAL Teal color 
// CL_WHITE White color 
// CL_YELLOW Yellow color 


void debug(uint32_t value) {
    Delay_ms(1);
    USART1_DR = 0xD;
    Delay_ms(1);
    USART1_DR=0xA;
    Delay_ms(1);
    USART1_DR = value;
}


#endif // _CP_CONST_DEF