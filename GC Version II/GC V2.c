#include "Signaling/Signaling.h"
#include "Keys/Keys.h"

#define Buzzer (portc.b5)
#define Dip4 (!porta.b1)
#define Dip3 (!porta.b2)
#define Dip2 (!porta.b3)
#define Dip1 (!porta.b5)
#define LCDBL (porta.b6)
#define sw2 (porta.b7)
#define Relay4 (portd.b0)
#define Relay3 (portd.b1)
#define Relay2 (portd.b2)
#define Relay1 (portd.b3)
#define sw3 (portd.b4)
#define sw1 (portd.b5)
#define IRin (portc.b0)
#define RTEn1 (portc.b1)
#define RTEn2 (portc.b2)
#define LED (porte.b0)


#define CENTER (0b001)
#define UP (0b010)
#define DOWN (0b100)






// Lcd pinout settings
sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB4_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB5_bit;
sbit LCD_EN_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;



// RS485 module pinout
sbit RS485_rxtx_pin at RC1_bit;  // transmit/receive control set to PORTC.B1

// Pin direction
sbit RS485_rxtx_pin_direction at TRISC1_bit;   // RxTx pin direction set as output



enum
{
  DOORSTATUS_Invalid,
  DOORSTATUS_Open,
  DOORSTATUS_Close,
  DOORSTATUS_Openning,
  DOORSTATUS_Closing,
  DOORSTATUS_StopedOpenning,
  DOORSTATUS_StopedClosing
}DoorStatus;


//Global Variables
char text[16];
char Flag20ms=0,Flag500ms=0,Counterms500=0,SimStatus=0,PrevSimStatus=0,DoorActFlag=0,LCDBLCounter=10;
char MenuState=0,MenuCounter=0,Keys=0,DisplayMode=0,BuzzerCounter=5,LCDFlashFlag=0,LCDFlashState=0,OpenCommand=0;
char NetBuffer[10];
unsigned long ms500=0,SimTime=0,LCTime=0;

//-----Configs
char OpenningTime=10,ClosingTime=10,InvalidTime=1,AutocloseTime=20,NetworkAddress=0;


SignalingSystem SigSys;
//LCDSystem LCD;

//-------Texts
char * _Blank="                ";





void DoorSimulator();
void Sim0();
void Sim1();
void Sim2();
void Sim3();
void Sim4();
void Sim5();
void Init();
void charValueToStr(char, char *);
void MenuHandler();
void Menu1();
void Menu2();
void Menu3();
void SaveConfig();
void LoadConfig();
void FlashLCD();
void NetworkTask();








void Init()
{
  //-------Oscillator Configuration
  OSCCON=0b01100000;
  OSCTUNE.PLLEN=1;
  //-------AD Configuration
  ANCON0=0;
  ANCON1=0;
  //-------Port Configuration
  porta=0;
  portb=0;
  portc=0;
  portd=0;
  porte=0;
  trisa=0b10111111;
  trisb=0b11000000;
  trisc=0b10000001;
  trisd=0b10110000;
  trise=0b1110;
  
  //------TMR0
  T0CON=0b10000001; //prescaler 4
  TMR0H=0x63;
  TMR0L=0xBF;
  INTCON.b7=1;
  INTCON.T0IE=1;
  
  //------LCD Init
  LCD_Init();
  //LCDSystem_Init(&LCD);
  LCD_cmd(_LCD_CURSOR_OFF);
  delay_ms(500);
  LCDBL=1;
  
  //-------UART
  UART1_Init(9600);
  UART2_Init(9600);
  RC1IF_bit=0;
  RC1IE_bit=1;
  RC1IP_bit=1;
  UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle);
  
  //-------Signaling System
  SignalingSystem_Init(&SigSys);
  
  //-------Door Status
  DoorStatus=DOORSTATUS_Close;
  
  //-------LoadConfigs
  LoadConfig();
  
  //-------RS485
  RS485Slave_Init(NetworkAddress);
}













void interrupt()
{
  if((TMR0IF_bit)&&(TMR0IE_bit))
  {
    Flag20ms=1;
    Counterms500=Counterms500+1;
    if(Counterms500>=25)
      {Flag500ms=1;Counterms500=0;}
    TMR0H=0x63;
    TMR0L=0xBF;
    TMR0IF_bit=0;
  }
  
  if((RC1IE_bit)&&(RC1IF_bit))
  {
    RS485Slave_Receive(NetBuffer);
  }
}












void main() {

char dat;

Init();

LCD_out(1,1,"     Start!     ");
LCD_out(2,1,"                ");


while(1)
{

  if(Flag20ms)
  {
    KeysSystem_EPOCH();
    
    if(BuzzerCounter>0)
      {BuzzerCounter=BuzzerCounter-1;/*Buzzer=1;*/}
    else
      Buzzer=0;
    
    Flag20ms=0;
  }
  
  if(Flag500ms)
  {
    if(LCDBLCounter>0)
      LCDBLCounter=LCDBLCounter-1;
    else
      LCDBL=0;
    LCDFlashState=!LCDFlashState;
    FlashLCD();
    ms500=ms500+1;
    SignalingSystem_SystemEPOCH(&SigSys);
    SignalingSystem_Task(&SigSys);
    Flag500ms=0;
  }


  Keys=KeysSystem_Task();
  if(Keys!=0) {LCDBLCounter=10;BuzzerCounter=3;}
  
  if(DisplayMode==0)
    MenuHandler();


  
  /*if((Dip1)&&(!Relay1))
  {
    Relay1=1;
    SignalingSystem_AddSignal(&SigSys,4,1);
    DoorActFlag=1;
  }


  if(SignalingSystem_CheckSignal(&SigSys,1))
    Relay1=0;*/
    
  DoorSimulator();
  
  NetworkTask();
  
  if(LCDBLCounter>0)LCDBL=1;


}
}















void ShowLCTime()
{
  static unsigned long PrevLCTime;
  unsigned long tm;
  unsigned hours;
  char minutes,seconds;
  char txt[17];
  tm=(ms500-LCTime)/2;
  if(tm!=PrevLCTime)
  {
    PrevLCTime=tm;
    seconds=(tm%60);
    tm=tm/60;
    minutes=(tm%60);
    hours=tm/60;

    wordtostr(hours,txt+2);
    bytetostr(minutes,txt+8);
    bytetostr(seconds,txt+12);
    memcpy(txt,"LC:",3);
    memcpy(txt+7,"H ",2);
    memcpy(txt+11,"M ",2);
    memcpy(txt+15,"S ",2);
    txt[16]=0;

    LCD_out(1,1,txt);
  }
  
  
  
  
  
}



















void MenuHandler()
{
  switch(MenuState)
  {
    case 0:
      if(Keys & CENTER) MenuState=1;
      ShowLCTime();
      break;

    case 1:
      Menu1();
      break;
    
    case 2:
      Menu2();
      break;
    
    case 3:
      Menu3();
      break;
  }
}










void UpdateMenuText()
{
char txt[10];

   memcpy(txt,"                ",10);
   switch(MenuCounter)
   {
     case 0:
       lcd_out(1,1,"1 Openning Time ");
       charValueToStr(OpenningTime,txt);
       lcd_out(2,5,txt);
       break;

     case 1:
       lcd_out(1,1,"2 Closing Time  ");
       charValueToStr(ClosingTime,txt);
       lcd_out(2,5,txt);
       break;

     case 2:
       lcd_out(1,1,"3 Invalid Time  ");
       charValueToStr(InvalidTime,txt);
       lcd_out(2,5,txt);
       break;

     case 3:
       lcd_out(1,1,"4 Autoclose Time");
       charValueToStr(AutocloseTime,txt);
       lcd_out(2,5,txt);
       break;
       
     case 4:
       lcd_out(1,1,"5 Net Address  ");
       byteToStr(NetworkAddress,txt);
       lcd_out(2,5,txt);
       break;

     case 5:
       lcd_out(1,1,"6 Save Changes  ");
       lcd_out(2,1,_Blank);
       break;

     case 6:
       lcd_out(1,1,"7 Discard & Exit");
       lcd_out(2,1,_Blank);
       break;
   }
}













void Menu1()
{
   UpdateMenuText();
   MenuState=2;
}









void Menu2()
{
  LCDFlashFlag=0;
  if(Keys & DOWN)
    if(MenuCounter>0)
      {MenuCounter=MenuCounter-1;MenuState=1;}
      
  if(Keys & UP)
    if(MenuCounter<5)
      {MenuCounter=MenuCounter+1;MenuState=1;}
      
  if(Keys & CENTER)
    MenuState=3;
}








void Menu3()
{
  LCDFlashFlag=1;
  switch(MenuCounter)
  {
    case 0:
      if(Keys & UP)     if(OpenningTime<255)  {OpenningTime=OpenningTime+1;UpdateMenuText();}
      if(Keys & DOWN)   if(OpenningTime>0)    {OpenningTime=OpenningTime-1;UpdateMenuText();}
      if(Keys & CENTER) MenuState=1;
      break;
      
    case 1:
      if(Keys & UP)     if(ClosingTime<255)  {ClosingTime=ClosingTime+1;UpdateMenuText();}
      if(Keys & DOWN)   if(ClosingTime>0)    {ClosingTime=ClosingTime-1;UpdateMenuText();}
      if(Keys & CENTER) MenuState=1;
      break;
      
    case 2:
      if(Keys & UP)     if(InvalidTime<255)  {InvalidTime=InvalidTime+1;UpdateMenuText();}
      if(Keys & DOWN)   if(InvalidTime>0)    {InvalidTime=InvalidTime-1;UpdateMenuText();}
      if(Keys & CENTER) MenuState=1;
      break;
      
    case 3:
      if(Keys & UP)     if(AutocloseTime<255)  {AutocloseTime=AutocloseTime+1;UpdateMenuText();}
      if(Keys & DOWN)   if(AutocloseTime>0)    {AutocloseTime=AutocloseTime-1;UpdateMenuText();}
      if(Keys & CENTER) MenuState=1;
      break;
      
    case 4:
      if(Keys & UP)     if(NetworkAddress<255)  {NetworkAddress=NetworkAddress+1;UpdateMenuText();}
      if(Keys & DOWN)   if(NetworkAddress>0)    {NetworkAddress=NetworkAddress-1;UpdateMenuText();}
      if(Keys & CENTER) MenuState=1;
      break;
      
    case 5:
      if(Keys & CENTER) MenuState=0;
        {LCDFlashFlag=0;SaveConfig();MenuState=0;}
      break;
      
    case 6:
      if(Keys & CENTER) MenuState=0;
        {LCDFlashFlag=0;LoadConfig();MenuState=0;}
      break;
  }
  


}














void charValueToStr(char val, char * string)
{
  bytetostr(val>>1,string);
  if((val%2)==1)
    memcpy(string+3,".5s",4);
  else
    memcpy(string+3,".0s",4);
}






















void Sim0() // Close
{

  if(DoorActFlag)
  {
    SignalingSystem_AddSignal(&SigSys,OpenningTime,50); // OpenTime
    DoorStatus=DOORSTATUS_Openning;
    if((DisplayMode==0) && (MenuState==0))
    {
      LCD_out(2,1,"    Openning    ");
    }
    SimStatus=1;
    DoorActFlag=0;
  }
}














void Sim1() // Openning
{
  if(SignalingSystem_CheckSignal(&SigSys,50))
  {
    DoorStatus=DOORSTATUS_Open;
    if((DisplayMode==0) && (MenuState==0))
    {
      LCD_out(2,1,"     Opened     ");
    }
    SimStatus=2;
    SignalingSystem_AddSignal(&SigSys,AutocloseTime-InvalidTime,51);//AutoClose - Invalid
  }
}















void Sim2() // Open
{
     if(SignalingSystem_CheckSignal(&SigSys,51))
     {
       DoorStatus=DOORSTATUS_Invalid;
       if((DisplayMode==0) && (MenuState==0))
       {
         LCD_out(2,1,"    Invalid     ");
       }
       SimStatus=3;
       SignalingSystem_AddSignal(&SigSys,InvalidTime*2,52); // invalid time * 2
       SimTime=ms500+InvalidTime;
       DoorActFlag=0;
     }
}






















void Sim3() // Invalid 1
{
  if(SignalingSystem_CheckSignal(&SigSys,52))
  {
       DoorStatus=DOORSTATUS_Closing;
       if((DisplayMode==0) && (MenuState==0))
       {
         LCD_out(2,1,"    Closing     ");
       }
       SimStatus=4;
       SignalingSystem_AddSignal(&SigSys,ClosingTime-(InvalidTime*2),53); // closing time - invalid time * 2
  }

  if(!IRin)
  {
    SignalingSystem_ClearSignal(&SigSys,53);
    SignalingSystem_ClearSignal(&SigSys,52);
    DoorStatus=DOORSTATUS_Openning;
    if((DisplayMode==0) && (MenuState==0))
    {
      LCD_out(2,1,"    Openning    ");
    }
    SimStatus=1;
    SignalingSystem_AddSignal(&SigSys,InvalidTime,50);
  }
}




















void Sim4() // Closing
{
  if(SignalingSystem_CheckSignal(&SigSys,53))
  {
       DoorStatus=DOORSTATUS_Invalid;
       if((DisplayMode==0) && (MenuState==0))
       {
         LCD_out(2,1,"    Invalid     ");
       }
       SimStatus=5;
       SignalingSystem_AddSignal(&SigSys,(InvalidTime*2),54); // invalid time * 2
  }

  if(!IRin)
  {
    SignalingSystem_ClearSignal(&SigSys,53);
    SignalingSystem_ClearSignal(&SigSys,54);
    DoorStatus=DOORSTATUS_Openning;
    if((DisplayMode==0) && (MenuState==0))
    {
      LCD_out(2,1,"    Openning    ");
    }
    SimStatus=1;
    SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
  }

  if(DoorActFlag)
  {
    SignalingSystem_ClearSignal(&SigSys,53);
    SignalingSystem_ClearSignal(&SigSys,54);
    DoorStatus=DOORSTATUS_Openning;
    if((DisplayMode==0) && (MenuState==0))
    {
      LCD_out(2,1,"    Openning    ");
    }
    SimStatus=1;
    SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
    DoorActFlag=0;
  }
}
















void Sim5() // Invalid 2
{
  if(SignalingSystem_CheckSignal(&SigSys,54))
     {
       DoorStatus=DOORSTATUS_Close;
       if((DisplayMode==0) && (MenuState==0))
       {
         LCD_out(2,1,"     Closed     ");
       }
       SimStatus=0;
     }
}


















void DoorSimulator()
{
   switch(SimStatus)
   {
     case 0:
       Sim0();
       break;

     case 1:
       Sim1();
       break;

     case 2:
       Sim2();
       break;

     case 3:
       Sim3();
       break;

     case 4:
       Sim4();
       break;

     case 5:
       Sim5();
       break;
   }
}












void SaveConfig()
{
  eeprom_write(0,OpenningTime);
  eeprom_write(1,ClosingTime);
  eeprom_write(2,InvalidTime);
  eeprom_write(3,AutocloseTime);
  eeprom_write(4,NetworkAddress);
  RS485Slave_Init(NetworkAddress);
}









void LoadConfig()
{
  OpenningTime=eeprom_read(0);
  ClosingTime=eeprom_read(1);
  InvalidTime=eeprom_read(2);
  AutocloseTime=eeprom_read(3);
  NetworkAddress=eeprom_read(4);
}












void FlashLCD()
{
  static char PrevLCDFlashState;
  
  if(LCDFlashFlag)
  {
    PrevLCDFlashState=LCDFlashFlag;
    if(LCDFlashState)
    {
      LCD_chr(2,1,'>');LCD_chr(2,2,'>');LCD_chr(2,3,'>');
      LCD_chr(2,16,'<');LCD_chr(2,15,'<');LCD_chr(2,14,'<');
    }
    else
    {
      LCD_chr(2,1,' ');LCD_chr(2,2,' ');LCD_chr(2,3,' ');
      LCD_chr(2,16,' ');LCD_chr(2,15,' ');LCD_chr(2,14,' ');
    }
  }
  else
  {
    if(PrevLCDFlashState)
    {
      LCD_chr(2,1,' ');LCD_chr(2,2,' ');LCD_chr(2,3,' ');
      LCD_chr(2,16,' ');LCD_chr(2,15,' ');LCD_chr(2,14,' ');
    }
    PrevLCDFlashState=LCDFlashState;
  }
}







void NetworkTask()
{
  if (NetBuffer[4]) {                    // upon completed valid message receive
      NetBuffer[4] = 0;                    //   data[4] is set to 0xFF
      switch(NetBuffer[0])
      {
        case 1:
          LCTime=ms500;
          OpenCommand=1;
          NetBuffer[0]=200;
          NetBuffer[1]=200;
          NetBuffer[2]=200;
          Delay_ms(1);
          RS485Slave_Send(NetBuffer,3);
          break;
          
        case 2:
          NetBuffer[0]=200;
          NetBuffer[1]=200;
          NetBuffer[2]=200;
          Delay_ms(1);
          RS485Slave_Send(NetBuffer,3);
          break;
      }
    }

}