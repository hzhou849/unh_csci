#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_main.c"
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/tft_test2/tft_test2_objects.h"
typedef struct Screen TScreen;

typedef struct Box {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 char Pen_Width;
 unsigned int Pen_Color;
 char Visible;
 char Active;
 char Transparent;
 char Gradient;
 char Gradient_Orientation;
 unsigned int Gradient_Start_Color;
 unsigned int Gradient_End_Color;
 unsigned int Color;
 char PressColEnabled;
 unsigned int Press_Color;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TBox;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned int ObjectsCount;
 unsigned int BoxesCount;
 TBox * const code *Boxes;
};

extern TScreen Screen1;
extern TBox Box1;
extern TBox * const code Screen1_Boxes[1];








extern char Box1_Caption[];


void DrawScreen(TScreen *aScreen);
void DrawBox(TBox *ABox);
void Check_TP();
void Start_TP();
void Process_TP_Press(unsigned int X, unsigned int Y);
void Process_TP_Up(unsigned int X, unsigned int Y);
void Process_TP_Down(unsigned int X, unsigned int Y);
#line 18 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_main.c"
void main() {
 unsigned int counter = 0;
 Start_TP();
 RCC_APB2ENR |= 1 << 2;
 GPIOA_CRL = 0x44444444;

 TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
 TFT_Rectangle(0,0,320, 240);


 while (1) {

 TFT_Set_Brush(1, CL_AQUA, 0, 0, 0, 0);
 TFT_Rectangle(counter+50,0,counter+100, 50);


 if (GPIOA_IDR.B0 == 1) {
 if (counter < 240-50) {
 TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
 TFT_Rectangle(counter+50,0,counter+100, 50);
 }


 counter+=25;

 }
 Delay_ms(10);






 Check_TP();
 }
}
