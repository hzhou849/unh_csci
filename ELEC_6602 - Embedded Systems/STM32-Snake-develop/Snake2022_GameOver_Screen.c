#include "Snake2022_Sounds.h"

unsigned int nChar1, nChar2, nChar3;
unsigned int pos1;

extern snakeDir;
extern soundEnabled;

extern score;
extern scoreD3;
extern scoreD2;
extern scoreD1;
extern death;
extern nodes;

void ClearScreen();

void GameOverScreen(){
  snakeDir = 5;
  if(soundEnabled == 1){
    Sound_Play(NOTE_D4, 167);
    Sound_Play(NOTE_Bf3, 167);
    Sound_Play(NOTE_A3, 167);
    Sound_Play(NOTE_E3, 167);
    Sound_Play(NOTE_A2, 167);
    Sound_Play(NOTE_D2, 1000);
  }

  ClearScreen();

  TFT_Write_Text("GAME OVER",120,60);
  TFT_Write_Text("Your Score: ",100,80);

  scoreD3 = score%10;
  scoreD2 = (score%100 - scoreD3 ) / 10;
  scoreD1 = (score - score%100)/ 100;

  TFT_Write_Char(scoreD1+48,180,80);
  TFT_Write_Char(scoreD2+48,190,80);
  TFT_Write_Char(scoreD3+48,200,80);

  TFT_Write_Text("Enter your initials to be immortalized: ",40,120);

  TFT_Write_CHAR('_',130,150);
  TFT_Write_CHAR('_',150,150);
  TFT_Write_CHAR('_',170,150);

  // A-Z 65-90, 0-9 48-57
      nChar1 = 64;
  while(snakeDir != 30){
    switch(snakeDir){
      case 1: // up
      USART1_DR = nChar1;

      snakeDir = 5;
      if(nChar1 < 90){
        TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        TFT_Write_CHAR(nChar1,130+pos1,150);
        TFT_Set_Font(TFT_defaultFont, CL_GREEN, FO_HORIZONTAL);
        nChar1++;
        TFT_Write_CHAR(nChar1,130+pos1,150);
      }
      break;
      case 2: // down
      USART1_DR = nChar1;
      snakeDir = 5;
      if(nChar1 > 65){
        TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        TFT_Write_CHAR(nChar1,130+pos1,150);
        TFT_Set_Font(TFT_defaultFont, CL_GREEN, FO_HORIZONTAL);
        nChar1--;
        TFT_Write_CHAR(nChar1,130+pos1,150);
      }
      break;
      case 3: // right
      pos1 += 10;
      snakeDir = 5;
      if(pos1 > 40){
       snakeDir = 30;
      }
      break;
      default:
      break;
    }
    delay_ms(100);
  }
  //while(snakeDir != 0); //Wait for back button
  pos1 = 0;
  snakeDir = 0;
  death = 0;  // You're not dead anymore!
  nodes = 0;
  score = 0;
  scoreD3 = 0;
  scoreD2 = 0;
  scoreD1 = 0;

  if(soundEnabled == 1){
    Sound_Play(1000, 100);
  }
}