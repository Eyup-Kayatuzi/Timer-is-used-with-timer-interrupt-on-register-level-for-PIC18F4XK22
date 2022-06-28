unsigned int aa = 0;

void interrupt(){

     aa++;
     UART2_Write_Text("hi");
     if (aa == 4000){
        LATB.B0 = ~LATB.B0;
        aa = 0;
     }
     TMR0L = 6;
     TMR0IF_bit = 0;


}
void main() {
     OSCCON = 0x62;
     ANSELB = 0;
     TRISB = 0;
     LATB = 0X00;
     UART2_Init(115200);

     T0CON = 0Xc0;
     INTCON = 0Xc0; // interrupt is enabled
     INTCON.TMR0IE = 1;
     INTCON.TMR0IF = 0;
     TMR0L = 6;
      while(1){

      }


}