#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_events_code.c"
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
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/tft_test2/tft_test2_resources.h"
