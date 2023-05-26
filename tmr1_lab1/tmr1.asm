
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;tmr1.c,3 :: 		void interrupt() {
;tmr1.c,4 :: 		if(PIR1.TMR1IF == 1) {
	BTFSS      PIR1+0, 0
	GOTO       L_interrupt0
;tmr1.c,5 :: 		PIR1.TMR1IF = 0;
	BCF        PIR1+0, 0
;tmr1.c,6 :: 		TMR1L = 0xD4;
	MOVLW      212
	MOVWF      TMR1L+0
;tmr1.c,7 :: 		TMR1H = 0xFE;
	MOVLW      254
	MOVWF      TMR1H+0
;tmr1.c,9 :: 		if(i == 1){
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt5
	MOVLW      1
	XORWF      _i+0, 0
L__interrupt5:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;tmr1.c,10 :: 		PORTB.F0 = 1;
	BSF        PORTB+0, 0
;tmr1.c,11 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;tmr1.c,12 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;tmr1.c,14 :: 		PORTB.F0 = 0;
	BCF        PORTB+0, 0
;tmr1.c,15 :: 		i = 1;
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
;tmr1.c,16 :: 		}
L_interrupt2:
;tmr1.c,17 :: 		}
L_interrupt0:
;tmr1.c,18 :: 		}
L_end_interrupt:
L__interrupt4:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;tmr1.c,20 :: 		void main() {
;tmr1.c,21 :: 		TRISB = 0;
	CLRF       TRISB+0
;tmr1.c,22 :: 		PORTB = 0;
	CLRF       PORTB+0
;tmr1.c,24 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;tmr1.c,25 :: 		INTCON.PEIE = 1;
	BSF        INTCON+0, 6
;tmr1.c,26 :: 		T1CON.TMR1ON = 1;
	BSF        T1CON+0, 0
;tmr1.c,27 :: 		T1CON.TMR1CS = 0;
	BCF        T1CON+0, 1
;tmr1.c,28 :: 		T1CON.T1OSCEN = 0;
	BCF        T1CON+0, 3
;tmr1.c,29 :: 		T1CON.T1CKPS1 = 0;
	BCF        T1CON+0, 5
;tmr1.c,30 :: 		T1CON.T1CKPS0 = 1;
	BSF        T1CON+0, 4
;tmr1.c,31 :: 		PIE1.TMR1IE = 1;
	BSF        PIE1+0, 0
;tmr1.c,32 :: 		PIR1.TMR1IF = 0;
	BCF        PIR1+0, 0
;tmr1.c,33 :: 		TMR1L = 0xD4;
	MOVLW      212
	MOVWF      TMR1L+0
;tmr1.c,34 :: 		TMR1H = 0xFE;
	MOVLW      254
	MOVWF      TMR1H+0
;tmr1.c,35 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
