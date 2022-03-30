#line 1 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P4_serial_comm/p4_serial_comm.c"
#line 12 "C:/GIT_REPO/unh_csci/ELEC_6602 - Embedded Systems/P4_serial_comm/p4_serial_comm.c"
unsigned int rcvrd;

void InitializeUSART1();



void main() {
 InitializeUSART1();



 for(;;) {




 while (!((USART1_SR & (1<<5))== 0x20)){}






 rcvrd = USART1_DR;

 while (! (USART1_SR & (1<<7)) == 0x80) {}

 USART1_DR = rcvrd;
 }
}


void InitializeUSART1(){
 RCC_APB2ENR |= 1;
 AFIO_MAPR=0X0F000000;
 RCC_APB2ENR |= 1<<2;
 GPIOA_CRH &= ~(0xFF << 4);
 GPIOA_CRH |= (0x0B << 4);
 GPIOA_CRH |= (0x04 << 8);
 RCC_APB2ENR |= 1<<14;
 USART1_BRR=0X00000506;




 USART1_CR1 &= ~(1<<12);
 USART1_CR2 &= ~(3<<12);
 USART1_CR3 &= ~(3<<8);
 USART1_CR1 &= ~(3<<9);
 USART1_CR1 |= 3<<2;



 USART1_CR1 |= 1<<13;
 Delay_ms(100);

}
