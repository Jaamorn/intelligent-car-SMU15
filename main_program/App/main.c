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
 * 香港记者 2016-1-24
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
#define Jump_threshold 40 //定义跳变阀值
#define Interval 3 //定义跳变检测宽度
#define Tracking_displacement 7 //决定寻线起始位置
#define Tracking_NUM 12 //定义寻线范围
//#define L 39 //定义要采集的行号



uint16 DUTY;//舵机输出占空比
uint8 center;//图像中线
uint8 mid_count;//用于中线计数
uint8 L;//起始行
uint8 flag_left[40];//左线标志位数组
uint8 FLAG_L=0; //左底线标志位 0丢失1未丢失
uint8 flag_right[40];//右线标志位
uint8 FLAG_R=0; //右底线标志位 0丢失1未丢失
uint8 flag_acc;//加速标志位
uint8 flag_slo;//低速标志位
uint8 left_line[40],right_line[40],mid_line[40];//左右中线数组

uint8 imgbuff[CAMERA_R_H][CAMERA_W];                             //定义存储接收图像的数组

uint8 V_Cnt = 0;
volatile IMG_STATUS_e      img_flag = IMG_START;        //图像状态

uint16 VS=0;
uint16 HS=0;

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
      int DUTY_MOTO = 190;//默认速度//200
      int DUTY_MOTO_A = 245;//加速速度//240
      int DUTY_MOTO_S = 170;//减速速度//170
     
      //电机pwm初始化
      FTM_PWM_init(FTM1, FTM_CH0,10000,0);//A12
      FTM_PWM_init(FTM1, FTM_CH1,10000,0);//A13 
           
      FTM_PWM_init(FTM2, FTM_CH0,10000,0);//B18
      FTM_PWM_init(FTM2, FTM_CH1,10000,0);//B19

      
  
  
  
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
    
   
    while(1)//主控制循环
    {  
      
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
        
       /**********扫描第L行*************/
         flag_left[L]=0;
         flag_right[L]=0;
         FLAG_L=0;
         FLAG_R=0;
         L=39;
        for (int i = 80; i>=4; i--)//找左线
        {
          if(imgbuff[L][i]-imgbuff[L][i-Interval] >= Jump_threshold )
          {
            left_line[L] = i;
            flag_left[L]=1;
            FLAG_L = 1;     
            break;
          }
        }

        for (int i = 70; i <= CAMERA_W-4; i++)//找右线
        {
          if(imgbuff[L][i]-imgbuff[L][i+Interval]>=Jump_threshold )
          {
            right_line[L] = i;          
            flag_right[L]=1;
            FLAG_R = 1;
            break;
          }
        }        
        
        /*******黑线跟踪********/
        //左
        if ( flag_left[L] == 1 )
        {
          for(int i=L;i>=1;i--)
          {
            for (int j=0;j<Tracking_NUM;j++)
            {
              if (imgbuff[i-1][left_line[i]+Tracking_displacement-j]-imgbuff[i-1][left_line[i]-j+Tracking_displacement-Interval]>=Jump_threshold)
              {
                left_line[i-1]=left_line[i]+Tracking_displacement-j;
                flag_left[i-1]=1;
                break;
              }
              else
              {
                flag_left[i-1]=0;
                flag_acc=0;
              }
            }
          }
        }
        //右
        if(flag_right[L] == 1)
        {
          for(int i = L;i>=1;i--)
          {
            for (int j=0;j<Tracking_NUM;j++)
            {
              if (imgbuff[i-1][right_line[i]-Tracking_displacement+j]-imgbuff[i-1][right_line[i]-Tracking_displacement+j+Interval]>=Jump_threshold)
              {
                right_line[i-1]=right_line[i]-Tracking_displacement+j;
                flag_right[i-1]=1;
                break;
              }
              else
              {
                flag_right[i-1]=0;
                flag_acc=0;
              }
            }
          }
        }


        
        /****中值计算*****/

        int mid=0;
        int left=0;
        int right=0;
        flag_slo=0;
        flag_acc=1;
        mid_count=0;
        /*********小s判断 为减慢直到速度没有使用*********/
        /*
        if(flag_right[2]==1 && flag_left[2]==1)
        {
        	for(int i=2;i<=38;i++)
        	{
        		mid_line[i]=(left_line[i]+right_line[i])/2;
        		mid=mid+mid_line[i];
                    mid_count++;
                    flag_acc=1;
        	}
        	center=mid/mid_count;
        }
        */
        if(FLAG_R==1 && FLAG_L==1)
        {
            for(int i=20;i<=38;i++)
            {
               mid_line[i]=(left_line[i]+right_line[i])/2;
               mid=mid+mid_line[i];
               mid_count++;
            }
            center = mid/mid_count;          
        }
        else if (FLAG_R==0 && FLAG_L==0)//丢两条线
        {
          /********搜索20行 提高十字稳定性*******/
          L=20;
          for (int i = 95; i>=4; i--)//找左线
          {
             if(imgbuff[L][i]-imgbuff[L][i-Interval] >= Jump_threshold )
             {
               left_line[L] = i;
               flag_left[L]=1;  
               break;
             }
             else
             {
                flag_left[L]=0;
                flag_slo=0;
             }
          }

          for (int i = 65; i <= CAMERA_W-4; i++)//找右线
          {
          if(imgbuff[L][i]-imgbuff[L][i+Interval]>=Jump_threshold )
           {
              right_line[L] = i;          
              flag_right[L]=1;
              break;
              
           }
          else
           {
            flag_right[L]=0;
            flag_slo=0;
           }         
          }
          /******根据20行数据计算中线*******/
          if(flag_right[L]==1 && flag_left[L]==1)
          {
           center=(right_line[L]+left_line[L])/2;
           flag_acc=1;
           flag_slo=1;
          }
          else
          {
            center=80;
            flag_slo=1;
          }
        }
         
        /***********丢失右线***********/
        
        else if (FLAG_L==1 && FLAG_R==0)
        {
          for(int i=20;i<=38;i++)
          {
            left=left+left_line[i];
          }
          left=left/19;
          center=left+45;//原70
          flag_slo=1;
        }
        
        /***********丢失左线***********/
        
        else if (FLAG_L==0 && FLAG_R==1)
        {
          for(int i=20;i<=38;i++)
          {
            right=right+right_line[i];
          }
          right=right/19;
          center = right-50;
          flag_slo=1;
        }
        
        
        LCD_Show_Number(70,1,center);
        LCD_Show_Number(70,2,FLAG_L);
        LCD_Show_Number(70,3,FLAG_R);






         /***********舵机控制程序***********/
        int MID= 80;//设定参考中点值
        FTM_PWM_init(FTM0, FTM_CH0,50,775);   //初始化舵机PWM输出中值 PTC1  775
        if(center > MID)//右拐
        {
            DUTY = 775 - 2*(center - MID);
            //舵机保护
            if(DUTY<702)
            {
              DUTY = 702;
            }
        }  


        
        if(center<MID)//左拐
        {
            DUTY = 775 + 2*(MID - center);
            //舵机保护
            if(DUTY>850)
            {
              DUTY = 850;
            }
        } 
         
        FTM_PWM_Duty(FTM0, FTM_CH0, DUTY);
        
        
        
        /*********速度控制程序*********/

        if(center>=70 && center<=90 && flag_acc==1)//加速判定
        {
           FTM_PWM_Duty(FTM1, FTM_CH0, DUTY_MOTO_A);//左轮
           FTM_PWM_Duty(FTM2, FTM_CH0, DUTY_MOTO_A);//右轮
           LCD_Show_Number(70,5,flag_acc);
        }
        else if(flag_slo==1)//低速判定
        {
           FTM_PWM_Duty(FTM1, FTM_CH0, DUTY_MOTO_S);//左轮
           FTM_PWM_Duty(FTM2, FTM_CH0, DUTY_MOTO_S);//右轮
        }
        else//输出默认速度
        {
            FTM_PWM_Duty(FTM1, FTM_CH0, DUTY_MOTO);//左轮
            FTM_PWM_Duty(FTM2, FTM_CH0, DUTY_MOTO);//右轮
        }
         
        

        PORTC_ISFR = ~0;               //写清中断标志位(必须的，不然回导致一开中断就马上触发中断)
        enable_irq(PORTC_IRQn);
        img_flag = IMG_START;
      }
    }
}

uint8 num;

/*
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




