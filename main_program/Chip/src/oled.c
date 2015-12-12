#include "oled.h"
#include "common.h"
#include "oledfont.h" 




u8 OLED_GRAM[128][8];	 


void delay_us1(int16_t num)
{
  int16_t i,j;
  for(i=0;i<num;i++)
  {
     for(j=0;j<72;j++);
  }
}

 
void OLED_Refresh_Gram(void)
{
	u8 i,n;		    
	for(i=0;i<8;i++)  
	{  
		OLED_WR_Byte (0xb0+i,OLED_CMD);    
		OLED_WR_Byte (0x00,OLED_CMD);      
		OLED_WR_Byte (0x10,OLED_CMD);      
		for(n=0;n<128;n++)OLED_WR_Byte(OLED_GRAM[n][i],OLED_DATA); 
	}   
}


void OLED_WR_Byte(u8 dat,u8 cmd)
{	
	u8 i;	
  if(cmd==0)
	{		
	OLED_RS_L; 
	} 
	else
	{
		OLED_RS_H;
	}
	//OLED_CS_L;		  
	for(i=0;i<8;i++)
	{			  
		OLED_SCLK_L;
		if(dat&0x80)
		{OLED_SDIN_H;}
		else 
		{OLED_SDIN_L;}
		OLED_SCLK_H;
		dat<<=1;   
	}				 
	//OLED_CS_H;		  
	OLED_RS_H;   	  
} 

	  	  
//?a??OLED??¨º?    
void OLED_Display_On(void)
{
	OLED_WR_Byte(0X8D,OLED_CMD);  
	OLED_WR_Byte(0X14,OLED_CMD);  
	OLED_WR_Byte(0XAF,OLED_CMD);  
}
//1?¡À?OLED??¨º?     
void OLED_Display_Off(void)
{
	OLED_WR_Byte(0X8D,OLED_CMD); 
	OLED_WR_Byte(0X10,OLED_CMD);  
	OLED_WR_Byte(0XAE,OLED_CMD);  
}		   			 
  
void OLED_Clear(void)  
{  
	u8 i,n;  
	for(i=0;i<8;i++)for(n=0;n<128;n++)OLED_GRAM[n][i]=0X00;  
	OLED_Refresh_Gram();
}
		   
void OLED_DrawPoint(u8 x,u8 y,u8 t)
{
	u8 pos,bx,temp=0;
	if(x>127||y>63)return;
	pos=7-y/8;
	bx=y%8;
	temp=1<<(7-bx);
	if(t)OLED_GRAM[x][pos]|=temp;
	else OLED_GRAM[x][pos]&=~temp;
	
}
  
void OLED_Fill(u8 x1,u8 y1,u8 x2,u8 y2,u8 dot)  
{  
	u8 x,y;  
	for(x=x1;x<=x2;x++)
	{
		for(y=y1;y<=y2;y++)OLED_DrawPoint(x,y,dot);
	}													    
	OLED_Refresh_Gram();
}

void OLED_ShowChar(u8 x,u8 y,u8 chr,u8 size,u8 mode)
{      			    
	u8 temp,t,t1;
	u8 y0=y;
	u8 csize=(size/8+((size%8)?1:0))*(size/2);		
	chr=chr-' ';	 
    for(t=0;t<csize;t++)
    {   
		if(size==12)temp=asc2_1206[chr][t]; 	 	
		else if(size==16)temp=asc2_1608[chr][t];	
		else if(size==24)temp=asc2_2412[chr][t];	
		else return;								
        for(t1=0;t1<8;t1++)
		{
			if(temp&0x80)OLED_DrawPoint(x,y,mode);
			else OLED_DrawPoint(x,y,!mode);
			temp<<=1;
			y++;
			if((y-y0)==size)
			{
				y=y0;
				x++;
				break;
			}
		}  	 
    }          
}

u32 mypow(u8 m,u8 n)
{
	u32 result=1;
	
	while(n--)result*=m;    
	return result;
}				  
 		  
void OLED_ShowNum(u8 x,u8 y,u32 num,u8 len,u8 size)
{         	
	u8 t,temp;
	u8 enshow=0;						   
	for(t=0;t<len;t++)
	{
		temp=(num/mypow(10,len-t-1))%10;
		if(enshow==0&&t<(len-1))
		{
			if(temp==0)
			{
				OLED_ShowChar(x+(size/2)*t,y,' ',size,1);
				continue;
			}else enshow=1; 
		 	 
		}
	 	OLED_ShowChar(x+(size/2)*t,y,temp+'0',size,1); 
	}
} 

void OLED_ShowString(u8 x,u8 y,const u8 *p,u8 size)
{	
    while((*p<='~')&&(*p>=' '))
    {       
        if(x>(128-(size/2))){x=0;y+=size;}
        if(y>(64-size)){y=x=0;OLED_Clear();}
        OLED_ShowChar(x,y,*p,size,1);	 
        x+=size/2;
        p++;
    }  
	
}	   
					    
void OLED_Init(void)
{ 	
 						  
	
	OLED_RS_H;	 
	delay_us1(300);
	OLED_RST_L;
	delay_us1(300);
	
	OLED_RST_H; 
					  
	OLED_WR_Byte(0xAE,OLED_CMD); 
	OLED_WR_Byte(0xD5,OLED_CMD); 
	OLED_WR_Byte(80,OLED_CMD);   
	OLED_WR_Byte(0xA8,OLED_CMD); 
	OLED_WR_Byte(0X3F,OLED_CMD); 
	OLED_WR_Byte(0xD3,OLED_CMD); 
	OLED_WR_Byte(0X00,OLED_CMD); 

	OLED_WR_Byte(0x40,OLED_CMD); 
													    
	OLED_WR_Byte(0x8D,OLED_CMD); 
	OLED_WR_Byte(0x14,OLED_CMD); 
	OLED_WR_Byte(0x20,OLED_CMD); 
	OLED_WR_Byte(0x02,OLED_CMD); 
	OLED_WR_Byte(0xA1,OLED_CMD); 
	OLED_WR_Byte(0xC0,OLED_CMD); 
	OLED_WR_Byte(0xDA,OLED_CMD); 
	OLED_WR_Byte(0x12,OLED_CMD); 
		 
	OLED_WR_Byte(0x81,OLED_CMD); 
	OLED_WR_Byte(0xEF,OLED_CMD); 
	OLED_WR_Byte(0xD9,OLED_CMD); 
	OLED_WR_Byte(0xf1,OLED_CMD); 
	OLED_WR_Byte(0xDB,OLED_CMD); 
	OLED_WR_Byte(0x30,OLED_CMD); 

	OLED_WR_Byte(0xA4,OLED_CMD); 
	OLED_WR_Byte(0xA6,OLED_CMD); 	    						   
	OLED_WR_Byte(0xAF,OLED_CMD);  
	OLED_Clear();
}  