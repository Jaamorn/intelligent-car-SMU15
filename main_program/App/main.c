/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,Ұ��Ƽ�
 *     All rights reserved.
 *     �������ۣ�Ұ���ѧ��̳ http://www.chuxue123.com
 *
 *     ��ע�������⣬�����������ݰ�Ȩ����Ұ��Ƽ����У�δ������������������ҵ��;��
 *     �޸�����ʱ���뱣��Ұ��Ƽ��İ�Ȩ������
 *
 * @file       main.c
 * @brief      Ұ��K60 ƽ̨������
 * @author     Ұ��Ƽ�
 * @version    v5.0
 * @date       2013-08-28
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


#define CAMERA_W            200              //��������ͷͼ�����
#define CAMERA_H            240              //��������ͷͼ��߶�
#define CAMERA_R_H          40               //��������ͷͼ��߶�
#define CAMERA_SIZE         CAMERA_W*CAMERA_H
#define BLACK_C 0
#define WHITE_C 254


uint8 imgbuff[CAMERA_R_H][CAMERA_W];                             //����洢����ͼ�������

uint8 V_Cnt = 0;
volatile IMG_STATUS_e      img_flag = IMG_START;        //ͼ��״̬

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


//��������
void portb_handler();
void portc_handler();




void  main(void)
{
  
    DisableInterrupts;
    LED_init();
    uart_init (UART4, 115200);                        

    exti_init(PTC3,rising_up);                           //VS
    exti_init(PTB7,rising_down);                         //HS
    port_init(PTC0, ALT1 | DMA_FALLING | PULLUP );       //PCLK

    set_vector_handler(PORTB_VECTORn , portb_handler);   //�����жϸ�λ����Ϊ PORTB_IRQHandler
    set_vector_handler(PORTC_VECTORn , portc_handler);   //�����жϸ�λ����Ϊ PORTC_IRQHandler
    
     //DMAͨ��0��ʼ����PTA27����Դ(Ĭ��������)��Դ��ַΪPTE_B0_IN��Ŀ�ĵ�ַΪ��IMG_BUFF��ÿ�δ���1Byte
    dma_portx2buff_init(DMA_CH0, (void *)&PTE_B0_IN, (void *)imgbuff, PTC0, DMA_BYTE1, CAMERA_W, DADDR_KEEPON);
    
    enable_irq (PORTC_IRQn);
    
    EnableInterrupts;
    
   
    while(1)
    {  
      LCD_Show_Number(5,2,123);
      if(img_flag == IMG_FINISH)
      {
        img_flag = IMG_PROCESS;
        
        /********���ڷ��ͳ���*************/
        
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
        
        /*************Һ������ʾ����**********/
        
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
        
        
        PORTC_ISFR = ~0;               //д1���жϱ�־λ(����ģ���Ȼ�ص���һ���жϾ����ϴ����ж�)
        enable_irq(PORTC_IRQn);
        img_flag = IMG_START;
      }
    }
}

uint8 num;

/*!
 *  @brief      PORTB�жϷ�����
 *  @since      v5.0
 */
void portb_handler()
{
    uint8  n;    //���ź�
    n = 7;                              //���ж�
    if(PORTB_ISFR & (1 << n))           //PTB7�����ж�
    {
      PORTB_ISFR  = (1 << n);        //д1���жϱ�־λ
      HS++;
      V_Cnt++;
      if(V_Cnt <= CAMERA_H)
      {
        if(V_Cnt==sz[num])
        {
          systick_delay(400);
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
    uint8  n;    //���ź�
    n = 3;                               //���ж�
    if(PORTC_ISFR & (1 << n))           //PTC3�����ж�
    {
      PORTC_ISFR  = (1 << n);        //д1���жϱ�־λ
      VS++;
      img_flag = IMG_GATHER;      
      DMA_DADDR(DMA_CH0) = (uint32)imgbuff;    //�ָ���ַ
      V_Cnt = 0;
      num=0;
      enable_irq(PORTB_IRQn);
      disable_irq(PORTC_IRQn);
    }
}



