#include "tft_test_objects.h"
#include "tft_test_resources.h"
#include "built_in.h"
#include "FT800_Types.h"


// TFT module connections
sbit FT800_RST at Todo;
sbit FT800_CS at Todo;
sbit FT800_RST_Direction at Todo;
sbit FT800_CS_Direction at Todo;
// End TFT module connections

// Object type constants
// Usage: VTFT stack internally
const VTFT_OT_BUTTON = 0;
const VTFT_OT_BOX    = 12;
// ~Object type constants

// Event type constants
// Usage: OnEvent
const VTFT_EVT_UP    = 0;
const VTFT_EVT_DOWN  = 1;
const VTFT_EVT_CLICK = 2;
const VTFT_EVT_PRESS = 3;
// ~Event type constants

// Sound action constants
// Usage: sound event action property and ProcessEvent
const VTFT_SNDACT_NONE  = 0;
const VTFT_SNDACT_PLAY  = 1;
const VTFT_SNDACT_STOP  = 2;
// ~Sound action constants

// Resource loading constants.
// Usage: DrawScreenO and LoadCurrentScreenResToGRAM
const VTFT_LOAD_RES_NONE    = 0x00; // do not load g-ram resources
const VTFT_LOAD_RES_STATIC  = 0x01; // load g-ram resources for static objects
const VTFT_LOAD_RES_DYNAMIC = 0x02; // load g-ram resources for dynamic objects
const VTFT_LOAD_RES_ALL     = 0x03; // load g-ram resources for all objects
// ~Resource loading constants

// Display effect constants
// Usage: DrawScreenO
const VTFT_DISPLAY_EFF_NONE         = 0x00; // no effect when switching between screens
const VTFT_DISPLAY_EFF_LIGHTS_FADE  = 0x04; // backlight: fade out before, fade in after drawing new screen
const VTFT_DISPLAY_EFF_LIGHTS_OFF   = 0x08; // backlight: turn off before, turn on after drawing new screen
// ~Display effect constants

// Stack flags
// Usage: internally used by VTFT stack
const VTFT_INT_REPAINT_ON_DOWN     = 1 << 0;
const VTFT_INT_REPAINT_ON_UP       = 1 << 1;
const VTFT_INT_BRING_TO_FRONT      = 1 << 2;
const VTFT_INT_INTRINSIC_CLICK_EFF = 1 << 3;
// ~Stack flags

// Table of object draw handlers
// Use object type constants to access coresponding object draw handler
const TPointer DrawHandlerTable[44] = {
  &DrawButton,     // Button draw handler
  0,               // CButton draw handler not used
  0,               // ButtonRound draw handler not used
  0,               // CButtonRound draw handler not used
  0,               // Label draw handler not used
  0,               // CLabel draw handler not used
  0,               // Image draw handler not used
  0,               // CImage draw handler not used
  0,               // Circle draw handler not used
  0,               // CCircle draw handler not used
  0,               // CircleButton draw handler not used
  0,               // CCircleButton draw handler not used
  &DrawBox,        // Box draw handler
  0,               // CBox draw handler not used
  0,               // BoxRound draw handler not used
  0,               // CBoxRound draw handler not used
  0,               // Line draw handler not used
  0,               // CLine draw handler not used
  0,               // Polygon draw handler not used
  0,               // CPolygon draw handler not used
  0,               // CheckBox draw handler not used
  0,               // RadioButton draw handler not used
  0,               // ProgressBar draw handler not used
  0,               // Audio draw handler not used
  0,               // EveClock draw handler not used
  0,               // EveGauge draw handler not used
  0,               // EveDial draw handler not used
  0,               // EveKeys draw handler not used
  0,               // CEveKeys draw handler not used
  0,               // EveProgressBar draw handler not used
  0,               // EveScrollBar draw handler not used
  0,               // EveToggle draw handler not used
  0,               // EveSlider draw handler not used
  0,               // EveSpinner draw handler not used
  0,               // EveScreenSaver draw handler not used
  0,               // EveSketch draw handler not used
  0,               // EveButton draw handler not used
  0,               // CEveButton draw handler not used
  0,               // EveGradient draw handler not used
  0,               // CEveGradient draw handler not used
  0,               // EveText draw handler not used
  0,               // CEveText draw handler not used
  0,               // EveNumber draw handler not used
  0                // CEveNumber draw handler not used
};
// ~Table of draw handler pointers


// Default configuration parameters
const TFT800Display VTFT_FT800_CONFIG_DISPLAY =
{
  0,               // Frequency          = main clock frequency
  0,               // OutRenderMode      = 0 normal, 1 write, 2 read
  0,               // RenderReadScanLine = scanline for read render mode
  0,               // RenderWriteTrigger = trigger for write render mode (read only)
  0,               // hCycle             = number if horizontal cycles for display
  0,               // hOffset            = horizontal offset from starting signal
  512,             // hSize              = width resolution
  0,               // hSync0             = hsync falls
  0,               // hSync1             = hsync rise
  0,               // vCycle             = number of vertical cycles for display
  0,               // vOffset            = vertical offset from start signal
  512,             // vSize              = height resolution
  0,               // vSync0             = vsync falls
  0,               // vSync1             = vsync rise
  0,               // Rotate             = rotate display
  0x0000,          // OutBits            = output bits resolution
  0,               // OutDither          = output number of bits
  0x0000,          // OutSwizzle         = output swizzle
  0,               // OutCSpread         = output clock spread enable
  0,               // PClockPolarity     = clock polarity: 0 - rising edge, 1 - falling edge
  0,               // PClock             = clock prescaler of FT800: - 0 means disable and >0 means 48MHz/pclock
};

const TFT800Touch VTFT_FT800_CONFIG_TOUCH =
{
  3,               // TouchMode        = touch screen mode (2 bits): 0 - off, 1 - oneshot, 2 - frame, 3 - continuous
  1,               // TouchADCMode     = touch screen adc mode (1 bit): 0 - singleended, 1 - differential
  6000,            // TouchCharge      = Touchscreen charge time, units of 6 clocks
  3,               // TouchSettle      = touch screen settle time - 4 bits
  7,               // TouchOversample  = touch screen oversample - 4 bits
  2000,            // TouchRZThreshold = Touchscreen resistance threshold
};

const TFT800GPIO VTFT_FT800_CONFIG_GPIO =
{
  0xFC,            // GPIODIR = GPIO direction: 1 - output, 0 - input (8bit wide)
  0xFF,            // GPIO    = GPIO data latch
};

const TFT800PWM VTFT_FT800_CONFIG_PWM =
{
  0,               // Freq = PWM frequency - 14 bits
  128,             // Duty = PWM duty cycle, 0 to 128 is the range
};

const TFT800Interrupt VTFT_FT800_CONFIG_INTERRUPT =
{
  0,               // Flags  = interrupt flags (read only)
  0,               // Enable = global interrupt enable: 1 - enabled, 0 - disabled
  255,             // Mask   = interrupt mask value (individual interrupt enable): 1 - masked/disabled, 0 - enabled
};

const TFT800Sound VTFT_FT800_CONFIG_SOUND =
{
  0,               // Volume
  {0,              // Effect
  0},              // Pitch
  0,               // Play
};

const TFT800Audio VTFT_FT800_CONFIG_AUDIO =
{
  0,               // Volume
  0,               // StartAddress
  0,               // Length
  0,               // ReadPtr
  8000,            // Frequency
  0,               // Format
  0,               // Loop = audio playback mode
  0,               // Play
};

// Global variables

TTouchStat TouchS = {0};


/////////////////////////
TScreen *CurrentScreen = 0;


TScreen Screen1;

TBox    Box1;
TButton Button1;
char    Button1_Caption[8] = "testing";

TButton *const code Screen1_Buttons[1] = {
  &Button1              
};

TBox *const code Screen1_Boxes[1] = {
  &Box1                 
};


static char IsInsideObject(TObjInfo *AObjInfo, unsigned int X, unsigned int Y) {
  TRect *ptrPressRect = 0;
  TRect *ptrPressCircle = 0;

  if ((AObjInfo->HitX == X) && (AObjInfo->HitY == Y))
    return 1;

  switch (AObjInfo->Type) {
    // Button
    case VTFT_OT_BUTTON: {
      ptrPressRect = (TRect *)&(((TButton *)AObjInfo->Obj)->Left);
      break;
    }
    // Box
    case VTFT_OT_BOX: {
      ptrPressRect = (TRect *)&(((TBox *)AObjInfo->Obj)->Left);
      break;
    }
  }

  if (ptrPressRect) {
    if ((ptrPressRect->Left <= X) && (ptrPressRect->Left+ptrPressRect->Width-1 >= X) &&
        (ptrPressRect->Top  <= Y) && (ptrPressRect->Top+ptrPressRect->Height-1 >= Y))
      return 1;
    }
  else if (ptrPressCircle) {
    if ((ptrPressCircle->Left <= X) && (ptrPressCircle->Left+ptrPressCircle->Width*2-1 >= X) &&
        (ptrPressCircle->Top  <= Y) && (ptrPressCircle->Top+ptrPressCircle->Width*2-1 >= Y))
      return 1;
    }

  return 0;
}

void DrawButton(TButton *AButton) {
  int textWidth;
  int textHeight;
  
  if (AButton->Visible) {
    if (AButton == (TButton *)TouchS.ActObjInfo.Obj) {
      if (AButton->Gradient != _FT800_BRUSH_GR_NONE) {
        FT800_Canvas_BrushGradient(_FT800_BRUSH_STYLE_SOLID, AButton->Gradient, AButton->Press_Color, AButton->Press_ColorTo, AButton->Opacity);
      }
      else {
        FT800_Canvas_BrushSingleColor(_FT800_BRUSH_STYLE_SOLID, AButton->Press_Color, AButton->Opacity);
      }
    }
    else {
      if (AButton->Gradient != _FT800_BRUSH_GR_NONE) {
        FT800_Canvas_BrushGradient(_FT800_BRUSH_STYLE_SOLID, AButton->Gradient, AButton->Color, AButton->ColorTo, AButton->Opacity);
      }
      else {
        FT800_Canvas_BrushSingleColor(_FT800_BRUSH_STYLE_SOLID, AButton->Color, AButton->Opacity);
      }
    }

    FT800_Canvas_Pen(AButton->Pen_Width, AButton->Pen_Color, AButton->Opacity);

    if (AButton->Tag)
      FT800_Canvas_Tag(AButton->Tag);

    FT800_Screen_Box(AButton->Left, AButton->Top, AButton->Left+AButton->Width-1, AButton->Top+AButton->Height-1);
    if (AButton->FontHandle >= 16)
      FT800_Canvas_FontSystem(AButton->FontHandle, AButton->Font_Color, AButton->Opacity);
    else
      FT800_Canvas_Font(AButton->FontHandle, AButton->FontName, AButton->Source, AButton->Font_Color, AButton->Opacity);
    
    textWidth  = FT800_Canvas_TextWidth(AButton->Caption);
    textHeight = FT800_Canvas_TextHeight();
    if (AButton->TextAlign == taLeft)
      FT800_Screen_TextPos(AButton->Left+(AButton->Pen_Width)+1, AButton->Top+(AButton->Height-textHeight)/2, AButton->Caption);
    else if (AButton->TextAlign == taCenter)
      FT800_Screen_TextPos(AButton->Left+(AButton->Width-textWidth)/2, AButton->Top+(AButton->Height-textHeight)/2, AButton->Caption);
    else if (AButton->TextAlign == taRight)
      FT800_Screen_TextPos(AButton->Left+AButton->Width-textWidth-1, AButton->Top+(AButton->Height-textHeight)/2, AButton->Caption);
  }
}

void DrawBox(TBox *ABox) {
  if (ABox->Visible) {
    if (ABox == (TBox *)TouchS.ActObjInfo.Obj) {
      if (ABox->Gradient != _FT800_BRUSH_GR_NONE) {
        FT800_Canvas_BrushGradient(_FT800_BRUSH_STYLE_SOLID, ABox->Gradient, ABox->Press_Color, ABox->Press_ColorTo, ABox->Opacity);
      }
      else {
        FT800_Canvas_BrushSingleColor(_FT800_BRUSH_STYLE_SOLID, ABox->Press_Color, ABox->Opacity);
      }
    }
    else {
      if (ABox->Gradient != _FT800_BRUSH_GR_NONE) {
        FT800_Canvas_BrushGradient(_FT800_BRUSH_STYLE_SOLID, ABox->Gradient, ABox->Color, ABox->ColorTo, ABox->Opacity);
      }
      else {
        FT800_Canvas_BrushSingleColor(_FT800_BRUSH_STYLE_SOLID, ABox->Color, ABox->Opacity);
      }
    }

    FT800_Canvas_Pen(ABox->Pen_Width, ABox->Pen_Color, ABox->Opacity);

    if (ABox->Tag)
      FT800_Canvas_Tag(ABox->Tag);

    FT800_Screen_Box(ABox->Left, ABox->Top, ABox->Left+ABox->Width-1, ABox->Top+ABox->Height-1);
  }
}

void SetIdenticalFontSources(const code char *AFontName, unsigned long ASource) {
  char i;
  TButton *pButton;
  void *const code *ptrO;

  // Button
  i    = CurrentScreen->ButtonsCount;
  ptrO = CurrentScreen->Buttons;
  while (i--) {
    pButton = (TButton *)(*ptrO);
    if (pButton->FontName == AFontName)
      pButton->Source = ASource;
    ptrO++;
  }
}

static void ClearDynObjSource() {
  char i;
  TButton *pButton;
  void *const code *ptrO;

  // Button
  i    = CurrentScreen->ButtonsCount;
  ptrO = CurrentScreen->Buttons;
  while (i--) {
    pButton = (TButton *)(*ptrO);
    pButton->Source = 0xFFFFFFFF;
    ptrO++;
  }
}

void LoadCurrentScreenResToGRAM(char loadOptions) {
  char i;
  long currSource = -1;
  long tmpDynResStart;
  TButton *pButton;
  void *const code *ptrO;

  // clear dynamic resource addresses first, if necessary
  if (loadOptions & VTFT_LOAD_RES_DYNAMIC)
    ClearDynObjSource();

  // dynamic resources allocation
  if (loadOptions & VTFT_LOAD_RES_DYNAMIC) {

    tmpDynResStart = CurrentScreen->DynResStart;
    if (FT800_RES_BeginLoad(tmpDynResStart)) {
      return;
    }

    // Button
    i    = CurrentScreen->ButtonsCount;
    ptrO = CurrentScreen->Buttons;
    while (i--) {
      pButton = (TButton *)(*ptrO);
      if (pButton->FontHandle < 16)
        if (pButton->Source == 0xFFFFFFFF) {
          currSource = FT800_RES_LoadFont(pButton->FontName);
          pButton->Source = currSource;
          SetIdenticalFontSources(pButton->FontName, currSource);
        }
      ptrO++;
    }

    FT800_RES_EndLoad();
  }
}

void DrawObject(TPointer aObj, char aObjType) {
  TDrawHandler drawHandler;

  drawHandler = DrawHandlerTable[aObjType];
  if (drawHandler)
    drawHandler(aObj);
}

void DrawScreenO(TScreen *aScreen, char aOptions) {
  unsigned short cOrder, saveOrder;
  signed   int   actObjOrder;
  unsigned short pwmDuty;
  // counter variables
  char cntButton;
  char cntBox;
  // pointer variables
  TButton *const code *pButton;
  TBox    *const code *pBox;

  // process screen switching effects
  if (aOptions & VTFT_DISPLAY_EFF_LIGHTS_FADE) {
    FT800_PWM_Get(0, &pwmDuty);
    FT800_PWM_FadeOut(pwmDuty, 0, pwmDuty/32? pwmDuty/32 : 1, 1);
  }
  else if (aOptions & VTFT_DISPLAY_EFF_LIGHTS_OFF) {
    FT800_PWM_Get(0, &pwmDuty);
    FT800_PWM_Duty(0);
  }

  if (CurrentScreen != aScreen) {
  // clear active object when drawing to new screen
    memset(&TouchS.ActObjInfo, 0, sizeof(TObjInfo));
  }

  CurrentScreen = aScreen;

  LoadCurrentScreenResToGRAM(aOptions);

  // init counter variables
  cntButton = CurrentScreen->ButtonsCount;
  cntBox    = CurrentScreen->BoxesCount;
  // init pointer variables
  pButton = CurrentScreen->Buttons;
  pBox    = CurrentScreen->Boxes;

  FT800_Screen_BeginUpdateCP();
  FT800_Canvas_BrushSingleColor(_FT800_BRUSH_STYLE_SOLID, CurrentScreen->Color, 255);
  FT800_Canvas_Tag(0);
  FT800_Screen_Clear(_FT800_CLEAR_ALL);
  FT800_CP_CmdStop();

  actObjOrder = -1;
  if (TouchS.ActObjInfo.Obj)
    if (TouchS.ActObjInfo.Flags & VTFT_INT_BRING_TO_FRONT)
      actObjOrder = TouchS.ActObjInfo.Order;

  cOrder = 0;
  while (cOrder < CurrentScreen->ObjectsCount) {
    saveOrder = cOrder;
    if (pButton) {
      while ((*pButton)->Order == cOrder) {
        if (actObjOrder != cOrder) // draw pressed object at the end
          DrawButton(*pButton);
        cOrder++;
        pButton++;
        cntButton--;
        if (!cntButton) {
          pButton = 0;
          break;
        }
      }
      if (saveOrder != cOrder)
        continue;
    }

    if (pBox) {
      while ((*pBox)->Order == cOrder) {
        if (actObjOrder != cOrder) // draw pressed object at the end
          DrawBox(*pBox);
        cOrder++;
        pBox++;
        cntBox--;
        if (!cntBox) {
          pBox = 0;
          break;
        }
      }
      if (saveOrder != cOrder)
        continue;
    }

    cOrder++;
  }

  // draw pressed object now
  if (TouchS.ActObjInfo.Obj)
    DrawObject(TouchS.ActObjInfo.Obj, TouchS.ActObjInfo.Type);

  FT800_Screen_EndUpdate();
  FT800_Screen_Show();

  // process screen switching effects
  if (aOptions & VTFT_DISPLAY_EFF_LIGHTS_FADE) {
    FT800_PWM_FadeIn(0, pwmDuty, 1, 3);
  }
  else if (aOptions & VTFT_DISPLAY_EFF_LIGHTS_OFF) {
    FT800_PWM_Duty(pwmDuty);
  }

}

void DrawScreen(TScreen *aScreen) {
  if (aScreen != CurrentScreen)
    DrawScreenO(aScreen, VTFT_LOAD_RES_ALL | VTFT_DISPLAY_EFF_LIGHTS_FADE);
  else
    DrawScreenO(aScreen, VTFT_LOAD_RES_NONE);
}

char GetActiveObjectByXY(int X, int Y, TObjInfo *AObjInfo) {
  char i;
  int  hiOrder;
  TButton *pButton;
  TBox    *pBox;
  void *const code *ptrO;

  // clear current object info
  memset(AObjInfo, 0, sizeof(TObjInfo));

  // Find object with highest order at specified position.
  // Objects lists are sorted by object order ascending.
  hiOrder = -1;

  // Button
  i    = CurrentScreen->ButtonsCount;
  ptrO = CurrentScreen->Buttons+CurrentScreen->ButtonsCount-1;
  while (i--) {
    pButton = (TButton *)(*ptrO);
    if (pButton->Order < hiOrder)
      break;
    if (pButton->Active) {
      if ((pButton->Left <= X) && (pButton->Left+pButton->Width-1 >= X) &&
          (pButton->Top  <= Y) && (pButton->Top+pButton->Height-1 >= Y)) {
        AObjInfo->Obj   = (void *)pButton;
        AObjInfo->Type  = VTFT_OT_BUTTON;
        AObjInfo->Order = pButton->Order;
        AObjInfo->Flags = VTFT_INT_BRING_TO_FRONT;
        if ((pButton->Press_Color != pButton->Color) ||
            ((pButton->Gradient != _FT800_BRUSH_GR_NONE) &&
             (pButton->Press_ColorTo != pButton->ColorTo)))
          AObjInfo->Flags |= VTFT_INT_REPAINT_ON_DOWN | VTFT_INT_REPAINT_ON_UP;

        hiOrder         = pButton->Order;

        break;
      }
    }
    ptrO--;
  }

  // Box
  i    = CurrentScreen->BoxesCount;
  ptrO = CurrentScreen->Boxes+CurrentScreen->BoxesCount-1;
  while (i--) {
    pBox = (TBox *)(*ptrO);
    if (pBox->Order < hiOrder)
      break;
    if (pBox->Active) {
      if ((pBox->Left <= X) && (pBox->Left+pBox->Width-1 >= X) &&
          (pBox->Top  <= Y) && (pBox->Top+pBox->Height-1 >= Y)) {
        AObjInfo->Obj   = (void *)pBox;
        AObjInfo->Type  = VTFT_OT_BOX;
        AObjInfo->Order = pBox->Order;
        AObjInfo->Flags = VTFT_INT_BRING_TO_FRONT;
        if ((pBox->Press_Color != pBox->Color) ||
            ((pBox->Gradient != _FT800_BRUSH_GR_NONE) &&
             (pBox->Press_ColorTo != pBox->ColorTo)))
          AObjInfo->Flags |= VTFT_INT_REPAINT_ON_DOWN | VTFT_INT_REPAINT_ON_UP;

        hiOrder         = pBox->Order;

        break;
      }
    }
    ptrO--;
  }

  if (AObjInfo->Obj) {
    AObjInfo->HitX = X;
    AObjInfo->HitY = Y;
    return 1;
  }
  else {
    return 0;
  }
}

char GetActiveObjectByTag(char ATag, TObjInfo *AObjInfo) {
  char i;
  TButton *pButton;
  TBox    *pBox;
  void *const code *ptrO;

  // clear current object info
  memset(AObjInfo, 0, sizeof(TObjInfo));

  // Find object with specified tag value.

  // Button
  i    = CurrentScreen->ButtonsCount;
  ptrO = CurrentScreen->Buttons+CurrentScreen->ButtonsCount-1;
  while (i--) {
    pButton = (TButton *)(*ptrO);
    if (pButton->Tag == ATag) {
      if (pButton->Active) {
        AObjInfo->Obj   = (void *)pButton;
        AObjInfo->Type  = VTFT_OT_BUTTON;
        AObjInfo->Order = pButton->Order;
        AObjInfo->Flags = VTFT_INT_BRING_TO_FRONT;
        if ((pButton->Press_Color != pButton->Color) ||
            ((pButton->Gradient != _FT800_BRUSH_GR_NONE) &&
             (pButton->Press_ColorTo != pButton->ColorTo)))
          AObjInfo->Flags |= VTFT_INT_REPAINT_ON_DOWN | VTFT_INT_REPAINT_ON_UP;

      }
      break;
    }
    ptrO--;
  }

  // Box
  i    = CurrentScreen->BoxesCount;
  ptrO = CurrentScreen->Boxes+CurrentScreen->BoxesCount-1;
  while (i--) {
    pBox = (TBox *)(*ptrO);
    if (pBox->Tag == ATag) {
      if (pBox->Active) {
        AObjInfo->Obj   = (void *)pBox;
        AObjInfo->Type  = VTFT_OT_BOX;
        AObjInfo->Order = pBox->Order;
        AObjInfo->Flags = VTFT_INT_BRING_TO_FRONT;
        if ((pBox->Press_Color != pBox->Color) ||
            ((pBox->Gradient != _FT800_BRUSH_GR_NONE) &&
             (pBox->Press_ColorTo != pBox->ColorTo)))
          AObjInfo->Flags |= VTFT_INT_REPAINT_ON_DOWN | VTFT_INT_REPAINT_ON_UP;

      }
      break;
    }
    ptrO--;
  }

  if (AObjInfo->Obj) {
    AObjInfo->HitTag = ATag;
    return 1;
  }
  else {
    return 0;
  }
}

static void ProcessEvent(TEvent *pEvent) {
  if (pEvent) {
    if (pEvent->Sound.SndAct == VTFT_SNDACT_PLAY) 
      FT800_Sound_SetAndPlay(pEvent->Sound.Effect, pEvent->Sound.Pitch, pEvent->Sound.Volume);
    else if (pEvent->Sound.SndAct == VTFT_SNDACT_STOP) 
      FT800_Sound_Stop();
    if (pEvent->Action) 
      pEvent->Action();
  }
}

static void ProcessCEvent(TCEvent *pEventC) {
  if (pEventC) {
    if (pEventC->Sound.SndAct == VTFT_SNDACT_PLAY) 
      FT800_Sound_SetAndPlay(pEventC->Sound.Effect, pEventC->Sound.Pitch, pEventC->Sound.Volume);
    else if (pEventC->Sound.SndAct == VTFT_SNDACT_STOP) 
      FT800_Sound_Stop();
    if (pEventC->Action) 
      pEventC->Action();
  }
}

static void OnEvent(TObjInfo *AObjInfo, char AEventType){
  TEvent **ppEvent;
  TEvent  *pEvent = 0;

  switch (AObjInfo->Type) {
    // Button
    case VTFT_OT_BUTTON: {
      ppEvent = &(((TButton *)AObjInfo->Obj)->OnUp);
      pEvent  = ppEvent[AEventType];
      break;
    }
    // Box
    case VTFT_OT_BOX: {
      ppEvent = &(((TBox *)AObjInfo->Obj)->OnUp);
      pEvent  = ppEvent[AEventType];
      break;
    }
  } // end switch

  if (pEvent) {
    ProcessEvent(pEvent);
  }
}

static void Process_TP_Press() {
  // Screen Event
  if (CurrentScreen->Active)
    if ((CurrentScreen->SniffObjectEvents) || (!TouchS.ActObjInfo.Obj))
      ProcessEvent(CurrentScreen->OnPress);

  // Object Event
  if (!TouchS.ActObjInfo.Obj)
    return;

  OnEvent(&TouchS.ActObjInfo, VTFT_EVT_PRESS);
}

static void Process_TP_Up() {
  char     isClick;
  TObjInfo actObj;

  // Screen Event
  if (CurrentScreen->Active)
    if ((CurrentScreen->SniffObjectEvents) || (!TouchS.ActObjInfo.Obj))
      ProcessEvent(CurrentScreen->OnUp);

  actObj = TouchS.ActObjInfo;
  // Cler active object info
  memset(&TouchS.ActObjInfo, 0, sizeof(TObjInfo));

  // Object Event
  if (!actObj.Obj)
    return;

  isClick = IsInsideObject(&actObj, TouchS.X, TouchS.Y);

  if (actObj.Flags & VTFT_INT_REPAINT_ON_UP)
    DrawScreen(CurrentScreen);

  OnEvent(&actObj, VTFT_EVT_UP);
  if (isClick)
    OnEvent(&actObj, VTFT_EVT_CLICK);
}

static void Process_TP_Down() {
  // Search for active object
  if (TouchS.Tag) {        // objects must not have zero for tag value
    if (TouchS.Tag != 255) // can not search objects by default tag value
      GetActiveObjectByTag(TouchS.Tag, &TouchS.ActObjInfo);
    if (!TouchS.ActObjInfo.Obj) // object not found by tag, search by coordinates
      GetActiveObjectByXY(TouchS.X, TouchS.Y, &TouchS.ActObjInfo);
  }

  // Screen Event
  if (CurrentScreen->Active)
    if ((CurrentScreen->SniffObjectEvents) || (!TouchS.ActObjInfo.Obj))
      ProcessEvent(CurrentScreen->OnDown);

  // Object Event
  if (!TouchS.ActObjInfo.Obj)
    return;

  if (TouchS.ActObjInfo.Flags & VTFT_INT_REPAINT_ON_DOWN)
    DrawScreen(CurrentScreen);

  OnEvent(&TouchS.ActObjInfo, VTFT_EVT_DOWN);
}

static void Process_TP_TagChange() {
  // Screen Event
  if (CurrentScreen->Active)
    ProcessEvent(CurrentScreen->OnTagChange);
}

void ProcessVTFTStack() {
  char         Tag, oldTag;
  unsigned int X, Y;

  oldTag = TouchS.Tag;

  if (FT800_Touch_GetTagXY(&X, &Y) == 1) {
    FT800_Touch_GetTag(&Tag);

    TouchS.Tag = Tag;
    TouchS.X = X;
    TouchS.Y = Y;

    if (!TouchS.Pressed) {
      TouchS.Pressed = 1;
      Process_TP_Down();
    }

    Process_TP_Press();
  }
  else if (TouchS.Pressed) {
    Process_TP_Up();

    TouchS.Tag = 0;
    TouchS.X   = X;
    TouchS.Y   = Y;

    TouchS.Pressed = 0;
  }

  if (oldTag != TouchS.Tag)
    Process_TP_TagChange();
}

static void InitObjects() {
  // Screen1: Init block start
  Screen1.Color             = 0x5AEB;
  Screen1.Width             = 512;
  Screen1.Height            = 512;
  Screen1.ObjectsCount      = 2;
  Screen1.ButtonsCount      = 1;
  Screen1.Buttons           = Screen1_Buttons;
  Screen1.BoxesCount        = 1;
  Screen1.Boxes             = Screen1_Boxes;
  Screen1.DynResStart       = 0;
  Screen1.Active            = 1;
  Screen1.SniffObjectEvents = 0;
  Screen1.OnUp              = 0;
  Screen1.OnDown            = 0;
  Screen1.OnTagChange       = 0;
  Screen1.OnPress           = 0;

  Box1.OwnerScreen   = &Screen1;
  Box1.Order         = 0;
  Box1.Visible       = 1;
  Box1.Opacity       = 255;
  Box1.Tag           = 255;
  Box1.Left          = 63;
  Box1.Top           = 52;
  Box1.Width         = 61;
  Box1.Height        = 46;
  Box1.Pen_Width     = 1;
  Box1.Pen_Color     = 0x0000;
  Box1.Color         = 0xFFFF;
  Box1.Press_Color   = 0xE71C;
  Box1.ColorTo       = 0xC618;
  Box1.Press_ColorTo = 0x0000;
  Box1.Gradient      = _FT800_BRUSH_GR_TOP_TO_BOTTOM;
  Box1.Active        = 1;
  Box1.OnUp          = 0;
  Box1.OnDown        = 0;
  Box1.OnClick       = 0;
  Box1.OnPress       = 0;

  Button1.OwnerScreen   = &Screen1;
  Button1.Order         = 1;
  Button1.Visible       = 1;
  Button1.Opacity       = 255;
  Button1.Tag           = 255;
  Button1.Left          = 155;
  Button1.Top           = 144;
  Button1.Width         = 98;
  Button1.Height        = 48;
  Button1.Pen_Width     = 1;
  Button1.Pen_Color     = 0x0000;
  Button1.Color         = 0xFFFF;
  Button1.Press_Color   = 0xE71C;
  Button1.ColorTo       = 0xC618;
  Button1.Press_ColorTo = 0x0000;
  Button1.Gradient      = _FT800_BRUSH_GR_TOP_TO_BOTTOM;
  Button1.Caption       = Button1_Caption;
  Button1.TextAlign     = taCenter;
  Button1.FontName      = Tahoma_11x13_Regular;
  Button1.Font_Color    = 0x0000;
  Button1.FontHandle    = 1;
  Button1.Source        = -1UL;
  Button1.Active        = 1;
  Button1.OnUp          = 0;
  Button1.OnDown        = 0;
  Button1.OnClick       = 0;
  Button1.OnPress       = 0;

}

void Init_MCU()
{
// Place your code here
}

void InitVTFTStack() {
  Init_MCU();

  SPI_Init();

  // Init all dynamic objects
  InitObjects();

  // Init FT800 controller core and library stack
  FT800_Init();

  FT800_Core_ClockSource(_FT800_CLK_SOURCE_EXTERNAL);

  // Internal modules setup
  FT800_Display_SetConfig(&VTFT_FT800_CONFIG_DISPLAY);

  FT800_Audio_SetConfig(&VTFT_FT800_CONFIG_AUDIO);

  FT800_Sound_SetConfig(&VTFT_FT800_CONFIG_SOUND);

  FT800_Interrupt_SetConfig(&VTFT_FT800_CONFIG_INTERRUPT);

  FT800_PWM_SetConfig(&VTFT_FT800_CONFIG_PWM);

  FT800_GPIO_SetConfig(&VTFT_FT800_CONFIG_GPIO);

  FT800_Touch_SetConfig(&VTFT_FT800_CONFIG_TOUCH);

  FT800_Touch_Calibrate(_FT800_FONT_ROBOTO_SIZE_10, "Touch blinking point on the screen!");

  // Draw start screen
  DrawScreen(&Screen1);
}