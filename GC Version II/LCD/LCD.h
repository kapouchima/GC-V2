/* -----------------------------------------------------------------------------
 - LCD Controller system for PIC18 Dveloped by : Sina Baghi
 -
 - This Library is working with general 2*16 LCD and the I2C interface COG one. you should uncomment the connected LCD first.
 -
 - LCDSystem_FlasherEPOCH should be called in cyclic form and it provides Time base for LCD flashing
 -
 - LCDSystem_Task should be called in while(1). it's the main task of the LCD Controller system
 -
 - LCDSystem_Update should be called after updating he LCD text each time
 -
 - LCDSystem_SetFlasher sets the flashing state of the LCD
 -  if the flashing is enabled two arrows at the second line of the LCD will flash
 -
 -------------------------------------------------------------------------------
 */





#ifndef LCDMODULE
#define LCDMODULE

//#define COGDisplay
#define GeneralDisplay


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

#endif