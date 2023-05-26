#line 1 "C:/Users/Owner/Desktop/Uni/fall_2022/digital_electr_design/practice/tmr0_lab1/tmr0.c"
unsigned int i = 0;

void interrupt() {
 if(INTCON.TMR0IF == 1) {
 INTCON.TMR0IF = 0;
 TMR0 = 156;

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
 INTCON.TMR0IE = 1;
 INTCON.TMR0IF = 0;
 OPTION_REG.T0CS = 0;
 OPTION_REG.PSA = 0;
 OPTION_REG.PS2 = 0;
 OPTION_REG.PS1 = 0;
 OPTION_REG.PS0 = 1;
 TMR0 = 156;

}
