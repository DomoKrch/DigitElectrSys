#line 1 "C:/Users/Owner/Desktop/Uni/fall_2022/digital_electr_design/practice/tmr1_lab1/tmr1.c"
unsigned int i = 0;

void interrupt() {
 if(PIR1.TMR1IF == 1) {
 PIR1.TMR1IF = 0;
 TMR1L = 0xD4;
 TMR1H = 0xFE;

 if(i == 1){
 PORTB.F0 = 1;
 i = 0;
 }
 else {
 PORTB.F0 = 0;
 i = 1;
 }
 }
}

void main() {
 TRISB = 0;
 PORTB = 0;

 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 T1CON.TMR1ON = 1;
 T1CON.TMR1CS = 0;
 T1CON.T1OSCEN = 0;
 T1CON.T1CKPS1 = 0;
 T1CON.T1CKPS0 = 1;
 PIE1.TMR1IE = 1;
 PIR1.TMR1IF = 0;
 TMR1L = 0xD4;
 TMR1H = 0xFE;
}
