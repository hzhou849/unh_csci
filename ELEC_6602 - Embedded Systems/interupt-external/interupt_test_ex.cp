#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/interupt-external/interupt_test_ex.c"
#line 13 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/interupt-external/interupt_test_ex.c"
void EXTIPB6() iv IVT_INT_EXTI9_5 ics ICS_AUTO {
EXTI_PR.B6 = 1;
GPIOD_ODR = ~ GPIOD_ODR;
}

void EXTIPA0 () iv IVT_INT_EXTI0 {
EXTI_PR.B0 = 1;
GPIOE_ODR = ~ GPIOE_ODR;
}



int counter;
void PinConfiguration();
void ExternalIntConfiguration();



void main () {
 PinConfiguration();
 ExternalIntConfiguration();

 GPIOD_ODR=0XFF00;
 GPIOE_ODR=0XF000;



 for(;;){

 }
}


void PinConfiguration() {
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Output(&GPIOE_BASE, _GPIO_PINMASK_ALL);
 GPIO_Digital_Input(&GPIOA_BASE, _GPIO_PINMASK_0);
 GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_6);
}

void ExternalIntConfiguration(){
 RCC_APB2ENR.AFIOEN = 1;
 AFIO_EXTICR1 = 0x00000000;
 AFIO_EXTICR2 |= 0x00000100;
 EXTI_RTSR |= 0x00000041;
 EXTI_IMR |= 0x00000041;
 NVIC_ISER0 |= 1<<6;

 NVIC_ISER0 |= (long int)1<<23;
}
