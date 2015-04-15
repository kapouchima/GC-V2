//#include "LCD/LCD.h"
#include "Signaling/Signaling.h"

#define Buzzer (porta.b0)
#define Dip1 (porta.b1)
#define Dip2 (porta.b2)
#define Dip3 (porta.b3)
#define Dip4 (porta.b5)
#define LED (porta.b6)
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
#define LCDBL (porte.b0)






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





//Global Variables
char Flag20ms=0,Flag500ms=0,Counterms500=0;
unsigned long ms500=0;

SignalingSystem SigSys;











void Init()
{
  //-------Oscillator Configuration
  OSCCON=0b01100000;
  OSCTUNE.PLLEN=1;
  //-------AD Configuration
  ANCON0=0;
  ANCON1=0;
  //-------Port Configuration
  porta=1;
  portb=0;
  portc=0;
  portd=0;
  porte=0;
  trisa=0b10111110;
  trisb=0b11000000;
  trisc=0b10100001;
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
  delay_ms(100);
  LCDBL=1;
  
  //-------UART
  UART1_Init(9600);
  UART2_Init(9600);
  
  //-------Signaling System
  SignalingSystem_Init(&SigSys);
}













void interrupt()
{
  if((TMR0IF_bit)&&(TMR0IE_bit))
  {
    Flag20ms=1;
    Counterms500=Counterms500+1;
    if(Counterms500>=25)
      {Flag500ms=1;Counterms500=0;}
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
    Flag20ms=0;
  }
  
  if(Flag500ms)
  {
    ms500=ms500+1;
    SignalingSystem_SystemEPOCH(&SigSys);
    SignalingSystem_Task(&SigSys);
    Flag500ms=0;
  }



  LED=IRin;
  /*dat=0;

  RTEn1=1;
  RTEn2=0;
  uart1_write('a');
  if(UART2_Data_Ready())
  dat=Uart2_read();
  if(dat=='a')
  LED=1;//LCD_out(1,1,"BALAAALAAAR");
  delay_ms(1000);
  LED=0;
  delay_ms(1000);*/
}

}