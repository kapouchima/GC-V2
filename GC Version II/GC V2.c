#include "LCD/LCD.h"
#include "Signaling/Signaling.h"

#define Buzzer (portc.b5)
#define Dip1 (porta.b1)
#define Dip2 (porta.b2)
#define Dip3 (porta.b3)
#define Dip4 (porta.b5)
#define LCDBL (porta.b6)
#define sw2 (porta.b7)
#define Relay4 (portd.b0)
#define Relay3 (portd.b1)
#define Relay2 (portd.b2)
#define Relay1 (portd.b3)
#define sw3 (portd.b4)
#define sw1 (portd.b5)
#define IRin Dip4
//(portc.b0)
#define RTEn1 (portc.b1)
#define RTEn2 (portc.b2)
#define LED (porte.b0)






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
char MenuState=0,MenuCounter=0,Keys=0;
unsigned long ms500=0,SimTime=0;

//-----Configs
char OpenningTime=10,ClosingTime=10,InvalidTime=1,AutocloseTime=20;


SignalingSystem SigSys;
LCDSystem LCD;





void DoorSimulator();
void Sim0();
void Sim1();
void Sim2();
void Sim3();
void Sim4();
void Sim5();
void Init();
void SaveConfig();
void LoadConfig();








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
  LCDSystem_Init(&LCD);
  delay_ms(100);
  LCDBL=1;
  
  //-------UART
  UART1_Init(9600);
  UART2_Init(9600);
  
  //-------Signaling System
  SignalingSystem_Init(&SigSys);
  
  //-------Door Status
  DoorStatus=DOORSTATUS_Close;
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
}












void main() {

char dat;

Init();

while(1)
{

  if(Flag20ms)
  {
    LCDSystem_Task(&LCD);
    Flag20ms=0;
  }
  
  if(Flag500ms)
  {
    if(LCDBLCounter>0)
      LCDBLCounter=LCDBLCounter-1;
    else
      LCDBL=0;
    ms500=ms500+1;
    SignalingSystem_SystemEPOCH(&SigSys);
    SignalingSystem_Task(&SigSys);
    Flag500ms=0;
  }

  MenuHandler();

  LED=IRin;
  
  if((Dip1)&&(!Relay1))
  {
    Relay1=1;
    SignalingSystem_AddSignal(&SigSys,4,1);
    DoorActFlag=1;
  }
  
  
  if(SignalingSystem_CheckSignal(&SigSys,1))
    Relay1=0;
    
  DoorSimulator();

}
}











void MenuHandler()
{
  if(MenuState==1)
    Menu1();
    
  if(MenuState==2)
    Menu2();
    
  if(MenuState==3)
    Menu3();
}












void Menu1()
{
   switch(MenuCounter)
   {
     case 0:
       memcpy(LCD.Line1," Openning Time  ",16);
       LCDSystem_Update(&LCD);
       break;

     case 1:
       memcpy(LCD.Line1,"  Closing Time  ",16);
       LCDSystem_Update(&LCD);
       break;
       
     case 2:
       memcpy(LCD.Line1,"  Invalid Time  ",16);
       LCDSystem_Update(&LCD);
       break;
       
     case 3:
       memcpy(LCD.Line1,"Autoclose Time  ",16);
       LCDSystem_Update(&LCD);
       break;
       
     case 4:
       memcpy(LCD.Line1,"  Save Changes  ",16);
       LCDSystem_Update(&LCD);
       break;
       
     case 5:
       memcpy(LCD.Line1," Discard & Exit ",16);
       LCDSystem_Update(&LCD);
       break;
   }
   MenuState=2;
}









void Menu2()
{
  if(Keys.b0)
    if(MenuCounter>0)
      MenuCounter=MenuCounter-1;
      
  if(Keys.b2)
    if(MenuCounter<5)
      MenuCounter=MenuCounter+1;
  
}








void Menu3()
{
}


















void Sim0() // Close
{

  if(DoorActFlag)
  {
    SignalingSystem_AddSignal(&SigSys,OpenningTime,50); // OpenTime
    DoorStatus=DOORSTATUS_Openning;
    memcpy(LCD.Line2,"    Openning    ",16);
    LCDSystem_Update(&LCD);
    SimStatus=1;
    DoorActFlag=0;
  }
}














void Sim1() // Openning
{
  if(SignalingSystem_CheckSignal(&SigSys,50))
  {
    DoorStatus=DOORSTATUS_Open;
    memcpy(LCD.Line2,"     Opened     ",16);
    LCDSystem_Update(&LCD);
    SimStatus=2;
    SignalingSystem_AddSignal(&SigSys,AutocloseTime-InvalidTime,51);//AutoClose - Invalid
  }
}















void Sim2() // Open
{
     if(SignalingSystem_CheckSignal(&SigSys,51))
     {
       DoorStatus=DOORSTATUS_Invalid;
       memcpy(LCD.Line2,"    Invalid     ",16);
       LCDSystem_Update(&LCD);
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
       memcpy(LCD.Line2,"    Closing     ",16);
       LCDSystem_Update(&LCD);
       SimStatus=4;
       SignalingSystem_AddSignal(&SigSys,ClosingTime-(InvalidTime*2),53); // closing time - invalid time * 2
  }

  if(!IRin)
  {
    SignalingSystem_ClearSignal(&SigSys,53);
    SignalingSystem_ClearSignal(&SigSys,52);
    DoorStatus=DOORSTATUS_Openning;
    memcpy(LCD.Line2,"    Openning    ",16);
    LCDSystem_Update(&LCD);
    SimStatus=1;
    SignalingSystem_AddSignal(&SigSys,InvalidTime,50);
  }
}




















void Sim4() // Closing
{
  if(SignalingSystem_CheckSignal(&SigSys,53))
  {
       DoorStatus=DOORSTATUS_Invalid;
       memcpy(LCD.Line2,"    Invalid     ",16);
       LCDSystem_Update(&LCD);
       SimStatus=5;
       SignalingSystem_AddSignal(&SigSys,(InvalidTime*2),54); // invalid time * 2
  }

  if(!IRin)
  {
    SignalingSystem_ClearSignal(&SigSys,53);
    SignalingSystem_ClearSignal(&SigSys,54);
    DoorStatus=DOORSTATUS_Openning;
    memcpy(LCD.Line2,"    Openning    ",16);
    LCDSystem_Update(&LCD);
    SimStatus=1;
    SignalingSystem_AddSignal(&SigSys,ms500-SimTime,50);
  }

  if(DoorActFlag)
  {
    SignalingSystem_ClearSignal(&SigSys,53);
    SignalingSystem_ClearSignal(&SigSys,54);
    DoorStatus=DOORSTATUS_Openning;
    memcpy(LCD.Line2,"    Openning    ",16);
    LCDSystem_Update(&LCD);
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
       memcpy(LCD.Line2,"     Closed     ",16);
       LCDSystem_Update(&LCD);
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
}









void LoadConfig()
{
  OpenningTime=eeprom_read(0);
  ClosingTime=eeprom_read(1);
  InvalidTime=eeprom_read(2);
  AutocloseTime=eeprom_read(3);
}

