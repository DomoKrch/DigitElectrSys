
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;tmr0.c,3 :: 		void interrupt() {
;tmr0.c,4 :: 		if(INTCON.TMR0IF == 1) {
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;tmr0.c,5 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;tmr0.c,6 :: 		TMR0 = 156;
	MOVLW      156
	MOVWF      TMR0+0
;tmr0.c,8 :: 		if(i == 1){
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt5
	MOVLW      1
	XORWF      _i+0, 0
L__interrupt5:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;tmr0.c,9 :: 		PORTB.F0 = 1;
	BSF        PORTB+0, 0
;tmr0.c,10 :: 		i = 0;
	CLRF       _i+0
	CLRF       _i+1
;tmr0.c,11 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;tmr0.c,13 :: 		PORTB.F0 = 0;
	BCF        PORTB+0, 0
;tmr0.c,14 :: 		i = 1;
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
;tmr0.c,15 :: 		}
L_interrupt2:
;tmr0.c,16 :: 		}
L_interrupt0:
;tmr0.c,17 :: 		}
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

;tmr0.c,20 :: 		void main() {
;tmr0.c,21 :: 		TRISB = 0;
	CLRF       TRISB+0
;tmr0.c,22 :: 		PORTB = 0;
	CLRF       PORTB+0
;tmr0.c,24 :: 		INTCON.GIE = 1;
	BSF        INTCON+0, 7
;tmr0.c,25 :: 		INTCON.PEIE = 1;
	BSF        INTCON+0, 6
;tmr0.c,26 :: 		INTCON.TMR0IE = 1;
	BSF        INTCON+0, 5
;tmr0.c,27 :: 		INTCON.TMR0IF = 0;
	BCF        INTCON+0, 2
;tmr0.c,28 :: 		OPTION_REG.T0CS = 0;
	BCF        OPTION_REG+0, 5
;tmr0.c,29 :: 		OPTION_REG.PSA = 0;
	BCF        OPTION_REG+0, 3
;tmr0.c,30 :: 		OPTION_REG.PS2 = 0;
	BCF        OPTION_REG+0, 2
;tmr0.c,31 :: 		OPTION_REG.PS1 = 0;
	BCF        OPTION_REG+0, 1
;tmr0.c,32 :: 		OPTION_REG.PS0 = 1;
	BSF        OPTION_REG+0, 0
;tmr0.c,33 :: 		TMR0 = 156;
	MOVLW      156
	MOVWF      TMR0+0
;tmr0.c,35 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
