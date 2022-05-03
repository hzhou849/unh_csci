// My list of constant definitions to use
#ifndef _CP_CONST_DEF
#define _CP_CONST_DEF

static const uint8_t PHASE_INTRO          = 0;
static const uint8_t PHASE_GAME1           = 1; 
static const uint8_t PHASE_GAME2           = 2; 
static const uint8_t TRUE                 = 1;
static const uint8_t FALSE                = 0;

static const uint32_t GPIO_INPUT_MASK      = 0x44444444;

/* Screen Constants */
static const uint32_t SCREEN_X_MAX         = 320;
static const uint32_t SCREEN_Y_MAX         = 240;


void debug(uint32_t value) {
    Delay_ms(1);
    USART1_DR = 0xD;
    Delay_ms(1);
    USART1_DR=0xA;
    Delay_ms(1);
    USART1_DR = value;
}


#endif // _CP_CONST_DEF