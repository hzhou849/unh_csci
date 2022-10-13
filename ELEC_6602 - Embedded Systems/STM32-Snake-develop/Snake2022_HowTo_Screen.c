#include "Snake2022_Sounds.h"

extern snakeDir;
extern soundEnabled;

void HowToScreen(){
  TFT_Set_Font(TFT_defaultFont, CL_GREEN, FO_HORIZONTAL);
  TFT_Write_Text(" HOW TO PLAY ",120,0);
  TFT_Write_Text("Snake Game made by Frank Pellicano, 2022",30,220);
  TFT_Write_Text("Use the joystick to move the snake. Eat ",40,40);
  TFT_Write_Text("apples to grow larger. The game ends ",40,60);
  TFT_Write_Text("when the snake hits itself or the border. ",40,80);
  TFT_Write_Text(" CONTROLS ",120,120);
  TFT_Write_Text("PD4 - Snake UP",40,140);
  TFT_Write_Text("PB5 - Snake DOWN",40,160);
  TFT_Write_Text("PD2 - Snake LEFT",40,180);
  TFT_Write_Text("PA6 - Snake RIGHT",40,200);
  TFT_Write_Text("PC0 - Game Speed",170,140);
  TFT_Write_Text("PD6 - Display Time",170,160);
  TFT_Write_Text("PA0 - Pause Game",170,180);
  TFT_Write_Text("PA4 - Game Modes",170,200);

  if(soundEnabled == 1){      // Star Wars!
    Sound_Play(NOTE_C4, 1000);
    Sound_Play(NOTE_G4, 1000);
    Sound_Play(NOTE_F4, 167);
    Sound_Play(NOTE_E4, 167);
    Sound_Play(NOTE_D4, 167);
    Sound_Play(NOTE_C5, 1000);
    Sound_Play(NOTE_G4, 500);

    Sound_Play(NOTE_F4, 167);
    Sound_Play(NOTE_E4, 167);
    Sound_Play(NOTE_D4, 167);
    Sound_Play(NOTE_C5, 1000);
    Sound_Play(NOTE_G4, 500);

    Sound_Play(NOTE_F4, 167);
    Sound_Play(NOTE_E4, 167);
    Sound_Play(NOTE_F4, 167);
    Sound_Play(NOTE_D4, 2000);
  }

  while(snakeDir != 0); //Wait for back button
  if(soundEnabled == 1){
    Sound_Play(1000, 100);
  }
}