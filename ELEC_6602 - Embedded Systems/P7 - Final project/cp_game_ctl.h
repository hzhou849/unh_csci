/// cp_game_ctl.h
//  Game screen/engine control handler

#ifndef _CP_GAME_CTL_H
#define _CP_GAME_CTL_H

#include <stdint.h>
#include "cp_const_def.h"
void load_game_screen() {
    uint32_t x_axis = 0;
    uint32_t y_axis = 0;
    uint32_t pixel_s = 16;

    set_cur_screen_run_flag(TRUE);

    TFT_Fill_Screen(CL_NAVY);
    TFT_SET_PEN(CL_BLACK, 2);
    TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
    TFT_Rectangle(x_axis,y_axis, pixel_s,pixel_s);
    TFT_Rectangle(pixel_s*1 , pixel_s*0 , pixel_s*2,pixel_s*1);

    while (cur_screen_run_flag == TRUE) {};

    
}

#endif //_CP_GAME_CTL_H