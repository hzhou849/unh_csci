#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/interupt_test/interupt_test.c"
#line 13 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/interupt_test/interupt_test.c"
void TIMER3_ISR () iv IVT_INT_TIM3 {
TIM3_SR.UIF = 0;
GPIOD_ODR = ~ GPIOD_ODR;
GPIOE_ODR = ~ GPIOE_ODR;
}



int counter;
void PinConfiguration();
void Timer3IntConfiguration();



void main () {
 PinConfiguration();
 Timer3IntConfiguration();

 GPIOD_ODR=0X0000;
 GPIOE_ODR=0XFFFF;



 for(;;){

 }
}


void PinConfiguration() {
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);
}

void Timer3IntConfiguration(){
 RCC_APB1ENR |= (1 << 1);
 TIM3_CR1 = 0x0000;


 TIM3_PSC = 7999;

 TIM3_ARR = 9000;





 NVIC_ISER0.B29 = 1;






 TIM3_DIER.UIE = 1;
 TIM3_CR1 = 0x0001;
}
