#line 1 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
#line 1 "c:/users/kapouchima/desktop/gc v2/gc-v2/gc version ii/lcd/lcd.h"
#line 29 "c:/users/kapouchima/desktop/gc v2/gc-v2/gc version ii/lcd/lcd.h"
typedef struct
{
 char Line1[16];
 char Line2[16];
 char LCDUpdateFlag;
 char LCDFlashFlag;
 char LCDLine;
}LCDSystem;



void LCDSystem_Task(LCDsystem *);
void LCDSystem_FlasherEPOCH();
void LCDSystem_Init(LCDSystem *);
void LCDSystem_Update(LCDSystem *);
void LCDSystem_SetFlasher(LCDSystem *,char);
#line 1 "c:/users/kapouchima/desktop/gc v2/gc-v2/gc version ii/signaling/signaling.h"
#line 30 "c:/users/kapouchima/desktop/gc v2/gc-v2/gc version ii/signaling/signaling.h"
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
#line 29 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
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


char s0[]="Invalid";
char s1[]="Open   ";
char s2[]="Close  ";
char s3[]="Opening";
char s4[]="Closing";
char s5[]="StopedO";
char s6[]="StopedC";





char text[16];
char Flag20ms=0,Flag500ms=0,Counterms500=0,SimStatus=0,PrevSimStatus=0,DoorActFlag=0;
unsigned long ms500=0,SimTime=0;


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
 trisa=0b10111111;
 trisb=0b11000000;
 trisc=0b10000001;
 trisd=0b10110000;
 trise=0b1110;


 T0CON=0b10000001;
 TMR0H=0x63;
 TMR0L=0xBF;
 INTCON.b7=1;
 INTCON.T0IE=1;


 LCD_Init();
 LCDSystem_Init(&LCD);
 delay_ms(100);
  (porta.b6) =1;


 UART1_Init(9600);
 UART2_Init(9600);


 SignalingSystem_Init(&SigSys);


 DoorStatus=DOORSTATUS_Close;
}
#line 158 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
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
#line 183 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
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
 ms500=ms500+1;
 SignalingSystem_SystemEPOCH(&SigSys);
 SignalingSystem_Task(&SigSys);
 Flag500ms=0;
 }



  (porte.b0) = (porta.b5) ;

 if(( (porta.b1) )&&(! (portd.b3) ))
 {
  (portd.b3) =1;
 SignalingSystem_AddSignal(&SigSys,4,1);
 DoorActFlag=1;
 }


 if(SignalingSystem_CheckSignal(&SigSys,1))
  (portd.b3) =0;

 DoorSimulator();
#line 255 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
}

}
#line 272 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
void Sim0()
{

 if(DoorActFlag)
 {
 SignalingSystem_AddSignal(&SigSys,OpenningTime,50);
 DoorStatus=DOORSTATUS_Openning;
 memcpy(LCD.Line2,"    Openning    ",16);
 LCDSystem_Update(&LCD);
 SimStatus=1;
 DoorActFlag=0;
 }
}
#line 299 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
void Sim1()
{
 if(SignalingSystem_CheckSignal(&SigSys,50))
 {
 DoorStatus=DOORSTATUS_Open;
 memcpy(LCD.Line2,"     Opened     ",16);
 LCDSystem_Update(&LCD);
 SimStatus=2;
 SignalingSystem_AddSignal(&SigSys,AutocloseTime-InvalidTime,51);
 }
}
#line 325 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
void Sim2()
{
 if(SignalingSystem_CheckSignal(&SigSys,51))
 {
 DoorStatus=DOORSTATUS_Invalid;
 memcpy(LCD.Line2,"    Invalid     ",16);
 LCDSystem_Update(&LCD);
 SimStatus=3;
 SignalingSystem_AddSignal(&SigSys,InvalidTime*2,52);
 SimTime=ms500+InvalidTime;
 DoorActFlag=0;
 }
}
#line 360 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
void Sim3()
{
 if(SignalingSystem_CheckSignal(&SigSys,52))
 {
 DoorStatus=DOORSTATUS_Closing;
 memcpy(LCD.Line2,"    Closing     ",16);
 LCDSystem_Update(&LCD);
 SimStatus=4;
 SignalingSystem_AddSignal(&SigSys,ClosingTime-(InvalidTime*2),53);
 }

 if(! (porta.b5) )
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
#line 402 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
void Sim4()
{
 if(SignalingSystem_CheckSignal(&SigSys,53))
 {
 DoorStatus=DOORSTATUS_Invalid;
 memcpy(LCD.Line2,"    Invalid     ",16);
 LCDSystem_Update(&LCD);
 SimStatus=5;
 SignalingSystem_AddSignal(&SigSys,(InvalidTime*2),54);
 }

 if(! (porta.b5) )
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
#line 452 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
void Sim5()
{
 if(SignalingSystem_CheckSignal(&SigSys,54))
 {
 DoorStatus=DOORSTATUS_Close;
 memcpy(LCD.Line2,"     Closed     ",16);
 LCDSystem_Update(&LCD);
 SimStatus=0;
 }
}
#line 480 "C:/Users/Kapouchima/Desktop/GC V2/GC-V2/GC Version II/GC V2.c"
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
