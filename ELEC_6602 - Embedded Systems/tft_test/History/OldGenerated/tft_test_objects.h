#ifndef TFT_TEST_OBJECTS
#define TFT_TEST_OBJECTS

#include "FT800_Types.h"

typedef enum {taNone, taLeft, taCenter, taRight, taCenterX, taCenterY, taRightX} TTextAlign;

typedef struct Screen TScreen;

typedef unsigned long TPointer;

typedef struct tagObjInfo {
  void     *Obj;
  char     Type;
  char     Order;
  char     Flags;

  char     HitTag;
  int      HitX;
  int      HitY;
} TObjInfo;

typedef struct tagTouchStat {
  char Pressed;

  char Tag;
  int  X;
  int  Y;

  TObjInfo ActObjInfo;
} TTouchStat;

typedef void (*TDrawHandler)(TPointer aObj);

typedef void (*TEvtAction)();

typedef struct tagEvtSound {
  char SndAct;
  char Effect;
  char Pitch;
  char Volume;
} TEvtSound;

typedef const struct tagCEvent {
  TEvtAction Action;
  TEvtSound  Sound;
} TCEvent;

typedef struct tagEvent {
  TEvtAction Action;
  TEvtSound  Sound;
} TEvent;

typedef const struct tagCRect {
  int Left;
  int Top;
  int Width;
  int Height;
} TCRect;

typedef struct tagRect {
  int Left;
  int Top;
  int Width;
  int Height;
} TRect;

typedef struct tagButton {
  TScreen         *OwnerScreen;
  char            Order;
  char            Visible;
  char            Opacity;
  char            Tag;
  int             Left;
  int             Top;
  int             Width;
  int             Height;
  char            Pen_Width;
  unsigned int    Pen_Color;
  unsigned int    Color;
  unsigned int    Press_Color;
  unsigned int    ColorTo;
  unsigned int    Press_ColorTo;
  char            Gradient;
  char            *Caption;
  TTextAlign      TextAlign;
  const code char *FontName;
  unsigned int    Font_Color;
  char            FontHandle;
  long            Source;
  char            Active;
  TEvent          *OnUp;
  TEvent          *OnDown;
  TEvent          *OnClick;
  TEvent          *OnPress;
} TButton;

typedef struct tagBox {
  TScreen      *OwnerScreen;
  char         Order;
  char         Visible;
  char         Opacity;
  char         Tag;
  int          Left;
  int          Top;
  int          Width;
  int          Height;
  char         Pen_Width;
  unsigned int Pen_Color;
  unsigned int Color;
  unsigned int Press_Color;
  unsigned int ColorTo;
  unsigned int Press_ColorTo;
  char         Gradient;
  char         Active;
  TEvent       *OnUp;
  TEvent       *OnDown;
  TEvent       *OnClick;
  TEvent       *OnPress;
} TBox;

struct Screen {
  unsigned int   Color;
  unsigned int   Width;
  unsigned int   Height;
  unsigned short ObjectsCount;
  unsigned short ButtonsCount;
  TButton        *const code *Buttons;
  unsigned short BoxesCount;
  TBox           *const code *Boxes;
  unsigned long  DynResStart;
  unsigned short Active;
  unsigned short SniffObjectEvents;
  TEvent         *OnUp;
  TEvent         *OnDown;
  TEvent         *OnTagChange;
  TEvent         *OnPress;
};


// Object type constants
// Usage: VTFT stack internally
extern const VTFT_OT_BUTTON;
extern const VTFT_OT_BOX;
// ~Object type constants

// Event type constants
// Usage: OnEvent
extern const VTFT_EVT_UP;
extern const VTFT_EVT_DOWN;
extern const VTFT_EVT_CLICK;
extern const VTFT_EVT_PRESS;
// ~Event type constants

// Sound action constants
// Usage: sound event action property and ProcessEvent
extern const VTFT_SNDACT_NONE;
extern const VTFT_SNDACT_PLAY;
extern const VTFT_SNDACT_STOP;
// ~Sound action constants

// Resource loading constants.
// Usage: DrawScreenO and LoadCurrentScreenResToGRAM
extern const VTFT_LOAD_RES_NONE;
extern const VTFT_LOAD_RES_STATIC;
extern const VTFT_LOAD_RES_DYNAMIC;
extern const VTFT_LOAD_RES_ALL;
// ~Resource loading constants

// Display effect constants
// Usage: DrawScreenO
extern const VTFT_DISPLAY_EFF_NONE;
extern const VTFT_DISPLAY_EFF_LIGHTS_FADE;
extern const VTFT_DISPLAY_EFF_LIGHTS_OFF;
// ~Display effect constants

// Stack flags
// Usage: internally used by VTFT stack
extern const VTFT_INT_REPAINT_ON_DOWN;
extern const VTFT_INT_REPAINT_ON_UP;
extern const VTFT_INT_BRING_TO_FRONT;
extern const VTFT_INT_INTRINSIC_CLICK_EFF;
// ~Stack flags

// Table of object draw handlers
// Use object type constants to access coresponding object draw handler
extern const TPointer DrawHandlerTable[44];
// ~Table of draw handler pointers


// Default configuration parameters
extern const TFT800PWM            VTFT_FT800_CONFIG_PWM;
extern const TFT800GPIO           VTFT_FT800_CONFIG_GPIO;
extern const TFT800Sound          VTFT_FT800_CONFIG_SOUND;
extern const TFT800Audio          VTFT_FT800_CONFIG_AUDIO;
extern const TFT800Display        VTFT_FT800_CONFIG_DISPLAY;
extern const TFT800Interrupt      VTFT_FT800_CONFIG_INTERRUPT;
extern const TFT800Touch          VTFT_FT800_CONFIG_TOUCH;

extern TTouchStat TouchS;

extern TScreen Screen1;

extern TBox    Box1;
extern TButton Button1;

extern TButton *const code Screen1_Buttons[1];
extern TBox    *const code Screen1_Boxes[1];

extern TScreen *CurrentScreen;

/////////////////////////
// User Event Handlers
/////////////////////////

/////////////////////////////////
// Captions
extern char Button1_Caption[];

void DrawScreenO(TScreen *aScreen, char aOptions);
void DrawScreen(TScreen *aScreen);
void DrawButton(TButton *AButton);
void DrawBox(TBox *ABox);
void ProcessVTFTStack();
void InitVTFTStack();

#endif