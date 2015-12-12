/******************** (C) COPYRIGHT 2011 Ұ��Ƕ��ʽ���������� ********************
 * �ļ���       ��exti.c
 * ����         ��EXTI�ⲿGPIO�ж�����
 *
 * ʵ��ƽ̨     ��Ұ��kinetis������
 * ��汾       ��
 * Ƕ��ϵͳ     ��
 *
 * ����         ��Ұ��Ƕ��ʽ����������
 * �Ա���       ��http://firestm32.taobao.com
 * ����֧����̳ ��http://www.ourdev.cn/bbs/bbs_list.jsp?bbs_id=1008
**********************************************************************************/

#include "common.h"
#include "MK60_gpio.h"
#include "exti.h"



/*************************************************************************
*                             Ұ��Ƕ��ʽ����������
*
*  �������ƣ�exti_init
*  ����˵����EXTI�ⲿGPIO�жϳ�ʼ��
*  ����˵����PORTx       �˿ںţ�PORTA,PORTB,PORTC,PORTD,PORTE��
*            n           �˿�����
*            exti_cfg    ����ѡ�����������ѡ��
*  �������أ���
*  �޸�ʱ�䣺2012-1-20
*  ��    ע��
*************************************************************************/
void  exti_init(PTXn_e ptxn, uint8 n, exti_cfg cfg)
{
    SIM_SCGC5 |= (SIM_SCGC5_PORTA_MASK << PTX(ptxn));    //����PORTx�˿�

    PORT_PCR_REG(PTXn_e [ptxn], n) = PORT_PCR_MUX(1) | PORT_PCR_IRQC(cfg & 0x7f ) | PORT_PCR_PE_MASK | ((cfg & 0x80 ) >> 7); // ����GPIO , ȷ������ģʽ ,������������������
    GPIO_PDDR_REG(GPIOx[portx]) &= ~(1 << n);       //����ģʽ
    enable_irq(portx + 87);                         //ʹ��PORT�жϣ�PORTA��ISR�жϺ�Ϊ87
}