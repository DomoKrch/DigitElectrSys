unsigned short arr[11] = {127, 196, 243, 254, 224, 163, 91, 31, 1, 11, 58};
unsigned int i = 0;

void interrupt() {
     if(INTCON.TMR0IF == 1) {
                      INTCON.TMR0IF = 0;
                      TMR0 = 22;
                      
                      if (i == 11) {
                         i = 0;
                      }
                      
                      PWM1_Set_Duty(arr[i]);
                      i++;
     }
}

void main() {
     TRISC = 0;
     PORTC = 0;
   
     INTCON.GIE = 1;
     INTCON.PEIE = 1;
     INTCON.TMR0IE = 1;
     INTCON.TMR0IF = 0;
     OPTION_REG.T0CS = 0;
     OPTION_REG.PSA = 0;
     OPTION_REG.PS2 = 1;
     OPTION_REG.PS1 = 1;
     OPTION_REG.PS0 = 0;
     TMR0 = 22;

     PWM1_Init(5000);
     PWM1_Start();
     
}