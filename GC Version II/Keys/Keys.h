/* -----------------------------------------------------------------------------
 - Key reading Module for PIC18 Dveloped by : Sina Baghi
 -
 - KeysSystem_EPOCH should be called in cyclic form and it provides Time base for Key reading system
 -
 - KeysSystem_Task should be called in while(1). it's the main task of the key reading system and returns the key value
 -
 - There is 3 repeating levels for each hold key. number of each repeat phase and the speed of it can be adjust with repeatCycles and
 - Repeat count params these values are multiplied in system epoch time.
 -
 - StartRepeatCycles determines the initial time for starting repeating after pressing and holding any keys
 -
 - Key value should be defined in Key1 , Key2 and ... to Key8 in header file
 -------------------------------------------------------------------------------
 */



#ifndef KEYMODULE
#define KEYMODULE


#define Key1 (!portd.b5)
#define Key2 (!porta.b7)
#define Key3 (!portd.b4)


#define DebouncingCycles (1)
#define StartRepeatCycles (100)
#define SlowRepeatCycles (25)
#define SlowRepeatCount  (10)
#define MidRepeatCycles  (15)
#define MidRepeatCount   (10)
#define FastRepeatCycles (8)



void KeysSystem_EPOCH();
char KeysSystem_Task();

#endif