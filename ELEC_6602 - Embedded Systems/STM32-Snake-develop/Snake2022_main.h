#include "Snake2022_objects.h"
#include "Snake2022_resources.h"
#include "Snake2022_Sounds.h"

unsigned int SNAKESIZE = 20;
unsigned int snakeNodes = 0;
unsigned int gameSpeed = 500;
unsigned int soundEnabled = 1;
unsigned int snakeDir = 0;
unsigned int i = 0;
unsigned int score = 0;
unsigned int scoreD1 = 0;
unsigned int scoreD2 = 0;
unsigned int scoreD3 = 0;
unsigned int death = 0;
unsigned int StateMachine = 0;
unsigned int nodes = 0;
unsigned int appleMatch = 0; // 0 is not on snake, 1 is on snake
int matchCount = 0;
unsigned int timerFlag = 0;
unsigned int tsec = 0;
unsigned int tmin = 0;

struct Apples{
int x1;
int x2;
int y1;
int y2;
int color;
};

struct SnakeNode{
int x1;
int x2;
int y1;
int y2;
int color;
int direction;
};

struct Apples apple;
struct SnakeNode snake[193];

unsigned int TitleScreen();
unsigned int getAdcReading();        // Begins conversion and returns 12 bit value
void AdcConfiguration();
void PinConfiguration();
void PlayScreen();
void PlaySong();
void HowToScreen();
void ScoreScreen();
void GameOverScreen();
void InitializeUSART1();
void Timer3IntConfiguration();
void JoyStickConfiguration();
void RandomizeApple();
void ClearScreen();