/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,野火科技
 *     All rights reserved.
 *     技术讨论：野火初学论坛 http://www.chuxue123.com
 *
 *     除注明出处外，以下所有内容版权均属野火科技所有，未经允许，不得用于商业用途，
 *     修改内容时必须保留野火科技的版权声明。
 *
 * @file       main.c
 * @brief      野火K60 平台主程序
 * @author     野火科技
 * @version    v5.0
 * @date       2013-08-28
 * 香港记者
 */

#include "common.h"
#include "include.h"


void LED_init(void)
{
  gpio_init  (PTC17,GPO,0);   //D1
  gpio_init  (PTC16,GPO,0);   //D0
  gpio_init  (PTC19,GPO,0);   //DC
  gpio_init  (PTC18,GPO,1);   //RST
  LCD_Init();
}


#define CAMERA_W            160              //定义摄像头图像宽度
#define CAMERA_H            240              //定义摄像头图像高度
#define CAMERA_R_H          40               //定义摄像头图像高度
#define CAMERA_SIZE         CAMERA_W*CAMERA_H
#define BLACK_C 0
#define WHITE_C 254
#define Jump_threshold 60
#define Interval 5
#define Tracking_displacement 7
#define Tracking_NUM 12

 
uint8 imgbuff[CAMERA_R_H][CAMERA_W];                             //定义存储接收图像的数组

uint8 V_Cnt = 0;
volatile IMG_STATUS_e      img_flag = IMG_START;        //图像状态

uint16 VS=0;
uint16 HS=0;

uint8 POINT_R; //定义图像采集的右点
uint8 POINT_L; //定义图像采集的左点
uint8 POINT_C; //定义图像采集的中点
uint8 L = 37; //定义要采集的行号
uint8 FLAG_L;//0丢失1未丢失
uint8 FLAG_R;//0丢失1未丢失
uint8 left_line[40],right_line[40];







uint8  sz[CAMERA_R_H]={ 30,31,32,
                34,36,38,
                41,44,47,
                51,55,59,
                64,69,74,
                80,86,92,
                98,104,110,
                116,122,128,
                134,140,146,
                152,158,164,
                170,176,182,
                188,194,200,
                206,212,218,
                224//,230
                };


//函数声明
void portb_handler();
void portc_handler();




void  main(void)
{
      
         
          /*************驱动程序**********/
      int DUTY_MOTO = 180;//默认速度
      //int DUTY_MOTO_A = 200;//加速速度
      FTM_PWM_init(FTM1, FTM_CH0,10000,0);//A12
      FTM_PWM_init(FTM1, FTM_CH1,10000,0);//A13 
      
      
      FTM_PWM_init(FTM2, FTM_CH0,10000,0);//B18
      FTM_PWM_init(FTM2, FTM_CH1,10000,0);//B19

      FTM_PWM_Duty(FTM1, FTM_CH0, DUTY_MOTO);//左轮
      FTM_PWM_Duty(FTM2, FTM_CH0, DUTY_MOTO);//右轮
  
    DisableInterrupts;
    LED_init();
    uart_init (UART4, 115200);                        

    exti_init(PTC3,rising_up);                           //VS
    exti_init(PTB7,rising_down);                         //HS
    port_init(PTC0, ALT1 | DMA_FALLING | PULLUP );       //PCLK

    set_vector_handler(PORTB_VECTORn , portb_handler);   //设置中断复位函数为 PORTB_IRQHandler
    set_vector_handler(PORTC_VECTORn , portc_handler);   //设置中断复位函数为 PORTC_IRQHandler
    
     //DMA通道0初始化，PTA27触发源(默认上升沿)，源地址为PTE_B0_IN，目的地址为：IMG_BUFF，每次传输1Byte
    dma_portx2buff_init(DMA_CH0, (void *)&PTE_B0_IN, (void *)imgbuff, PTC0, DMA_BYTE1, CAMERA_W, DADDR_KEEPON);
    
    enable_irq (PORTC_IRQn);
    
    EnableInterrupts;   //数据采集完成
    
   
    while(1)
    {
      

  
  
      
      
      
      //LCD_Show_Number(5,2,123);
      if(img_flag == IMG_FINISH)
      {
        img_flag = IMG_PROCESS;
        
        /********串口发送程序*************/
        /*
        uart_putchar(UART4,0xff);
        for(int j = 0;j<CAMERA_R_H;j++)
        {
          for(int i = 0;i<CAMERA_W;i++)
          {
            if(imgbuff[j][i]==0xff)
            {
              imgbuff[j][i]=0xfe;
            }
            uart_putchar(UART4,imgbuff[j][i]);
          }
       }
        */
        /*************液晶屏显示程序**********/
        
        for(int j=0;j<CAMERA_R_H;j++)
        {
          for(int i=CAMERA_W;i>0;i--)
          {
            if(i%4==0)
            {
              if(imgbuff[j][i]<100)
              {
              OLED_DrawPoint(i/4,64-j,1);
              }
              else
              {
                OLED_DrawPoint(i/4,64-j,0);
              }
            }
            
          }
        }
        OLED_Refresh_Gram();
        
        
        
        
        
        /*************中线提取程序**********/
        
        
        for (int i = 110; i>2; i--)//找左线
        {
        	if(imgbuff[L][i]-imgbuff[L][i-2] > Jump_threshold )
        	{
        		left_line[L] = i;
        		LCD_Show_Number(70,3,POINT_L);
        		FLAG_L=1;
                    break;
        	}
          else FLAG_L=0;
        }

        for (int i = 60; i < CAMERA_W; i++)//找右线
        {
        	if(imgbuff[L][i]-imgbuff[L][i+2] > Jump_threshold )
        	{
        		right_line[L] = i;
        		LCD_Show_Number(70,4,POINT_R);
        		FLAG_R=1;
                    break;
        	}
          else FLAG_R = 0;
        }
        
        //LCD_Show_Number(70,1,FLAG_L);
        //LCD_Show_Number(70,2,FLAG_R);
 
        /*******黑线跟踪********/
        //左
        if (FLAG_L == 1)
        {
          for(int i=CAMERA_R_H-1;i>1;i--)
          {
            for (int j=0;j<Tracking_NUM;j++)
            {
              if (imgbuff[i-1][left_line[i]+Tracking_displacement-j]-imgbuff[i-1][left_line[i]-j+Tracking_displacement-Interval]>=Jump_threshold)
              {
                left_line[i-1]=left_line[i]+Tracking_displacement-j;
                break;
              }
            }
          }
        }
        //右
        if(FLAG_R == 1)
        {
          for(int i = CAMERA_R_H-1;i>1;i--)
          {
            for (int j=0;j<Tracking_NUM;j++)
            {
              if (imgbuff[i-1][left_line[i]+Tracking_displacement-j]-imgbuff[i-1][left_line[i]-j+Tracking_displacement-Interval]>=Jump_threshold)
              {
                left_line[i-1]=left_line[i]+Tracking_displacement-j;
                break;
              }
            }
          }
        }
        
        
        
        
/*        
        if(FLAG_R == 1 && FLAG_L == 1)
        {
          POINT_C = (POINT_L+POINT_R)/2;
          LCD_Show_Number(70,7,POINT_C);
        }  
        else if(FLAG_R == 1 && FLAG_L == 0)
        {
          POINT_C = POINT_R - 80;
          LCD_Show_Number(70,8,POINT_C);
        }
        else if(FLAG_R == 0 && FLAG_L == 1)
        {
          POINT_C = POINT_L + 70;
          LCD_Show_Number(70,6,POINT_C);
        }
        else if(FLAG_R == 0 && FLAG_L == 0)
        {
          POINT_C=80;
          LCD_Show_Number(70,9,POINT_C);
        }
*/         


 
       
          
        //float K_LEFT = 1.71;
        //float K_RIGHT = 1.71;
        //float DUTY_F;
        int DUTY;
        int MID= 80;//设定参考中点值
        //K_RIGHT = 1.71; 
        FTM_PWM_init(FTM0, FTM_CH0,50,775);   //初始化PWM输出中值 PTC1  775
        if(POINT_C > MID)//右拐
        {
            DUTY = 775 - 3*(POINT_C - MID);
            //int DUTY=(int)DUTY_F;
            if(DUTY<702)
          {
            DUTY = 705;
          }//舵机保护
            FTM_PWM_Duty(FTM0, FTM_CH0, DUTY);
        }  


        
        if(POINT_C<MID)//左拐
        {
            DUTY = 775 + 2*(MID - POINT_C);
            //DUTY=(int)DUTY_F;
            if(DUTY>850)
          {
            DUTY = 840;
          }
           //舵机保护
          FTM_PWM_Duty(FTM0, FTM_CH0, DUTY);
        } 


        /**********加速程序********/
        /*
        if (POINT_C <90 && POINT_C>70)
        {
        	FTM_PWM_Duty(FTM1, FTM_CH0, DUTY_MOTO_A);//左轮
      		FTM_PWM_Duty(FTM2, FTM_CH0, DUTY_MOTO_A);//右轮
        }
         */
         

        PORTC_ISFR = ~0;               //写1清中断标志位(必须的，不然回导致一开中断就马上触发中断)
        enable_irq(PORTC_IRQn);
        img_flag = IMG_START;
      }
    }
}

uint8 num;

/*!
 *  @brief      PORTB中断服务函数
 *  @since      v5.0
 */
void portb_handler()
{
    uint8  n;    //引脚号
    n = 7;                              //行中断
    if(PORTB_ISFR & (1 << n))           //PTB7触发中断
    {
      PORTB_ISFR  = (1 << n);        //写1清中断标志位
      HS++;
      V_Cnt++;
      if(V_Cnt <= CAMERA_H)
      {
        if(V_Cnt==sz[num])
        {
          systick_delay(450);
          DMA_EN(DMA_CH0);
          num++;
        }
      }
      
      else
      {
        disable_irq(PORTB_IRQn);
        img_flag = IMG_FINISH;
      }
      
    }


}

void portc_handler()
{
    uint8  n;    //引脚号
    n = 3;                               //场中断
    if(PORTC_ISFR & (1 << n))           //PTC3触发中断
    {
      PORTC_ISFR  = (1 << n);        //写1清中断标志位
      VS++;
      img_flag = IMG_GATHER;      
      DMA_DADDR(DMA_CH0) = (uint32)imgbuff;    //恢复地址
      V_Cnt = 0;
      num=0;
      enable_irq(PORTB_IRQn);
      disable_irq(PORTC_IRQn);
    }
}




