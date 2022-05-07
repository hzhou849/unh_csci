// #ifndef _CP_GAME_OVER_CTL_H
// #define _CP_GAME_OVER_CTL_H

// #include <stdint.h>
// #include "cp_const_def.h"



// uint8_t g_str_buffer[128];                                // General use string buffer for output text
// static int32_t i            = 0;


// /*Prototypes*/
// void game_over_scr();
// void EE_write(uint8_t w_addr, uint8_t w_data);
// uint8_t EE_read(uint8_t r_addr);
// void game_high_score_scr();

// /// Quit - HIGH SCORE screen
// ///
// void game_over_scr() {
//      // Set the game phase mode flag
//     g_GAME_PHASE = PHASE_QUIT;
    
//     // init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);

//     // Set the current screen run flag
//     set_cur_screen_run_flag(TRUE);

//     //  // Setup screen 
//     // TFT_Fill_Screen(CL_BLACK);
   
//     // TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
//     set_brush_color(m_BLACK);

//     TFT_SET_PEN(CL_GRAY, 0);
//     TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );

//     sprintf(g_str_buffer, "Total Time: \x20 %02d:%02d", g_t_mins, g_t_secs );
//     TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

//     sprintf(g_str_buffer, "Final score: \x20 %04d", g_game_score);
//     TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 3*PX_BLOCK);
    
//     // Game loop 
//     while (cur_screen_run_flag == TRUE) {}
    
    
// }

// void EE_write(uint8_t w_addr, uint8_t w_data) {
//     data_[0] = w_addr;
//     data_[1] = w_data;
//     I2C1_Start();

//     // Issue I2c start signal
//     I2C1_Write(0x50, data_, 2, END_MODE_STOP);

// }

// uint8_t EE_read(uint8_t r_addr) {
//     data_[0] = r_addr;
//     I2C1_Start();
//     I2C1_Write(0x50, data_,1, END_MODE_RESTART);
//     I2C1_Read(0x50, data_, 1, END_MODE_STOP);

//     return data_[0];
// }

// void game_high_score_scr() {


//     // Set the current screen run flag
//     set_cur_screen_run_flag(TRUE);

//     // High score loop
//     TFT_Fill_Screen(CL_BLACK);
//     // sprintf(g_str_buffer, "Enter High score: \x20 %04d", g_game_score);
//     // TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

//     I2C1_Init();
   
//     GPIOB_ODR |= 0xFF00; // PB6 PB7
//     Delay_ms(10);

//     for (i = 0; i < 0x16; i++) {
//         EE_write(i, (0x32 +i) );
//         GPIOB_ODR++;
//         Delay_ms(5);
//     }

//     Delay_ms(10);
//     GPIOB_ODR |= 0xFF00;
//     Delay_ms(10);

//     for (i=0; i < 0x16; i++) {
//         rx_data_[i] = EE_read(i);
//         Delay_ms(10);
//     } 

//     sprintf(g_str_buffer, "testing: \x20 %s", rx_data_);
//     TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 4*PX_BLOCK);

     

//     while (cur_screen_run_flag == TRUE) {}

// }



// #endif // _CP_GAME_OVER_CTL_H