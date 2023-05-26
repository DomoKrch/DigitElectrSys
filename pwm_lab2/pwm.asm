
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;pwm.c,4 :: 		void interrupt() {
;pwm.c,5 :: 		if(INTCON.TMR0IF == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;pwm.c,6 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;pwm.c,7 :: 		TMR0 = 22;
	MOVLW      22
	MOVWF      TMR0+0
;pwm.c,9 :: 		if (i == 11) {
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt4
	MOVLW      11
	XORWF      _i+0, 0
L__interrupt4:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;pwm.c,10 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;pwm.c,11 :: 		}
L_interrupt1:
;pwm.c,13 :: 		PWM1_Set_Duty(arr[i]);
	MOVF       _i+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;pwm.c,14 :: 		i++;
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;pwm.c,15 :: 		}
L_interrupt0:
;pwm.c,16 :: 		}
L_end_interrupt:
L__interrupt3:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;pwm.c,18 :: 		void main() {
;pwm.c,19 :: 		TRISC = 0;
	CLRF       TRISC+0
;pwm.c,20 :: 		PORTC = 0;
	CLRF       PORTC+0
;pwm.c,22 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;pwm.c,23 :: 		INTCON.PEIE = 1;
	BSF        INTCON+0, 6
;pwm.c,24 :: 		INTCON.TMR0IE = 1;
	BSF        INTCON+0, 5
;pwm.c,25 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;pwm.c,26 :: 		OPTION_REG.T0CS = 0;
	BCF        OPTION_REG+0, 5
;pwm.c,27 :: 		OPTION_REG.PSA = 0;
	BCF        OPTION_REG+0, 3
;pwm.c,28 :: 		OPTION_REG.PS2 = 1;
	BSF        OPTION_REG+0, 2
;pwm.c,29 :: 		OPTION_REG.PS1 = 1;
	BSF        OPTION_REG+0, 1
;pwm.c,30 :: 		OPTION_REG.PS0 = 0;
	BCF        OPTION_REG+0, 0
;pwm.c,31 :: 		TMR0 = 22;
	MOVLW      22
	MOVWF      TMR0+0
;pwm.c,33 :: 		PWM1_Init(5000);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      99
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;pwm.c,34 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;pwm.c,36 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
