#include "Datalink.h"
#include "CRC.h"


void DatalinkSystem_Send(DatalinkSystem *sys,DataPacket *pac)
{
  char i;
  
  pac->Data[0]=sys->SendStartChar;
  if(sys->mode==Client)
    pac->Data[1]=sys->SendAddress;
    
  if(pac->len>3)
    pac->Data[pac->len-1]=CRC_Marktrace((pac->Data),pac->len);
  
   if(sys->UARTChannel==1)
   {
     //UART_Set_Active(&UART1_Read, &UART1_Write, &UART1_Data_Ready, &UART1_Tx_Idle);
     UART1Direction=UARTDirection_Transmit;
     delay_us(300);
     for(i=0;i<pac->len;i++)
     {
       uart1_write(pac->Data[i]);
     }
     delay_us(300);
     UART1Direction=UARTDirection_Receive;
   }


   if(sys->UARTChannel==2)
   {
     //UART_Set_Active(&UART2_Read, &UART2_Write, &UART2_Data_Ready, &UART2_Tx_Idle);
     UART2Direction=UARTDirection_Transmit;
     delay_us(300);
     for(i=0;i<pac->len;i++)
     {
       uart2_write(pac->Data[i]);
     }
     delay_us(300);
     UART2Direction=UARTDirection_Receive;
   }
}






void DatalinkSystem_Receive(DatalinkSystem *sys,char dat)
{
  static char i,ByteIndex,FIFOIndex,j,AddTemp;

  switch(sys->ReceiveStatus)
  {
  case 0:

    if(dat==sys->ReceiveStartChar)
      {sys->ReceiveStatus=1;sys->TimeoutCounter=0;}
    break;

  case 1:
    AddTemp=dat;
    if(sys->mode==Client)
    {
      if(dat!=sys->ReceiveAddress)
      {sys->ReceiveStatus=0;}
      else
      {sys->ReceiveStatus=2;}
    }
    
    if(sys->mode==Server)
    {
      sys->ReceiveStatus=2;
    }
    break;

  case 2:

    i=dat;
    if(i>MAXPACKETSIZE-3)
      sys->ReceiveStatus=0;

    for(j=0;j<RECBUFFERSIZE;j++)
    {
      if(sys->RecBuffer[j].status==0){sys->RecBuffer[j].len=dat+3;sys->RecBuffer[j].Data[0]=sys->ReceiveStartChar;sys->RecBuffer[j].Data[1]=AddTemp;sys->RecBuffer[j].Data[2]=dat;sys->ReceiveStatus=3;sys->RecBuffer[j].status=1;FIFOIndex=0;ByteIndex=3;break;}
      else if(j==(RECBUFFERSIZE-1))sys->ReceiveStatus=0;
    }
    if(i==0)
      {sys->RecBuffer[FIFOIndex].status=2;sys->ReceiveFlag=FIFOIndex+1;sys->ReceiveStatus=0;}
    break;

  case 3:

    sys->RecBuffer[FIFOIndex].Data[ByteIndex]=dat;
    ByteIndex=ByteIndex+1;
    i=i-1;
    if(i==0)
    {
      if(CRC_Marktrace(sys->RecBuffer[FIFOIndex].Data,sys->RecBuffer[FIFOIndex].len)==sys->RecBuffer[FIFOIndex].Data[sys->RecBuffer[FIFOIndex].len-1])
        {sys->RecBuffer[FIFOIndex].status=2;sys->ReceiveFlag=FIFOIndex+1;sys->ReceiveStatus=0;}
      else
        {sys->RecBuffer[FIFOIndex].status=0;sys->ReceiveStatus=0;}
    }
    break;
   }

}






void DatalinkSystem_TimeoutEPOCH(DatalinkSystem *sys)
{
  char i;
  
  if(sys->TimeoutCounter<255)
    sys->TimeoutCounter=sys->TimeoutCounter+1;

    if((sys->ReceiveStatus)&&(sys->TimeoutCounter>sys->Timeout)) 
    {
      sys->ReceiveStatus=0;
      for(i=0;i<RECBUFFERSIZE;i++)
       if(sys->RecBuffer[i].status!=2)sys->RecBuffer[i].status=0;
    }
}





void DatalinkSystem_Init(DatalinkSystem *sys)
{
  char i;
  sys->ReceiveStatus=0;
  sys->ReceiveFlag=0;
  for(i=0;i<RECBUFFERSIZE;i++)
    sys->RecBuffer[i].Status=0;
}







void DatalinkSystem_ClearBuffer(DatalinkSystem *sys)
{
  sys->RecBuffer[sys->ReceiveFlag].Status=0;
  sys->ReceiveFlag=0;
}