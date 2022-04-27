#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test/tft_test_main.c"
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/tft_test/tft_test_objects.h"
typedef enum {_taLeft, _taCenter, _taRight} TTextAlign;
typedef enum {_tavTop, _tavMiddle, _tavBottom} TTextAlignVertical;

typedef struct Screen TScreen;

typedef struct Button {
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
 char *Caption;
 TTextAlign TextAlign;
 TTextAlignVertical TextAlignVertical;
 const char *FontName;
 unsigned int Font_Color;
 char VerticalText;
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
} TButton;

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
 unsigned int ButtonsCount;
 TButton * const code *Buttons;
 unsigned int BoxesCount;
 TBox * const code *Boxes;
};

extern TScreen Screen1;
extern TBox Box1;
extern TButton Button1;
extern TButton * const code Screen1_Buttons[1];
extern TBox * const code Screen1_Boxes[1];








extern char Box1_Caption[];
extern char Button1_Caption[];


void DrawScreen(TScreen *aScreen);
void DrawButton(TButton *aButton);
void DrawBox(TBox *ABox);
void Check_TP();
void Start_TP();
void Process_TP_Press(unsigned int X, unsigned int Y);
void Process_TP_Up(unsigned int X, unsigned int Y);
void Process_TP_Down(unsigned int X, unsigned int Y);
#line 19 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test/tft_test_main.c"
void main() {

 Start_TP();

 while (1) {
 Check_TP();
 }
}
