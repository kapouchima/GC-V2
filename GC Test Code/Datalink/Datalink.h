/* -----------------------------------------------------------------------------
 - Datalink layer for PIC18 Dveloped by : Sina Baghi
 -
 - This Library is working uart module in Server or Client mode.
 - Packet architecture is like below :
 - _______________________________________________________________
 - | Start Char | Address | Byte Count | data | data | ... | CRC |
 - _______________________________________________________________
 
 -Sample :
 -
 - ___________________________________________
 - | 0x0A | 0x12 | 0x03 | 0xB1 | 0xB2 | (CRC)|
 - ___________________________________________
 -
 - DatalinkSystem_Receive should be called when an uart receive interrupt occured and data should be passed inside
 -
 - DatalinkSystem_TimeoutEPOCH should be called in cycles with known and calculated time out epochs
 -  if number of epochs is seted for timeout is elapsed and packet receiving is not continued the packet will be discarded
 -
 -
 -------------------------------------------------------------------------------
 */




#ifndef DATALINKMODULE
#define DATALINKMODULE


#define MAXPACKETSIZE 30
#define RECBUFFERSIZE 3

#define UART1Direction portb.b0
#define UART2Direction portb.b1
#define UARTDirection_Transmit 1
#define UARTDirection_Receive 0

typedef struct
{
  char Data[MAXPACKETSIZE];
  char len;
  char status; // 0-Free    1-Processing  2-Valid
}DataPacket;


typedef enum
{
  Server,
  Client
}WorkingMode;

typedef struct
{
  DataPacket RecBuffer[RECBUFFERSIZE];
  char SendAddress;
  char ReceiveAddress;
  char ReceiveFlag;
  char Timeout;
  char UARTChannel;
  char TimeoutCounter;
  char SendStartChar;
  char ReceiveStartChar;
  char ReceiveStatus;
  WorkingMode mode;
}DatalinkSystem;

void DatalinkSystem_Send(DatalinkSystem *,DataPacket *);
void DatalinkSystem_Receive(DatalinkSystem *,char);
void DatalinkSystem_TimeoutEPOCH(DatalinkSystem *);
void DatalinkSystem_Init(DatalinkSystem *);
void DatalinkSystem_ClearBuffer(DatalinkSystem *);

#endif