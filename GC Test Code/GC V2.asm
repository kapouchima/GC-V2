
_Init:

;GC V2.c,63 :: 		void Init()
;GC V2.c,66 :: 		OSCCON=0b01100000;
	MOVLW       96
	MOVWF       OSCCON+0 
;GC V2.c,67 :: 		OSCTUNE.PLLEN=1;
	BSF         OSCTUNE+0, 6 
;GC V2.c,69 :: 		ANCON0=0;
	CLRF        ANCON0+0 
;GC V2.c,70 :: 		ANCON1=0;
	CLRF        ANCON1+0 
;GC V2.c,72 :: 		porta=1;
	MOVLW       1
	MOVWF       PORTA+0 
;GC V2.c,73 :: 		portb=0;
	CLRF        PORTB+0 
;GC V2.c,74 :: 		portc=0;
	CLRF        PORTC+0 
;GC V2.c,75 :: 		portd=0;
	CLRF        PORTD+0 
;GC V2.c,76 :: 		porte=0;
	CLRF        PORTE+0 
;GC V2.c,77 :: 		trisa=0b10111110;
	MOVLW       190
	MOVWF       TRISA+0 
;GC V2.c,78 :: 		trisb=0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;GC V2.c,79 :: 		trisc=0b10100001;
	MOVLW       161
	MOVWF       TRISC+0 
;GC V2.c,80 :: 		trisd=0b10110000;
	MOVLW       176
	MOVWF       TRISD+0 
;GC V2.c,81 :: 		trise=0b1110;
	MOVLW       14
	MOVWF       TRISE+0 
;GC V2.c,84 :: 		T0CON=0b10000001; //prescaler 4
	MOVLW       129
	MOVWF       T0CON+0 
;GC V2.c,85 :: 		TMR0H=0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;GC V2.c,86 :: 		TMR0L=0xBF;
	MOVLW       191
	MOVWF       TMR0L+0 
;GC V2.c,87 :: 		INTCON.b7=1;
	BSF         INTCON+0, 7 
;GC V2.c,88 :: 		INTCON.T0IE=1;
	BSF         INTCON+0, 5 
;GC V2.c,91 :: 		LCD_Init();
	CALL        _Lcd_Init+0, 0
;GC V2.c,92 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_Init0:
	DECFSZ      R13, 1, 0
	BRA         L_Init0
	DECFSZ      R12, 1, 0
	BRA         L_Init0
	DECFSZ      R11, 1, 0
	BRA         L_Init0
;GC V2.c,93 :: 		LCDBL=1;
	BSF         PORTE+0, 0 
;GC V2.c,96 :: 		UART1_Init(9600);
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;GC V2.c,97 :: 		UART2_Init(9600);
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;GC V2.c,100 :: 		SignalingSystem_Init(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Init+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Init+1 
	CALL        _SignalingSystem_Init+0, 0
;GC V2.c,101 :: 		}
	RETURN      0
; end of _Init

_interrupt:

;GC V2.c,115 :: 		void interrupt()
;GC V2.c,117 :: 		if((TMR0IF_bit)&&(TMR0IE_bit))
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt3
	BTFSS       TMR0IE_bit+0, 5 
	GOTO        L_interrupt3
L__interrupt9:
;GC V2.c,119 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;GC V2.c,120 :: 		Counterms500=Counterms500+1;
	INCF        _Counterms500+0, 1 
;GC V2.c,121 :: 		if(Counterms500>=25)
	MOVLW       25
	SUBWF       _Counterms500+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt4
;GC V2.c,122 :: 		{Flag500ms=1;Counterms500=0;}
	MOVLW       1
	MOVWF       _Flag500ms+0 
	CLRF        _Counterms500+0 
L_interrupt4:
;GC V2.c,123 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;GC V2.c,124 :: 		}
L_interrupt3:
;GC V2.c,125 :: 		}
L__interrupt10:
	RETFIE      1
; end of _interrupt

_main:

;GC V2.c,138 :: 		void main() {
;GC V2.c,142 :: 		Init();
	CALL        _Init+0, 0
;GC V2.c,144 :: 		while(1)
L_main5:
;GC V2.c,147 :: 		if(Flag20ms)
	MOVF        _Flag20ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
;GC V2.c,149 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;GC V2.c,150 :: 		}
L_main7:
;GC V2.c,152 :: 		if(Flag500ms)
	MOVF        _Flag500ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;GC V2.c,154 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;GC V2.c,155 :: 		SignalingSystem_SystemEPOCH(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_SystemEPOCH+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_SystemEPOCH+1 
	CALL        _SignalingSystem_SystemEPOCH+0, 0
;GC V2.c,156 :: 		SignalingSystem_Task(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Task+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Task+1 
	CALL        _SignalingSystem_Task+0, 0
;GC V2.c,157 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;GC V2.c,158 :: 		}
L_main8:
;GC V2.c,162 :: 		LED=IRin;
	BTFSC       PORTC+0, 0 
	GOTO        L__main11
	BCF         PORTA+0, 6 
	GOTO        L__main12
L__main11:
	BSF         PORTA+0, 6 
L__main12:
;GC V2.c,175 :: 		}
	GOTO        L_main5
;GC V2.c,177 :: 		}
	GOTO        $+0
; end of _main
