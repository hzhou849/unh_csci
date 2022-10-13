unsigned int arrow = 80;
unsigned int x = 0;
extern snakeDir;
extern soundEnabled;
unsigned int TitleScreen(){
  TFT_Set_Font(TFT_defaultFont, CL_GREEN, FO_HORIZONTAL);
  TFT_Write_Text(" Play Snake ",120,80);
  TFT_Write_Text("High Scores ",120,100);
  TFT_Write_Text("How To Play ",120,120);
  TFT_Write_Text("->",90,arrow);
  TFT_Write_Text("Snake Game made by Frank Pellicano, 2022",30,220);
  x = 0;
 
  while(x != 1){
    TFT_Set_Font(TFT_defaultFont, CL_GREEN, FO_HORIZONTAL);
    TFT_Write_Text("->",90,arrow);
    delay_ms(200);

    switch(snakeDir){

      case 1:    // UP
      if(arrow > 80){
        TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        TFT_Write_Text("->",90,arrow);
        arrow -= 20;
        if(soundEnabled == 1){
          Sound_Play(1000, 100);
        }
      }
      break;
      case 2:    // DOWN

      if(arrow < 120){
        TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        TFT_Write_Text("->",90,arrow);
        arrow += 20;
        if(soundEnabled == 1){
          Sound_Play(1000, 100);
        }
      }
      break;
      case 3:    // RIGHT
      x = 1;
        if(soundEnabled == 1){
          Sound_Play(1000, 100);
        }
      break;
    }
    snakeDir = 5;
  }
  return arrow;
}