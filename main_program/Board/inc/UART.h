#ifndef _UART_H_
#define _UART_H_

extern unsigned short CRC_CHECK(unsigned char *Buf, unsigned char CRC_CNT);
extern void OutPut_Data(void);
extern void SEND(float a,float b,float c,float d);
#endif