
_Init:

;GC V2.c,117 :: 		void Init()
;GC V2.c,120 :: 		OSCCON=0b01100000;
	MOVLW       96
	MOVWF       OSCCON+0 
;GC V2.c,121 :: 		OSCTUNE.PLLEN=1;
	BSF         OSCTUNE+0, 6 
;GC V2.c,123 :: 		ANCON0=0;
	CLRF        ANCON0+0 
;GC V2.c,124 :: 		ANCON1=0;
	CLRF        ANCON1+0 
;GC V2.c,126 :: 		porta=0;
	CLRF        PORTA+0 
;GC V2.c,127 :: 		portb=0;
	CLRF        PORTB+0 
;GC V2.c,128 :: 		portc=0;
	CLRF        PORTC+0 
;GC V2.c,129 :: 		portd=0;
	CLRF        PORTD+0 
;GC V2.c,130 :: 		porte=0;
	CLRF        PORTE+0 
;GC V2.c,131 :: 		trisa=0b10111111;
	MOVLW       191
	MOVWF       TRISA+0 
;GC V2.c,132 :: 		trisb=0b11000000;
	MOVLW       192
	MOVWF       TRISB+0 
;GC V2.c,133 :: 		trisc=0b10000001;
	MOVLW       129
	MOVWF       TRISC+0 
;GC V2.c,134 :: 		trisd=0b10110000;
	MOVLW       176
	MOVWF       TRISD+0 
;GC V2.c,135 :: 		trise=0b1110;
	MOVLW       14
	MOVWF       TRISE+0 
;GC V2.c,138 :: 		T0CON=0b10000001; //prescaler 4
	MOVLW       129
	MOVWF       T0CON+0 
;GC V2.c,139 :: 		TMR0H=0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;GC V2.c,140 :: 		TMR0L=0xBF;
	MOVLW       191
	MOVWF       TMR0L+0 
;GC V2.c,141 :: 		INTCON.b7=1;
	BSF         INTCON+0, 7 
;GC V2.c,142 :: 		INTCON.T0IE=1;
	BSF         INTCON+0, 5 
;GC V2.c,145 :: 		LCD_Init();
	CALL        _Lcd_Init+0, 0
;GC V2.c,147 :: 		LCD_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;GC V2.c,148 :: 		delay_ms(500);
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
;GC V2.c,149 :: 		LCDBL=1;
	BSF         PORTA+0, 6 
;GC V2.c,152 :: 		UART1_Init(9600);
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;GC V2.c,153 :: 		UART2_Init(9600);
	MOVLW       207
	MOVWF       SPBRG2+0 
	BSF         TXSTA2+0, 2, 0
	CALL        _UART2_Init+0, 0
;GC V2.c,154 :: 		RC1IF_bit=0;
	BCF         RC1IF_bit+0, 5 
;GC V2.c,155 :: 		RC1IE_bit=1;
	BSF         RC1IE_bit+0, 5 
;GC V2.c,156 :: 		RC1IP_bit=1;
	BSF         RC1IP_bit+0, 5 
;GC V2.c,157 :: 		PEIE_bit=1;
	BSF         PEIE_bit+0, 6 
;GC V2.c,158 :: 		UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle);
	MOVLW       _UART1_Read+0
	MOVWF       FARG_UART_Set_Active_read_ptr+0 
	MOVLW       hi_addr(_UART1_Read+0)
	MOVWF       FARG_UART_Set_Active_read_ptr+1 
	MOVLW       0
	MOVWF       FARG_UART_Set_Active_read_ptr+2 
	MOVLW       0
	MOVWF       FARG_UART_Set_Active_read_ptr+3 
	MOVLW       _UART1_Write+0
	MOVWF       FARG_UART_Set_Active_write_ptr+0 
	MOVLW       hi_addr(_UART1_Write+0)
	MOVWF       FARG_UART_Set_Active_write_ptr+1 
	MOVLW       FARG_UART1_Write_data_+0
	MOVWF       FARG_UART_Set_Active_write_ptr+2 
	MOVLW       hi_addr(FARG_UART1_Write_data_+0)
	MOVWF       FARG_UART_Set_Active_write_ptr+3 
	MOVLW       _UART1_Data_Ready+0
	MOVWF       FARG_UART_Set_Active_ready_ptr+0 
	MOVLW       hi_addr(_UART1_Data_Ready+0)
	MOVWF       FARG_UART_Set_Active_ready_ptr+1 
	MOVLW       0
	MOVWF       FARG_UART_Set_Active_ready_ptr+2 
	MOVLW       0
	MOVWF       FARG_UART_Set_Active_ready_ptr+3 
	MOVLW       _UART1_Tx_Idle+0
	MOVWF       FARG_UART_Set_Active_tx_idle_ptr+0 
	MOVLW       hi_addr(_UART1_Tx_Idle+0)
	MOVWF       FARG_UART_Set_Active_tx_idle_ptr+1 
	MOVLW       0
	MOVWF       FARG_UART_Set_Active_tx_idle_ptr+2 
	MOVLW       0
	MOVWF       FARG_UART_Set_Active_tx_idle_ptr+3 
	CALL        _UART_Set_Active+0, 0
;GC V2.c,161 :: 		SignalingSystem_Init(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Init+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Init+1 
	CALL        _SignalingSystem_Init+0, 0
;GC V2.c,164 :: 		DoorStatus=DOORSTATUS_Close;
	MOVLW       2
	MOVWF       _DoorStatus+0 
;GC V2.c,167 :: 		LoadConfig();
	CALL        _LoadConfig+0, 0
;GC V2.c,170 :: 		RS485Slave_Init(NetworkAddress);
	MOVF        _NetworkAddress+0, 0 
	MOVWF       FARG_RS485Slave_Init_slave_address+0 
	CALL        _RS485Slave_Init+0, 0
;GC V2.c,171 :: 		}
	RETURN      0
; end of _Init

_interrupt:

;GC V2.c,185 :: 		void interrupt()
;GC V2.c,187 :: 		if((TMR0IF_bit)&&(TMR0IE_bit))
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt3
	BTFSS       TMR0IE_bit+0, 5 
	GOTO        L_interrupt3
L__interrupt138:
;GC V2.c,189 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;GC V2.c,190 :: 		Counterms500=Counterms500+1;
	INCF        _Counterms500+0, 1 
;GC V2.c,191 :: 		if(Counterms500>=25)
	MOVLW       25
	SUBWF       _Counterms500+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt4
;GC V2.c,192 :: 		{Flag500ms=1;Counterms500=0;}
	MOVLW       1
	MOVWF       _Flag500ms+0 
	CLRF        _Counterms500+0 
L_interrupt4:
;GC V2.c,193 :: 		TMR0H=0x63;
	MOVLW       99
	MOVWF       TMR0H+0 
;GC V2.c,194 :: 		TMR0L=0xBF;
	MOVLW       191
	MOVWF       TMR0L+0 
;GC V2.c,195 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;GC V2.c,196 :: 		}
L_interrupt3:
;GC V2.c,198 :: 		if((RC1IE_bit)&&(RC1IF_bit))
	BTFSS       RC1IE_bit+0, 5 
	GOTO        L_interrupt7
	BTFSS       RC1IF_bit+0, 5 
	GOTO        L_interrupt7
L__interrupt137:
;GC V2.c,200 :: 		RS485Slave_Receive(NetBuffer);
	MOVLW       _NetBuffer+0
	MOVWF       FARG_RS485Slave_Receive_data_buffer+0 
	MOVLW       hi_addr(_NetBuffer+0)
	MOVWF       FARG_RS485Slave_Receive_data_buffer+1 
	CALL        _RS485Slave_Receive+0, 0
;GC V2.c,201 :: 		}
L_interrupt7:
;GC V2.c,202 :: 		}
L__interrupt148:
	RETFIE      1
; end of _interrupt

_main:

;GC V2.c,215 :: 		void main() {
;GC V2.c,219 :: 		Init();
	CALL        _Init+0, 0
;GC V2.c,221 :: 		LCD_out(1,1,"     Start!     ");
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
;GC V2.c,222 :: 		LCD_out(2,1,"                ");
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
;GC V2.c,225 :: 		while(1)
L_main8:
;GC V2.c,228 :: 		if(Flag20ms)
	MOVF        _Flag20ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
;GC V2.c,230 :: 		KeysSystem_EPOCH();
	CALL        _KeysSystem_EPOCH+0, 0
;GC V2.c,232 :: 		if(BuzzerCounter>0)
	MOVF        _BuzzerCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main11
;GC V2.c,233 :: 		{BuzzerCounter=BuzzerCounter-1;/*Buzzer=1;*/}
	DECF        _BuzzerCounter+0, 1 
	GOTO        L_main12
L_main11:
;GC V2.c,235 :: 		Buzzer=0;
	BCF         PORTC+0, 5 
L_main12:
;GC V2.c,237 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;GC V2.c,238 :: 		}
L_main10:
;GC V2.c,240 :: 		if(Flag500ms)
	MOVF        _Flag500ms+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
;GC V2.c,242 :: 		if(LCDBLCounter>0)
	MOVF        _LCDBLCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main14
;GC V2.c,243 :: 		LCDBLCounter=LCDBLCounter-1;
	DECF        _LCDBLCounter+0, 1 
	GOTO        L_main15
L_main14:
;GC V2.c,245 :: 		LCDBL=0;
	BCF         PORTA+0, 6 
L_main15:
;GC V2.c,246 :: 		LCDFlashState=!LCDFlashState;
	MOVF        _LCDFlashState+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashState+0 
;GC V2.c,247 :: 		FlashLCD();
	CALL        _FlashLCD+0, 0
;GC V2.c,248 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;GC V2.c,249 :: 		SignalingSystem_SystemEPOCH(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_SystemEPOCH+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_SystemEPOCH+1 
	CALL        _SignalingSystem_SystemEPOCH+0, 0
;GC V2.c,250 :: 		SignalingSystem_Task(&SigSys);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_Task+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_Task+1 
	CALL        _SignalingSystem_Task+0, 0
;GC V2.c,251 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;GC V2.c,252 :: 		}
L_main13:
;GC V2.c,255 :: 		Keys=KeysSystem_Task();
	CALL        _KeysSystem_Task+0, 0
	MOVF        R0, 0 
	MOVWF       _Keys+0 
;GC V2.c,256 :: 		if(Keys!=0) {LCDBLCounter=20;BuzzerCounter=3;}
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVLW       20
	MOVWF       _LCDBLCounter+0 
	MOVLW       3
	MOVWF       _BuzzerCounter+0 
L_main16:
;GC V2.c,266 :: 		if(DisplayMode==0)
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
;GC V2.c,267 :: 		MenuHandler();
	CALL        _MenuHandler+0, 0
L_main17:
;GC V2.c,282 :: 		DoorSimulator();
	CALL        _DoorSimulator+0, 0
;GC V2.c,284 :: 		NetworkTask();
	CALL        _NetworkTask+0, 0
;GC V2.c,286 :: 		if(LCDBLCounter>0)LCDBL=1;
	MOVF        _LCDBLCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
	BSF         PORTA+0, 6 
L_main18:
;GC V2.c,289 :: 		}
	GOTO        L_main8
;GC V2.c,290 :: 		}
	GOTO        $+0
; end of _main

_ShowLCTime:

;GC V2.c,306 :: 		void ShowLCTime()
;GC V2.c,313 :: 		tm=(ms500-LCTime)/2;
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
;GC V2.c,314 :: 		if(tm!=PrevLCTime)
	MOVF        R4, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ShowLCTime149
	MOVF        R3, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ShowLCTime149
	MOVF        R2, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ShowLCTime149
	MOVF        R1, 0 
	XORWF       ShowLCTime_PrevLCTime_L0+0, 0 
L__ShowLCTime149:
	BTFSC       STATUS+0, 2 
	GOTO        L_ShowLCTime19
;GC V2.c,316 :: 		PrevLCTime=tm;
	MOVF        ShowLCTime_tm_L0+0, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+0 
	MOVF        ShowLCTime_tm_L0+1, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+1 
	MOVF        ShowLCTime_tm_L0+2, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+2 
	MOVF        ShowLCTime_tm_L0+3, 0 
	MOVWF       ShowLCTime_PrevLCTime_L0+3 
;GC V2.c,317 :: 		seconds=(tm%60);
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
;GC V2.c,318 :: 		tm=tm/60;
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
;GC V2.c,319 :: 		minutes=(tm%60);
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
;GC V2.c,320 :: 		hours=tm/60;
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
;GC V2.c,322 :: 		wordtostr(hours,txt+2);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       ShowLCTime_txt_L0+2
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+2)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;GC V2.c,323 :: 		bytetostr(minutes,txt+8);
	MOVF        ShowLCTime_minutes_L0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ShowLCTime_txt_L0+8
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+8)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;GC V2.c,324 :: 		bytetostr(seconds,txt+12);
	MOVF        ShowLCTime_seconds_L0+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       ShowLCTime_txt_L0+12
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+12)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;GC V2.c,325 :: 		memcpy(txt,"LC:",3);
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
;GC V2.c,326 :: 		memcpy(txt+7,"H ",2);
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
;GC V2.c,327 :: 		memcpy(txt+11,"M ",2);
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
;GC V2.c,328 :: 		memcpy(txt+15,"S ",2);
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
;GC V2.c,329 :: 		txt[16]=0;
	CLRF        ShowLCTime_txt_L0+16 
;GC V2.c,331 :: 		LCD_out(1,1,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ShowLCTime_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(ShowLCTime_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,332 :: 		}
L_ShowLCTime19:
;GC V2.c,338 :: 		}
	RETURN      0
; end of _ShowLCTime

_MenuHandler:

;GC V2.c,358 :: 		void MenuHandler()
;GC V2.c,360 :: 		switch(MenuState)
	GOTO        L_MenuHandler20
;GC V2.c,362 :: 		case 0:
L_MenuHandler22:
;GC V2.c,363 :: 		if(Keys & CENTER) {MenuState=1;MenuCounter=0;}
	BTFSS       _Keys+0, 0 
	GOTO        L_MenuHandler23
	MOVLW       1
	MOVWF       _MenuState+0 
	CLRF        _MenuCounter+0 
L_MenuHandler23:
;GC V2.c,364 :: 		ShowLCTime();
	CALL        _ShowLCTime+0, 0
;GC V2.c,365 :: 		break;
	GOTO        L_MenuHandler21
;GC V2.c,367 :: 		case 1:
L_MenuHandler24:
;GC V2.c,368 :: 		Menu1();
	CALL        _Menu1+0, 0
;GC V2.c,369 :: 		break;
	GOTO        L_MenuHandler21
;GC V2.c,371 :: 		case 2:
L_MenuHandler25:
;GC V2.c,372 :: 		Menu2();
	CALL        _Menu2+0, 0
;GC V2.c,373 :: 		break;
	GOTO        L_MenuHandler21
;GC V2.c,375 :: 		case 3:
L_MenuHandler26:
;GC V2.c,376 :: 		Menu3();
	CALL        _Menu3+0, 0
;GC V2.c,377 :: 		break;
	GOTO        L_MenuHandler21
;GC V2.c,378 :: 		}
L_MenuHandler20:
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler22
	MOVF        _MenuState+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler24
	MOVF        _MenuState+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler25
	MOVF        _MenuState+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_MenuHandler26
L_MenuHandler21:
;GC V2.c,379 :: 		}
	RETURN      0
; end of _MenuHandler

_UpdateMenuText:

;GC V2.c,390 :: 		void UpdateMenuText()
;GC V2.c,394 :: 		memcpy(txt,"                ",10);
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
;GC V2.c,395 :: 		LCD_cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;GC V2.c,396 :: 		switch(MenuCounter)
	GOTO        L_UpdateMenuText27
;GC V2.c,398 :: 		case 0:
L_UpdateMenuText29:
;GC V2.c,399 :: 		lcd_out(1,1,"1 Openning Time ");
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
;GC V2.c,400 :: 		charValueToStr(OpenningTime,txt);
	MOVF        _OpenningTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,401 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,402 :: 		break;
	GOTO        L_UpdateMenuText28
;GC V2.c,404 :: 		case 1:
L_UpdateMenuText30:
;GC V2.c,405 :: 		lcd_out(1,1,"2 Closing Time  ");
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
;GC V2.c,406 :: 		charValueToStr(ClosingTime,txt);
	MOVF        _ClosingTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,407 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,408 :: 		break;
	GOTO        L_UpdateMenuText28
;GC V2.c,410 :: 		case 2:
L_UpdateMenuText31:
;GC V2.c,411 :: 		lcd_out(1,1,"3 Invalid Time  ");
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
;GC V2.c,412 :: 		charValueToStr(InvalidTime,txt);
	MOVF        _InvalidTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,413 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,414 :: 		break;
	GOTO        L_UpdateMenuText28
;GC V2.c,416 :: 		case 3:
L_UpdateMenuText32:
;GC V2.c,417 :: 		lcd_out(1,1,"4 Autoclose Time");
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
;GC V2.c,418 :: 		charValueToStr(AutocloseTime,txt);
	MOVF        _AutocloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
;GC V2.c,419 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,420 :: 		break;
	GOTO        L_UpdateMenuText28
;GC V2.c,422 :: 		case 4:
L_UpdateMenuText33:
;GC V2.c,423 :: 		lcd_out(1,1,"5 Net Address   ");
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
;GC V2.c,424 :: 		byteToStr(NetworkAddress,txt);
	MOVF        _NetworkAddress+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;GC V2.c,425 :: 		lcd_out(2,5,txt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       UpdateMenuText_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(UpdateMenuText_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,426 :: 		break;
	GOTO        L_UpdateMenuText28
;GC V2.c,428 :: 		case 5:
L_UpdateMenuText34:
;GC V2.c,429 :: 		lcd_out(1,1,"6 Save Changes  ");
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
;GC V2.c,430 :: 		lcd_out(2,1,_Blank);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        __Blank+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        __Blank+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,431 :: 		break;
	GOTO        L_UpdateMenuText28
;GC V2.c,433 :: 		case 6:
L_UpdateMenuText35:
;GC V2.c,434 :: 		lcd_out(1,1,"7 Discard & Exit");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr15_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr15_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr15_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr15_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr15_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr15_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,435 :: 		lcd_out(2,1,_Blank);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        __Blank+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        __Blank+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,436 :: 		break;
	GOTO        L_UpdateMenuText28
;GC V2.c,437 :: 		}
L_UpdateMenuText27:
	MOVF        _MenuCounter+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText29
	MOVF        _MenuCounter+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText30
	MOVF        _MenuCounter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText31
	MOVF        _MenuCounter+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText32
	MOVF        _MenuCounter+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText33
	MOVF        _MenuCounter+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText34
	MOVF        _MenuCounter+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_UpdateMenuText35
L_UpdateMenuText28:
;GC V2.c,438 :: 		}
	RETURN      0
; end of _UpdateMenuText

_Menu1:

;GC V2.c,452 :: 		void Menu1()
;GC V2.c,454 :: 		UpdateMenuText();
	CALL        _UpdateMenuText+0, 0
;GC V2.c,455 :: 		MenuState=2;
	MOVLW       2
	MOVWF       _MenuState+0 
;GC V2.c,456 :: 		}
	RETURN      0
; end of _Menu1

_Menu2:

;GC V2.c,466 :: 		void Menu2()
;GC V2.c,470 :: 		LCDFlashFlag=0;
	CLRF        _LCDFlashFlag+0 
;GC V2.c,471 :: 		if(Keys & DOWN)
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu236
;GC V2.c,473 :: 		if(MenuCounter>0)
	MOVF        _MenuCounter+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu237
;GC V2.c,474 :: 		MenuCounter=MenuCounter-1;
	DECF        _MenuCounter+0, 1 
	GOTO        L_Menu238
L_Menu237:
;GC V2.c,476 :: 		MenuCounter=MenuLevel;
	MOVLW       6
	MOVWF       _MenuCounter+0 
L_Menu238:
;GC V2.c,477 :: 		MenuState=1;
	MOVLW       1
	MOVWF       _MenuState+0 
;GC V2.c,478 :: 		}
L_Menu236:
;GC V2.c,480 :: 		if(Keys & UP)
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu239
;GC V2.c,482 :: 		if(MenuCounter<MenuLevel)
	MOVLW       6
	SUBWF       _MenuCounter+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu240
;GC V2.c,483 :: 		MenuCounter=MenuCounter+1;
	INCF        _MenuCounter+0, 1 
	GOTO        L_Menu241
L_Menu240:
;GC V2.c,485 :: 		MenuCounter=0;
	CLRF        _MenuCounter+0 
L_Menu241:
;GC V2.c,486 :: 		MenuState=1;
	MOVLW       1
	MOVWF       _MenuState+0 
;GC V2.c,487 :: 		}
L_Menu239:
;GC V2.c,489 :: 		if(Keys & CENTER)
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu242
;GC V2.c,490 :: 		MenuState=3;
	MOVLW       3
	MOVWF       _MenuState+0 
L_Menu242:
;GC V2.c,491 :: 		}
	RETURN      0
; end of _Menu2

_Menu3:

;GC V2.c,500 :: 		void Menu3()
;GC V2.c,502 :: 		LCDFlashFlag=1;
	MOVLW       1
	MOVWF       _LCDFlashFlag+0 
;GC V2.c,503 :: 		switch(MenuCounter)
	GOTO        L_Menu343
;GC V2.c,505 :: 		case 0:
L_Menu345:
;GC V2.c,506 :: 		if(Keys & UP)     if(OpenningTime<255)  {OpenningTime=OpenningTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu346
	MOVLW       255
	SUBWF       _OpenningTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu347
	INCF        _OpenningTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu347:
L_Menu346:
;GC V2.c,507 :: 		if(Keys & DOWN)   if(OpenningTime>0)    {OpenningTime=OpenningTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu348
	MOVF        _OpenningTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu349
	DECF        _OpenningTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu349:
L_Menu348:
;GC V2.c,508 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu350
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu350:
;GC V2.c,509 :: 		break;
	GOTO        L_Menu344
;GC V2.c,511 :: 		case 1:
L_Menu351:
;GC V2.c,512 :: 		if(Keys & UP)     if(ClosingTime<255)  {ClosingTime=ClosingTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu352
	MOVLW       255
	SUBWF       _ClosingTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu353
	INCF        _ClosingTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu353:
L_Menu352:
;GC V2.c,513 :: 		if(Keys & DOWN)   if(ClosingTime>0)    {ClosingTime=ClosingTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu354
	MOVF        _ClosingTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu355
	DECF        _ClosingTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu355:
L_Menu354:
;GC V2.c,514 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu356
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu356:
;GC V2.c,515 :: 		break;
	GOTO        L_Menu344
;GC V2.c,517 :: 		case 2:
L_Menu357:
;GC V2.c,518 :: 		if(Keys & UP)     if(InvalidTime<255)  {InvalidTime=InvalidTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu358
	MOVLW       255
	SUBWF       _InvalidTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu359
	INCF        _InvalidTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu359:
L_Menu358:
;GC V2.c,519 :: 		if(Keys & DOWN)   if(InvalidTime>0)    {InvalidTime=InvalidTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu360
	MOVF        _InvalidTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu361
	DECF        _InvalidTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu361:
L_Menu360:
;GC V2.c,520 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu362
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu362:
;GC V2.c,521 :: 		break;
	GOTO        L_Menu344
;GC V2.c,523 :: 		case 3:
L_Menu363:
;GC V2.c,524 :: 		if(Keys & UP)     if(AutocloseTime<255)  {AutocloseTime=AutocloseTime+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu364
	MOVLW       255
	SUBWF       _AutocloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu365
	INCF        _AutocloseTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu365:
L_Menu364:
;GC V2.c,525 :: 		if(Keys & DOWN)   if(AutocloseTime>0)    {AutocloseTime=AutocloseTime-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu366
	MOVF        _AutocloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu367
	DECF        _AutocloseTime+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu367:
L_Menu366:
;GC V2.c,526 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu368
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu368:
;GC V2.c,527 :: 		break;
	GOTO        L_Menu344
;GC V2.c,529 :: 		case 4:
L_Menu369:
;GC V2.c,530 :: 		if(Keys & UP)     if(NetworkAddress<255)  {NetworkAddress=NetworkAddress+1;UpdateMenuText();}
	BTFSS       _Keys+0, 1 
	GOTO        L_Menu370
	MOVLW       255
	SUBWF       _NetworkAddress+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu371
	INCF        _NetworkAddress+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu371:
L_Menu370:
;GC V2.c,531 :: 		if(Keys & DOWN)   if(NetworkAddress>0)    {NetworkAddress=NetworkAddress-1;UpdateMenuText();}
	BTFSS       _Keys+0, 2 
	GOTO        L_Menu372
	MOVF        _NetworkAddress+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu373
	DECF        _NetworkAddress+0, 1 
	CALL        _UpdateMenuText+0, 0
L_Menu373:
L_Menu372:
;GC V2.c,532 :: 		if(Keys & CENTER) MenuState=1;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu374
	MOVLW       1
	MOVWF       _MenuState+0 
L_Menu374:
;GC V2.c,533 :: 		break;
	GOTO        L_Menu344
;GC V2.c,535 :: 		case 5:
L_Menu375:
;GC V2.c,536 :: 		if(Keys & CENTER) MenuState=0;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu376
	CLRF        _MenuState+0 
L_Menu376:
;GC V2.c,537 :: 		{LCDFlashFlag=0;SaveConfig();MenuState=0;}
	CLRF        _LCDFlashFlag+0 
	CALL        _SaveConfig+0, 0
	CLRF        _MenuState+0 
;GC V2.c,538 :: 		break;
	GOTO        L_Menu344
;GC V2.c,540 :: 		case 6:
L_Menu377:
;GC V2.c,541 :: 		if(Keys & CENTER) MenuState=0;
	BTFSS       _Keys+0, 0 
	GOTO        L_Menu378
	CLRF        _MenuState+0 
L_Menu378:
;GC V2.c,542 :: 		{LCDFlashFlag=0;LoadConfig();MenuState=0;}
	CLRF        _LCDFlashFlag+0 
	CALL        _LoadConfig+0, 0
	CLRF        _MenuState+0 
;GC V2.c,543 :: 		break;
	GOTO        L_Menu344
;GC V2.c,544 :: 		}
L_Menu343:
	MOVF        _MenuCounter+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu345
	MOVF        _MenuCounter+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu351
	MOVF        _MenuCounter+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu357
	MOVF        _MenuCounter+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu363
	MOVF        _MenuCounter+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu369
	MOVF        _MenuCounter+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu375
	MOVF        _MenuCounter+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_Menu377
L_Menu344:
;GC V2.c,548 :: 		}
	RETURN      0
; end of _Menu3

_charValueToStr:

;GC V2.c,563 :: 		void charValueToStr(char val, char * string)
;GC V2.c,565 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;GC V2.c,566 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr79
;GC V2.c,567 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr16_GC_32V2+0 
	MOVLW       53
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
	GOTO        L_charValueToStr80
L_charValueToStr79:
;GC V2.c,569 :: 		memcpy(string+3,".0s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr17_GC_32V2+0 
	MOVLW       48
	MOVWF       ?lstr17_GC_32V2+1 
	MOVLW       115
	MOVWF       ?lstr17_GC_32V2+2 
	CLRF        ?lstr17_GC_32V2+3 
	MOVLW       ?lstr17_GC_32V2+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr17_GC_32V2+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr80:
;GC V2.c,570 :: 		}
	RETURN      0
; end of _charValueToStr

_Sim0:

;GC V2.c,593 :: 		void Sim0() // Close
;GC V2.c,596 :: 		if(DoorActFlag)
	MOVF        _DoorActFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim081
;GC V2.c,598 :: 		SignalingSystem_AddSignal(&SigSys,OpenningTime,50); // OpenTime
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
;GC V2.c,599 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,600 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim084
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim084
L__Sim0139:
;GC V2.c,602 :: 		LCD_out(2,1,"    Openning    ");
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
;GC V2.c,603 :: 		}
L_Sim084:
;GC V2.c,604 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,605 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,606 :: 		}
L_Sim081:
;GC V2.c,607 :: 		}
	RETURN      0
; end of _Sim0

_Sim1:

;GC V2.c,622 :: 		void Sim1() // Openning
;GC V2.c,624 :: 		if(SignalingSystem_CheckSignal(&SigSys,50))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       50
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim185
;GC V2.c,626 :: 		DoorStatus=DOORSTATUS_Open;
	MOVLW       1
	MOVWF       _DoorStatus+0 
;GC V2.c,627 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim188
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim188
L__Sim1140:
;GC V2.c,629 :: 		LCD_out(2,1,"     Opened     ");
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
;GC V2.c,630 :: 		}
L_Sim188:
;GC V2.c,631 :: 		SimStatus=2;
	MOVLW       2
	MOVWF       _SimStatus+0 
;GC V2.c,632 :: 		SignalingSystem_AddSignal(&SigSys,AutocloseTime-InvalidTime,51);//AutoClose - Invalid
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
;GC V2.c,633 :: 		}
L_Sim185:
;GC V2.c,634 :: 		}
	RETURN      0
; end of _Sim1

_Sim2:

;GC V2.c,650 :: 		void Sim2() // Open
;GC V2.c,652 :: 		if(SignalingSystem_CheckSignal(&SigSys,51))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       51
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim289
;GC V2.c,654 :: 		DoorStatus=DOORSTATUS_Invalid;
	CLRF        _DoorStatus+0 
;GC V2.c,655 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim292
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim292
L__Sim2141:
;GC V2.c,657 :: 		LCD_out(2,1,"    Invalid     ");
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
;GC V2.c,658 :: 		}
L_Sim292:
;GC V2.c,659 :: 		SimStatus=3;
	MOVLW       3
	MOVWF       _SimStatus+0 
;GC V2.c,660 :: 		SignalingSystem_AddSignal(&SigSys,InvalidTime*2,52); // invalid time * 2
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
;GC V2.c,661 :: 		SimTime=ms500+InvalidTime;
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
;GC V2.c,662 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,663 :: 		}
L_Sim289:
;GC V2.c,664 :: 		}
	RETURN      0
; end of _Sim2

_Sim3:

;GC V2.c,687 :: 		void Sim3() // Invalid 1
;GC V2.c,689 :: 		if(SignalingSystem_CheckSignal(&SigSys,52))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       52
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim393
;GC V2.c,691 :: 		DoorStatus=DOORSTATUS_Closing;
	MOVLW       4
	MOVWF       _DoorStatus+0 
;GC V2.c,692 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim396
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim396
L__Sim3143:
;GC V2.c,694 :: 		LCD_out(2,1,"    Closing     ");
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
;GC V2.c,695 :: 		}
L_Sim396:
;GC V2.c,696 :: 		SimStatus=4;
	MOVLW       4
	MOVWF       _SimStatus+0 
;GC V2.c,697 :: 		SignalingSystem_AddSignal(&SigSys,ClosingTime-(InvalidTime*2),53); // closing time - invalid time * 2
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
;GC V2.c,698 :: 		}
L_Sim393:
;GC V2.c,700 :: 		if(!IRin)
	BTFSC       PORTC+0, 0 
	GOTO        L_Sim397
;GC V2.c,702 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,703 :: 		SignalingSystem_ClearSignal(&SigSys,52);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       52
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,704 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,705 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim3100
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim3100
L__Sim3142:
;GC V2.c,707 :: 		LCD_out(2,1,"    Openning    ");
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
;GC V2.c,708 :: 		}
L_Sim3100:
;GC V2.c,709 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,710 :: 		SignalingSystem_AddSignal(&SigSys,InvalidTime,50);
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
;GC V2.c,711 :: 		}
L_Sim397:
;GC V2.c,712 :: 		}
	RETURN      0
; end of _Sim3

_Sim4:

;GC V2.c,733 :: 		void Sim4() // Closing
;GC V2.c,735 :: 		if(SignalingSystem_CheckSignal(&SigSys,53))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim4101
;GC V2.c,737 :: 		DoorStatus=DOORSTATUS_Invalid;
	CLRF        _DoorStatus+0 
;GC V2.c,738 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4104
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4104
L__Sim4146:
;GC V2.c,740 :: 		LCD_out(2,1,"    Invalid     ");
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
;GC V2.c,741 :: 		}
L_Sim4104:
;GC V2.c,742 :: 		SimStatus=5;
	MOVLW       5
	MOVWF       _SimStatus+0 
;GC V2.c,743 :: 		SignalingSystem_AddSignal(&SigSys,(InvalidTime*2),54); // invalid time * 2
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
;GC V2.c,744 :: 		}
L_Sim4101:
;GC V2.c,746 :: 		if(!IRin)
	BTFSC       PORTC+0, 0 
	GOTO        L_Sim4105
;GC V2.c,748 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,749 :: 		SignalingSystem_ClearSignal(&SigSys,54);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,750 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,751 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4108
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4108
L__Sim4145:
;GC V2.c,753 :: 		LCD_out(2,1,"    Openning    ");
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
;GC V2.c,754 :: 		}
L_Sim4108:
;GC V2.c,755 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,756 :: 		SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
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
;GC V2.c,757 :: 		}
L_Sim4105:
;GC V2.c,759 :: 		if(DoorActFlag)
	MOVF        _DoorActFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim4109
;GC V2.c,761 :: 		SignalingSystem_ClearSignal(&SigSys,53);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       53
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,762 :: 		SignalingSystem_ClearSignal(&SigSys,54);
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_ClearSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_ClearSignal+0 
	CALL        _SignalingSystem_ClearSignal+0, 0
;GC V2.c,763 :: 		DoorStatus=DOORSTATUS_Openning;
	MOVLW       3
	MOVWF       _DoorStatus+0 
;GC V2.c,764 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4112
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim4112
L__Sim4144:
;GC V2.c,766 :: 		LCD_out(2,1,"    Openning    ");
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
;GC V2.c,767 :: 		}
L_Sim4112:
;GC V2.c,768 :: 		SimStatus=1;
	MOVLW       1
	MOVWF       _SimStatus+0 
;GC V2.c,769 :: 		SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
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
;GC V2.c,770 :: 		DoorActFlag=0;
	CLRF        _DoorActFlag+0 
;GC V2.c,771 :: 		}
L_Sim4109:
;GC V2.c,772 :: 		}
	RETURN      0
; end of _Sim4

_Sim5:

;GC V2.c,789 :: 		void Sim5() // Invalid 2
;GC V2.c,791 :: 		if(SignalingSystem_CheckSignal(&SigSys,54))
	MOVLW       _SigSys+0
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	MOVLW       hi_addr(_SigSys+0)
	MOVWF       FARG_SignalingSystem_CheckSignal+1 
	MOVLW       54
	MOVWF       FARG_SignalingSystem_CheckSignal+0 
	CALL        _SignalingSystem_CheckSignal+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Sim5113
;GC V2.c,793 :: 		DoorStatus=DOORSTATUS_Close;
	MOVLW       2
	MOVWF       _DoorStatus+0 
;GC V2.c,794 :: 		if((DisplayMode==0) && (MenuState==0))
	MOVF        _DisplayMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim5116
	MOVF        _MenuState+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Sim5116
L__Sim5147:
;GC V2.c,796 :: 		LCD_out(2,1,"     Closed     ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr26_GC_32V2+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr26_GC_32V2+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr26_GC_32V2+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr26_GC_32V2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr26_GC_32V2+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr26_GC_32V2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr26_GC_32V2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;GC V2.c,797 :: 		}
L_Sim5116:
;GC V2.c,798 :: 		SimStatus=0;
	CLRF        _SimStatus+0 
;GC V2.c,799 :: 		}
L_Sim5113:
;GC V2.c,800 :: 		}
	RETURN      0
; end of _Sim5

_DoorSimulator:

;GC V2.c,819 :: 		void DoorSimulator()
;GC V2.c,821 :: 		switch(SimStatus)
	GOTO        L_DoorSimulator117
;GC V2.c,823 :: 		case 0:
L_DoorSimulator119:
;GC V2.c,824 :: 		Sim0();
	CALL        _Sim0+0, 0
;GC V2.c,825 :: 		break;
	GOTO        L_DoorSimulator118
;GC V2.c,827 :: 		case 1:
L_DoorSimulator120:
;GC V2.c,828 :: 		Sim1();
	CALL        _Sim1+0, 0
;GC V2.c,829 :: 		break;
	GOTO        L_DoorSimulator118
;GC V2.c,831 :: 		case 2:
L_DoorSimulator121:
;GC V2.c,832 :: 		Sim2();
	CALL        _Sim2+0, 0
;GC V2.c,833 :: 		break;
	GOTO        L_DoorSimulator118
;GC V2.c,835 :: 		case 3:
L_DoorSimulator122:
;GC V2.c,836 :: 		Sim3();
	CALL        _Sim3+0, 0
;GC V2.c,837 :: 		break;
	GOTO        L_DoorSimulator118
;GC V2.c,839 :: 		case 4:
L_DoorSimulator123:
;GC V2.c,840 :: 		Sim4();
	CALL        _Sim4+0, 0
;GC V2.c,841 :: 		break;
	GOTO        L_DoorSimulator118
;GC V2.c,843 :: 		case 5:
L_DoorSimulator124:
;GC V2.c,844 :: 		Sim5();
	CALL        _Sim5+0, 0
;GC V2.c,845 :: 		break;
	GOTO        L_DoorSimulator118
;GC V2.c,846 :: 		}
L_DoorSimulator117:
	MOVF        _SimStatus+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator119
	MOVF        _SimStatus+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator120
	MOVF        _SimStatus+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator121
	MOVF        _SimStatus+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator122
	MOVF        _SimStatus+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator123
	MOVF        _SimStatus+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_DoorSimulator124
L_DoorSimulator118:
;GC V2.c,847 :: 		}
	RETURN      0
; end of _DoorSimulator

_SaveConfig:

;GC V2.c,860 :: 		void SaveConfig()
;GC V2.c,862 :: 		eeprom_write(0,OpenningTime);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVF        _OpenningTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,863 :: 		eeprom_write(1,ClosingTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _ClosingTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,864 :: 		eeprom_write(2,InvalidTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _InvalidTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,865 :: 		eeprom_write(3,AutocloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _AutocloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,866 :: 		eeprom_write(4,NetworkAddress);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _NetworkAddress+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;GC V2.c,867 :: 		RS485Slave_Init(NetworkAddress);
	MOVF        _NetworkAddress+0, 0 
	MOVWF       FARG_RS485Slave_Init_slave_address+0 
	CALL        _RS485Slave_Init+0, 0
;GC V2.c,868 :: 		}
	RETURN      0
; end of _SaveConfig

_LoadConfig:

;GC V2.c,878 :: 		void LoadConfig()
;GC V2.c,880 :: 		OpenningTime=eeprom_read(0);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenningTime+0 
;GC V2.c,881 :: 		ClosingTime=eeprom_read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ClosingTime+0 
;GC V2.c,882 :: 		InvalidTime=eeprom_read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _InvalidTime+0 
;GC V2.c,883 :: 		AutocloseTime=eeprom_read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutocloseTime+0 
;GC V2.c,884 :: 		NetworkAddress=eeprom_read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _NetworkAddress+0 
;GC V2.c,885 :: 		}
	RETURN      0
; end of _LoadConfig

_FlashLCD:

;GC V2.c,898 :: 		void FlashLCD()
;GC V2.c,902 :: 		if(LCDFlashFlag)
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FlashLCD125
;GC V2.c,904 :: 		PrevLCDFlashState=LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 0 
	MOVWF       FlashLCD_PrevLCDFlashState_L0+0 
;GC V2.c,905 :: 		if(LCDFlashState)
	MOVF        _LCDFlashState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FlashLCD126
;GC V2.c,907 :: 		LCD_chr(2,1,'>');LCD_chr(2,2,'>');LCD_chr(2,3,'>');
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
;GC V2.c,908 :: 		LCD_chr(2,16,'<');LCD_chr(2,15,'<');LCD_chr(2,14,'<');
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
;GC V2.c,909 :: 		}
	GOTO        L_FlashLCD127
L_FlashLCD126:
;GC V2.c,912 :: 		LCD_chr(2,1,' ');LCD_chr(2,2,' ');LCD_chr(2,3,' ');
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
;GC V2.c,913 :: 		LCD_chr(2,16,' ');LCD_chr(2,15,' ');LCD_chr(2,14,' ');
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
;GC V2.c,914 :: 		}
L_FlashLCD127:
;GC V2.c,915 :: 		}
	GOTO        L_FlashLCD128
L_FlashLCD125:
;GC V2.c,918 :: 		if(PrevLCDFlashState)
	MOVF        FlashLCD_PrevLCDFlashState_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_FlashLCD129
;GC V2.c,920 :: 		LCD_chr(2,1,' ');LCD_chr(2,2,' ');LCD_chr(2,3,' ');
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
;GC V2.c,921 :: 		LCD_chr(2,16,' ');LCD_chr(2,15,' ');LCD_chr(2,14,' ');
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
;GC V2.c,922 :: 		}
L_FlashLCD129:
;GC V2.c,923 :: 		PrevLCDFlashState=LCDFlashState;
	MOVF        _LCDFlashState+0, 0 
	MOVWF       FlashLCD_PrevLCDFlashState_L0+0 
;GC V2.c,924 :: 		}
L_FlashLCD128:
;GC V2.c,925 :: 		}
	RETURN      0
; end of _FlashLCD

_NetworkTask:

;GC V2.c,933 :: 		void NetworkTask()
;GC V2.c,935 :: 		if (NetBuffer[4]) {                    // upon completed valid message receive
	MOVF        _NetBuffer+4, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_NetworkTask130
;GC V2.c,936 :: 		NetBuffer[4] = 0;                    //   data[4] is set to 0xFF
	CLRF        _NetBuffer+4 
;GC V2.c,937 :: 		switch(NetBuffer[0])
	GOTO        L_NetworkTask131
;GC V2.c,939 :: 		case 1:
L_NetworkTask133:
;GC V2.c,940 :: 		LCTime=ms500;
	MOVF        _ms500+0, 0 
	MOVWF       _LCTime+0 
	MOVF        _ms500+1, 0 
	MOVWF       _LCTime+1 
	MOVF        _ms500+2, 0 
	MOVWF       _LCTime+2 
	MOVF        _ms500+3, 0 
	MOVWF       _LCTime+3 
;GC V2.c,941 :: 		OpenCommand=1;
	MOVLW       1
	MOVWF       _OpenCommand+0 
;GC V2.c,942 :: 		NetBuffer[0]=200;
	MOVLW       200
	MOVWF       _NetBuffer+0 
;GC V2.c,943 :: 		Delay_ms(1);
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       98
	MOVWF       R13, 0
L_NetworkTask134:
	DECFSZ      R13, 1, 0
	BRA         L_NetworkTask134
	DECFSZ      R12, 1, 0
	BRA         L_NetworkTask134
	NOP
;GC V2.c,944 :: 		RS485Slave_Send(NetBuffer,1);
	MOVLW       _NetBuffer+0
	MOVWF       FARG_RS485Slave_Send_data_buffer+0 
	MOVLW       hi_addr(_NetBuffer+0)
	MOVWF       FARG_RS485Slave_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Slave_Send_datalen+0 
	CALL        _RS485Slave_Send+0, 0
;GC V2.c,945 :: 		LED=1;
	BSF         PORTE+0, 0 
;GC V2.c,946 :: 		break;
	GOTO        L_NetworkTask132
;GC V2.c,948 :: 		case 2:
L_NetworkTask135:
;GC V2.c,949 :: 		NetBuffer[0]=200;
	MOVLW       200
	MOVWF       _NetBuffer+0 
;GC V2.c,950 :: 		Delay_ms(1);
	MOVLW       11
	MOVWF       R12, 0
	MOVLW       98
	MOVWF       R13, 0
L_NetworkTask136:
	DECFSZ      R13, 1, 0
	BRA         L_NetworkTask136
	DECFSZ      R12, 1, 0
	BRA         L_NetworkTask136
	NOP
;GC V2.c,951 :: 		RS485Slave_Send(NetBuffer,1);
	MOVLW       _NetBuffer+0
	MOVWF       FARG_RS485Slave_Send_data_buffer+0 
	MOVLW       hi_addr(_NetBuffer+0)
	MOVWF       FARG_RS485Slave_Send_data_buffer+1 
	MOVLW       1
	MOVWF       FARG_RS485Slave_Send_datalen+0 
	CALL        _RS485Slave_Send+0, 0
;GC V2.c,952 :: 		break;
	GOTO        L_NetworkTask132
;GC V2.c,953 :: 		}
L_NetworkTask131:
	MOVF        _NetBuffer+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_NetworkTask133
	MOVF        _NetBuffer+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_NetworkTask135
L_NetworkTask132:
;GC V2.c,954 :: 		}
L_NetworkTask130:
;GC V2.c,956 :: 		}
	RETURN      0
; end of _NetworkTask
