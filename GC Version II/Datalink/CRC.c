// CRC calculator
//in this code crc is calculated from the 3th byte

#include "CRC.h"

char CRC(char *dat,char len)
{
  char i,result;
  result=CRCBase;
  for(i=3;i<len-1;i++)
  {
    result=result^dat[i];
  }
  return result;
}




char CRC_Marktrace(char *dat,char len)
{
  char i,result;
  unsigned long sum=0;
  for(i=0;i<len-1;i++)
  {
    sum=sum+dat[i];
  }
  result=(char)(0xFF & (sum ^ 0xFFFFFFFF) + 1);
  return result;
}
