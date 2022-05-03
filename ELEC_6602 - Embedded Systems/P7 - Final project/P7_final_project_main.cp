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




static const uint8_t PHASE_INTRO = 0;
static const uint8_t PHASE_GAME1 = 1;
static const uint8_t PHASE_GAME2 = 2;
static const uint8_t TRUE = 1;
static const uint8_t FALSE = 0;

static const uint32_t GPIO_INPUT_MASK = 0x44444444;


static const uint32_t SCREEN_X_MAX = 320;
static const uint32_t SCREEN_Y_MAX = 240;


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
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL );
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
#line 12 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
static const uint8_t PX_BLOCK = 16;
static const uint32_t X_MAX_WIDTH = 20;
static const uint32_t Y_MAX_LENGTH = 15;
static const uint8_t MAX_BLOCK_COUNT = 300;
static const uint8_t EOF_ARRAY = 0xFF;



uint8_t g_DS_BUFFER[300];






typedef struct cell_t {
 uint32_t x;
 uint32_t y;
} cell_t;






void load_game_screen();


void init_arr(uint8_t *in_arr, uint32_t a_size);
void dump_arr_memory(uint8_t *in_arr, uint32_t a_size);
void draw_snake();
void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos);
void draw_cell_pos( uint32_t linear_pos);

void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var );
void draw_cell_xy(uint32_t x_var, uint32_t y_var);

void duck_sprite();
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
#line 101 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
void load_game_screen() {
 uint32_t x_axis = 0;
 uint32_t y_axis = 0;
 uint32_t PX_BLOCK = 16;
 uint32_t i=0;

 uint32_t value = 0;

 cell_t cell;

 init_arr(&g_DS_BUFFER, MAX_BLOCK_COUNT);



 set_cur_screen_run_flag(TRUE);



 TFT_Fill_Screen(CL_NAVY);

 TFT_SET_PEN(CL_BLACK, 0);
 TFT_SET_Brush(1, CL_AQUA, 0, 0 , 0 ,0);
#line 136 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
 draw_cell_xy(0, 4);
 draw_cell_xy(0, 5);
 draw_cell_xy(0, 6);

 dump_ds_buffer();










 while (cur_screen_run_flag == TRUE) {};


}
void draw_snake() {

 g_DS_BUFFER[0] = 1;
 g_DS_BUFFER[1] = 1;
 g_DS_BUFFER[2] = 0;
 g_DS_BUFFER[3] = 1;
 g_DS_BUFFER[4] = 1;
 g_DS_BUFFER[5] = EOF_ARRAY;

 draw_block(&g_DS_BUFFER,1,1);


}

void get_xy(uint32_t *cell_pos, uint32_t *x_var, uint32_t *y_var ) {

 uint32_t row = 0;
 uint32_t col = 0;
 uint32_t temp_val = *cell_pos;



 while (temp_val >= (X_MAX_WIDTH) ) {
 temp_val -= X_MAX_WIDTH-1;
 ++row;

 if (temp_val > 0 ) {
 --temp_val;
 }

 }





 col = temp_val;





 *x_var = col;
 *y_var = row;

}
#line 230 "c:/git_repo/unh_csci/elec_6602 - embedded systems/p7 - final project/cp_game_ctl.h"
void draw_cell_pos( uint32_t linear_pos) {


 cell_t cell;
 uint32_t x_var;
 uint32_t y_var;
 uint32_t cell_pos = linear_pos;

 get_xy(&cell_pos, &x_var, &y_var );


 debug(x_var);
 debug(y_var);

 TFT_Rectangle(
 PX_BLOCK * x_var,
 (y_var * PX_BLOCK),
 PX_BLOCK + (PX_BLOCK * x_var),
 PX_BLOCK + (PX_BLOCK * y_var)
 );

}

void draw_cell_xy(uint32_t x_var, uint32_t y_var) {
 uint32_t linear_val = 0;










 linear_val = ( (y_var * X_MAX_WIDTH) + x_var );

 g_DS_BUFFER[linear_val] = 1;

}


void dump_ds_buffer() {

 uint32_t i=0;

 for (i=0; i < MAX_BLOCK_COUNT; i++) {
 if (g_DS_BUFFER[i] == 1) {
 draw_cell_pos(i);
 }

 }
}

void draw_block(uint8_t *dp_buffer, uint32_t x_pos, uint8_t y_pos) {

 uint32_t i = 0;
 uint32_t col_count = 0;
 uint32_t row_count = 0;
 cell_t cell;






 for (i=0; i < MAX_BLOCK_COUNT; i++) {

 if (dp_buffer[i] == 0xFF) {
 break;
 }



 else if (dp_buffer[i] == 1) {


 TFT_Rectangle(PX_BLOCK*i, row_count, (PX_BLOCK + (PX_BLOCK*i)),(PX_BLOCK+(PX_BLOCK*row_count)) );
 }


 col_count++;
 if (col_count > X_MAX_WIDTH-1) {
 row_count++;
 }
 }



}








void duck_sprite() {
 TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
 draw_cell_xy(8,4);
 draw_cell_xy(9,4);
 draw_cell_xy(10,4);

 draw_cell_xy(7,5);
 draw_cell_xy(8,5);
 draw_cell_xy(9,5);

 TFT_SET_Brush(1, CL_BLACK, 0, 0 , 0 ,0);
 draw_cell_xy(10,5);


 TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
 draw_cell_xy(11,5);
 draw_cell_xy(2,6);
 draw_cell_xy(3,6);
 draw_cell_xy(7,6);
 draw_cell_xy(8,6);
 draw_cell_xy(9,6);
 draw_cell_xy(10,6);

 TFT_SET_Brush(1, CL_RED, 0, 0 , 0 ,0);
 draw_cell_xy(11,6);
 draw_cell_xy(12,6);
 draw_cell_xy(13,6);


 draw_cell_xy(11,7);
 draw_cell_xy(12,7);

 TFT_SET_Brush(1, CL_YELLOW, 0, 0 , 0 ,0);
 draw_cell_xy(1,7);
 draw_cell_xy(2,7);
 draw_cell_xy(3,7);
 draw_cell_xy(4,7);
 draw_cell_xy(8,7);
 draw_cell_xy(9,7);
 draw_cell_xy(10,7);
 draw_cell_xy(0,8);
 draw_cell_xy(1,8);
 draw_cell_xy(2,8);
 draw_cell_xy(3,8);
 draw_cell_xy(4,8);
 draw_cell_xy(5,8);
 draw_cell_xy(6,8);
 draw_cell_xy(7,8);
 draw_cell_xy(8,8);
 draw_cell_xy(9,8);
 draw_cell_xy(10,8);
 draw_cell_xy(1,9);
 draw_cell_xy(2,9);
 draw_cell_xy(3,9);
 draw_cell_xy(4,9);
 draw_cell_xy(5,9);
 draw_cell_xy(6,9);
 draw_cell_xy(7,9);
 draw_cell_xy(8,9);
 draw_cell_xy(9,9);
 draw_cell_xy(10,9);
 draw_cell_xy(2,10);
 draw_cell_xy(3,10);
 draw_cell_xy(4,10);
 draw_cell_xy(5,10);
 draw_cell_xy(6,10);
 draw_cell_xy(7,10);
 draw_cell_xy(8,10);
 draw_cell_xy(9,10);
 draw_cell_xy(10,10);
 draw_cell_xy(3,11);
 draw_cell_xy(4,11);
 draw_cell_xy(5,11);
 draw_cell_xy(6,11);
 draw_cell_xy(7,11);
 draw_cell_xy(8,11);
 draw_cell_xy(9,11);
 draw_cell_xy(4,12);
 draw_cell_xy(5,12);
 draw_cell_xy(6,12);
 draw_cell_xy(7,12);
 draw_cell_xy(8,12);
}
#line 60 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
static volatile uint8_t DEV_MODE = FALSE;
static volatile uint8_t GAME_PHASE = PHASE_INTRO;

uint32_t rx_buffer = 0;
#line 89 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P7 - Final project/P7_final_project_main.c"
void EXTI15_10() iv IVT_INT_EXTI15_10 {


 if (GAME_PHASE == PHASE_INTRO) {
 while (GPIOC_IDR.B13 == 0) {}


 EXTI_PR |= 1 << 13;


 GPIOB_ODR = ~GPIOB_ODR;

 set_cur_screen_run_flag(FALSE);
 GAME_PHASE = PHASE_GAME1;
 }
 else if (GAME_PHASE == PHASE_GAME1) {
 set_cur_screen_run_flag(FALSE);
 GAME_PHASE = PHASE_GAME2;

 }
}


void EXTIPA6() iv IVT_INT_EXTI9_5 {
 EXTI_PR |= 1 << 6;
 while (GPIOA_IDR.B6 == 0) {}

 set_cur_screen_run_flag(FALSE);

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



 EXTI_FTSR |= 1 << 6;
 EXTI_FTSR |= 1 << 13;


 EXTI_IMR |= 0x00002074;




 NVIC_ISER0 |= (uint32_t) 1 << 8;
 NVIC_ISER0 |= (uint32_t) 1 << 10;
 NVIC_ISER0 |= (uint32_t) 1 << 23;
 NVIC_ISER1 |= (uint32_t) 1 << 8;
 NVIC_ISER1 |= (uint32_t) 1 << 5;

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


 load_game_screen();


 TFT_SET_Brush(1, CL_RED, 0, 0, 0 ,0);
 TFT_Rectangle(0, 0, 320, 240);
 TFT_Fill_Screen(CL_RED);

 Delay_ms(3000);

 while (1) {

 }
}
