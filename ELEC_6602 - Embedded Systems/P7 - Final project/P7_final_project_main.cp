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



volatile uint8_t cur_screen_run_flag = TRUE;


static const uint32_t GPIO_INPUT_MASK = 0x44444444;


static const int32_t Y_MAX_LENGTH = 15;
static const int32_t MAX_COL_WIDTH = 20;
static const int32_t MAX_ROW_LENGTH = 15;
static const int32_t MAX_BLOCK_COUNT = 300;
static const uint8_t PX_BLOCK = 16;




typedef struct {
 int16_t node_x;
 int16_t node_y;
} t_node;


static const uint8_t PHASE_INTRO = 0;
static const uint8_t PHASE1_READY = 1;
static const uint8_t PHASE2_PLAYING = 2;
static const uint8_t PHASE_QUIT = 3;
static const uint8_t PHASE_HSCORE = 3;

static const uint8_t NORMAL_MODE = 0;
static const uint8_t WALL_COL_OFF = 0x1;
static const uint8_t DEV_MODE = 0x3;

static const uint8_t MOVE_RIGHT = 0x0;
static const uint8_t MOVE_LEFT = 0x1;
static const uint8_t MOVE_UP = 0x2;
static const uint8_t MOVE_DOWN = 0x3;
static const uint16_t NEG_NULL = -1;
static const uint32_t SFX_FOOD = 5;
static const uint32_t SFX_FOOD_HIGH = 1;
static const uint32_t SFX_WALL = 10;


static const uint32_t SCREEN_X_MAX = 320;
static const uint32_t SCREEN_Y_MAX = 240;



static const uint8_t m_BLACK = 0;
static const uint8_t m_YELLOW = 1;
static const uint8_t m_RED = 2;
static const uint8_t m_NAVY = 3;
static const uint8_t m_GRAY = 3;
static const uint8_t m_GREEN = 4;
static const uint8_t m_WHITE = 5;
static const uint8_t m_FUCHSIA = 6;
#line 92 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_const_def.h"
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
#line 16 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_pix_render.h"
static const uint8_t SHIFT_UP = 0xC1;
static const uint8_t SHIFT_DOWN = 0xC2;
static const uint8_t SHIFT_LEFT = 0xC3;
static const uint8_t SHIFT_RIGHT = 0xC4;




static volatile uint8_t CUR_BRUSH_COLOUR = m_BLACK;
uint8_t g_DS_BUFFER[300];


static int32_t offset_x = 0;
static int32_t offset_y = 0;


void set_sprite_offset(int32_t ofs_x, int32_t ofs_y);
int32_t get_offset_x();

void draw_cell_pos( int32_t *linear_pos, uint8_t color_8bit);
void convert_lin_xy( int32_t *cell_pos, int32_t *x_var, int32_t *y_var );
void load_cell_xy(int32_t x_var, int32_t y_var, int32_t clr_code);
void render_rect_mask(int32_t ul_x, int32_t ul_y, int32_t lr_x, int32_t lr_y, uint8_t color_8bit);
int32_t color_convert_32(uint8_t color_8bit);
void cleaning_buffer(uint8_t color_8bit);






void dump_ds_buffer();



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


 TFT_Rectangle(
 PX_BLOCK * x_var,
 (y_var * PX_BLOCK),
 PX_BLOCK + (PX_BLOCK * x_var),
 PX_BLOCK + (PX_BLOCK * y_var)
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


void load_snake_xy(int32_t x_var, int32_t y_var, uint8_t clr_code) {
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
#line 14 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
static const uint8_t EOF_ARRAY = 0xFF;
const static int32_t MAX_CELLS = 300;










static volatile uint8_t game_cur_screen_run_flag = TRUE;
static uint8_t g_GAME_PHASE = PHASE1_READY;
static uint8_t g_GAME_MODE = NORMAL_MODE;
static uint8_t g_curr_snake_dir = MOVE_RIGHT;
static volatile uint8_t g_game_clock_delay_tim3 = ON;
static volatile uint32_t g_time_count = 0;
static uint32_t g_game_score = 0;
static int32_t g_debug = 0;
static int32_t g_debug2 = 2;
static int32_t g_rand_num = 999;
static uint8_t g_food_in_play = FALSE;
static int32_t g_fd_x_val = NEG_NULL;
static int32_t g_fd_y_val = NEG_NULL;
int32_t i=0;
int32_t j=0;
uint32_t i2c_status;
uint8_t data_[128];
uint8_t rx_data_[256];


uint8_t g_str_buffer[128];

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




void init_arr(uint8_t *in_arr, uint32_t a_size);
void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);

void duck_sprite();
void init_snake_sprite();

void incr_snake_head();
void incr_snake_tail();
t_node* incr_node(t_node *_node);
void game_over();



void update_snake_info(int32_t head_x, int32_t head_y);
void toggle_game_clock_delay();
void set_food_in_play_flag (uint8_t state);
void set_food_xy(int32_t *x_val, int32_t *y_val);


void scr_debug(int32_t value, int32_t value2) {
 g_debug = value;
 g_debug2 = value2;
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



uint8_t get_game_phase() {
 return g_GAME_PHASE;
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


 TIM2_CR1 = 0;
 TIM3_CR1 = 0;
 play_sfx_wall(20);
 game_cur_screen_run_flag = FALSE;
 g_GAME_PHASE = PHASE_QUIT;
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



void init_arr(uint8_t *in_arr, uint32_t a_size) {
 uint32_t i=0;

 for (i=0; i < a_size; i++) {
 in_arr[i]=0xFF;
 }
}






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





 cleaning_buffer(m_NAVY);


 set_sprite_offset(i, 6);
 dump_ds_buffer();
 }



 while (cur_screen_run_flag == TRUE) {};


 set_sprite_offset(0,0);

}



void load_snake_game() {


 g_GAME_PHASE = PHASE1_READY;

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



void update_stats() {
 sprintf(g_str_buffer, "Score: \x20 %04d", g_game_score);
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 0*PX_BLOCK);


 if (g_GAME_MODE == NORMAL_MODE) {
 sprintf(g_str_buffer, "MODE: \x20 Normal" );
 }
 else {
 sprintf(g_str_buffer, "MODE: \x20 DEV:\x20 %d;\x20 %d",g_debug, g_debug2 );
 }
 TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 0*PX_BLOCK);
}



void update_time() {
 g_t_secs = g_time_count % 60;
 if (g_t_secs != 0) {
 g_t_wait = FALSE;
 }
 if (g_t_secs == 0 && g_t_wait == FALSE) {
 g_t_mins++;
 g_t_wait = TRUE;
 }
 sprintf(g_str_buffer, "Time: \x20 %02d:%02d", g_t_mins, g_t_secs );
 TFT_Write_Text(&g_str_buffer, 15*PX_BLOCK, 0*PX_BLOCK);
}



void init_snake_game() {

 g_GAME_PHASE = PHASE2_PLAYING;

 init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);


 set_cur_screen_run_flag(TRUE);


 TFT_Fill_Screen(CL_BLACK);


 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
 set_brush_color(m_GREEN);

 TFT_SET_PEN(CL_GRAY, 0);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );

 Delay_ms(100);
 init_snake_sprite();
}




void init_snake_sprite() {
 m_node_head->node_x = 0;
 m_node_head->node_y = 1;
 print_snake(m_node_head, m_GREEN);
 generate_food();
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

 g_GAME_PHASE = PHASE_QUIT;

 init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);


 set_cur_screen_run_flag(TRUE);





 set_brush_color(m_BLACK);

 TFT_SET_PEN(CL_GRAY, 0);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );

 sprintf(g_str_buffer, "Total Time: \x20 %02d:%02d", g_t_mins, g_t_secs );
 TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 2*PX_BLOCK);

 sprintf(g_str_buffer, "Final score: \x20 %04d", g_game_score);
 TFT_Write_Text(&g_str_buffer, 7*PX_BLOCK, 3*PX_BLOCK);




 while (cur_screen_run_flag == TRUE) {}


}

void EE_write(uint8_t w_addr, uint8_t w_data) {
 data_[0] = w_addr;
 data_[1] = w_data;
 I2C1_Start();


 I2C1_Write(0x50, data_, 2, END_MODE_STOP);

}

uint8_t EE_read(uint8_t r_addr) {
 data_[0] = r_addr;
 I2C1_Start();
 I2C1_Write(0x50, data_,1, END_MODE_RESTART);
 I2C1_Read(0x50, data_, 1, END_MODE_STOP);

 return data_[0];
}

void game_high_score_scr() {



 set_cur_screen_run_flag(TRUE);


 TFT_Fill_Screen(CL_BLACK);



 I2C1_Init();

 GPIOB_ODR |= 0xFF00;
 Delay_ms(10);

 for (i = 0; i < 0x16; i++) {
 EE_write(i, (0x32 +i) );
 GPIOB_ODR++;
 Delay_ms(5);
 }

 Delay_ms(10);
 GPIOB_ODR |= 0xFF00;
 Delay_ms(10);

 for (i=0; i < 0x16; i++) {
 rx_data_[i] = EE_read(i);
 Delay_ms(10);
 }

 sprintf(g_str_buffer, "testing: \x20 %s", rx_data_);
 TFT_Write_Text(&g_str_buffer, 0*PX_BLOCK, 4*PX_BLOCK);



 while (cur_screen_run_flag == TRUE) {}

}
#line 776 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
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
#line 62 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
static uint8_t g_cur_game_phase = 0xFF;
static int32_t g_game_speed = 1000;

uint32_t rx_buffer = 0;
uint32_t debug_val;
uint32_t i2c_status1;
uint8_t rx_data1 =0x32;
uint8_t tx_data1 =0x55;
#line 95 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
void EXTI15_10() iv IVT_INT_EXTI15_10 {

 EXTI_PR |= 1 << 13;
 GPIOB_ODR = ~GPIOB_ODR;

 while (GPIOC_IDR.B13 == 0) { GPIOB_ODR = ~GPIOB_ODR; }

 g_cur_game_phase = get_game_phase();

 switch (g_cur_game_phase)
 {
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






 default:
 break;
 }
}



void EXTIPA0() iv IVT_INT_EXTI0 {
 EXTI_PR |= 1 << 2;
 while (GPIOA_IDR.B0 == 0) {GPIOB_ODR = ~GPIOB_ODR;}

 if (g_cur_game_phase == PHASE2_PLAYING) {
 set_cur_screen_run_flag(FALSE);
 game_cur_screen_run_flag = FALSE;
 g_cur_game_phase = PHASE_QUIT;


 TIM2_CR1 = 0;
 TIM3_CR1 = 0;
 }
 else if (g_cur_game_phase == PHASE_QUIT) {
 set_cur_screen_run_flag(FALSE);
 g_cur_game_phase = PHASE_HSCORE;
 }


}

void EXTIPA6() iv IVT_INT_EXTI9_5 {
 if (GPIOB_IDR.B5 == 0) {
 while(GPIOB_IDR.B5 == 0) {GPIOC_ODR = ~GPIOC_ODR;}
 EXTI_PR |= 1 << 5;

 if (g_curr_snake_dir != MOVE_UP) {
 set_curr_snake_dir(MOVE_DOWN);
 }
 }


 if (GPIOA_IDR.B6 == 0) {
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



void EXTIPD2() iv IVT_INT_EXTI2 {
 EXTI_PR |= 1 << 2;
 while (GPIOD_IDR.B2 == 0) {GPIOB_ODR = ~GPIOB_ODR;}

 if (g_curr_snake_dir != MOVE_RIGHT) {
 set_curr_snake_dir(MOVE_LEFT);
 }


}



void EXTIPD4() iv IVT_INT_EXTI4 {
 EXTI_PR |= 1 << 4;
 while (GPIOD_IDR.B4 == 0) {GPIOB_ODR = ~GPIOB_ODR;}

 if (g_curr_snake_dir != MOVE_DOWN) {
 set_curr_snake_dir(MOVE_UP);
 }
}


void TIMER2_ISR() iv IVT_INT_TIM2 {
 TIM2_SR &= ~(1<<0);


 update_game_time();




 render_rect_mask(0,0,20,1, m_NAVY);
 Delay_ms(50);


 update_time();


 update_stats();






 debug_val = ADC1_Read(3);



}


void TIMER3_ISR() iv IVT_INT_TIM3 {
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

 GPIOA_CRL |= 4 << 4;
 GPIOA_CRL |= 4 << 6;
 GPIOB_CRL |= 4 << 5;
 GPIOD_CRL |= 4 << 2;
 GPIOD_CRL |= 4 << 4;
 GPIOC_CRH |= 4 << 5;
#line 330 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
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
#line 476 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
 Start_TP();
#line 497 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
 load_snake_game();



 init_snake_game();

 TIM2_CR1 = 0x0001;
 TIM3_CR1 = 0x0001;
 start_snake_game();

 game_over_scr();
 game_high_score_scr();




 TFT_SET_Brush(1, CL_BLACK, 0, 0, 0 ,0);
 TFT_Rectangle(0, 0, 320, 240);
 TFT_Fill_Screen(CL_GRAY);

 Delay_ms(3000);

 while (1) {

 }
}
