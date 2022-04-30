#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_driver.c"
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/p7_final_project_objects.h"
typedef struct Screen TScreen;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned int ObjectsCount;
};

extern TScreen Screen1;










void DrawScreen(TScreen *aScreen);
void Check_TP();
void Start_TP();
void Process_TP_Press(unsigned int X, unsigned int Y);
void Process_TP_Up(unsigned int X, unsigned int Y);
void Process_TP_Down(unsigned int X, unsigned int Y);
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/p7_final_project_resources.h"
#line 1 "d:/mikroc pro for arm/include/built_in.h"
#line 7 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_driver.c"
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
typedef unsigned long TPointer;
TPointer PressedObject;
int PressedObjectType;
unsigned int caption_length, caption_height;
unsigned int display_width, display_height;

int _object_count;
unsigned short object_pressed;


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



static void InitializeObjects() {
 Screen1.Color = 0x5AEB;
 Screen1.Width = 320;
 Screen1.Height = 240;
 Screen1.ObjectsCount = 0;

}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) {
 if ( (Left<= X) && (Left+ Width - 1 >= X) &&
 (Top <= Y) && (Top + Height - 1 >= Y) )
 return 1;
 else
 return 0;
}




void DrawScreen(TScreen *aScreen) {
 unsigned int order;
 char save_bled;

 object_pressed = 0;
 order = 0;
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
 }
}

void Get_Object(unsigned int X, unsigned int Y) {
 _object_count = -1;
}


void Process_TP_Press(unsigned int X, unsigned int Y) {

 Get_Object(X, Y);

 if (_object_count != -1) {
 }
}

void Process_TP_Up(unsigned int X, unsigned int Y) {


 Get_Object(X, Y);


 if (_object_count != -1) {
 }
 PressedObject = 0;
 PressedObjectType = -1;
}

void Process_TP_Down(unsigned int X, unsigned int Y) {

 object_pressed = 0;

 Get_Object(X, Y);

 if (_object_count != -1) {
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
