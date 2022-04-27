#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_driver.c"
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
#line 1 "d:/mikroc pro for arm/include/built_in.h"
#line 7 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/tft_test2/tft_test2_driver.c"
sbit TFT_BLED at GPIOE_ODR.B9;
sbit TFT_CS at GPIOE_ODR.B15;
unsigned int TFT_DataPort at GPIOE_ODR;
sbit TFT_RD at GPIOE_ODR.B10;
sbit TFT_RS at GPIOE_ODR.B12;
sbit TFT_RST at GPIOE_ODR.B8;
sbit TFT_WR at GPIOE_ODR.B11;



sbit DriveX_Left at GPIOB_ODR.B1;
sbit DriveX_Right at GPIOB_ODR.B8;
sbit DriveY_Up at GPIOB_ODR.B9;
sbit DriveY_Down at GPIOB_ODR.B0;



unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 1500;
char PenDown;
void *PressedObject;
int PressedObjectType;
unsigned int caption_length, caption_height;
unsigned int display_width, display_height;

int _object_count;
unsigned short object_pressed;
TBox *local_box;
TBox *exec_box;
int box_order;


void Init_ADC() {
 ADC_Set_Input_Channel(_ADC_CHANNEL_8 | _ADC_CHANNEL_9);
 ADC1_Init();
 Delay_ms(100);
}
static void InitializeTouchPanel() {
 Init_ADC();
 TFT_Init_ILI9341_8bit(320, 240);

 TP_TFT_Init(320, 240, 8, 9);
 TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);

 PenDown = 0;
 PressedObject = 0;
 PressedObjectType = -1;
}

void Calibrate() {
 TFT_Set_Pen(CL_WHITE, 3);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Write_Text("Touch selected corners for calibration", 50, 80);
 TFT_Line(315, 239, 319, 239);
 TFT_Line(309, 229, 319, 239);
 TFT_Line(319, 234, 319, 239);
 TFT_Write_Text("first here", 210, 220);

 TP_TFT_Calibrate_Min();
 Delay_ms(500);

 TFT_Set_Pen(CL_BLACK, 3);
 TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
 TFT_Line(315, 239, 319, 239);
 TFT_Line(309, 229, 319, 239);
 TFT_Line(319, 234, 319, 239);
 TFT_Write_Text("first here", 210, 220);

 TFT_Set_Pen(CL_WHITE, 3);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Write_Text("now here ", 20, 5);
 TFT_Line(0, 0, 5, 0);
 TFT_Line(0, 0, 0, 5);
 TFT_Line(0, 0, 10, 10);

 TP_TFT_Calibrate_Max();
 Delay_ms(500);
}



 TScreen* CurrentScreen;

 TScreen Screen1;
 TBox Box1;
 TBox * const code Screen1_Boxes[1]=
 {
 &Box1
 };



static void InitializeObjects() {
 Screen1.Color = 0x5AEB;
 Screen1.Width = 320;
 Screen1.Height = 240;
 Screen1.BoxesCount = 1;
 Screen1.Boxes = Screen1_Boxes;
 Screen1.ObjectsCount = 1;


 Box1.OwnerScreen = &Screen1;
 Box1.Order = 0;
 Box1.Left = 140;
 Box1.Top = 59;
 Box1.Width = 83;
 Box1.Height = 59;
 Box1.Pen_Width = 1;
 Box1.Pen_Color = 0x0000;
 Box1.Visible = 1;
 Box1.Active = 1;
 Box1.Transparent = 1;
 Box1.Gradient = 1;
 Box1.Gradient_Orientation = 0;
 Box1.Gradient_Start_Color = 0xFFFF;
 Box1.Gradient_End_Color = 0xC618;
 Box1.Color = 0xC618;
 Box1.PressColEnabled = 1;
 Box1.Press_Color = 0xE71C;
}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) {
 if ( (Left<= X) && (Left+ Width - 1 >= X) &&
 (Top <= Y) && (Top + Height - 1 >= Y) )
 return 1;
 else
 return 0;
}





void DrawBox(TBox *ABox) {
 if (ABox->Visible != 0) {
 if (object_pressed == 1) {
 object_pressed = 0;
 TFT_Set_Brush(ABox->Transparent, ABox->Press_Color, ABox->Gradient, ABox->Gradient_Orientation, ABox->Gradient_End_Color, ABox->Gradient_Start_Color);
 }
 else {
 TFT_Set_Brush(ABox->Transparent, ABox->Color, ABox->Gradient, ABox->Gradient_Orientation, ABox->Gradient_Start_Color, ABox->Gradient_End_Color);
 }
 TFT_Set_Pen(ABox->Pen_Color, ABox->Pen_Width);
 TFT_Rectangle(ABox->Left, ABox->Top, ABox->Left + ABox->Width - 1, ABox->Top + ABox->Height - 1);
 }
}

void DrawScreen(TScreen *aScreen) {
 unsigned int order;
 unsigned short box_idx;
 TBox *local_box;
 char save_bled;

 object_pressed = 0;
 order = 0;
 box_idx = 0;
 CurrentScreen = aScreen;

 if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
 save_bled = TFT_BLED;
 TFT_BLED = 0;
 TFT_Init_ILI9341_8bit(CurrentScreen->Width, CurrentScreen->Height);
 TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 8, 9);
 TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);
 TFT_Fill_Screen(CurrentScreen->Color);
 display_width = CurrentScreen->Width;
 display_height = CurrentScreen->Height;
 TFT_BLED = save_bled;
 }
 else
 TFT_Fill_Screen(CurrentScreen->Color);


 while (order < CurrentScreen->ObjectsCount) {
 if (box_idx < CurrentScreen->BoxesCount) {
 local_box =  CurrentScreen->Boxes[box_idx] ;
 if (order == local_box->Order) {
 box_idx++;
 order++;
 DrawBox(local_box);
 }
 }

 }
}

void Get_Object(unsigned int X, unsigned int Y) {
 box_order = -1;

 for ( _object_count = 0 ; _object_count < CurrentScreen->BoxesCount ; _object_count++ ) {
 local_box =  CurrentScreen->Boxes[_object_count] ;
 if (local_box->Active != 0) {
 if (IsInsideObject(X, Y, local_box->Left, local_box->Top,
 local_box->Width, local_box->Height) == 1) {
 box_order = local_box->Order;
 exec_box = local_box;
 }
 }
 }

 _object_count = -1;
 if (box_order > _object_count )
 _object_count = box_order;
}


void Process_TP_Press(unsigned int X, unsigned int Y) {
 exec_box = 0;

 Get_Object(X, Y);

 if (_object_count != -1) {
 if (_object_count == box_order) {
 if (exec_box->Active != 0) {
 if (exec_box->OnPressPtr != 0) {
 exec_box->OnPressPtr();
 return;
 }
 }
 }

 }
}

void Process_TP_Up(unsigned int X, unsigned int Y) {

 switch (PressedObjectType) {

 case 6: {
 if (PressedObject != 0) {
 exec_box = (TBox*)PressedObject;
 if ((exec_box->PressColEnabled != 0) && (exec_box->OwnerScreen == CurrentScreen)) {
 DrawBox(exec_box);
 }
 break;
 }
 break;
 }
 }


 Get_Object(X, Y);


 if (_object_count != -1) {

 if (_object_count == box_order) {
 if (exec_box->Active != 0) {
 if (exec_box->OnUpPtr != 0)
 exec_box->OnUpPtr();
 if (PressedObject == (void *)exec_box)
 if (exec_box->OnClickPtr != 0)
 exec_box->OnClickPtr();
 PressedObject = 0;
 PressedObjectType = -1;
 return;
 }
 }

 }
 PressedObject = 0;
 PressedObjectType = -1;
}

void Process_TP_Down(unsigned int X, unsigned int Y) {

 object_pressed = 0;
 exec_box = 0;

 Get_Object(X, Y);

 if (_object_count != -1) {
 if (_object_count == box_order) {
 if (exec_box->Active != 0) {
 if (exec_box->PressColEnabled != 0) {
 object_pressed = 1;
 DrawBox(exec_box);
 }
 PressedObject = (void *)exec_box;
 PressedObjectType = 6;
 if (exec_box->OnDownPtr != 0) {
 exec_box->OnDownPtr();
 return;
 }
 }
 }

 }
}

void Check_TP() {
 if (TP_TFT_Press_Detect()) {
 if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {

 Process_TP_Press(Xcoord, Ycoord);
 if (PenDown == 0) {
 PenDown = 1;
 Process_TP_Down(Xcoord, Ycoord);
 }
 }
 }
 else if (PenDown == 1) {
 PenDown = 0;
 Process_TP_Up(Xcoord, Ycoord);
 }
}

void Init_MCU() {
 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_9);
 TFT_BLED = 1;
 TFT_Set_Default_Mode();
 TP_TFT_Set_Default_Mode();
}

void Start_TP() {
 Init_MCU();

 InitializeTouchPanel();

 Delay_ms(1000);
 TFT_Fill_Screen(0);

 TFT_Fill_Screen(0);

 InitializeObjects();
 display_width = Screen1.Width;
 display_height = Screen1.Height;
 DrawScreen(&Screen1);
}
