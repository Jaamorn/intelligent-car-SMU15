/***************************�����Ƶ���****************************
**  �������ƣ�YS-SYN6288�����ϳ����׳���
**	CPU: STC89LE52
**	����22.1184MHZ
**	�����ʣ�9600 bit/S
**	���ײ�Ʒ��Ϣ��YS-SYN6288�����ϳ�ģ��
**                http://yuesheng001.taobao.com
**  ���ߣ�zdings
**  ��ϵ��751956552@qq.com
**  �޸����ڣ�2012.8.25
**  ˵��������
/***************************�����Ƶ���******************************/

//#include "config.h"
#include "common.h"
#include "SYN6288.h"
#include "string.h"
#include "MK60_uart.h"



/**************оƬ��������*********************/
uint8 SYN_StopCom[]={0xFD,0X00,0X02,0X02,0XFD};//ֹͣ�ϳ�
uint8 SYN_SuspendCom[]={0XFD,0X00,0X02,0X03,0XFC};//��ͣ�ϳ�
uint8 SYN_RecoverCom[]={0XFD,0X00,0X02,0X04,0XFB};//�ָ��ϳ�
uint8 SYN_ChackCom[]={0XFD,0X00,0X02,0X21,0XDE};//״̬��ѯ
uint8 SYN_PowerDownCom[]={0XFD,0X00,0X02,0X88,0X77};//����POWER DOWN ״̬����

/***********************************************/



/***********************************************************
* ��    �ƣ�  YS-SYN6288 �ı��ϳɺ���
* ��    �ܣ�  ���ͺϳ��ı���SYN6288оƬ���кϳɲ���
* ��ڲ�����Music(��������ѡ��):0�ޱ������֡�1-15����ر�������
            *HZdata:�ı�ָ����� 
* ���ڲ�����
* ˵    ���� ������ֻ�����ı��ϳɣ��߱���������ѡ��Ĭ�ϲ�����9600bps��					 
* ���÷��������� SYN_FrameInfo��0�����������ӿƼ�������
**********************************************************/
void SYN_FrameInfo(uint8 Music,char *HZdata)
{
/****************��Ҫ���͵��ı�**********************************/ 
    unsigned  char  Frame_Info[50];
    unsigned  char  HZ_Length;  
    unsigned  char  ecc  = 0;  			//����У���ֽ�
    unsigned  int i=0;
	int count=0;
    HZ_Length =strlen(HZdata); 			//��Ҫ�����ı��ĳ���
 
/*****************֡�̶�������Ϣ**************************************/           
		 Frame_Info[0] = 0xFD ; 			//����֡ͷFD
		 Frame_Info[1] = 0x00 ; 			//�������������ȵĸ��ֽ�
		 Frame_Info[2] = HZ_Length + 3; 		//�������������ȵĵ��ֽ�
		 Frame_Info[3] = 0x01 ; 			//���������֣��ϳɲ�������		 		 
		 Frame_Info[4] = 0x01 | Music<<4 ;  //����������������������趨
		 

/*******************У�������***************************************/		 
		 for(i = 0; i<5; i++)   				//���η��͹���õ�5��֡ͷ�ֽ�
	     {   
	         ecc=ecc^(Frame_Info[i]);		//�Է��͵��ֽڽ������У��	
             uart_putchar (UART5,Frame_Info[i]);
			 //while(count==0);
			 //count=0;
			 
	     }

	   	 for(i= 0; i<HZ_Length; i++)   		//���η��ʹ��ϳɵ��ı�����
	     {   
	         ecc=ecc^(HZdata[i]); 				//�Է��͵��ֽڽ������У��
	         uart_putchar (UART5,HZdata[i]);
			 //while(count==0);
			// count=0;
	     }
		 
		     
                 uart_putchar (UART5,ecc);
			 //while(count==0);
			 //count=0;
			 
		 
/*******************����֡��Ϣ***************************************/		  
		  //memcpy(&Frame_Info[5], HZdata, HZ_Length);
		  //Frame_Info[5+HZ_Length]=ecc;
		  //PrintCom(Frame_Info,5+HZ_Length+1);
}


/***********************************************************
* ��    �ƣ� void  main(void)
* ��    �ܣ� ������	�������
* ��ڲ����� *Info_data:�̶���������Ϣ���� 
* ���ڲ�����
* ˵    �����������������ã�ֹͣ�ϳɡ���ͣ�ϳɵ����� ��Ĭ�ϲ�����9600bps��					 
* ���÷�����ͨ�������Ѿ�������������������á� 
**********************************************************/
/***void YS_SYN_Set(char *Info_data)
{
	uint8_t Com_Len;
	Com_Len =strlen(Info_data);
	PrintCom(Info_data,Com_Len);
}***/




