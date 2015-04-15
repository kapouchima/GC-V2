#line 1 "C:/Users/baghi/Desktop/GC V2/GC V2/GC V2.c"
#line 1 "c:/users/baghi/desktop/gc v2/gc v2/signaling/signaling.h"
#line 30 "c:/users/baghi/desktop/gc v2/gc v2/signaling/signaling.h"
typedef struct
{
 char SignalCode;
 unsigned long Time;
 char Expired;
 char Fired;
}Signal;

typedef struct
{
 Signal SignalQueue[ 20 ];
 unsigned long SystemEPOCH;
}SignalingSystem;

void SignalingSystem_SystemEPOCH(SignalingSystem *);
void SignalingSystem_AddSignal(SignalingSystem *,unsigned long ,char );
char SignalingSystem_CheckSignal(SignalingSystem * ,char );
void SignalingSystem_ClearSignal(SignalingSystem *,char);
void SignalingSystem_ClearAllSignals(SignalingSystem * ,char );
void SignalingSystem_Task(SignalingSystem *);
void SignalingSystem_Init(SignalingSystem *);
#line 28 "C:/Users/baghi/Desktop/GC V2/GC V2/GC V2.c"
sbit LCD_RS at RB5_bit;
sbit LCD_EN at RB4_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;


sbit LCD_RS_Direction at TRISB5_bit;
sbit LCD_EN_Direction at TRISB4_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;






char Flag20ms=0,Flag500ms=0,Counterms500=0;
unsigned long ms500=0;

SignalingSystem SigSys;
#line 63 "C:/Users/baghi/Desktop/GC V2/GC V2/GC V2.c"
void Init()
{

 OSCCON=0b01100000;
 OSCTUNE.PLLEN=1;

 ANCON0=0;
 ANCON1=0;

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


 T0CON=0b10000001;
 TMR0H=0x63;
 TMR0L=0xBF;
 INTCON.b7=1;
 INTCON.T0IE=1;


 LCD_Init();
 delay_ms(100);
  (porte.b0) =1;


 UART1_Init(9600);
 UART2_Init(9600);


 SignalingSystem_Init(&SigSys);
}
#line 115 "C:/Users/baghi/Desktop/GC V2/GC V2/GC V2.c"
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
#line 138 "C:/Users/baghi/Desktop/GC V2/GC V2/GC V2.c"
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



  (porta.b6) = (portc.b0) ;
#line 175 "C:/Users/baghi/Desktop/GC V2/GC V2/GC V2.c"
}

}
