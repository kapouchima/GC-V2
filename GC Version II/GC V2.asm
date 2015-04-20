
_Init:

;GC V2.c,108 :: 		void Init()
;GC V2.c,111 :: 		OSCCON=0b01100000;
	MOVLW       96
	MOVWF       OSCCON+0 
;GC V2.c,112 :: 		OSCTUNE.PLLEN=1;
	BSF         OSCTUNE+0, 6 
;GC V2.c,114 :: 		ANCON0=0;
	CLRF        ANCON0+0 
;GC V2.c,115 :: 		ANCON1=0;
	CLRF        ANCON1+0 
;GC V2.c,117 :: 		porta=0;
	CLRF        PORTA+0 
;GC V2.c,118 :: 		portb=0;
	CLRF        PORTB+0 
;GC V2.c,119 :: 		portc=0;
	CLRF        PORTC+0 
;GC V2.c,120 :: 		portd=0;
	CLRF        PORTD+0 
;GC V2.c,121 :: 		porte=0;
	CLRF        PORTE+0 
;GC V2.c,122 :: 		trisa=0b10111111;
	MOVLW       191
	MOVWF       TRISA+0 
;GC V2.c,123 :: 		trisb=0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;GC V2.c,124 :: 		trisc=0b10000001;
	MOVLW       129
	MOVWF       TRISC+0 
;GC V2.c,125 :: 		trisd=0b10110000;
	MOVLW       176
	MOVWF       TRISD+0 
;GC V2.c,126 :: 		trise=0b1110;
	MOVLW       14
	MOVWF       TRISE+0 
;GC V2.c,129 :: 		T0CON=0b10000001; //prescaler 4
	MOVLW       129
	MOVWF       T0CON+0 
;GC V2.c,130 :: 		TMR0H=0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;GC V2.c,131 :: 		TMR0L=0xBF;
	MOVLW       191
	MOVWF       TMR0L+0 
;GC V2.c,132 :: 		INTCON.b7=1;
	BSF         INTCON+0, 7 
;GC V2.c,133 :: 		INTCON.T0IE=1;
	BSF         INTCON+0, 5 
;GC V2.c,136 :: 		LCD_Init();
	CALL        _Lcd_Init+0, 0
;GC V2.c,138 :: 		LCD_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;GC V2.c,139 :: 		delay_ms(500);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_Init0:
	DECFSZ      R13, 1, 0
	BRA         L_Init0
	DECFSZ      R12, 1, 0
	BRA         L_Init0
	DECFSZ      R11, 1, 0
	BRA         L_Init0
	NOP
;GC V2.c,140 :: 		LCDBL=1;
	BSF         PORTA+0, 6 
;GC V2.c,143 :: 		UART1_Init(9600);
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;GC V2.c,144 :: 		UART2_Init(9600);
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;GC V2.c,147 :: 		SignalingSystem_Init(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Init+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Init+1 
	CALL        _SignalingSystem_Init+0, 0
;GC V2.c,150 :: 		DoorStatus=DOORSTATUS_Close;
	MOVLW       2
	MOVWF       _DoorStatus+0 
;GC V2.c,153 :: 		LoadConfig();
	CALL        _LoadConfig+0, 0
;GC V2.c,154 :: 		}
	RETURN      0
; end of _Init

_interrupt:

;GC V2.c,168 :: 		void interrupt()
;GC V2.c,170 :: 		if((TMR0IF_bit)&&(TMR0IE_bit))
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt3
	BTFSS       TMR0IE_bit+0, 5 
	GOTO        L_interrupt3
L__interrupt118:
;GC V2.c,172 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;GC V2.c,173 :: 		Counterms500=Counterms500+1;
	INCF        _Counterms500+0, 1 
;GC V2.c,174 :: 		if(Counterms500>=25)
	MOVLW       25
	SUBWF       _Counterms500+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt4
;GC V2.c,175 :: 		{Flag500ms=1;Counterms500=0;}
	MOVLW       1
	MOVWF       _Flag500ms+0 
	CLRF        _Counterms500+0 
L_interrupt4:
;GC V2.c,176 :: 		TMR0H=0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;GC V2.c,177 :: 		TMR0L=0xBF;
	MOVLW       191
	MOVWF       TMR0L+0 
;GC V2.c,178 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;GC V2.c,179 :: 		}
L_interrupt3:
;GC V2.c,180 :: 		}
L__interrupt128:
	RETFIE      1
; end of _interrupt

_main:

;GC V2.c,193 :: 		void main() {
;GC V2.c,197 :: 		Init();
	CALL        _Init+0, 0
;GC V2.c,199 :: 		LCD_out(1,1,"     Start!     ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr2_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr2_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr2_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr2_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr2_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr2_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,200 :: 		LCD_out(2,1,"                ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr3_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr3_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr3_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr3_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr3_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr3_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,203 :: 		while(1)
L_main5:
;GC V2.c,206 :: 		if(Flag20ms)
	MOVF        _Flag20ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
;GC V2.c,208 :: 		KeysSystem_EPOCH();
	CALL        _KeysSystem_EPOCH+0, 0
;GC V2.c,210 :: 		if(BuzzerCounter>0)
	MOVF        _BuzzerCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main8
;GC V2.c,211 :: 		{BuzzerCounter=BuzzerCounter-1;/*Buzzer=1;*/}
	DECF        _BuzzerCounter+0, 1 
	GOTO        L_main9
L_main8:
;GC V2.c,213 :: 		Buzzer=0;
	BCF         PORTC+0, 5 
L_main9:
;GC V2.c,215 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;GC V2.c,216 :: 		}
L_main7:
;GC V2.c,218 :: 		if(Flag500ms)
	MOVF        _Flag500ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
;GC V2.c,220 :: 		if(LCDBLCounter>0)
	MOVF        _LCDBLCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main11
;GC V2.c,221 :: 		LCDBLCounter=LCDBLCounter-1;
	DECF        _LCDBLCounter+0, 1 
	GOTO        L_main12
L_main11:
;GC V2.c,223 :: 		LCDBL=0;
	BCF         PORTA+0, 6 
L_main12:
;GC V2.c,224 :: 		LCDFlashState=!LCDFlashState;
	MOVF        _LCDFlashState+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashState+0 
;GC V2.c,225 :: 		FlashLCD();
	CALL        _FlashLCD+0, 0
;GC V2.c,226 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;GC V2.c,227 :: 		SignalingSystem_SystemEPOCH(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_SystemEPOCH+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_SystemEPOCH+1 
	CALL        _SignalingSystem_SystemEPOCH+0, 0
;GC V2.c,228 :: 		SignalingSystem_Task(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Task+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Task+1 
	CALL        _SignalingSystem_Task+0, 0
;GC V2.c,229 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;GC V2.c,230 :: 		}
L_main10:
;GC V2.c,233 :: 		Keys=KeysSystem_Task();
	CALL        _KeysSystem_Task+0, 0
	MOVF        R0, 0 
	MOVWF       _Keys+0 
;GC V2.c,234 :: 		if(Keys!=0) {LCDBLCounter=10;BuzzerCounter=3;}
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVLW       10
	MOVWF       _LCDBLCounter+0 
	MOVLW       3
	MOVWF       _BuzzerCounter+0 
L_main13:
;GC V2.c,236 :: 		if(DisplayMode==0)
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main14
;GC V2.c,237 :: 		MenuHandler();
	CALL        _MenuHandler+0, 0
L_main14:
;GC V2.c,252 :: 		DoorSimulator();
	CALL        _DoorSimulator+0, 0
;GC V2.c,254 :: 		if(LCDBLCounter>0)LCDBL=1;
	MOVF        _LCDBLCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
	BSF         PORTA+0, 6 
L_main15:
;GC V2.c,257 :: 		}
	GOTO        L_main5
;GC V2.c,258 :: 		}
	GOTO        $+0
; end of _main

_ShowLCTime:

;GC V2.c,274 :: 		void ShowLCTime()
;GC V2.c,281 :: 		tm=(ms500-LCTime)/2;
	MOVF        _ms500+0, 0 
	MOVWF       R5 
	MOVF        _ms500+1, 0 
	MOVWF       R6 
	MOVF        _ms500+2, 0 
	MOVWF       R7 
	MOVF        _ms500+3, 0 
	MOVWF       R8 
	MOVF        _LCTime+0, 0 
	SUBWF       R5, 1 
	MOVF        _LCTime+1, 0 
	SUBWFB      R6, 1 
	MOVF        _LCTime+2, 0 
	SUBWFB      R7, 1 
	MOVF        _LCTime+3, 0 
	SUBWFB      R8, 1 
	MOVF        R5, 0 
	MOVWF       R1 
	MOVF        R6, 0 
	MOVWF       R2 
	MOVF        R7, 0 
	MOVWF       R3 
	MOVF        R8, 0 
	MOVWF       R4 
	RRCF        R4, 1 
	RRCF        R3, 1 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R4, 7 
	MOVF        R1, 0 
	MOVWF       ShowLCTime_tm_L0+0 
	MOVF        R2, 0 
	MOVWF       ShowLCTime_tm_L0+1 
	MOVF        R3, 0 
	MOVWF       ShowLCTime_tm_L0+2 
	MOVF        R4, 0 
	MOVWF       ShowLCTime_tm_L0+3 
;GC V2.c,282 :: 		if(tm!=PrevLCTime)
	MOVF        R4, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ShowLCTime129
	MOVF        R3, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ShowLCTime129
	MOVF        R2, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ShowLCTime129
	MOVF        R1, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+0, 0 
L__ShowLCTime129:
	BTFSC       STATUS+0, 2 
	GOTO        L_ShowLCTime16
;GC V2.c,284 :: 		PrevLCTime=tm;
	MOVF        ShowLCTime_tm_L0+0, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+0 
	MOVF        ShowLCTime_tm_L0+1, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+1 
	MOVF        ShowLCTime_tm_L0+2, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+2 
	MOVF        ShowLCTime_tm_L0+3, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+3 
;GC V2.c,285 :: 		seconds=(tm%60);
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        ShowLCTime_tm_L0+0, 0 
	MOVWF       R0 
	MOVF        ShowLCTime_tm_L0+1, 0 
	MOVWF       R1 
	MOVF        ShowLCTime_tm_L0+2, 0 
	MOVWF       R2 
	MOVF        ShowLCTime_tm_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       ShowLCTime_seconds_L0+0 
;GC V2.c,286 :: 		tm=tm/60;
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        ShowLCTime_tm_L0+0, 0 
	MOVWF       R0 
	MOVF        ShowLCTime_tm_L0+1, 0 
	MOVWF       R1 
	MOVF        ShowLCTime_tm_L0+2, 0 
	MOVWF       R2 
	MOVF        ShowLCTime_tm_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
	MOVF        R0, 0 
	MOVWF       ShowLCTime_tm_L0+0 
	MOVF        R1, 0 
	MOVWF       ShowLCTime_tm_L0+1 
	MOVF        R2, 0 
	MOVWF       ShowLCTime_tm_L0+2 
	MOVF        R3, 0 
	MOVWF       ShowLCTime_tm_L0+3 
;GC V2.c,287 :: 		minutes=(tm%60);
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	CALL        _Div_32x32_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R10, 0 
	MOVWF       R2 
	MOVF        R11, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       ShowLCTime_minutes_L0+0 
;GC V2.c,288 :: 		hours=tm/60;
	MOVLW       60
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVWF       R6 
	MOVWF       R7 
	MOVF        ShowLCTime_tm_L0+0, 0 
	MOVWF       R0 
	MOVF        ShowLCTime_tm_L0+1, 0 
	MOVWF       R1 
	MOVF        ShowLCTime_tm_L0+2, 0 
	MOVWF       R2 
	MOVF        ShowLCTime_tm_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_U+0, 0
;GC V2.c,290 :: 		wordtostr(hours,txt+2);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ShowLCTime_txt_L0+2
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+2)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;GC V2.c,291 :: 		bytetostr(minutes,txt+8);
	MOVF        ShowLCTime_minutes_L0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ShowLCTime_txt_L0+8
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+8)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;GC V2.c,292 :: 		bytetostr(seconds,txt+12);
	MOVF        ShowLCTime_seconds_L0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ShowLCTime_txt_L0+12
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+12)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;GC V2.c,293 :: 		memcpy(txt,"LC:",3);
	MOVLW       ShowLCTime_txt_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       76
	MOVWF       ?lstr4_GC_32V2+0 
	MOVLW       67
	MOVWF       ?lstr4_GC_32V2+1 
	MOVLW       58
	MOVWF       ?lstr4_GC_32V2+2 
	CLRF        ?lstr4_GC_32V2+3 
	MOVLW       ?lstr4_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr4_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       3
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,294 :: 		memcpy(txt+7,"H ",2);
	MOVLW       ShowLCTime_txt_L0+7
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+7)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       72
	MOVWF       ?lstr5_GC_32V2+0 
	MOVLW       32
	MOVWF       ?lstr5_GC_32V2+1 
	CLRF        ?lstr5_GC_32V2+2 
	MOVLW       ?lstr5_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr5_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       2
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,295 :: 		memcpy(txt+11,"M ",2);
	MOVLW       ShowLCTime_txt_L0+11
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+11)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       77
	MOVWF       ?lstr6_GC_32V2+0 
	MOVLW       32
	MOVWF       ?lstr6_GC_32V2+1 
	CLRF        ?lstr6_GC_32V2+2 
	MOVLW       ?lstr6_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr6_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       2
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,296 :: 		memcpy(txt+15,"S ",2);
	MOVLW       ShowLCTime_txt_L0+15
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+15)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       83
	MOVWF       ?lstr7_GC_32V2+0 
	MOVLW       32
	MOVWF       ?lstr7_GC_32V2+1 
	CLRF        ?lstr7_GC_32V2+2 
	MOVLW       ?lstr7_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr7_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       2
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,297 :: 		txt[16]=0;
	CLRF        ShowLCTime_txt_L0+16 
;GC V2.c,299 :: 		LCD_out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ShowLCTime_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,300 :: 		}
L_ShowLCTime16:
;GC V2.c,306 :: 		}
	RETURN      0
; end of _ShowLCTime

_MenuHandler:

;GC V2.c,326 :: 		void MenuHandler()
;GC V2.c,328 :: 		switch(MenuState)
	GOTO        L_MenuHandler17
;GC V2.c,330 :: 		case 0:
L_MenuHandler19:
;GC V2.c,331 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_MenuHandler20
	MOVLW       1
	MOVWF       _MenuState+0 
L_MenuHandler20:
;GC V2.c,332 :: 		ShowLCTime();
	CALL        _ShowLCTime+0, 0
;GC V2.c,333 :: 		break;
	GOTO        L_MenuHandler18
;GC V2.c,335 :: 		case 1:
L_MenuHandler21:
;GC V2.c,336 :: 		Menu1();
	CALL        _Menu1+0, 0
;GC V2.c,337 :: 		break;
	GOTO        L_MenuHandler18
;GC V2.c,339 :: 		case 2:
L_MenuHandler22:
;GC V2.c,340 :: 		Menu2();
	CALL        _Menu2+0, 0
;GC V2.c,341 :: 		break;
	GOTO        L_MenuHandler18
;GC V2.c,343 :: 		case 3:
L_MenuHandler23:
;GC V2.c,344 :: 		Menu3();
	CALL        _Menu3+0, 0
;GC V2.c,345 :: 		break;
	GOTO        L_MenuHandler18
;GC V2.c,346 :: 		}
L_MenuHandler17:
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler19
	MOVF        _MenuState+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler21
	MOVF        _MenuState+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler22
	MOVF        _MenuState+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler23
L_MenuHandler18:
;GC V2.c,347 :: 		}
	RETURN      0
; end of _MenuHandler

_UpdateMenuText:

;GC V2.c,358 :: 		void UpdateMenuText()
;GC V2.c,362 :: 		memcpy(txt,"                ",10);
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr8_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr8_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr8_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr8_GC_32V2+0
	MOVWF       FSR1L 
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
	MOVLW       10
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;GC V2.c,363 :: 		switch(MenuCounter)
	GOTO        L_UpdateMenuText24
;GC V2.c,365 :: 		case 0:
L_UpdateMenuText26:
;GC V2.c,366 :: 		lcd_out(1,1," Openning Time  ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr9_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr9_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr9_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr9_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr9_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr9_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,367 :: 		charValueToStr(OpenningTime,txt);
	MOVF        _OpenningTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,368 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,369 :: 		break;
	GOTO        L_UpdateMenuText25
;GC V2.c,371 :: 		case 1:
L_UpdateMenuText27:
;GC V2.c,372 :: 		lcd_out(1,1,"  Closing Time  ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr10_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr10_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr10_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr10_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr10_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr10_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,373 :: 		charValueToStr(ClosingTime,txt);
	MOVF        _ClosingTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,374 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,375 :: 		break;
	GOTO        L_UpdateMenuText25
;GC V2.c,377 :: 		case 2:
L_UpdateMenuText28:
;GC V2.c,378 :: 		lcd_out(1,1,"  Invalid Time  ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr11_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr11_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr11_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr11_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr11_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr11_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,379 :: 		charValueToStr(InvalidTime,txt);
	MOVF        _InvalidTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,380 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,381 :: 		break;
	GOTO        L_UpdateMenuText25
;GC V2.c,383 :: 		case 3:
L_UpdateMenuText29:
;GC V2.c,384 :: 		lcd_out(1,1,"Autoclose Time  ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr12_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr12_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr12_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr12_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr12_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr12_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,385 :: 		charValueToStr(AutocloseTime,txt);
	MOVF        _AutocloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,386 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,387 :: 		break;
	GOTO        L_UpdateMenuText25
;GC V2.c,389 :: 		case 4:
L_UpdateMenuText30:
;GC V2.c,390 :: 		lcd_out(1,1,"  Save Changes  ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr13_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr13_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr13_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr13_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr13_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr13_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,391 :: 		lcd_out(2,1,_Blank);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        __Blank+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        __Blank+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,392 :: 		break;
	GOTO        L_UpdateMenuText25
;GC V2.c,394 :: 		case 5:
L_UpdateMenuText31:
;GC V2.c,395 :: 		lcd_out(1,1," Discard & Exit ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr14_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr14_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr14_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr14_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr14_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr14_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,396 :: 		lcd_out(2,1,_Blank);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        __Blank+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        __Blank+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,397 :: 		break;
	GOTO        L_UpdateMenuText25
;GC V2.c,398 :: 		}
L_UpdateMenuText24:
	MOVF        _MenuCounter+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText26
	MOVF        _MenuCounter+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText27
	MOVF        _MenuCounter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText28
	MOVF        _MenuCounter+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText29
	MOVF        _MenuCounter+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText30
	MOVF        _MenuCounter+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText31
L_UpdateMenuText25:
;GC V2.c,399 :: 		}
	RETURN      0
; end of _UpdateMenuText

_Menu1:

;GC V2.c,413 :: 		void Menu1()
;GC V2.c,415 :: 		UpdateMenuText();
	CALL        _UpdateMenuText+0, 0
;GC V2.c,416 :: 		MenuState=2;
	MOVLW       2
	MOVWF       _MenuState+0 
;GC V2.c,417 :: 		}
	RETURN      0
; end of _Menu1

_Menu2:

;GC V2.c,427 :: 		void Menu2()
;GC V2.c,429 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;GC V2.c,430 :: 		if(Keys & DOWN)
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu232
;GC V2.c,431 :: 		if(MenuCounter>0)
	MOVF        _MenuCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu233
;GC V2.c,432 :: 		{MenuCounter=MenuCounter-1;MenuState=1;}
	DECF        _MenuCounter+0, 1 
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu233:
L_Menu232:
;GC V2.c,434 :: 		if(Keys & UP)
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu234
;GC V2.c,435 :: 		if(MenuCounter<5)
	MOVLW       5
	SUBWF       _MenuCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu235
;GC V2.c,436 :: 		{MenuCounter=MenuCounter+1;MenuState=1;}
	INCF        _MenuCounter+0, 1 
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu235:
L_Menu234:
;GC V2.c,438 :: 		if(Keys & CENTER)
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu236
;GC V2.c,439 :: 		MenuState=3;
	MOVLW       3
	MOVWF       _MenuState+0 
L_Menu236:
;GC V2.c,440 :: 		}
	RETURN      0
; end of _Menu2

_Menu3:

;GC V2.c,449 :: 		void Menu3()
;GC V2.c,451 :: 		LCDFlashFlag=1;
	MOVLW       1
	MOVWF       _LCDFlashFlag+0 
;GC V2.c,452 :: 		switch(MenuCounter)
	GOTO        L_Menu337
;GC V2.c,454 :: 		case 0:
L_Menu339:
;GC V2.c,455 :: 		if(Keys & UP)     if(OpenningTime<255)  {OpenningTime=OpenningTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu340
	MOVLW       255
	SUBWF       _OpenningTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu341
	INCF        _OpenningTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu341:
L_Menu340:
;GC V2.c,456 :: 		if(Keys & DOWN)   if(OpenningTime>0)    {OpenningTime=OpenningTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu342
	MOVF        _OpenningTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu343
	DECF        _OpenningTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu343:
L_Menu342:
;GC V2.c,457 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu344
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu344:
;GC V2.c,458 :: 		break;
	GOTO        L_Menu338
;GC V2.c,460 :: 		case 1:
L_Menu345:
;GC V2.c,461 :: 		if(Keys & UP)     if(ClosingTime<255)  {ClosingTime=ClosingTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu346
	MOVLW       255
	SUBWF       _ClosingTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu347
	INCF        _ClosingTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu347:
L_Menu346:
;GC V2.c,462 :: 		if(Keys & DOWN)   if(ClosingTime>0)    {ClosingTime=ClosingTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu348
	MOVF        _ClosingTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu349
	DECF        _ClosingTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu349:
L_Menu348:
;GC V2.c,463 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu350
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu350:
;GC V2.c,464 :: 		break;
	GOTO        L_Menu338
;GC V2.c,466 :: 		case 2:
L_Menu351:
;GC V2.c,467 :: 		if(Keys & UP)     if(InvalidTime<255)  {InvalidTime=InvalidTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu352
	MOVLW       255
	SUBWF       _InvalidTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu353
	INCF        _InvalidTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu353:
L_Menu352:
;GC V2.c,468 :: 		if(Keys & DOWN)   if(InvalidTime>0)    {InvalidTime=InvalidTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu354
	MOVF        _InvalidTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu355
	DECF        _InvalidTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu355:
L_Menu354:
;GC V2.c,469 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu356
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu356:
;GC V2.c,470 :: 		break;
	GOTO        L_Menu338
;GC V2.c,472 :: 		case 3:
L_Menu357:
;GC V2.c,473 :: 		if(Keys & UP)     if(AutocloseTime<255)  {AutocloseTime=AutocloseTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu358
	MOVLW       255
	SUBWF       _AutocloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu359
	INCF        _AutocloseTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu359:
L_Menu358:
;GC V2.c,474 :: 		if(Keys & DOWN)   if(AutocloseTime>0)    {AutocloseTime=AutocloseTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu360
	MOVF        _AutocloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu361
	DECF        _AutocloseTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu361:
L_Menu360:
;GC V2.c,475 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu362
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu362:
;GC V2.c,476 :: 		break;
	GOTO        L_Menu338
;GC V2.c,478 :: 		case 4:
L_Menu363:
;GC V2.c,479 :: 		if(Keys & CENTER) MenuState=0;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu364
	CLRF        _MenuState+0 
L_Menu364:
;GC V2.c,480 :: 		{LCDFlashFlag=0;SaveConfig();MenuState=0;}
	CLRF        _LCDFlashFlag+0 
	CALL        _SaveConfig+0, 0
	CLRF        _MenuState+0 
;GC V2.c,481 :: 		break;
	GOTO        L_Menu338
;GC V2.c,483 :: 		case 5:
L_Menu365:
;GC V2.c,484 :: 		if(Keys & CENTER) MenuState=0;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu366
	CLRF        _MenuState+0 
L_Menu366:
;GC V2.c,485 :: 		{LCDFlashFlag=0;LoadConfig();MenuState=0;}
	CLRF        _LCDFlashFlag+0 
	CALL        _LoadConfig+0, 0
	CLRF        _MenuState+0 
;GC V2.c,486 :: 		break;
	GOTO        L_Menu338
;GC V2.c,487 :: 		}
L_Menu337:
	MOVF        _MenuCounter+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu339
	MOVF        _MenuCounter+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu345
	MOVF        _MenuCounter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu351
	MOVF        _MenuCounter+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu357
	MOVF        _MenuCounter+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu363
	MOVF        _MenuCounter+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu365
L_Menu338:
;GC V2.c,491 :: 		}
	RETURN      0
; end of _Menu3

_charValueToStr:

;GC V2.c,506 :: 		void charValueToStr(char val, char * string)
;GC V2.c,508 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;GC V2.c,509 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr67
;GC V2.c,510 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr15_GC_32V2+0 
	MOVLW       53
	MOVWF       ?lstr15_GC_32V2+1 
	MOVLW       115
	MOVWF       ?lstr15_GC_32V2+2 
	CLRF        ?lstr15_GC_32V2+3 
	MOVLW       ?lstr15_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr15_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_charValueToStr68
L_charValueToStr67:
;GC V2.c,512 :: 		memcpy(string+3,".0s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr16_GC_32V2+0 
	MOVLW       48
	MOVWF       ?lstr16_GC_32V2+1 
	MOVLW       115
	MOVWF       ?lstr16_GC_32V2+2 
	CLRF        ?lstr16_GC_32V2+3 
	MOVLW       ?lstr16_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr16_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr68:
;GC V2.c,513 :: 		}
	RETURN      0
; end of _charValueToStr

_Sim0:

;GC V2.c,536 :: 		void Sim0() // Close
;GC V2.c,539 :: 		if(DoorActFlag)
	MOVF        _DoorActFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim069
;GC V2.c,541 :: 		SignalingSystem_AddSignal(&SigSys,OpenningTime,50); // OpenTime
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
;GC V2.c,542 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,543 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim072
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim072
L__Sim0119:
;GC V2.c,545 :: 		LCD_out(2,1,"    Openning    ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr17_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr17_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr17_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr17_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr17_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr17_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,546 :: 		}
L_Sim072:
;GC V2.c,547 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,548 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,549 :: 		}
L_Sim069:
;GC V2.c,550 :: 		}
	RETURN      0
; end of _Sim0

_Sim1:

;GC V2.c,565 :: 		void Sim1() // Openning
;GC V2.c,567 :: 		if(SignalingSystem_CheckSignal(&SigSys,50))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       50
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim173
;GC V2.c,569 :: 		DoorStatus=DOORSTATUS_Open;
	MOVLW       1
	MOVWF       _DoorStatus+0 
;GC V2.c,570 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim176
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim176
L__Sim1120:
;GC V2.c,572 :: 		LCD_out(2,1,"     Opened     ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr18_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr18_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr18_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr18_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr18_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr18_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,573 :: 		}
L_Sim176:
;GC V2.c,574 :: 		SimStatus=2;
	MOVLW       2
	MOVWF       _SimStatus+0 
;GC V2.c,575 :: 		SignalingSystem_AddSignal(&SigSys,AutocloseTime-InvalidTime,51);//AutoClose - Invalid
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
;GC V2.c,576 :: 		}
L_Sim173:
;GC V2.c,577 :: 		}
	RETURN      0
; end of _Sim1

_Sim2:

;GC V2.c,593 :: 		void Sim2() // Open
;GC V2.c,595 :: 		if(SignalingSystem_CheckSignal(&SigSys,51))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       51
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim277
;GC V2.c,597 :: 		DoorStatus=DOORSTATUS_Invalid;
	CLRF        _DoorStatus+0 
;GC V2.c,598 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim280
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim280
L__Sim2121:
;GC V2.c,600 :: 		LCD_out(2,1,"    Invalid     ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr19_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr19_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr19_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr19_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr19_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr19_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,601 :: 		}
L_Sim280:
;GC V2.c,602 :: 		SimStatus=3;
	MOVLW       3
	MOVWF       _SimStatus+0 
;GC V2.c,603 :: 		SignalingSystem_AddSignal(&SigSys,InvalidTime*2,52); // invalid time * 2
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
;GC V2.c,604 :: 		SimTime=ms500+InvalidTime;
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
;GC V2.c,605 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,606 :: 		}
L_Sim277:
;GC V2.c,607 :: 		}
	RETURN      0
; end of _Sim2

_Sim3:

;GC V2.c,630 :: 		void Sim3() // Invalid 1
;GC V2.c,632 :: 		if(SignalingSystem_CheckSignal(&SigSys,52))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       52
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim381
;GC V2.c,634 :: 		DoorStatus=DOORSTATUS_Closing;
	MOVLW       4
	MOVWF       _DoorStatus+0 
;GC V2.c,635 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim384
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim384
L__Sim3123:
;GC V2.c,637 :: 		LCD_out(2,1,"    Closing     ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr20_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr20_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr20_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr20_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr20_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr20_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,638 :: 		}
L_Sim384:
;GC V2.c,639 :: 		SimStatus=4;
	MOVLW       4
	MOVWF       _SimStatus+0 
;GC V2.c,640 :: 		SignalingSystem_AddSignal(&SigSys,ClosingTime-(InvalidTime*2),53); // closing time - invalid time * 2
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
;GC V2.c,641 :: 		}
L_Sim381:
;GC V2.c,643 :: 		if(!IRin)
	BTFSC       PORTC+0, 0 
	GOTO        L_Sim385
;GC V2.c,645 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,646 :: 		SignalingSystem_ClearSignal(&SigSys,52);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       52
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,647 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,648 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim388
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim388
L__Sim3122:
;GC V2.c,650 :: 		LCD_out(2,1,"    Openning    ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr21_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr21_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr21_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr21_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr21_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr21_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,651 :: 		}
L_Sim388:
;GC V2.c,652 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,653 :: 		SignalingSystem_AddSignal(&SigSys,InvalidTime,50);
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
;GC V2.c,654 :: 		}
L_Sim385:
;GC V2.c,655 :: 		}
	RETURN      0
; end of _Sim3

_Sim4:

;GC V2.c,676 :: 		void Sim4() // Closing
;GC V2.c,678 :: 		if(SignalingSystem_CheckSignal(&SigSys,53))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim489
;GC V2.c,680 :: 		DoorStatus=DOORSTATUS_Invalid;
	CLRF        _DoorStatus+0 
;GC V2.c,681 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim492
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim492
L__Sim4126:
;GC V2.c,683 :: 		LCD_out(2,1,"    Invalid     ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr22_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr22_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr22_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr22_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr22_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr22_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr22_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,684 :: 		}
L_Sim492:
;GC V2.c,685 :: 		SimStatus=5;
	MOVLW       5
	MOVWF       _SimStatus+0 
;GC V2.c,686 :: 		SignalingSystem_AddSignal(&SigSys,(InvalidTime*2),54); // invalid time * 2
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
;GC V2.c,687 :: 		}
L_Sim489:
;GC V2.c,689 :: 		if(!IRin)
	BTFSC       PORTC+0, 0 
	GOTO        L_Sim493
;GC V2.c,691 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,692 :: 		SignalingSystem_ClearSignal(&SigSys,54);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,693 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,694 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim496
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim496
L__Sim4125:
;GC V2.c,696 :: 		LCD_out(2,1,"    Openning    ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr23_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr23_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr23_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr23_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr23_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr23_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr23_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,697 :: 		}
L_Sim496:
;GC V2.c,698 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,699 :: 		SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
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
;GC V2.c,700 :: 		}
L_Sim493:
;GC V2.c,702 :: 		if(DoorActFlag)
	MOVF        _DoorActFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim497
;GC V2.c,704 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,705 :: 		SignalingSystem_ClearSignal(&SigSys,54);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,706 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,707 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4100
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4100
L__Sim4124:
;GC V2.c,709 :: 		LCD_out(2,1,"    Openning    ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr24_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr24_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr24_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr24_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr24_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr24_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr24_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,710 :: 		}
L_Sim4100:
;GC V2.c,711 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,712 :: 		SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
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
;GC V2.c,713 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,714 :: 		}
L_Sim497:
;GC V2.c,715 :: 		}
	RETURN      0
; end of _Sim4

_Sim5:

;GC V2.c,732 :: 		void Sim5() // Invalid 2
;GC V2.c,734 :: 		if(SignalingSystem_CheckSignal(&SigSys,54))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim5101
;GC V2.c,736 :: 		DoorStatus=DOORSTATUS_Close;
	MOVLW       2
	MOVWF       _DoorStatus+0 
;GC V2.c,737 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim5104
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim5104
L__Sim5127:
;GC V2.c,739 :: 		LCD_out(2,1,"     Closed     ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr25_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr25_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr25_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr25_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr25_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr25_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr25_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,740 :: 		}
L_Sim5104:
;GC V2.c,741 :: 		SimStatus=0;
	CLRF        _SimStatus+0 
;GC V2.c,742 :: 		}
L_Sim5101:
;GC V2.c,743 :: 		}
	RETURN      0
; end of _Sim5

_DoorSimulator:

;GC V2.c,762 :: 		void DoorSimulator()
;GC V2.c,764 :: 		switch(SimStatus)
	GOTO        L_DoorSimulator105
;GC V2.c,766 :: 		case 0:
L_DoorSimulator107:
;GC V2.c,767 :: 		Sim0();
	CALL        _Sim0+0, 0
;GC V2.c,768 :: 		break;
	GOTO        L_DoorSimulator106
;GC V2.c,770 :: 		case 1:
L_DoorSimulator108:
;GC V2.c,771 :: 		Sim1();
	CALL        _Sim1+0, 0
;GC V2.c,772 :: 		break;
	GOTO        L_DoorSimulator106
;GC V2.c,774 :: 		case 2:
L_DoorSimulator109:
;GC V2.c,775 :: 		Sim2();
	CALL        _Sim2+0, 0
;GC V2.c,776 :: 		break;
	GOTO        L_DoorSimulator106
;GC V2.c,778 :: 		case 3:
L_DoorSimulator110:
;GC V2.c,779 :: 		Sim3();
	CALL        _Sim3+0, 0
;GC V2.c,780 :: 		break;
	GOTO        L_DoorSimulator106
;GC V2.c,782 :: 		case 4:
L_DoorSimulator111:
;GC V2.c,783 :: 		Sim4();
	CALL        _Sim4+0, 0
;GC V2.c,784 :: 		break;
	GOTO        L_DoorSimulator106
;GC V2.c,786 :: 		case 5:
L_DoorSimulator112:
;GC V2.c,787 :: 		Sim5();
	CALL        _Sim5+0, 0
;GC V2.c,788 :: 		break;
	GOTO        L_DoorSimulator106
;GC V2.c,789 :: 		}
L_DoorSimulator105:
	MOVF        _SimStatus+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator107
	MOVF        _SimStatus+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator108
	MOVF        _SimStatus+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator109
	MOVF        _SimStatus+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator110
	MOVF        _SimStatus+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator111
	MOVF        _SimStatus+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator112
L_DoorSimulator106:
;GC V2.c,790 :: 		}
	RETURN      0
; end of _DoorSimulator

_SaveConfig:

;GC V2.c,803 :: 		void SaveConfig()
;GC V2.c,805 :: 		eeprom_write(0,OpenningTime);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVF        _OpenningTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,806 :: 		eeprom_write(1,ClosingTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ClosingTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,807 :: 		eeprom_write(2,InvalidTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _InvalidTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,808 :: 		eeprom_write(3,AutocloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutocloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,809 :: 		}
	RETURN      0
; end of _SaveConfig

_LoadConfig:

;GC V2.c,819 :: 		void LoadConfig()
;GC V2.c,821 :: 		OpenningTime=eeprom_read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenningTime+0 
;GC V2.c,822 :: 		ClosingTime=eeprom_read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ClosingTime+0 
;GC V2.c,823 :: 		InvalidTime=eeprom_read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _InvalidTime+0 
;GC V2.c,824 :: 		AutocloseTime=eeprom_read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutocloseTime+0 
;GC V2.c,825 :: 		}
	RETURN      0
; end of _LoadConfig

_FlashLCD:

;GC V2.c,838 :: 		void FlashLCD()
;GC V2.c,842 :: 		if(LCDFlashFlag)
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FlashLCD113
;GC V2.c,844 :: 		PrevLCDFlashState=LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 0 
	MOVWF       FlashLCD_PrevLCDFlashState_L0+0 
;GC V2.c,845 :: 		if(LCDFlashState)
	MOVF        _LCDFlashState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FlashLCD114
;GC V2.c,847 :: 		LCD_chr(2,1,'>');LCD_chr(2,2,'>');LCD_chr(2,3,'>');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       62
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;GC V2.c,848 :: 		LCD_chr(2,16,'<');LCD_chr(2,15,'<');LCD_chr(2,14,'<');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       60
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       60
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       60
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;GC V2.c,849 :: 		}
	GOTO        L_FlashLCD115
L_FlashLCD114:
;GC V2.c,852 :: 		LCD_chr(2,1,' ');LCD_chr(2,2,' ');LCD_chr(2,3,' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;GC V2.c,853 :: 		LCD_chr(2,16,' ');LCD_chr(2,15,' ');LCD_chr(2,14,' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;GC V2.c,854 :: 		}
L_FlashLCD115:
;GC V2.c,855 :: 		}
	GOTO        L_FlashLCD116
L_FlashLCD113:
;GC V2.c,858 :: 		if(PrevLCDFlashState)
	MOVF        FlashLCD_PrevLCDFlashState_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FlashLCD117
;GC V2.c,860 :: 		LCD_chr(2,1,' ');LCD_chr(2,2,' ');LCD_chr(2,3,' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;GC V2.c,861 :: 		LCD_chr(2,16,' ');LCD_chr(2,15,' ');LCD_chr(2,14,' ');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       16
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;GC V2.c,862 :: 		}
L_FlashLCD117:
;GC V2.c,863 :: 		PrevLCDFlashState=LCDFlashState;
	MOVF        _LCDFlashState+0, 0 
	MOVWF       FlashLCD_PrevLCDFlashState_L0+0 
;GC V2.c,864 :: 		}
L_FlashLCD116:
;GC V2.c,865 :: 		}
	RETURN      0
; end of _FlashLCD
