#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_main.c"
#line 1 "d:/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 17 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_main.c"
static const uint32_t SCREEN_X_MAX =320;
static const uint32_t SCREEN_Y_MAX =240;
static const uint32_t TRUE = 1;
static const uint32_t FALSE =0;

 uint8_t pub_msg[] = "Puddle Producktions presents:";
 uint8_t dev_msg[] = "A Run Hop Games, game.";
 uint8_t intro_msg[] = "Please press Joystick down to start";

void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {



 TFT_Set_Font(TFT_defaultFont, CL_GRAY, FO_HORIZONTAL );


 TFT_Write_Text(&intro_msg, x_axis, y_axis);

 TFT_Fill_Screen(CL_BLACK);

}



void load_intro_screen() {

 uint8_t scroll_dir = 1;
 uint8_t intro_screen_run_flag = 1;
 uint32_t x_axis = 35;
 uint32_t y_axis = 115;

 while (intro_screen_run_flag == TRUE ) {


 if (scroll_dir == 1 ) {
 if (y_axis > (SCREEN_Y_MAX-5) || x_axis > (SCREEN_X_MAX -30) ) {
 scroll_dir = 0;
 }

 x_axis+=5;
 y_axis+=5;

 }
 else {

 if (y_axis < 10 || x_axis < 10) {
 scroll_dir = 1;
 }

 x_axis-=5;
 y_axis-=5;
 }

 draw_intro_screen(x_axis, y_axis);


 }
}
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
#line 80 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_main.c"
void main() {

 unsigned int counter = 0;
 Start_TP();
 RCC_APB2ENR |= 1 << 2;
 GPIOA_CRL = 0x44444444;
 GPIOA_CRH = 0x44444444;

 TFT_Set_Brush(1, CL_BLACK, 0, 0, 0, 0);
 TFT_Rectangle(0,0,320, 240);

 load_intro_screen();



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
