extern snakeDir;
extern soundEnabled;

char str[8] = {70,88,80, 45, 49, 57, 49};
void ScoreScreen(){

  TFT_Set_Font(TFT_defaultFont, CL_GREEN, FO_HORIZONTAL);
  TFT_Write_Text(" HIGH SCORES ",120,0);

  TFT_Write_Text(str,100,40);
  
  while(snakeDir != 0); // Wait for back button
          if(soundEnabled == 1){
          Sound_Play(1000, 100);
        }
}