#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
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
#line 1 "d:/mikroc pro for arm/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
long int max(long int a, long int b);
long int min(long int a, long int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
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
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"







static const uint8_t TRUE = 1;
static const uint8_t FALSE = 0;
static const uint8_t ON = 1;
static const uint8_t OFF = 0;
static const uint8_t TAIL_ON = 1;
static const uint8_t TAIL_OFF = 0;





static const uint32_t GPIO_INPUT_MASK = 0x44444444;


static const int32_t Y_MAX_LENGTH = 15;
static const int32_t MAX_COL_WIDTH = 20;
static const int32_t MAX_ROW_LENGTH = 15;
static const int32_t MAX_BLOCK_COUNT = 300;
static const uint8_t PX_BLOCK = 16;
static const uint8_t INI_BLOCK = 10;




typedef struct {
 int16_t node_x;
 int16_t node_y;
} t_node;


static const uint8_t PHASE_LOGO = 0xF;
static const uint8_t PHASE_INTRO = 0;
static const uint8_t PHASE1_READY = 1;
static const uint8_t PHASE2_PLAYING = 2;
static const uint8_t PHASE_QUIT = 3;
static const uint8_t PHASE_HSCORE = 4;
static const uint8_t PHASE_PRINT_TOP_TEN = 5;

static const uint8_t NORMAL_MODE = 0;
static const uint8_t WALL_COL_OFF = 0x1;
static const uint8_t DEV_MODE = 0x3;

static const uint8_t TOTAL_TIME = 0x1A;
static const uint8_t SESSION_TIME = 0x1F;

static const uint8_t MOVE_RIGHT = 0x0;
static const uint8_t MOVE_LEFT = 0x1;
static const uint8_t MOVE_UP = 0x2;
static const uint8_t MOVE_DOWN = 0x3;
static const uint8_t JBTN_DOWN = 0x4;
static const uint16_t NEG_NULL = -1;
static const uint32_t SFX_FOOD = 5;
static const uint32_t SFX_FOOD_HIGH = 1;
static const uint32_t SFX_WALL = 10;


static const uint32_t SCREEN_X_MAX = 320;
static const uint32_t SCREEN_Y_MAX = 240;
static const uint32_t HS_CURSOR_START_X = 16;
static const uint32_t HS_CURSOR_START_Y = 4;



static const uint8_t m_BLACK = 0;
static const uint8_t m_YELLOW = 1;
static const uint8_t m_RED = 2;
static const uint8_t m_NAVY = 3;
static const uint8_t m_GRAY = 4;
static const uint8_t m_GREEN = 5;
static const uint8_t m_WHITE = 6;
static const uint8_t m_FUCHSIA = 6;


static volatile uint8_t cur_screen_run_flag = TRUE;
static volatile uint8_t g_GAME_PHASE = PHASE1_READY;

void set_cur_screen_run_flag(uint8_t run_flag) {
 cur_screen_run_flag = run_flag;
}

void set_game_phase(uint8_t game_phase) {
 g_GAME_PHASE = game_phase;
}
#line 111 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"
void debug(uint32_t value) {
 Delay_ms(1);
 USART1_DR = 0xD;
 Delay_ms(1);
 USART1_DR=0xA;
 Delay_ms(1);
 USART1_DR = value;
}
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_intro_screen_ctl.h"
#line 1 "d:/mikroc pro for arm/include/stdint.h"
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_pix_render.h"
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"
#line 16 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_pix_render.h"
static const uint8_t SHIFT_UP = 0xC1;
static const uint8_t SHIFT_DOWN = 0xC2;
static const uint8_t SHIFT_LEFT = 0xC3;
static const uint8_t SHIFT_RIGHT = 0xC4;




static volatile uint8_t CUR_BRUSH_COLOUR = m_BLACK;
uint8_t g_DS_BUFFER[300];


static int32_t offset_x = 0;
static int32_t offset_y = 0;



void cleaning_buffer (uint8_t color_8bit);
void convert_lin_xy ( int32_t *cell_pos, int32_t *x_var, int32_t *y_var );
void draw_cell_pos ( int32_t *linear_pos, uint8_t color_8bit);
void init_arr (uint8_t *in_arr, uint32_t a_size);
void load_cell_xy (int32_t x_var, int32_t y_var, int32_t clr_code);
void render_rect_mask (int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit);
void set_sprite_offset (int32_t ofs_x, int32_t ofs_y);

int32_t color_convert_32 (uint8_t color_8bit);
int32_t get_offset_x ();

void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_ini_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit );






void dump_ds_buffer();





void init_arr(uint8_t *in_arr, uint32_t a_size) {
 uint32_t i=0;

 for (i=0; i < a_size; i++) {
 in_arr[i]=0xFF;
 }
}



void dump_arr_memory(uint8_t *in_arr, uint32_t a_size) {
 uint32_t i = 0;

 for ( i=0; i < MAX_BLOCK_COUNT; i++) {


 while ( (USART1_SR & (1 << 7 )) == 0) {}
 Delay_ms(10);
 USART1_DR = (uint32_t)in_arr[i];
 Delay_ms(10);

 }
}




void set_sprite_offset(int32_t ofs_x, int32_t ofs_y) {
 offset_x = ofs_x;
 offset_y = ofs_y;
}

int32_t get_offset_x() {
 return offset_x;
}
int32_t get_offset_y() {
 return offset_y;
}




void convert_lin_xy(int32_t *cell_pos, int32_t *x_var, int32_t *y_var ) {

 int32_t row = 0;
 int32_t col = 0;
 int32_t temp_val = *cell_pos;

 if (temp_val > MAX_BLOCK_COUNT) {
 temp_val = 300;
 }




 while (temp_val >= (MAX_COL_WIDTH) ) {
 temp_val -= MAX_COL_WIDTH-1;
 ++row;

 if (temp_val > 0 ) {
 --temp_val;
 }

 }



 if (row <= 0 ) {
 row = 1;
 }

 col = temp_val;

 *x_var = col;
 *y_var = row;

}



int32_t color_convert_32(uint8_t color_8bit) {

 if (color_8bit == m_YELLOW){
 return CL_YELLOW;
 } else if (color_8bit == m_BLACK) {
 return CL_BLACK;
 } else if (color_8bit == m_RED) {
 return CL_RED;
 } else if (color_8bit == m_NAVY) {
 return CL_NAVY;
 } else if (color_8bit == m_GREEN) {
 return CL_GREEN;
 } else if (color_8bit == m_FUCHSIA) {
 return CL_FUCHSIA;
 } else if (color_8bit == m_GRAY) {
 return CL_GRAY;
 } else {
 return CL_WHITE;
 }
}




void set_brush_color(uint8_t color_8bit) {
 int32_t px_clr;
 px_clr = color_convert_32(color_8bit);

 TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
 CUR_BRUSH_COLOUR = color_8bit;
}




void draw_cell_pos( int32_t *linear_pos, uint8_t color_8bit) {
 int32_t x_var;
 int32_t y_var;
 int32_t cell_pos = *linear_pos;


 if (color_8bit != CUR_BRUSH_COLOUR) {

 set_brush_color(color_8bit);
 }


 convert_lin_xy(&cell_pos, &x_var, &y_var );


 x_var +=offset_x;
 y_var +=offset_y;



 TFT_Rectangle(
 PX_BLOCK * x_var,
 (y_var * PX_BLOCK),
 PX_BLOCK + (PX_BLOCK * x_var),
 PX_BLOCK + (PX_BLOCK * y_var)
 );
}




void draw_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {

 if (color_8bit != CUR_BRUSH_COLOUR) {
 set_brush_color(color_8bit);
 }



 x_var +=offset_x;
 y_var +=offset_y;



 TFT_Rectangle(
 PX_BLOCK * x_var,
 (y_var * PX_BLOCK),
 PX_BLOCK + (PX_BLOCK * x_var),
 PX_BLOCK + (PX_BLOCK * y_var)
 );
}



void draw_ini_cell_xy(int16_t x_var, int16_t y_var, uint8_t color_8bit ) {

 if (color_8bit != CUR_BRUSH_COLOUR) {
 set_brush_color(color_8bit);
 }



 x_var +=offset_x;
 y_var +=offset_y;



 TFT_Rectangle(
 INI_BLOCK * x_var,
 (y_var * PX_BLOCK),
 INI_BLOCK + ( INI_BLOCK * x_var),
 PX_BLOCK + ( PX_BLOCK * y_var)
 );
}






void render_rect_mask(int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit) {


 set_brush_color(color_8bit);

 TFT_Rectangle(
 PX_BLOCK * ul_x,
 PX_BLOCK * ul_y,
 PX_BLOCK * lr_x,
 PX_BLOCK * lr_y
 );
}





void load_cell_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
 int32_t linear_val = 0;
 uint8_t color_8bit = clr_code;










 linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );
 g_DS_BUFFER[linear_val] = color_8bit;

}




void dump_ds_buffer() {
 int32_t i=0;

 for (i=0; i < MAX_BLOCK_COUNT ; i++) {

 if (g_DS_BUFFER[i] != 0xFF) {
 draw_cell_pos(i, g_DS_BUFFER[i]);
 }

 }
}




void print_snake(t_node *node, uint8_t color_8bit) {
 draw_cell_xy(node->node_x, node->node_y, color_8bit);
}




void clean_tail(t_node * node_tail, uint8_t color_8bit) {
 print_snake(node_tail, color_8bit);
}


void cleaning_buffer(uint8_t color_8bit) {
 int32_t i=0;

 for (i=0; i < MAX_BLOCK_COUNT ; i++) {

 if (g_DS_BUFFER[i] != 0xFF) {
 draw_cell_pos(i, color_8bit );
 }

 }
}
#line 17 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_intro_screen_ctl.h"
static const uint32_t SCROLL_SPEED = 3;
static const uint32_t X_SCROLL_SPEED = 1;



 const uint8_t pub_msg[] = "Run Hop Games presents:";

 const uint8_t intro_msg[] = "Press Joystick/PC13 to contiue.";
uint8_t g_DS_BUFFERi[300];
uint8_t intro_game_phase = PHASE_LOGO;





void load_intro_screen_simple();



void duck_sprite();
void draw_intro_screen(uint32_t x_axis, uint32_t y_axis);
void draw_rectangle(uint32_t x_axis, uint32_t y_axis);
void set_cur_screen_run_flag(uint8_t run_flag);
void draw_info_text(uint32_t x_axis, uint32_t y_axi);
void get_intro_game_phase();
#line 54 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_intro_screen_ctl.h"
void load_intro_screen_simple() {


 uint8_t scroll_dir = 5;
 uint32_t volatile x_axis = 55;
 uint32_t volatile y_axis = 115;

 uint32_t prev_val = 0;
 uint32_t prev_val2 = 0;




 TFT_Fill_Screen(CL_BLACK);

 while (cur_screen_run_flag == TRUE ) {


 draw_rectangle(x_axis, y_axis);

 if (scroll_dir == 1 ) {
 if (y_axis > (SCREEN_Y_MAX-20) || x_axis > (SCREEN_X_MAX -30) ) {
 scroll_dir = 0;
 }
 x_axis+=X_SCROLL_SPEED;
 y_axis+=SCROLL_SPEED;

 }
 else {

 if (y_axis < 10 || x_axis < 2) {
 scroll_dir = 1;
 }
 x_axis-=X_SCROLL_SPEED;
 y_axis-=SCROLL_SPEED;
 }
 draw_intro_screen(x_axis, y_axis);

 }
}



void load_intro_screen() {

 uint8_t rotation = 0;
 uint8_t scroll_dir = 1;
 uint32_t volatile x_axis = 35;
 uint32_t volatile y_axis = 115;

 uint32_t prev_val = 0;
 uint32_t prev_val2 = 5;
 uint32_t counter = 1;

 intro_game_phase = PHASE_INTRO;
 cur_screen_run_flag = TRUE;





 TFT_Fill_Screen(CL_BLACK);

 draw_info_text( 10,220);


 while (cur_screen_run_flag == TRUE ) {


 draw_rectangle(x_axis, y_axis);


 if (scroll_dir == 1){
 x_axis+=X_SCROLL_SPEED;
 y_axis+=SCROLL_SPEED;


 if ( x_axis > (SCREEN_X_MAX -200) || y_axis > (SCREEN_Y_MAX-42) ) {
 if (rotation == 0) {
 scroll_dir = 2;
 }
 else {
 scroll_dir = 4;
 }
 }

 }

 else if (scroll_dir == 2) {
 x_axis += X_SCROLL_SPEED;
 y_axis -= SCROLL_SPEED;


 if (x_axis > (SCREEN_X_MAX -200) || y_axis <10 ) {
 if (rotation == 0) {
 scroll_dir = 3;
 }
 else {
 scroll_dir = 1;
 }
 }
 }


 else if (scroll_dir == 3) {
 x_axis -= X_SCROLL_SPEED;
 y_axis -= SCROLL_SPEED;


 if ( x_axis < 10 || y_axis < 10 ) {

 if (rotation == 0) {
 scroll_dir = 4;
 }
 else {
 scroll_dir = 1;
 }
 }

 }

 else if (scroll_dir == 4) {
 x_axis -= X_SCROLL_SPEED;
 y_axis += SCROLL_SPEED;


 if ( x_axis < 10 || y_axis > (SCREEN_Y_MAX-42)) {

 if (rotation == 0) {
 scroll_dir = 1;
 } else {
 scroll_dir = 3;
 x_axis + 10;
 }






 }
 }

 counter++;
 if (counter == 5) {
 rotation = ~rotation;
 counter = 0;
 }

 draw_intro_screen(x_axis, y_axis);

 }
}



void draw_info_text(uint32_t x_axis, uint32_t y_axis) {
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Write_Text(&intro_msg, x_axis, y_axis);
}

void draw_rectangle(uint32_t x_axis, uint32_t y_axis) {

 TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
 TFT_Rectangle(x_axis, y_axis, x_axis+255, y_axis+17);


}



void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {




 TFT_Set_Font(TFT_defaultFont, CL_YELLOW, FO_HORIZONTAL );


 TFT_Write_Text(&pub_msg, x_axis, y_axis);



 Delay_ms(10);

}





void load_duck_screen() {
 uint32_t x_axis = 0;
 uint32_t y_axis = 0;
 uint32_t PX_BLOCK = 16;
 uint32_t i=0;

 uint32_t value = 0;

 intro_game_phase = PHASE_LOGO;

 init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);



 set_cur_screen_run_flag(TRUE);



 TFT_Fill_Screen(CL_NAVY);

 TFT_SET_PEN(m_BLACK, 0);
 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);




 duck_sprite();
 set_sprite_offset(0, 6);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
 TFT_Write_Text("A PUDDLE ProDUCKtions ", 6*PX_BLOCK, 13*PX_BLOCK);
#line 294 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_intro_screen_ctl.h"
 while (cur_screen_run_flag == TRUE) {};


 set_sprite_offset(0,0);

}





void duck_sprite() {







 int32_t xfs = 3;
 int32_t yfs = 2;


 draw_cell_xy(8 + xfs,0 + yfs, m_YELLOW);
 draw_cell_xy(9 + xfs,0 + yfs, m_YELLOW);
 draw_cell_xy(10 + xfs,0 + yfs, m_YELLOW);


 draw_cell_xy(2 + xfs, 2+yfs, m_YELLOW);
 draw_cell_xy(3 + xfs, 2+yfs, m_YELLOW);
 draw_cell_xy(7 + xfs, 2+yfs, m_YELLOW);
 draw_cell_xy(8 + xfs, 2+yfs, m_YELLOW);




 draw_cell_xy(7 + xfs,1+yfs, m_BLACK);
 draw_cell_xy(8 + xfs,1+yfs, m_BLACK);
 draw_cell_xy(9 + xfs,1+yfs, m_BLACK);
 draw_cell_xy(10 + xfs, 1+yfs, m_BLACK);
 draw_cell_xy(11 + xfs, 1+yfs, m_BLACK);
 draw_cell_xy(9 + xfs,2+yfs, m_BLACK);
 draw_cell_xy(10+xfs,2+yfs, m_BLACK);




 draw_cell_xy(11+xfs,2+yfs, m_RED);
 draw_cell_xy(12+xfs,2+yfs, m_RED);
 draw_cell_xy(13+xfs,2+yfs, m_RED);
 draw_cell_xy(11+xfs,3+yfs, m_RED);
 draw_cell_xy(12+xfs,3+yfs, m_RED);


 draw_cell_xy(1+xfs,3+yfs, m_YELLOW);
 draw_cell_xy(2+xfs,3+yfs, m_YELLOW);
 draw_cell_xy(3+xfs,3+yfs, m_YELLOW);
 draw_cell_xy(4+xfs,3+yfs, m_YELLOW);
 draw_cell_xy(8+xfs,3+yfs, m_YELLOW);
 draw_cell_xy(9+xfs,3+yfs, m_YELLOW);
 draw_cell_xy(10+xfs,3+yfs, m_YELLOW);
 draw_cell_xy(0+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(1+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(2+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(3+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(4+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(5+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(6+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(7+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(8+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(9+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(10+xfs,4+yfs, m_YELLOW);
 draw_cell_xy(1+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(2+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(3+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(4+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(5+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(6+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(7+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(8+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(9+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(10+xfs,5+yfs, m_YELLOW);
 draw_cell_xy(2+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(3+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(4+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(5+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(6+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(7+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(8+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(9+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(10+xfs,6+yfs, m_YELLOW);
 draw_cell_xy(3+xfs,7+yfs,m_YELLOW);
 draw_cell_xy(4+xfs,7+yfs,m_YELLOW);
 draw_cell_xy(5+xfs,7+yfs,m_YELLOW);
 draw_cell_xy(6+xfs,7+yfs,m_YELLOW);
 draw_cell_xy(7+xfs,7+yfs,m_YELLOW);
 draw_cell_xy(8+xfs,7+yfs,m_YELLOW);
 draw_cell_xy(9+xfs,7+yfs,m_YELLOW);
 draw_cell_xy(4+xfs,8+yfs,m_YELLOW);
 draw_cell_xy(5+xfs,8+yfs,m_YELLOW);
 draw_cell_xy(6+xfs,8+yfs,m_YELLOW);
 draw_cell_xy(7+xfs,8+yfs,m_YELLOW);
 draw_cell_xy(8+xfs,8+yfs,m_YELLOW);

}
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
#line 1 "d:/mikroc pro for arm/include/stdint.h"
#line 1 "d:/mikroc pro for arm/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_pix_render.h"
#line 14 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
static const uint8_t EOF_ARRAY = 0xFF;
const static int32_t MAX_CELLS = 300;
static const uint32_t EEPROM_MAX_SIZE =100;
static const uint8_t init_cursor_start = 0x41;





static volatile uint8_t game_cur_screen_run_flag = TRUE;

static uint8_t g_TIME_TRACK_MODE = TOTAL_TIME;
static uint8_t g_GAME_MODE = NORMAL_MODE;

static uint8_t g_curr_snake_dir = MOVE_RIGHT;
static volatile uint8_t g_game_clock_delay_tim3 = ON;
static uint32_t g_game_score = 0;
static int32_t g_debug = 0;
static int32_t g_debug2 = 2;
static int32_t g_rand_num = 999;
static uint8_t g_food_in_play = FALSE;
static int32_t g_fd_x_val = NEG_NULL;
static int32_t g_fd_y_val = NEG_NULL;
static int32_t init_cur_pos = 0;
static uint8_t user_score_entry[7];
static int32_t i =0;
static int32_t j =0;
static uint32_t i2c_status;
static uint8_t tx_buffer_[128];
static uint8_t rx_buffer_[256];
static int32_t hs_cursor_x = HS_CURSOR_START_X;
static int32_t hs_cursor_y = HS_CURSOR_START_Y;
uint8_t init_cur = init_cursor_start;
int32_t game_speed =1;



uint8_t g_str_buffer[256];


static volatile uint32_t g_time_count = 0;
static volatile uint32_t g_session_count = 0;
static uint32_t g_t_mins = 0;
static uint32_t g_t_secs = 0;
static uint32_t g_t_wait = FALSE;



t_node g_snake_cells[MAX_CELLS];
t_node *m_node_start = &g_snake_cells;
t_node *m_node_end = &g_snake_cells[MAX_CELLS-1];

t_node *m_node_head = &g_snake_cells;
t_node *m_node_tail = &g_snake_cells;







void load_game_screen();
uint8_t get_game_phase();
void update_game_time();
void move_snake();
void set_curr_snake_dir();
void scr_debug(uint32_t value);

void update_game_time ();
void update_game_speed();
void set_secret_mode ();




void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);


void init_snake_sprite();

void incr_snake_head();
void incr_snake_tail();
t_node* incr_node(t_node *_node);
void game_over();
int32_t get_initial_cur_pos ();


void update_snake_info(int32_t head_x, int32_t head_y);
void toggle_game_clock_delay();
void set_food_in_play_flag (uint8_t state);
void set_food_xy(int32_t *x_val, int32_t *y_val);


void scr_debug(int32_t value, int32_t value2) {
 g_debug = value;
 g_debug2 = value2;
}





void reset_game_values () {
 i =0;
 j =0;
 g_session_count = 0;
 g_game_score = 0;
 g_debug = 0;
 g_debug2 = 2;
 g_rand_num = 999;
 g_food_in_play = FALSE;
 g_fd_x_val = NEG_NULL;
 g_fd_y_val = NEG_NULL;
 init_cur = init_cursor_start;
 init_cur_pos = 0;

 hs_cursor_x = HS_CURSOR_START_X;
 hs_cursor_y = HS_CURSOR_START_Y;

 user_score_entry[3] = 0;
 user_score_entry[4] = 0;
 user_score_entry[5] = 0;
 user_score_entry[6] = 0;

}



void update_game_speed(uint32_t gspeed) {
 game_speed = gspeed;
}



void set_curr_snake_dir(uint8_t new_dir) {
 g_curr_snake_dir = new_dir;
}



void toggle_game_clock_delay() {
 g_game_clock_delay_tim3 = ~g_game_clock_delay_tim3;
}



void update_game_time () {
 g_time_count++;

}

void set_secret_mode() {
 g_GAME_MODE = DEV_MODE;
}

void update_session_time() {
 g_session_count++;
}



uint8_t get_game_phase() {
 return g_GAME_PHASE;
}


int32_t get_initial_cur_pos () {
 return init_cur_pos;
}



void set_food_in_play_flag (uint8_t state) {
 g_food_in_play = state;
}



void set_food_xy(int32_t *x_val, int32_t *y_val) {
 g_fd_x_val = *x_val;
 g_fd_y_val = *y_val;
}



void play_sound1( uint32_t duration) {

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(SFX_FOOD_HIGH);
 }
}



void play_sound2( uint32_t duration) {

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(SFX_FOOD);
 }
}



void play_sound3( uint32_t duration) {

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(SFX_WALL);
 }
}



void play_sfx_wall( uint32_t duration) {

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(5);
 }

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(10);
 }

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(15);
 }
}




void play_sfx_food( uint32_t duration) {

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(5);
 }

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(3);
 }

 for (i=0; i < duration; i++) {
 GPIOE_ODRbits.ODR14 = ~GPIOE_ODRbits.ODR14;
 Delay_ms(1);
 }
}




void game_over() {



 TIM3_CR1 = 0;
 play_sfx_wall(20);
 g_GAME_PHASE = PHASE_QUIT;
 game_cur_screen_run_flag = FALSE;
}









void move_snake() {

 int16_t temp_x = m_node_head->node_x;
 int16_t temp_y = m_node_head->node_y;

 if (g_curr_snake_dir == MOVE_RIGHT) {

 if (m_node_head+1 > m_node_end) {
 m_node_start->node_x = ++temp_x;
 m_node_start->node_y = temp_y;

 m_node_head = m_node_start;
 } else {

 (m_node_head+1)->node_x = ++temp_x;
 (m_node_head+1)->node_y = temp_y;
 incr_snake_head();
 }





 if (m_node_head->node_x > MAX_COL_WIDTH-1 ) {

 if (g_GAME_MODE == NORMAL_MODE) {
 game_over();

 } else {
 m_node_head->node_x = 0;
 }
 }
 }
 else if (g_curr_snake_dir == MOVE_LEFT) {

 if (m_node_head+1 > m_node_end) {
 (m_node_start)->node_x = --temp_x;
 (m_node_start)->node_y = temp_y;

 m_node_head = m_node_start;
 } else {

 (m_node_head+1)->node_x = --temp_x;
 (m_node_head+1)->node_y = temp_y;

 incr_snake_head();
 }


 if (m_node_head->node_x < 0) {
 if (g_GAME_MODE == NORMAL_MODE) {
 game_over();

 } else {
 m_node_head->node_x = 19;
 }
 }

 }
 else if (g_curr_snake_dir == MOVE_UP) {

 if (m_node_head+1 > m_node_end) {
 (m_node_start)->node_x = temp_x;
 (m_node_start)->node_y = --temp_y;
 m_node_head = m_node_start;
 } else {

 (m_node_head+1)->node_x = temp_x;
 (m_node_head+1)->node_y = --temp_y;

 incr_snake_head();
 }


 if (m_node_head->node_y < 1 ) {
 if (g_GAME_MODE == NORMAL_MODE) {
 game_over();

 } else {
 m_node_head->node_y = (MAX_ROW_LENGTH-1);
 }
 }
 }
 else if (g_curr_snake_dir == MOVE_DOWN) {
 if (m_node_head+1 > m_node_end) {
 (m_node_start)->node_x = temp_x;
 (m_node_start)->node_y = ++temp_y;
 m_node_head = m_node_start;
 } else {

 (m_node_head+1)->node_x = temp_x;
 (m_node_head+1)->node_y = ++temp_y;


 incr_snake_head();
 }


 if (m_node_head->node_y > MAX_ROW_LENGTH-1 ) {
 if (g_GAME_MODE == NORMAL_MODE) {
 game_over();

 } else {
 m_node_head->node_y = 1;
 }
 }

 }

}



int32_t check_snake_collision(int16_t x_val, int16_t y_val, t_node * start_pos) {
 int32_t ret;
 t_node *temp_itr = start_pos;

 if (start_pos > m_node_end) {
 start_pos == m_node_start;
 }

 do {
 scr_debug(temp_itr->node_x, temp_itr->node_y );


 if (temp_itr->node_x == x_val && temp_itr->node_y == y_val) {

 return TRUE;
 }

 temp_itr = incr_node(temp_itr);
 } while (temp_itr <= m_node_head);

 return FALSE;
}



void generate_food() {

 int32_t fd_x_val;
 int32_t fd_y_val;
 int16_t col_ret = TRUE;


 int32_t temp_time = TIM3_CNT %33;



 do {

 for (i=0; i <= temp_time; i++) {

 g_rand_num = (int32_t) (rand() % MAX_BLOCK_COUNT);
 }



 convert_lin_xy(&g_rand_num, &fd_x_val, &fd_y_val);




 col_ret = check_snake_collision(&fd_x_val, &fd_y_val, m_node_tail);



 if (col_ret == FALSE) {

 draw_cell_pos(&g_rand_num, m_FUCHSIA);
 set_food_in_play_flag(TRUE);


 set_food_xy(&fd_x_val, &fd_y_val);
 }

 } while (col_ret == TRUE);

}




void incr_snake_head() {

 if (m_node_head < m_node_end) {
 m_node_head++;
 } else {

 m_node_head = m_node_start;
 }

}



t_node* incr_node( t_node *_node) {


 if (_node <= m_node_end) {
 _node++;
 } else {

 _node = m_node_start;
 }

 return _node;
}




void incr_snake_tail() {

 if (m_node_tail != m_node_head) {


 m_node_tail->node_x = 0xFF;
 m_node_tail->node_y = 0xFF;


 if (m_node_tail < m_node_end) {
 m_node_tail++;
 } else {

 m_node_tail = m_node_start;
 }
 }

}







void load_snake_game() {


 set_game_phase(PHASE1_READY);





 set_cur_screen_run_flag(TRUE);

 TFT_Fill_Screen(CL_BLACK);

 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
 set_brush_color(m_BLACK);

 TFT_SET_PEN(CL_GRAY, 0);

 TFT_Set_Font(TFT_defaultFont, CL_AQUA, FO_HORIZONTAL );
 TFT_Write_Text("SNAKE!", 8 * PX_BLOCK, 6 * PX_BLOCK);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
 TFT_Write_Text("v.1.0", 18* PX_BLOCK, 0 * PX_BLOCK);
 TFT_Write_Text("By Howard Zhou", 13 * PX_BLOCK, 14 * PX_BLOCK);
 TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 11*PX_BLOCK);

 while (cur_screen_run_flag == TRUE) {};

 TFT_Fill_Screen(CL_BLACK);
}



void update_stats() {
 sprintf(g_str_buffer, "Score: \x20 %04d", g_game_score);
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);


 if (g_GAME_MODE == NORMAL_MODE) {
 sprintf(g_str_buffer, "MODE: \x20 NORM" );
 }
 else {
 sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );
 }
 TFT_Write_Text(&g_str_buffer, 8*PX_BLOCK, 0*PX_BLOCK);
 sprintf(g_str_buffer, "x: %d", game_speed );
 TFT_Write_Text(&g_str_buffer, 6*PX_BLOCK, 0*PX_BLOCK);
}



void update_time() {


 if (g_TIME_TRACK_MODE == SESSION_TIME) {
 g_t_secs = g_session_count % 60;

 if (g_t_secs != 0) {
 g_t_wait = FALSE;
 }
 if (g_t_secs == 0 && g_t_wait == FALSE) {
 g_t_mins++;
 g_t_wait = TRUE;
 }


 sprintf(g_str_buffer, "GTIM: \x20 %02d:%02d", g_t_mins-1, g_t_secs );

 } else {
 g_t_secs = g_time_count % 60;

 if (g_t_secs != 0) {
 g_t_wait = FALSE;
 }
 if (g_t_secs == 0 && g_t_wait == FALSE) {
 g_t_mins++;
 g_t_wait = TRUE;
 }

 sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
 }


 TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);

}



void init_snake_game() {



 g_GAME_PHASE = PHASE2_PLAYING;


 set_cur_screen_run_flag(TRUE);
 game_cur_screen_run_flag=TRUE;




 TFT_Fill_Screen(CL_BLACK);


 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
 set_brush_color(m_GREEN);
 TFT_SET_PEN(CL_GRAY, 0);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );

 Delay_ms(100);
 init_snake_sprite();
}





void init_snake_sprite() {


 reset_game_values();


 m_node_head = m_node_start;
 m_node_tail = m_node_start;
 g_curr_snake_dir = MOVE_RIGHT;


 m_node_head->node_x = 0;
 m_node_head->node_y = 1;
 print_snake(m_node_head, m_GREEN);
 generate_food();


 g_session_count = 0;
}





void start_snake_game() {
 Delay_ms(500);



 while (game_cur_screen_run_flag == TRUE) {

 };
}




void screen_refresh_TIM3() {



 if ( check_snake_collision((m_node_tail)->node_x, (m_node_tail)->node_y, m_node_tail+1) == FALSE ) {
 clean_tail(m_node_tail, m_BLACK);
 }

 draw_cell_xy(g_fd_x_val, g_fd_y_val, m_FUCHSIA);
 Delay_ms(5);
 move_snake();

 if (g_GAME_PHASE != PHASE_QUIT) {

 print_snake(m_node_head, m_GREEN);
 Delay_ms(5);


 if ( check_snake_collision(g_fd_x_val, g_fd_y_val, m_node_head) == FALSE ) {
 incr_snake_tail();
 } else {

 play_sfx_food(20);
 g_game_score++;
 generate_food();
 }
 }
}



void game_over_scr() {


 update_session_time();


 render_rect_mask(0,0,20,1, m_NAVY);
 Delay_ms(50);



 update_time();


 update_stats();




 set_game_phase (PHASE_QUIT);





 set_cur_screen_run_flag(TRUE);





 set_brush_color(m_BLACK);

 TFT_SET_PEN(CL_GRAY, 0);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );

 sprintf(g_str_buffer, "Total Time: \x20 %02d:%02d", g_t_mins-1, g_t_secs );
 TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

 sprintf(g_str_buffer, "Final score: \x20 %04d", g_game_score);
 TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 3*PX_BLOCK);


 while (cur_screen_run_flag == TRUE) {}


}
#line 775 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
void convert_int_ascii(uint8_t *in_array, int32_t entry_row ) {
 int32_t temp_score = g_game_score;
 int32_t temp_val = 0;
 int32_t temp_dvdnd = 0;








 int32_t num_pos_ths = (entry_row * 7) + 3;
 int32_t num_pos_hds = (entry_row * 7) + 4;
 int32_t num_pos_ten = (entry_row * 7) + 5;
 int32_t num_pos_one = (entry_row * 7) + 6;



 if (temp_score >= 1000 & g_game_score <= 9999) {
 temp_dvdnd = (temp_score / 1000);
 temp_val = temp_dvdnd +0x30;
 in_array[num_pos_ths] = temp_val;


 temp_score = temp_score - (1000 * temp_dvdnd);

 } else {
 in_array[num_pos_ths] = 0x30;
 }


 if (temp_score >= 100 ) {
 temp_dvdnd = (temp_score / 100);
 temp_val = temp_dvdnd + 0x30;
 in_array[num_pos_hds] = temp_val;


 temp_score = temp_score - (100 * temp_dvdnd);

 } else {
 in_array[num_pos_hds] = 0x30;
 }


 if (temp_score >= 10) {
 temp_dvdnd = (temp_score / 10);
 temp_val = temp_dvdnd + 0x30;
 in_array[num_pos_ten] = temp_val;


 temp_score = temp_score - (10 * temp_dvdnd);
 } else {
 in_array[num_pos_ten] = 0x30;
 }


 in_array[num_pos_one] = temp_score + 0x30;
}




void refresh_hs_scr(uint8_t cur_dir) {
 int32_t xval = hs_cursor_x;
 int32_t yval = hs_cursor_y;








 TFT_Fill_Screen(CL_BLACK);
 switch(cur_dir) {
 case MOVE_UP:

 if (init_cur > 0x5A) {
 init_cur = init_cursor_start;
 }
 ++init_cur;
 break;

 case MOVE_DOWN:
 if (init_cur < init_cursor_start) {
 init_cur = 0x5A;
 } else {
 --init_cur;
 }
 break;
 case JBTN_DOWN:

 user_score_entry[get_initial_cur_pos()] = init_cur;
 ++init_cur_pos;
 ++hs_cursor_x;

 }


 if (init_cur_pos >= 3) {


 convert_int_ascii(&user_score_entry, 0);


 set_cur_screen_run_flag(FALSE);
 set_game_phase(PHASE_PRINT_TOP_TEN);
 } else {
 draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY);
 sprintf(g_str_buffer, "Enter high score: \x20 ");
 TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);

 if (get_initial_cur_pos() == 0) {
 sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
 } else if (get_initial_cur_pos() == 1) {
 sprintf(g_str_buffer, "%c\x20%c\x20_: \x20 %04d", user_score_entry[0], init_cur, g_game_score);
 } else if (get_initial_cur_pos() == 2) {
 sprintf(g_str_buffer, "%c\x20%c\x20%c: \x20 %04d", user_score_entry[0], user_score_entry[1], init_cur, g_game_score);
 } else {
 sprintf(g_str_buffer, "FINISHED");
 }

 TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);
 Delay_ms(200);
 }



}



void game_high_score_scr() {

 set_game_phase(PHASE_HSCORE);



 set_cur_screen_run_flag(TRUE);


 TFT_Fill_Screen(CL_BLACK);


 draw_ini_cell_xy(hs_cursor_x,hs_cursor_y,m_GRAY);
 Delay_ms(100);
 sprintf(g_str_buffer, "Enter high score: \x20 ");
 TFT_Write_Text(&g_str_buffer, 2*PX_BLOCK, 4*PX_BLOCK);
 sprintf(g_str_buffer, "%c \x20_\x20_: \x20 %04d", init_cur, g_game_score);
 TFT_Write_Text(&g_str_buffer, 10*PX_BLOCK, 4*PX_BLOCK);

 while (cur_screen_run_flag == TRUE) {}



 set_game_phase(PHASE_PRINT_TOP_TEN);

}

void EE_write(uint8_t row, uint8_t *tx_data_in, uint32_t tx_size) {
 uint8_t tx_data_[8];
 uint8_t reg_addr=0;
 row =0;


 switch (row) {
 case 0:
 reg_addr = 0;
 break;
 case 1:
 reg_addr = 7;
 break;
 case 2:
 reg_addr = 14;
 break;
 case 3:
 reg_addr = 21;
 break;
 case 4:
 reg_addr = 28;
 break;
 case 4:
 reg_addr = 35;
 break;
 default:
 break;
 }


 tx_data_[0] = 0;






 tx_data_[1] = tx_data_in[0];
 tx_data_[2] = tx_data_in[1];
 tx_data_[3] = tx_data_in[2];
 tx_data_[4] = tx_data_in[3];
 tx_data_[5] = tx_data_in[4];
 tx_data_[6] = tx_data_in[5];
 tx_data_[7] = tx_data_in[6];









 I2C1_Start();
 Delay_ms(10);


 I2C1_Write(0x50, tx_data_, tx_size+1, END_MODE_STOP);
 Delay_ms(100);

}
#line 1012 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
void EE_read(uint8_t reg_addr, uint8_t *read_buffer, uint32_t rx_size) {



 I2C1_Start();
 I2C1_Write(0x50, reg_addr, 1, END_MODE_RESTART);
 I2C1_Read(0x50, read_buffer, rx_size +4, END_MODE_STOP);


}





int32_t sort_score(uint8_t *in_arr) {
 int32_t cell_pos = 0;
 int32_t row_found = -1;
 uint8_t temp_entry[7];
 uint8_t temp_ee_score[4];
 uint8_t temp_player_score[4];
 int32_t eeprom_score;
 int32_t player_score;








 for (i=0; i < 15; i++ ) {









 temp_ee_score[0] = in_arr[(i*7) + 7];
 temp_ee_score[1] = in_arr[(i*7) + 8];
 temp_ee_score[2] = in_arr[(i*7) + 9];
 temp_ee_score[3] = in_arr[(i*7) + 10];


 temp_player_score[0] = user_score_entry[3];
 temp_player_score[1] = user_score_entry[4];
 temp_player_score[2] = user_score_entry[5];
 temp_player_score[3] = user_score_entry[7];


 eeprom_score = atoi(temp_ee_score);
 player_score = atoi(temp_player_score);




 sprintf(g_str_buffer, "atoi[%d]:\x20  %s \x20 | \x20 %c", i, user_score_entry, temp_ee_score[i]);
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, (i+1)*PX_BLOCK);


 if (player_score > eeprom_score || temp_ee_score[0] > 0x39 ) {
 row_found = i;
 sprintf(g_str_buffer, "found i [%d]", i);
 TFT_Write_Text(&g_str_buffer, 13*PX_BLOCK, (i+1)*PX_BLOCK);
 i = 999;
 } else if (i==15) {
 return -1;
 }

 Delay_ms(100);
 }



 return row_found;
}



void print_top_score_list() {
 uint32_t tx_count = 0;
 uint8_t byte;
 uint8_t hs_buffer[128];
 uint8_t atest[4];
 int32_t test_num;
 int32_t row_to_write;


 uint8_t temp_score[12];
 int32_t int_score;

 set_cur_screen_run_flag(TRUE);



 TFT_Fill_Screen(CL_BLACK);


 I2C1_Init();


 EE_read(0, &hs_buffer, 71);


 row_to_write = sort_score(&hs_buffer);

 if (row_to_write >=0 ) {
 EE_write( (uint8_t) row_to_write, &user_score_entry,7 );
 }


 sprintf(g_str_buffer, "TOP SCORES:");
 TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);


 sprintf(g_str_buffer, "test: %s", user_score_entry);
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 4*PX_BLOCK);

 user_score_entry[3] = 0x30+5;
 atest[0] = user_score_entry[3];
 atest[1] = user_score_entry[4];
 atest[2] = user_score_entry[5];
 atest[3] = user_score_entry[6];

 test_num = atoi(atest);
 sprintf(g_str_buffer, "atoi: %d", test_num);
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 5*PX_BLOCK);

 if (test_num > 999) {
 sprintf(g_str_buffer, "test num is greater");
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 6*PX_BLOCK);
 }

 GPIOB_ODR |= 0xFF00;
 Delay_ms(10);

 Delay_ms(1000);



 EE_read(0, &hs_buffer, 71);

 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 9*PX_BLOCK);








 TFT_Fill_Screen(CL_BLACK);
 sprintf(g_str_buffer, "TOP SCORES:\x20  %s | \x20 %c",hs_buffer, hs_buffer[0]);
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 1*PX_BLOCK);
 for (i=0; i < 5; i++ ) {







 temp_score[0] = hs_buffer[(i*7) + 2];
 temp_score[1] = hs_buffer[(i*7) + 3];
 temp_score[2] = hs_buffer[(i*7) + 4];
 temp_score[3] = hs_buffer[(i*7) + 5];
 temp_score[4] = hs_buffer[(i*7) + 6];
 temp_score[5] = hs_buffer[(i*7) + 7];
 temp_score[6] = hs_buffer[(i*7) + 8];




 sprintf(g_str_buffer, "score[%d]:\x20  %s | \x20 %c%c%c%c%c%c%c", i , temp_score,
 hs_buffer[(i*7) + 2],
 hs_buffer[(i*7) + 3],
 hs_buffer[(i*7) + 4],
 hs_buffer[(i*7) + 5],
 hs_buffer[(i*7) + 6],
 hs_buffer[(i*7) + 7],
 hs_buffer[(i*7) + 8]
 );


 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, (i+2)*PX_BLOCK);


 Delay_ms(100);
 }




 while (cur_screen_run_flag == TRUE) {}



 set_game_phase(PHASE1_READY);

}
#line 62 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
static uint8_t g_cur_game_phase = PHASE_LOGO;
static int32_t g_game_speed = 500;


uint32_t rx_buffer = 0;
uint32_t adc_val;
uint32_t i2c_status1;
uint8_t rx_data1 =0x32;
uint8_t tx_data1 =0x55;
uint8_t dev_position = 0;
#line 86 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
void EXTI15_10() iv IVT_INT_EXTI15_10 {

 EXTI_PR |= 1 << 13;
 GPIOB_ODR = ~GPIOB_ODR;

 while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }

 g_cur_game_phase = get_game_phase();

 switch (g_cur_game_phase)
 {
 case PHASE_LOGO:
 set_cur_screen_run_flag(FALSE);
 g_cur_game_phase = PHASE_INTRO;
 break;

 case PHASE_INTRO:
 set_cur_screen_run_flag(FALSE);
 g_cur_game_phase = PHASE1_READY;
 break;

 case PHASE1_READY:
 set_cur_screen_run_flag(FALSE);
 g_cur_game_phase = PHASE2_PLAYING;
 break;

 case PHASE2_PLAYING:
 Delay_ms(100);



 break;

 case PHASE_QUIT:
 set_cur_screen_run_flag(FALSE);
 g_cur_game_phase = PHASE_HSCORE;
 break;

 case PHASE_HSCORE:

 refresh_hs_scr(JBTN_DOWN);
 break;

 case PHASE_PRINT_TOP_TEN:
 set_cur_screen_run_flag(FALSE);
 g_cur_game_phase = PHASE1_READY;
 break;








 default:
 break;
 }
}



void EXTIPA0() iv IVT_INT_EXTI0 {
 EXTI_PR |= 1 << 2;

 while (GPIOA_IDR.B0 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
 g_cur_game_phase = get_game_phase();

 if (g_cur_game_phase == PHASE2_PLAYING) {
 set_cur_screen_run_flag(FALSE);
 game_cur_screen_run_flag = FALSE;
 g_cur_game_phase = PHASE_QUIT;



 TIM3_CR1 = 0;
 }
 else if (g_cur_game_phase == PHASE_QUIT) {
 set_cur_screen_run_flag(FALSE);
 g_cur_game_phase = PHASE_HSCORE;
 }


}


void EXTIPA6() iv IVT_INT_EXTI9_5 {
 g_cur_game_phase = get_game_phase();


 if (GPIOB_IDR.B5 == 0) {
 while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
 EXTI_PR |= 1 << 5;

 if (g_cur_game_phase == PHASE2_PLAYING) {
 if (g_curr_snake_dir != MOVE_UP) {
 set_curr_snake_dir(MOVE_DOWN);
 }
 } else if (g_cur_game_phase == PHASE_HSCORE) {
 refresh_hs_scr(MOVE_DOWN);
 }
 }


 if (GPIOA_IDR.B6 == 0) {
 while(GPIOA_IDR.B6 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
 g_cur_game_phase = get_game_phase();

 if (g_cur_game_phase == PHASE2_PLAYING) {

 EXTI_PR |= 1 << 6;
 while (GPIOA_IDR.B6 == 0) {
 GPIOB_ODR = ~GPIOB_ODR;
 Delay_ms(1);
 }
 if (g_curr_snake_dir != MOVE_LEFT) {
 set_curr_snake_dir(MOVE_RIGHT);
 }
 }
 }


}




void EXTIPD2() iv IVT_INT_EXTI2 {
 EXTI_PR |= 1 << 2;
 while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
 g_cur_game_phase = get_game_phase();

 if (g_cur_game_phase == PHASE1_READY && dev_position == 1) {
 dev_position++;
 }else if (g_cur_game_phase == PHASE1_READY && dev_position == 2) {
 TFT_Write_Text("DEV MODE ENABLED!", 7*PX_BLOCK, 3*PX_BLOCK);
 set_secret_mode();
 }

 if (g_cur_game_phase == PHASE2_PLAYING) {
 if (g_curr_snake_dir != MOVE_RIGHT) {
 set_curr_snake_dir(MOVE_LEFT);
 }
 }


}




void EXTIPD4() iv IVT_INT_EXTI4 {
 EXTI_PR |= 1 << 4;
 while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
 g_cur_game_phase = get_game_phase();

 if (g_cur_game_phase == PHASE1_READY && dev_position == 0) {
 dev_position++;
 }

 if (g_cur_game_phase == PHASE2_PLAYING) {

 if (g_curr_snake_dir != MOVE_DOWN) {
 set_curr_snake_dir(MOVE_UP);
 }
 } else if (g_cur_game_phase == PHASE_HSCORE) {
 refresh_hs_scr(MOVE_UP);
 }
}


void TIMER2_ISR() iv IVT_INT_TIM2 {
 TIM2_SR &= ~(1<<0);
 g_cur_game_phase = get_game_phase();

 update_game_time();

 if (g_GAME_PHASE == PHASE2_PLAYING) {


 update_session_time();


 render_rect_mask(0,0,20,1, m_NAVY);
 Delay_ms(50);



 update_time();


 update_stats();






 if (adc_val != ADC1_Read(3)) {
 adc_val = ADC1_Read(3);
 adc_val = adc_val/ 215;


 update_game_speed(adc_val);

 if (adc_val <= 0 ) {
 TIM3_ARR = 500;
 } else {
 TIM3_ARR = (adc_val * 500);
 }
 TIM3_CNT = 0;
 }




 }
}


void TIMER3_ISR() iv IVT_INT_TIM3 {
 g_cur_game_phase = get_game_phase();
 TIM3_SR &= ~(1<<0);

 toggle_game_clock_delay();






 screen_refresh_TIM3();
}









void init_cfg_M_CTL() {


 USART1_CR1 &= ~(1 << 13);

 AFIO_MAPR = 0x00000000;
 RCC_APB2ENR |= 0x00000001;

 RCC_APB2ENR |= 1 << 2;
 RCC_APB2ENR |= 1 << 3;
 RCC_APB2ENR |= 1 << 4;
 RCC_APB2ENR |= 1 << 5;
 RCC_APB2ENR |= 1 << 6;
 RCC_APB2ENR |= 1 << 14;
 RCC_APB2ENR |= 1 << 9;

 RCC_APB1ENR |= (uint32_t) 1 << 21;


 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_14);
 GPIOE_CRH &= (long int) ~(0xF << 24);
 GPIOE_CRH &= (uint32_t) ~(0xC << 24) ;

 GPIOA_CRL &= ~(0xF << 12);


 GPIOA_CRL |= 4 << 0;
 GPIOC_CRL |= 4 << 4;

 GPIOA_CRL |= 4 << 4;
 GPIOA_CRL |= 4 << 6;
 GPIOB_CRL |= 4 << 5;
 GPIOD_CRL |= 4 << 2;
 GPIOD_CRL |= 4 << 4;
 GPIOC_CRH |= 4 << 5;
#line 396 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
}


void config_USART1() {
 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4);
 GPIOA_CRH |= (0x04 << 8);


 USART1_BRR = 0x00000506;



 USART1_CR1 &= ~(1 << 13);

 USART1_CR1 &= ~(1 << 12);
 USART1_CR1 &= ~(3 << 9);
 USART1_CR2 &= ~(3 << 12);
 USART1_CR3 &= ~(3 << 8);

 USART1_CR1 |= 1 << 3;
 USART1_CR1 |= 1 << 2;

 Delay_ms(100);
 USART1_CR1 |= 1 << 13;


}





void init_timer2() {
 RCC_APB1ENR |= 1 << 0;
 TIM2_CR1 = 0x0000;
 TIM2_PSC = 7999;

 TIM2_ARR = 9000;
 TIM2_DIER |= 1 << 0;

}



void init_timer3() {
 RCC_APB1ENR |= (1 << 1);
 TIM3_CR1 = 0x0000;
 TIM3_PSC = 7999;

 TIM3_ARR = g_game_speed;
 TIM3_DIER |= 1 << 0;


}



void init_interrupt() {


 AFIO_EXTICR2 = 0x0000;
 NVIC_ISER0 = 0x00000000;



 AFIO_EXTICR1 &= ~(0xF << 0);
 AFIO_EXTICR1 |= 3 << 8;
 AFIO_EXTICR2 |= 3 << 0;
 AFIO_EXTICR2 |= 1 << 4;
 AFIO_EXTICR2 &= ~(0xF << 8);
 AFIO_EXTICR4 |= 2 << 4;



 EXTI_FTSR |= 1 << 2;
 EXTI_FTSR |= 1 << 4;
 EXTI_FTSR |= 1 << 5;
 EXTI_FTSR |= 1 << 6;
 EXTI_FTSR |= 1 << 13;
 EXTI_RTSR |= 1 << 0;
 EXTI_IMR |= 0x00002075;




 NVIC_ISER0 |= (uint32_t) 1 << 6;
 NVIC_ISER0 |= (uint32_t) 1 << 8;
 NVIC_ISER0 |= (uint32_t) 1 << 10;
 NVIC_ISER0 |= (uint32_t) 1 << 23;
 NVIC_ISER0 |= (uint32_t) 1 << 28;
 NVIC_ISER0 |= (uint32_t) 1 << 29;
 NVIC_ISER1 |= (uint32_t) 1 << 8;
 NVIC_ISER1 |= (uint32_t) 1 << 5;










}




void main() {



 int num =0;


 init_cfg_M_CTL();


 config_USART1();




 init_timer2();
 init_timer3();



 init_interrupt();
#line 541 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
 Start_TP();
#line 554 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
 load_duck_screen();


 load_intro_screen();
#line 571 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
 while (1) {

 dev_position = 0;
 load_snake_game();



 init_snake_game();
 render_rect_mask(0,0,20,1, m_NAVY);
 Delay_ms(50);


 update_time();


 update_stats();

 TIM2_CR1 = 0x0001;
 TIM3_CR1 = 0x0001;
 start_snake_game();
 g_GAME_PHASE = PHASE_QUIT;
 set_game_phase (PHASE_QUIT);

 game_over_scr();
 game_high_score_scr();
 print_top_score_list();

 }
}
