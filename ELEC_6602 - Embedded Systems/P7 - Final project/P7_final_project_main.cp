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

static const uint32_t GPIO_INPUT_MASK = 0x44444444;



static const uint8_t PHASE_INTRO = 0;
static const uint8_t PHASE1_READY = 1;
static const uint8_t PHASE2_PLAYING = 2;
static const uint8_t PHASE3_PLAYING = 3;



static const uint32_t SCREEN_X_MAX = 320;
static const uint32_t SCREEN_Y_MAX = 240;



static const uint8_t m_BLACK = 0;
static const uint8_t m_YELLOW = 1;
static const uint8_t m_RED = 2;
static const uint8_t m_NAVY = 3;
static const uint8_t m_GRAY = 3;
static const uint8_t m_GREEN = 4;
static const uint8_t m_WHITE = 5;
#line 53 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"
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
#line 18 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_intro_screen_ctl.h"
static const uint32_t SCROLL_SPEED = 3;
static const uint32_t X_SCROLL_SPEED = 1;

static volatile uint8_t cur_screen_run_flag = TRUE;
 const uint8_t pub_msg[] = "PUDDLE ProDUCKtions presents:";
 const uint8_t dev_msg[] = "A Run Hop Games, game.";
 const uint8_t intro_msg[] = "Press Joystick/PC13 to contiue.";






void load_intro_screen_simple();



void draw_intro_screen(uint32_t x_axis, uint32_t y_axis);
void draw_rectangle(uint32_t x_axis, uint32_t y_axis);
void set_cur_screen_run_flag(uint8_t run_flag);
void draw_info_text(uint32_t x_axis, uint32_t y_axi);









void set_cur_screen_run_flag(uint8_t run_flag) {
 cur_screen_run_flag = run_flag;
}




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
 TFT_Rectangle(x_axis, y_axis, x_axis+255, y_axis+15);


}



void draw_intro_screen(uint32_t x_axis, uint32_t y_axis) {




 TFT_Set_Font(TFT_defaultFont, CL_YELLOW, FO_HORIZONTAL );


 TFT_Write_Text(&pub_msg, x_axis, y_axis);



 Delay_ms(10);

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
#line 1 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"
#line 11 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_pix_render.h"
static const uint32_t Y_MAX_LENGTH = 15;
static const uint32_t MAX_COL_WIDTH = 20;
static const uint32_t MAX_BLOCK_COUNT = 300;

static const uint8_t PX_BLOCK = 16;


static const uint8_t SHIFT_UP = 0xC1;
static const uint8_t SHIFT_DOWN = 0xC2;
static const uint8_t SHIFT_LEFT = 0xC3;
static const uint8_t SHIFT_RIGHT = 0xC4;




static volatile uint8_t CUR_BRUSH_COLOUR = m_BLACK;
uint8_t g_DS_BUFFER[300];

static uint32_t offset_x = 0;
static uint32_t offset_y = 0;


void set_sprite_offset(uint32_t ofs_x, uint32_t ofs_y);
uint32_t get_offset_x();

void draw_cell_pos( uint32_t linear_pos, uint32_t clr_code);
void get_xy( uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var );
void load_cell_xy(uint32_t x_var, uint32_t y_var, uint32_t clr_code);
void render_rect_mask(uint32_t ul_x, uint32_t ul_y, uint32_t lr_x, uint32_t lr_y, uint8_t color_8bit);
uint32_t color_convert_32(uint8_t color_8bit);
#line 53 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_pix_render.h"
void set_sprite_offset(uint32_t ofs_x, uint32_t ofs_y) {
 offset_x = ofs_x;
 offset_y = ofs_y;
}

uint32_t get_offset_x() {
 return offset_x;
}
uint32_t get_offset_y() {
 return offset_y;
}


void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var ) {

 uint32_t row = 0;
 uint32_t col = 0;
 uint32_t temp_val = *cell_pos;



 while (temp_val >= (MAX_COL_WIDTH) ) {
 temp_val -= MAX_COL_WIDTH-1;
 ++row;

 if (temp_val > 0 ) {
 --temp_val;
 }

 }





 col = temp_val;





 *x_var = col;
 *y_var = row;

}



uint32_t color_convert_32(uint8_t color_8bit) {

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
 } else {
 return CL_WHITE;
 }
}

void set_brush_color(uint8_t color_8bit) {
 uint32_t px_clr;
 px_clr = color_convert_32(color_8bit);

 TFT_SET_Brush(1, px_clr, 0, 0 , 0 ,0);
 CUR_BRUSH_COLOUR = color_8bit;
}


void draw_cell_pos( uint32_t linear_pos, uint8_t color_8bit) {
 uint32_t x_var;
 uint32_t y_var;
 uint32_t cell_pos = linear_pos;


 if (color_8bit != CUR_BRUSH_COLOUR) {
#line 147 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_pix_render.h"
 set_brush_color(color_8bit);
 }


 get_xy(&cell_pos, &x_var, &y_var );




 x_var +=offset_x;
 y_var +=offset_y;


 TFT_Rectangle(
 PX_BLOCK * x_var,
 (y_var * PX_BLOCK),
 PX_BLOCK + (PX_BLOCK * x_var),
 PX_BLOCK + (PX_BLOCK * y_var)
 );



}



void draw_cell_xy(uint32_t x_var, uint32_t y_var) {
 uint32_t linear_val = 0;


 TFT_Rectangle(
 PX_BLOCK * x_var,
 (y_var * PX_BLOCK),
 PX_BLOCK + (PX_BLOCK * x_var),
 PX_BLOCK + (PX_BLOCK * y_var)
 );







}





void render_rect_mask(uint32_t ul_x, uint32_t ul_y, uint32_t lr_x, uint32_t lr_y, uint8_t color_8bit) {


 set_brush_color(color_8bit);

 TFT_Rectangle(
 PX_BLOCK * ul_x,
 PX_BLOCK * ul_y,
 PX_BLOCK * lr_x,
 PX_BLOCK * lr_y
 );
 }




void load_cell_xy(uint32_t x_var, uint32_t y_var, uint8_t clr_code) {
 uint32_t linear_val = 0;
 uint8_t color_8bit = clr_code;










 linear_val = ( (y_var * MAX_COL_WIDTH) + x_var );

 g_DS_BUFFER[linear_val] = color_8bit;

}


void dump_ds_buffer() {
 uint32_t i=0;

 for (i=0; i < MAX_BLOCK_COUNT ; i++) {

 if (g_DS_BUFFER[i] != 0xFF) {
 draw_cell_pos(i, g_DS_BUFFER[i]);
 }

 }
}
#line 14 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
static const uint8_t EOF_ARRAY = 0xFF;
static const uint8_t MOVE_RIGHT = 0x0;
static const uint8_t MOVE_LEFT = 0x0;







static uint8_t GAME_PHASE = PHASE1_READY;
static volatile uint32_t time_count = 0;
static uint8_t snake_direction = MOVE_RIGHT;







void load_game_screen();
uint8_t get_game_mode();
void update_game_time();
void move_snake();




void init_arr(uint8_t *in_arr, uint32_t a_size);
void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);
void draw_cell_pos( uint32_t linear_pos, uint32_t clr_code);

void load_cell_xy(uint32_t x_var, uint32_t y_var, uint32_t clr_code);

void duck_sprite();
void snake_sprite();
void dump_ds_buffer();








void update_game_time () {
 time_count++;
}


uint8_t get_game_mode() {
 return GAME_PHASE;
}


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
#line 105 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
void load_duck_screen() {
 uint32_t x_axis = 0;
 uint32_t y_axis = 0;
 uint32_t PX_BLOCK = 16;
 uint32_t i=0;

 uint32_t value = 0;



 init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);



 set_cur_screen_run_flag(TRUE);



 TFT_Fill_Screen(CL_NAVY);

 TFT_SET_PEN(m_BLACK, 0);
 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);



 duck_sprite();




 for (i=0; i< 20; i++) {

 if (i < 1) {
 render_rect_mask(0, 0+6, 13+i, 9+6, m_NAVY);
 }
 render_rect_mask(0+ (i-1), 0+6, 13+i, 9+6, m_NAVY);


 set_sprite_offset(i, 6);
 dump_ds_buffer();
 }



 while (cur_screen_run_flag == TRUE) {};


 set_sprite_offset(0,0);




}

void load_snake_game() {


 GAME_PHASE = PHASE1_READY;

 init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);



 set_cur_screen_run_flag(TRUE);

 TFT_Fill_Screen(CL_BLACK);

 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
 set_brush_color(m_BLACK);

 TFT_SET_PEN(CL_GRAY, 0);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
 TFT_Write_Text("READY?", 7 * PX_BLOCK, 6 * PX_BLOCK);
 TFT_Write_Text("Press Joytick/PC13 to start", 5*PX_BLOCK, 7*PX_BLOCK);

 while (cur_screen_run_flag == TRUE) {};
}


void start_snake_game() {


 uint8_t str_buffer[128];
 uint32_t num = 2550;
 int rand_num;


 GAME_PHASE = PHASE2_PLAYING;

 init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);



 set_cur_screen_run_flag(TRUE);

 TFT_Fill_Screen(CL_BLACK);

 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
 set_brush_color(m_GREEN);




 TFT_SET_PEN(CL_GRAY, 0);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );








 snake_sprite();

 dump_ds_buffer();


 while (cur_screen_run_flag == TRUE) {

 rand_num = (rand() % 100);

 render_rect_mask(0,0,20,1, m_NAVY);



 sprintf(str_buffer, "Score: %d", rand_num);
 TFT_Write_Text(&str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);
 sprintf(str_buffer, "Time: %d", time_count);
 TFT_Write_Text(&str_buffer, 13*PX_BLOCK, 0*PX_BLOCK);

 move_snake();
 dump_ds_buffer();
 Delay_ms(200);
 };


 set_sprite_offset(0,0);
}
#line 259 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
void move_snake() {

 if (snake_direction == MOVE_RIGHT) {
 set_sprite_offset( (get_offset_x() + 1), (get_offset_y()) );
 }

}
#line 318 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
void snake_sprite() {
 load_cell_xy(0,1, m_GREEN);
}

void duck_sprite() {









 load_cell_xy(8,0, m_YELLOW);
 load_cell_xy(9,0, m_YELLOW);
 load_cell_xy(10,0, m_YELLOW);


 load_cell_xy(2,2,m_YELLOW);
 load_cell_xy(3,2,m_YELLOW);
 load_cell_xy(7,2,m_YELLOW);
 load_cell_xy(8,2,m_YELLOW);




 load_cell_xy(7,1, m_BLACK);
 load_cell_xy(8,1, m_BLACK);
 load_cell_xy(9,1, m_BLACK);
 load_cell_xy(10,1, m_BLACK);
 load_cell_xy(11,1, m_BLACK);
 load_cell_xy(9,2, m_BLACK);
 load_cell_xy(10,2, m_BLACK);




 load_cell_xy(11,2, m_RED);
 load_cell_xy(12,2, m_RED);
 load_cell_xy(13,2, m_RED);
 load_cell_xy(11,3, m_RED);
 load_cell_xy(12,3, m_RED);


 load_cell_xy(1,3, m_YELLOW);
 load_cell_xy(2,3, m_YELLOW);
 load_cell_xy(3,3, m_YELLOW);
 load_cell_xy(4,3, m_YELLOW);
 load_cell_xy(8,3, m_YELLOW);
 load_cell_xy(9,3, m_YELLOW);
 load_cell_xy(10,3, m_YELLOW);
 load_cell_xy(0,4, m_YELLOW);
 load_cell_xy(1,4, m_YELLOW);
 load_cell_xy(2,4, m_YELLOW);
 load_cell_xy(3,4, m_YELLOW);
 load_cell_xy(4,4, m_YELLOW);
 load_cell_xy(5,4, m_YELLOW);
 load_cell_xy(6,4, m_YELLOW);
 load_cell_xy(7,4, m_YELLOW);
 load_cell_xy(8,4, m_YELLOW);
 load_cell_xy(9,4, m_YELLOW);
 load_cell_xy(10,4, m_YELLOW);
 load_cell_xy(1,5, m_YELLOW);
 load_cell_xy(2,5, m_YELLOW);
 load_cell_xy(3,5, m_YELLOW);
 load_cell_xy(4,5, m_YELLOW);
 load_cell_xy(5,5, m_YELLOW);
 load_cell_xy(6,5, m_YELLOW);
 load_cell_xy(7,5, m_YELLOW);
 load_cell_xy(8,5, m_YELLOW);
 load_cell_xy(9,5, m_YELLOW);
 load_cell_xy(10,5, m_YELLOW);
 load_cell_xy(2,6, m_YELLOW);
 load_cell_xy(3,6, m_YELLOW);
 load_cell_xy(4,6, m_YELLOW);
 load_cell_xy(5,6, m_YELLOW);
 load_cell_xy(6,6, m_YELLOW);
 load_cell_xy(7,6, m_YELLOW);
 load_cell_xy(8,6, m_YELLOW);
 load_cell_xy(9,6, m_YELLOW);
 load_cell_xy(10,6, m_YELLOW);
 load_cell_xy(3,7,m_YELLOW);
 load_cell_xy(4,7,m_YELLOW);
 load_cell_xy(5,7,m_YELLOW);
 load_cell_xy(6,7,m_YELLOW);
 load_cell_xy(7,7,m_YELLOW);
 load_cell_xy(8,7,m_YELLOW);
 load_cell_xy(9,7,m_YELLOW);
 load_cell_xy(4,8,m_YELLOW);
 load_cell_xy(5,8,m_YELLOW);
 load_cell_xy(6,8,m_YELLOW);
 load_cell_xy(7,8,m_YELLOW);
 load_cell_xy(8,8,m_YELLOW);
}
#line 59 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
static volatile uint8_t DEV_MODE = FALSE;
static uint8_t CUR_GAME_PHASE = 0xFF;

uint32_t rx_buffer = 0;
#line 88 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
void EXTI15_10() iv IVT_INT_EXTI15_10 {

 EXTI_PR |= 1 << 13;
 GPIOB_ODR = ~GPIOB_ODR;

 while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }

 CUR_GAME_PHASE=get_game_mode();

 switch (CUR_GAME_PHASE)
 {
 case PHASE_INTRO:
 set_cur_screen_run_flag(FALSE);
 CUR_GAME_PHASE = PHASE1_READY;
 break;

 case PHASE1_READY:
 set_cur_screen_run_flag(FALSE);
 CUR_GAME_PHASE = PHASE2_PLAYING;
 break;

 case PHASE2_PLAYING:
 Delay_ms(100);



 break;






 default:
 break;
 }
#line 147 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
}


void EXTIPA6() iv IVT_INT_EXTI9_5 {
 if (GPIOB_IDR.B5 == 0) {
 while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
 EXTI_PR |= 1 << 5;
 }


 if (GPIOA_IDR.B6 == 0) {
 while (GPIOA_IDR.B6 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
 EXTI_PR |= 1 << 6;
 }



}


void EXTIPD2() iv IVT_INT_EXTI2 {
 EXTI_PR |= 1 << 2;
 while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
}


void EXTIPD4() iv IVT_INT_EXTI4 {
 EXTI_PR |= 1 << 4;
 while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}
}


void TIMER2_ISR() iv IVT_INT_TIM2 {
 TIM2_SR &= ~(1<<0);
 update_game_time();
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


 GPIOA_CRL = GPIO_INPUT_MASK;
 GPIOE_CRH = 0xFF00;


 GPIOA_CRL |= 4 << 6;
 GPIOB_CRL |= 4 << 5;
 GPIOD_CRL |= 4 << 2;
 GPIOD_CRL |= 4 << 4;
 GPIOC_CRH |= 4 << 5;
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
 TIM2_CR1 = 0x0001;
}



void init_interrupt() {


 AFIO_EXTICR2 = 0x0000;
 NVIC_ISER0 = 0x00000000;


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


 EXTI_IMR |= 0x00002074;




 NVIC_ISER0 |= (uint32_t) 1 << 8;
 NVIC_ISER0 |= (uint32_t) 1 << 10;
 NVIC_ISER0 |= (uint32_t) 1 << 23;
 NVIC_ISER1 |= (uint32_t) 1 << 8;
 NVIC_ISER1 |= (uint32_t) 1 << 5;
 NVIC_ISER0 |= (uint32_t) 1 << 28;

}


uint32_t rand_num_gen() {
 uint32_t ret = 0;
 ret = TIM2_CNT % 100;
 return ret ;
}



void main() {



 int num =0;


 init_cfg_M_CTL();


 config_USART1();




 init_timer2();



 init_interrupt();



 Start_TP();







 debug( rand_num_gen() );
 debug( rand_num_gen() );
 debug( rand_num_gen() );




 load_snake_game();

 start_snake_game();


 TFT_SET_Brush(1, CL_RED, 0, 0, 0 ,0);
 TFT_Rectangle(0, 0, 320, 240);
 TFT_Fill_Screen(CL_RED);

 Delay_ms(3000);

 while (1) {

 }
}
