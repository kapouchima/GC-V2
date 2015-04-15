#include "LCD.h"

char LCDFlashEPOCHFlag;


void LCDSystem_Task(LCDSystem *sys)
{
 static char line,LastLCDFlashState;
 char LCDLineTemp[16];

 #ifdef COGDisplay

 if(sys->LCDUpdateFlag==1)
 {
  if(sys->LCDLine!=line)
  {
    line=sys->LCDLine;
    LCD_init(sys->LCDLine);
    delay_ms(50);
  }
  lcd_out(1,0,sys->Line1);
  if(!sys->LCDFlashFlag)
    lcd_out(2,0,sys->Line2);
  sys->LCDUpdateFlag=0;
 }

 if(sys->LCDFlashFlag)
   {
       if((LCDFlashEPOCHFlag)&&(LastLCDFlashState==0))
         {memcpy(LCDLineTemp,sys->Line2,16);LCDLineTemp[0]='>';LCDLineTemp[1]='>';LCDLineTemp[2]='>';LCDLineTemp[13]='<';LCDLineTemp[14]='<';LCDLineTemp[15]='<';lcd_out(2,0,LCDLineTemp);LastLCDFlashState=1;}
       if((!LCDFlashEPOCHFlag)&&(LastLCDFlashState!=0))
         {lcd_out(2,0,sys->Line2);LastLCDFlashState=0;}
   }
   
 #endif
 
 
 #ifdef GeneralDisplay

 if(sys->LCDUpdateFlag==1)
 {
  lcd_out(1,0,sys->Line1);
  if(!sys->LCDFlashFlag)
    lcd_out(2,0,sys->Line2);
  sys->LCDUpdateFlag=0;
 }

 if(sys->LCDFlashFlag)
   {
       if((LCDFlashEPOCHFlag)&&(LastLCDFlashState==0))
         {memcpy(LCDLineTemp,sys->Line2,16);LCDLineTemp[0]='>';LCDLineTemp[1]='>';LCDLineTemp[2]='>';LCDLineTemp[13]='<';LCDLineTemp[14]='<';LCDLineTemp[15]='<';lcd_out(2,0,LCDLineTemp);LastLCDFlashState=1;}
       if((!LCDFlashEPOCHFlag)&&(LastLCDFlashState!=0))
         {lcd_out(2,0,sys->Line2);LastLCDFlashState=0;}
   }

 #endif
}




void LCDSystem_FlasherEPOCH()
{
  LCDFlashEPOCHFlag=!LCDFlashEPOCHFlag;
}






void LCDSystem_Init(LCDSystem *sys)
{
  LCDFlashEPOCHFlag=0;
  sys->LCDUpdateFlag=0;
  sys->LCDFlashFlag=0;
  sys->LCDLine=2;
}





void LCDSystem_Update(LCDSystem *sys)
{
  sys->LCDUpdateFlag=1;
}




void LCDSystem_SetFlasher(LCDSystem *sys,char flash)
{
  sys->LCDFlashFlag=flash;
}


