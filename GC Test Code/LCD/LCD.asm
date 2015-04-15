
_LCDSystem_Task:

;LCD.c,6 :: 		void LCDSystem_Task(LCDSystem *sys)
;LCD.c,40 :: 		if(sys->LCDUpdateFlag==1)
	MOVLW       32
	ADDWF       FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDSystem_Task0
;LCD.c,42 :: 		lcd_out(1,0,sys->Line1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVF        FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;LCD.c,43 :: 		if(!sys->LCDFlashFlag)
	MOVLW       33
	ADDWF       FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDSystem_Task1
;LCD.c,44 :: 		lcd_out(2,0,sys->Line2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       16
	ADDWF       FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_LCDSystem_Task1:
;LCD.c,45 :: 		sys->LCDUpdateFlag=0;
	MOVLW       32
	ADDWF       FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;LCD.c,46 :: 		}
L_LCDSystem_Task0:
;LCD.c,48 :: 		if(sys->LCDFlashFlag)
	MOVLW       33
	ADDWF       FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDSystem_Task2
;LCD.c,50 :: 		if((LCDFlashEPOCHFlag)&&(LastLCDFlashState==0))
	MOVF        _LCDFlashEPOCHFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDSystem_Task5
	MOVF        LCDSystem_Task_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDSystem_Task5
L__LCDSystem_Task10:
;LCD.c,51 :: 		{memcpy(LCDLineTemp,sys->Line2,16);LCDLineTemp[0]='>';LCDLineTemp[1]='>';LCDLineTemp[2]='>';LCDLineTemp[13]='<';LCDLineTemp[14]='<';LCDLineTemp[15]='<';lcd_out(2,0,LCDLineTemp);LastLCDFlashState=1;}
	MOVLW       LCDSystem_Task_LCDLineTemp_L0+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(LCDSystem_Task_LCDLineTemp_L0+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       16
	ADDWF       FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       62
	MOVWF       LCDSystem_Task_LCDLineTemp_L0+0 
	MOVLW       62
	MOVWF       LCDSystem_Task_LCDLineTemp_L0+1 
	MOVLW       62
	MOVWF       LCDSystem_Task_LCDLineTemp_L0+2 
	MOVLW       60
	MOVWF       LCDSystem_Task_LCDLineTemp_L0+13 
	MOVLW       60
	MOVWF       LCDSystem_Task_LCDLineTemp_L0+14 
	MOVLW       60
	MOVWF       LCDSystem_Task_LCDLineTemp_L0+15 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       LCDSystem_Task_LCDLineTemp_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(LCDSystem_Task_LCDLineTemp_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	MOVLW       1
	MOVWF       LCDSystem_Task_LastLCDFlashState_L0+0 
L_LCDSystem_Task5:
;LCD.c,52 :: 		if((!LCDFlashEPOCHFlag)&&(LastLCDFlashState!=0))
	MOVF        _LCDFlashEPOCHFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDSystem_Task8
	MOVF        LCDSystem_Task_LastLCDFlashState_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDSystem_Task8
L__LCDSystem_Task9:
;LCD.c,53 :: 		{lcd_out(2,0,sys->Line2);LastLCDFlashState=0;}
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       16
	ADDWF       FARG_LCDSystem_Task_sys+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Task_sys+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	CLRF        LCDSystem_Task_LastLCDFlashState_L0+0 
L_LCDSystem_Task8:
;LCD.c,54 :: 		}
L_LCDSystem_Task2:
;LCD.c,57 :: 		}
L_end_LCDSystem_Task:
	RETURN      0
; end of _LCDSystem_Task

_LCDSystem_FlasherEPOCH:

;LCD.c,62 :: 		void LCDSystem_FlasherEPOCH()
;LCD.c,64 :: 		LCDFlashEPOCHFlag=!LCDFlashEPOCHFlag;
	MOVF        _LCDFlashEPOCHFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashEPOCHFlag+0 
;LCD.c,65 :: 		}
L_end_LCDSystem_FlasherEPOCH:
	RETURN      0
; end of _LCDSystem_FlasherEPOCH

_LCDSystem_Init:

;LCD.c,72 :: 		void LCDSystem_Init(LCDSystem *sys)
;LCD.c,74 :: 		LCDFlashEPOCHFlag=0;
	CLRF        _LCDFlashEPOCHFlag+0 
;LCD.c,75 :: 		sys->LCDUpdateFlag=0;
	MOVLW       32
	ADDWF       FARG_LCDSystem_Init_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Init_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;LCD.c,76 :: 		sys->LCDFlashFlag=0;
	MOVLW       33
	ADDWF       FARG_LCDSystem_Init_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Init_sys+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;LCD.c,77 :: 		sys->LCDLine=2;
	MOVLW       34
	ADDWF       FARG_LCDSystem_Init_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Init_sys+1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	MOVWF       POSTINC1+0 
;LCD.c,78 :: 		}
L_end_LCDSystem_Init:
	RETURN      0
; end of _LCDSystem_Init

_LCDSystem_Update:

;LCD.c,84 :: 		void LCDSystem_Update(LCDSystem *sys)
;LCD.c,86 :: 		sys->LCDUpdateFlag=1;
	MOVLW       32
	ADDWF       FARG_LCDSystem_Update_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_Update_sys+1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;LCD.c,87 :: 		}
L_end_LCDSystem_Update:
	RETURN      0
; end of _LCDSystem_Update

_LCDSystem_SetFlasher:

;LCD.c,92 :: 		void LCDSystem_SetFlasher(LCDSystem *sys,char flash)
;LCD.c,94 :: 		sys->LCDFlashFlag=flash;
	MOVLW       33
	ADDWF       FARG_LCDSystem_SetFlasher_sys+0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      FARG_LCDSystem_SetFlasher_sys+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_LCDSystem_SetFlasher_flash+0, 0 
	MOVWF       POSTINC1+0 
;LCD.c,95 :: 		}
L_end_LCDSystem_SetFlasher:
	RETURN      0
; end of _LCDSystem_SetFlasher
