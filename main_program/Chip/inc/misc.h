/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,Ұ��Ƽ�
 *     All rights reserved.
 *     �������ۣ�Ұ���ѧ��̳ http://www.chuxue123.com
 *
 *     ��ע�������⣬�����������ݰ�Ȩ����Ұ��Ƽ����У�δ����������������ҵ��;��
 *     �޸�����ʱ���뱣��Ұ��Ƽ��İ�Ȩ������
 *
 * @file       misc.h
 * @brief      Ұ��K60 ƽ̨������Ҫ�õ��ĺ�����ʵ��
 * @author     Ұ��Ƽ�
 * @version    v5.0
 * @date       2013-06-26
 */

#ifndef __MISC_H__
#define __MISC_H__

#include "common.h"


void write_vtor (int);                                              //�����ж�������ĵ�ַ
void set_vector_handler(VECTORn_t , void pfunc_handler(void));      //�����жϺ������ж���������


//���ݾɴ���
#define enable_irq(irq)                 NVIC_EnableIRQ(irq)         //ʹ��IRQ
#define disable_irq(irq)                NVIC_DisableIRQ(irq)        //��ֹIRQ
#define set_irq_priority(irq,pri0)      NVIC_SetPriority(irq,pri0)  //�������ȼ�


#define EnableInterrupts                asm(" CPSIE i");            //ʹ��ȫ���ж�
#define DisableInterrupts               asm(" CPSID i");            //��ֹȫ���ж�

void fire_cpy( uint8 *dst, uint8 *src, uint32 count);

#endif  /* __MISC_H__ */

