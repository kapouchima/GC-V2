
_Init:

;GC V2.c,102 :: 		void Init()
;GC V2.c,105 :: 		OSCCON=0b01100000;
	MOVLW       96
	MOVWF       OSCCON+0 
;GC V2.c,106 :: 		OSCTUNE.PLLEN=1;
	BSF         OSCTUNE+0, 6 
;GC V2.c,108 :: 		ANCON0=0;
	CLRF        ANCON0+0 
;GC V2.c,109 :: 		ANCON1=0;
	CLRF        ANCON1+0 
;GC V2.c,111 :: 		porta=1;
	MOVLW       1
	MOVWF       PORTA+0 
;GC V2.c,112 :: 		portb=0;
	CLRF        PORTB+0 
;GC V2.c,113 :: 		portc=0;
	CLRF        PORTC+0 
;GC V2.c,114 :: 		portd=0;
	CLRF        PORTD+0 
;GC V2.c,115 :: 		porte=0;
	CLRF        PORTE+0 
;GC V2.c,116 :: 		trisa=0b10111111;
	MOVLW       191
	MOVWF       TRISA+0 
;GC V2.c,117 :: 		trisb=0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;GC V2.c,118 :: 		trisc=0b10000001;
	MOVLW       129
	MOVWF       TRISC+0 
;GC V2.c,119 :: 		trisd=0b10110000;
	MOVLW       176
	MOVWF       TRISD+0 
;GC V2.c,120 :: 		trise=0b1110;
	MOVLW       14
	MOVWF       TRISE+0 
;GC V2.c,123 :: 		T0CON=0b10000001; //prescaler 4
	MOVLW       129
	MOVWF       T0CON+0 
;GC V2.c,124 :: 		TMR0H=0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;GC V2.c,125 :: 		TMR0L=0xBF;
	MOVLW       191
	MOVWF       TMR0L+0 
;GC V2.c,126 :: 		INTCON.b7=1;
	BSF         INTCON+0, 7 
;GC V2.c,127 :: 		INTCON.T0IE=1;
	BSF         INTCON+0, 5 
;GC V2.c,130 :: 		LCD_Init();
	CALL        _Lcd_Init+0, 0
;GC V2.c,131 :: 		LCDSystem_Init(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Init+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Init+1 
	CALL        _LCDSystem_Init+0, 0
;GC V2.c,132 :: 		delay_ms(100);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_Init0:
	DECFSZ      R13, 1, 1
	BRA         L_Init0
	DECFSZ      R12, 1, 1
	BRA         L_Init0
	DECFSZ      R11, 1, 1
	BRA         L_Init0
;GC V2.c,133 :: 		LCDBL=1;
	BSF         PORTA+0, 6 
;GC V2.c,136 :: 		UART1_Init(9600);
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;GC V2.c,137 :: 		UART2_Init(9600);
	BSF         BAUDCON2+0, 3, 0
	MOVLW       3
	MOVWF       SPBRGH2+0 
	MOVLW       64
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;GC V2.c,140 :: 		SignalingSystem_Init(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Init+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Init+1 
	CALL        _SignalingSystem_Init+0, 0
;GC V2.c,143 :: 		DoorStatus=DOORSTATUS_Close;
	MOVLW       2
	MOVWF       _DoorStatus+0 
;GC V2.c,144 :: 		}
L_end_Init:
	RETURN      0
; end of _Init

_interrupt:

;GC V2.c,158 :: 		void interrupt()
;GC V2.c,160 :: 		if((TMR0IF_bit)&&(TMR0IE_bit))
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt3
	BTFSS       TMR0IE_bit+0, 5 
	GOTO        L_interrupt3
L__interrupt30:
;GC V2.c,162 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;GC V2.c,163 :: 		Counterms500=Counterms500+1;
	INCF        _Counterms500+0, 1 
;GC V2.c,164 :: 		if(Counterms500>=25)
	MOVLW       25
	SUBWF       _Counterms500+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt4
;GC V2.c,165 :: 		{Flag500ms=1;Counterms500=0;}
	MOVLW       1
	MOVWF       _Flag500ms+0 
	CLRF        _Counterms500+0 
L_interrupt4:
;GC V2.c,166 :: 		TMR0H=0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;GC V2.c,167 :: 		TMR0L=0xBF;
	MOVLW       191
	MOVWF       TMR0L+0 
;GC V2.c,168 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;GC V2.c,169 :: 		}
L_interrupt3:
;GC V2.c,170 :: 		}
L_end_interrupt:
L__interrupt34:
	RETFIE      1
; end of _interrupt

_main:

;GC V2.c,183 :: 		void main() {
;GC V2.c,187 :: 		Init();
	CALL        _Init+0, 0
;GC V2.c,189 :: 		while(1)
L_main5:
;GC V2.c,192 :: 		if(Flag20ms)
	MOVF        _Flag20ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
;GC V2.c,194 :: 		LCDSystem_Task(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Task+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Task+1 
	CALL        _LCDSystem_Task+0, 0
;GC V2.c,195 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;GC V2.c,196 :: 		}
L_main7:
;GC V2.c,198 :: 		if(Flag500ms)
	MOVF        _Flag500ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
;GC V2.c,200 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;GC V2.c,201 :: 		SignalingSystem_SystemEPOCH(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_SystemEPOCH+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_SystemEPOCH+1 
	CALL        _SignalingSystem_SystemEPOCH+0, 0
;GC V2.c,202 :: 		SignalingSystem_Task(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Task+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Task+1 
	CALL        _SignalingSystem_Task+0, 0
;GC V2.c,203 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;GC V2.c,204 :: 		}
L_main8:
;GC V2.c,208 :: 		LED=IRin;
	BTFSC       PORTA+0, 5 
	GOTO        L__main36
	BCF         PORTE+0, 0 
	GOTO        L__main37
L__main36:
	BSF         PORTE+0, 0 
L__main37:
;GC V2.c,210 :: 		if((Dip1)&&(!Relay1))
	BTFSS       PORTA+0, 1 
	GOTO        L_main11
	BTFSC       PORTD+0, 3 
	GOTO        L_main11
L__main31:
;GC V2.c,212 :: 		Relay1=1;
	BSF         PORTD+0, 3 
;GC V2.c,213 :: 		SignalingSystem_AddSignal(&SigSys,4,1);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       4
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,214 :: 		DoorActFlag=1;
	MOVLW       1
	MOVWF       _DoorActFlag+0 
;GC V2.c,215 :: 		}
L_main11:
;GC V2.c,218 :: 		if(SignalingSystem_CheckSignal(&SigSys,1))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       1
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
;GC V2.c,219 :: 		Relay1=0;
	BCF         PORTD+0, 3 
L_main12:
;GC V2.c,221 :: 		DoorSimulator();
	CALL        _DoorSimulator+0, 0
;GC V2.c,255 :: 		}
	GOTO        L_main5
;GC V2.c,257 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_Sim0:

;GC V2.c,272 :: 		void Sim0() // Close
;GC V2.c,275 :: 		if(DoorActFlag)
	MOVF        _DoorActFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim013
;GC V2.c,277 :: 		SignalingSystem_AddSignal(&SigSys,OpenningTime,50); // OpenTime
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _OpenningTime+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       50
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,278 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,279 :: 		memcpy(LCD.Line2,"    Openning    ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr1_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr1_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr1_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr1_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr1_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr1_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr1_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,280 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,281 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,282 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,283 :: 		}
L_Sim013:
;GC V2.c,284 :: 		}
L_end_Sim0:
	RETURN      0
; end of _Sim0

_Sim1:

;GC V2.c,299 :: 		void Sim1() // Openning
;GC V2.c,301 :: 		if(SignalingSystem_CheckSignal(&SigSys,50))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       50
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim114
;GC V2.c,303 :: 		DoorStatus=DOORSTATUS_Open;
	MOVLW       1
	MOVWF       _DoorStatus+0 
;GC V2.c,304 :: 		memcpy(LCD.Line2,"     Opened     ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr2_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr2_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr2_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr2_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr2_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr2_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr2_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,305 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,306 :: 		SimStatus=2;
	MOVLW       2
	MOVWF       _SimStatus+0 
;GC V2.c,307 :: 		SignalingSystem_AddSignal(&SigSys,AutocloseTime-InvalidTime,51);//AutoClose - Invalid
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _InvalidTime+0, 0 
	SUBWF       _AutocloseTime+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CLRF        FARG_SignalingSystem_AddSignal+1 
	MOVLW       0
	SUBWFB      FARG_SignalingSystem_AddSignal+1, 1 
	MOVLW       0
	BTFSC       FARG_SignalingSystem_AddSignal+1, 7 
	MOVLW       255
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       51
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,308 :: 		}
L_Sim114:
;GC V2.c,309 :: 		}
L_end_Sim1:
	RETURN      0
; end of _Sim1

_Sim2:

;GC V2.c,325 :: 		void Sim2() // Open
;GC V2.c,327 :: 		if(SignalingSystem_CheckSignal(&SigSys,51))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       51
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim215
;GC V2.c,329 :: 		DoorStatus=DOORSTATUS_Invalid;
	CLRF        _DoorStatus+0 
;GC V2.c,330 :: 		memcpy(LCD.Line2,"    Invalid     ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr3_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr3_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr3_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr3_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr3_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr3_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr3_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,331 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,332 :: 		SimStatus=3;
	MOVLW       3
	MOVWF       _SimStatus+0 
;GC V2.c,333 :: 		SignalingSystem_AddSignal(&SigSys,InvalidTime*2,52); // invalid time * 2
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _InvalidTime+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	RLCF        FARG_SignalingSystem_AddSignal+0, 1 
	RLCF        FARG_SignalingSystem_AddSignal+1, 1 
	BCF         FARG_SignalingSystem_AddSignal+0, 0 
	MOVLW       0
	BTFSC       FARG_SignalingSystem_AddSignal+1, 7 
	MOVLW       255
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       52
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,334 :: 		SimTime=ms500+InvalidTime;
	MOVF        _InvalidTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       _SimTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       _SimTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       _SimTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       _SimTime+3 
;GC V2.c,335 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,336 :: 		}
L_Sim215:
;GC V2.c,337 :: 		}
L_end_Sim2:
	RETURN      0
; end of _Sim2

_Sim3:

;GC V2.c,360 :: 		void Sim3() // Invalid 1
;GC V2.c,362 :: 		if(SignalingSystem_CheckSignal(&SigSys,52))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       52
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim316
;GC V2.c,364 :: 		DoorStatus=DOORSTATUS_Closing;
	MOVLW       4
	MOVWF       _DoorStatus+0 
;GC V2.c,365 :: 		memcpy(LCD.Line2,"    Closing     ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr4_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr4_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr4_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr4_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr4_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr4_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr4_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,366 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,367 :: 		SimStatus=4;
	MOVLW       4
	MOVWF       _SimStatus+0 
;GC V2.c,368 :: 		SignalingSystem_AddSignal(&SigSys,ClosingTime-(InvalidTime*2),53); // closing time - invalid time * 2
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _InvalidTime+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	RLCF        R0, 1 
	RLCF        R1, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	SUBWF       _ClosingTime+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVF        R1, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVLW       0
	SUBFWB      FARG_SignalingSystem_AddSignal+1, 1 
	MOVLW       0
	BTFSC       FARG_SignalingSystem_AddSignal+1, 7 
	MOVLW       255
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,369 :: 		}
L_Sim316:
;GC V2.c,371 :: 		if(!IRin)
	BTFSC       PORTA+0, 5 
	GOTO        L_Sim317
;GC V2.c,373 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,374 :: 		SignalingSystem_ClearSignal(&SigSys,52);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       52
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,375 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,376 :: 		memcpy(LCD.Line2,"    Openning    ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr5_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr5_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr5_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr5_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr5_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr5_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr5_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,377 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,378 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,379 :: 		SignalingSystem_AddSignal(&SigSys,InvalidTime,50);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _InvalidTime+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       50
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,380 :: 		}
L_Sim317:
;GC V2.c,381 :: 		}
L_end_Sim3:
	RETURN      0
; end of _Sim3

_Sim4:

;GC V2.c,402 :: 		void Sim4() // Closing
;GC V2.c,404 :: 		if(SignalingSystem_CheckSignal(&SigSys,53))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim418
;GC V2.c,406 :: 		DoorStatus=DOORSTATUS_Invalid;
	CLRF        _DoorStatus+0 
;GC V2.c,407 :: 		memcpy(LCD.Line2,"    Invalid     ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr6_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr6_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr6_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr6_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr6_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr6_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr6_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,408 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,409 :: 		SimStatus=5;
	MOVLW       5
	MOVWF       _SimStatus+0 
;GC V2.c,410 :: 		SignalingSystem_AddSignal(&SigSys,(InvalidTime*2),54); // invalid time * 2
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _InvalidTime+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       0
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	RLCF        FARG_SignalingSystem_AddSignal+0, 1 
	RLCF        FARG_SignalingSystem_AddSignal+1, 1 
	BCF         FARG_SignalingSystem_AddSignal+0, 0 
	MOVLW       0
	BTFSC       FARG_SignalingSystem_AddSignal+1, 7 
	MOVLW       255
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,411 :: 		}
L_Sim418:
;GC V2.c,413 :: 		if(!IRin)
	BTFSC       PORTA+0, 5 
	GOTO        L_Sim419
;GC V2.c,415 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,416 :: 		SignalingSystem_ClearSignal(&SigSys,54);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,417 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,418 :: 		memcpy(LCD.Line2,"    Openning    ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr7_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr7_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr7_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr7_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr7_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr7_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr7_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,419 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,420 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,421 :: 		SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _ms500+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVF        _ms500+1, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _ms500+2, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVF        _ms500+3, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVF        _SimTime+0, 0 
	SUBWF       FARG_SignalingSystem_AddSignal+0, 1 
	MOVF        _SimTime+1, 0 
	SUBWFB      FARG_SignalingSystem_AddSignal+1, 1 
	MOVF        _SimTime+2, 0 
	SUBWFB      FARG_SignalingSystem_AddSignal+2, 1 
	MOVF        _SimTime+3, 0 
	SUBWFB      FARG_SignalingSystem_AddSignal+3, 1 
	MOVLW       50
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,422 :: 		}
L_Sim419:
;GC V2.c,424 :: 		if(DoorActFlag)
	MOVF        _DoorActFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim420
;GC V2.c,426 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,427 :: 		SignalingSystem_ClearSignal(&SigSys,54);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,428 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,429 :: 		memcpy(LCD.Line2,"    Openning    ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr8_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr8_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr8_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr8_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr8_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr8_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr8_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,430 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,431 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,432 :: 		SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _ms500+0, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	MOVF        _ms500+1, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+1 
	MOVF        _ms500+2, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+2 
	MOVF        _ms500+3, 0 
	MOVWF       FARG_SignalingSystem_AddSignal+3 
	MOVF        _SimTime+0, 0 
	SUBWF       FARG_SignalingSystem_AddSignal+0, 1 
	MOVF        _SimTime+1, 0 
	SUBWFB      FARG_SignalingSystem_AddSignal+1, 1 
	MOVF        _SimTime+2, 0 
	SUBWFB      FARG_SignalingSystem_AddSignal+2, 1 
	MOVF        _SimTime+3, 0 
	SUBWFB      FARG_SignalingSystem_AddSignal+3, 1 
	MOVLW       50
	MOVWF       FARG_SignalingSystem_AddSignal+0 
	CALL        _SignalingSystem_AddSignal+0, 0
;GC V2.c,433 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,434 :: 		}
L_Sim420:
;GC V2.c,435 :: 		}
L_end_Sim4:
	RETURN      0
; end of _Sim4

_Sim5:

;GC V2.c,452 :: 		void Sim5() // Invalid 2
;GC V2.c,454 :: 		if(SignalingSystem_CheckSignal(&SigSys,54))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim521
;GC V2.c,456 :: 		DoorStatus=DOORSTATUS_Close;
	MOVLW       2
	MOVWF       _DoorStatus+0 
;GC V2.c,457 :: 		memcpy(LCD.Line2,"     Closed     ",16);
	MOVLW       _LCD+16
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCD+16)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr9_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr9_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr9_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr9_GC_32V2+0
	MOVWF       FSR1 
	MOVLW       hi_addr(?lstr9_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr9_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr9_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,458 :: 		LCDSystem_Update(&LCD);
	MOVLW       _LCD+0
	MOVWF       FARG_LCDSystem_Update+0 
	MOVLW       hi_addr(_LCD+0)
	MOVWF       FARG_LCDSystem_Update+1 
	CALL        _LCDSystem_Update+0, 0
;GC V2.c,459 :: 		SimStatus=0;
	CLRF        _SimStatus+0 
;GC V2.c,460 :: 		}
L_Sim521:
;GC V2.c,461 :: 		}
L_end_Sim5:
	RETURN      0
; end of _Sim5

_DoorSimulator:

;GC V2.c,480 :: 		void DoorSimulator()
;GC V2.c,482 :: 		switch(SimStatus)
	GOTO        L_DoorSimulator22
;GC V2.c,484 :: 		case 0:
L_DoorSimulator24:
;GC V2.c,485 :: 		Sim0();
	CALL        _Sim0+0, 0
;GC V2.c,486 :: 		break;
	GOTO        L_DoorSimulator23
;GC V2.c,488 :: 		case 1:
L_DoorSimulator25:
;GC V2.c,489 :: 		Sim1();
	CALL        _Sim1+0, 0
;GC V2.c,490 :: 		break;
	GOTO        L_DoorSimulator23
;GC V2.c,492 :: 		case 2:
L_DoorSimulator26:
;GC V2.c,493 :: 		Sim2();
	CALL        _Sim2+0, 0
;GC V2.c,494 :: 		break;
	GOTO        L_DoorSimulator23
;GC V2.c,496 :: 		case 3:
L_DoorSimulator27:
;GC V2.c,497 :: 		Sim3();
	CALL        _Sim3+0, 0
;GC V2.c,498 :: 		break;
	GOTO        L_DoorSimulator23
;GC V2.c,500 :: 		case 4:
L_DoorSimulator28:
;GC V2.c,501 :: 		Sim4();
	CALL        _Sim4+0, 0
;GC V2.c,502 :: 		break;
	GOTO        L_DoorSimulator23
;GC V2.c,504 :: 		case 5:
L_DoorSimulator29:
;GC V2.c,505 :: 		Sim5();
	CALL        _Sim5+0, 0
;GC V2.c,506 :: 		break;
	GOTO        L_DoorSimulator23
;GC V2.c,507 :: 		}
L_DoorSimulator22:
	MOVF        _SimStatus+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator24
	MOVF        _SimStatus+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator25
	MOVF        _SimStatus+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator26
	MOVF        _SimStatus+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator27
	MOVF        _SimStatus+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator28
	MOVF        _SimStatus+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator29
L_DoorSimulator23:
;GC V2.c,508 :: 		}
L_end_DoorSimulator:
	RETURN      0
; end of _DoorSimulator
