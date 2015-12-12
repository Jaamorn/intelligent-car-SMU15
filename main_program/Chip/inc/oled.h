#ifndef __OLED_H
#define __OLED_H			  	 
#include "common.h"




    						
#define OLED_SCLK_H    P0.0=1;              
#define OLED_SCLK_L    P0.0=0;
#define OLED_SDIN_H    P0.1=1;
#define OLED_SDIN_L    P0.1=0;             
#define OLED_RST_H  	P0.4=1;
#define OLED_RST_L  	P0.4=0;
#define OLED_RS_H       P0.5=1;
#define OLED_RS_L       P0.5=0;      



#define OLED_CMD  0	
#define OLED_DATA 1	


void OLED_WR_Byte(u8 dat,u8 cmd);	    
void OLED_Display_On(void);
void OLED_Display_Off(void);
void OLED_Refresh_Gram(void);  		    
void OLED_Init(void);
void OLED_Clear(void);
void OLED_DrawPoint(u8 x,u8 y,u8 t);
void OLED_Fill(u8 x1,u8 y1,u8 x2,u8 y2,u8 dot);
void OLED_ShowChar(u8 x,u8 y,u8 chr,u8 size,u8 mode);
void OLED_ShowNum(u8 x,u8 y,u32 num,u8 len,u8 size);
void OLED_ShowString(u8 x,u8 y,const u8 *p,u8 size);	 
#endif  