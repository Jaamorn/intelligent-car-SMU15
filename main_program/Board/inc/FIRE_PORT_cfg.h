/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,Ұ��Ƽ�
 *     All rights reserved.
 *     �������ۣ�Ұ���ѧ��̳ http://www.chuxue123.com
 *
 *     ��ע�������⣬�����������ݰ�Ȩ����Ұ��Ƽ����У�δ����������������ҵ��;��
 *     �޸�����ʱ���뱣��Ұ��Ƽ��İ�Ȩ������
 *
 * @file       fire_port_cfg.h
 * @brief      Ұ��K60 ���ùܽ�����
 * @author     Ұ��Ƽ�
 * @version    v5.0
 * @date       2013-06-26
 */
#ifndef _FIRE_DRIVERS_CFG_H_
#define _FIRE_DRIVERS_CFG_H_

#include "MK60_port.h"

/**********************************  UART   ***************************************/

//      ģ��ͨ��    �˿�          ��ѡ��Χ                          ����
#define UART0_RX    PTA15        //PTA1��PTA15��PTB16��PTD6          PTA1��Ҫ�ã���Jtag��ͻ��
#define UART0_TX    PTA14        //PTA2��PTA14��PTB17��PTD7          PTA2��Ҫ�ã���Jtag��ͻ��

#define UART1_RX    PTC3        //PTC3��PTE1
#define UART1_TX    PTC4        //PTC4��PTE0

#define UART2_RX    PTD2        //PTD2
#define UART2_TX    PTD3        //PTD3

#define UART3_RX    PTE5       //PTB10��PTC16��PTE5
#define UART3_TX    PTE4       //PTB11��PTC17��PTE4

#define UART4_RX    PTE25       //PTC14��PTE25
#define UART4_TX    PTE24       //PTC15��PTE24

#define UART5_RX    PTE9        //PTD8��PTE9
#define UART5_TX    PTE8        //PTD9��PTE8

/**********************************  FTM    ***************************************/

//      ģ��ͨ��    �˿�          ��ѡ��Χ              ����
#define FTM0_CH0    PTC1        //PTC1��PTA3            PTA3��Ҫ�ã���Jtag��SWD��ͻ��
#define FTM0_CH1    PTA4        //PTC2��PTA4
#define FTM0_CH2    PTA5        //PTC3��PTA5
#define FTM0_CH3    PTA6        //PTC4��PTA6
#define FTM0_CH4    PTA7        //PTD4��PTA7
#define FTM0_CH5    PTD5        //PTD5��PTA0            PTA0��Ҫ�ã���Jtag��SWD��ͻ��
#define FTM0_CH6    PTD6        //PTD6��PTA1            PTA1��Ҫ�ã���Jtag��ͻ��
#define FTM0_CH7    PTD7        //PTD7��PTA2            PTA2��Ҫ�ã���Jtag��ͻ��


//      ģ��ͨ��    �˿�          ��ѡ��Χ              ����
#define FTM1_CH0    PTA12       //PTA8��PTA12��PTB0
#define FTM1_CH1    PTA13       //PTA9��PTA13��PTB1

//      ģ��ͨ��    �˿�          ��ѡ��Χ              ����
#define FTM2_CH0    PTA10       //PTA10��PTB18
#define FTM2_CH1    PTA11       //PTA11��PTB19


//��������ģ��ͨ��  �˿�          ��ѡ��Χ              ����
#define FTM1_QDPHA  PTA12       //PTA8��PTA12��PTB0
#define FTM1_QDPHB  PTA13       //PTA9��PTA13��PTB1

#define FTM2_QDPHA  PTA10       //PTA10��PTB18
#define FTM2_QDPHB  PTA11       //PTA11��PTB19


/**********************************  I2C   ***************************************/

//      ģ��ͨ��    �˿�          ��ѡ��Χ              ����
#define I2C0_SCL    PTD8        // PTB0��PTB2��PTD8
#define I2C0_SDA    PTD9        // PTB1��PTB3��PTD9

#define I2C1_SCL    PTC10       // PTE1��PTC10
#define I2C1_SDA    PTC11       // PTE0��PTC11


/**********************************  SPI   ***************************************/
//PCS�ӿڣ����õ�ʱ����Ҫע�ͣ��Ͳ�����г�ʼ����Ӧ�Ĺܽ�
//      ģ��ͨ��    �˿�          ��ѡ��Χ                  ����

#define SPI0_SCK    PTA15       // PTA15��PTC5��PTD1        ȫ������ ALT2
#define SPI0_SOUT   PTA16       // PTA16��PTC6��PTD2        ȫ������ ALT2
#define SPI0_SIN    PTA17       // PTA17��PTC7��PTD3        ȫ������ ALT2

#define SPI0_PCS0   PTA14       // PTA14��PTC4��PTD0��      ȫ������ ALT2
#define SPI0_PCS1   PTC3        // PTC3��PTD4               ȫ������ ALT2
#define SPI0_PCS2   PTC2        // PTC2��PTD5               ȫ������ ALT2
#define SPI0_PCS3   PTC1        // PTC1��PTD6               ȫ������ ALT2
#define SPI0_PCS4   PTC0        // PTC0��                   ȫ������ ALT2
#define SPI0_PCS5   PTB23       // PTB23                    ALT3


#define SPI1_SCK    PTB11       // PTE2��PTB11��            ȫ������ ALT2
#define SPI1_SOUT   PTB16       // PTE1��PTB16��            ȫ������ ALT2
#define SPI1_SIN    PTB17       // PTE3��PTB17��            ȫ������ ALT2

#define SPI1_PCS0   PTE4        // PTE4��PTB10��            ȫ������ ALT2
#define SPI1_PCS1   PTE0        // PTE0��PTB9��             ȫ������ ALT2
#define SPI1_PCS2   PTE5        // PTE5��                   ȫ������ ALT2
#define SPI1_PCS3   PTE6        // PTE6��                   ȫ������ ALT2


#define SPI2_SCK    PTB21       // PTB21��PTD12             ȫ������ ALT2
#define SPI2_SOUT   PTB22       // PTB22��PTD13             ȫ������ ALT2
#define SPI2_SIN    PTB23       // PTB23��PTD14             ȫ������ ALT2
#define SPI2_PCS0   PTB20       // PTB20��PTD11             ȫ������ ALT2
#define SPI2_PCS1   PTD15       // PTD15                    ȫ������ ALT2


/**********************************  CAN   ***************************************/
#define CAN0_TX     PTA12       //PTA12��PTB18              ȫ������ ALT2
#define CAN0_RX     PTA13       //PTA13��PTB19              ȫ������ ALT2

#define CAN1_TX     PTE24       //PTE24��PTC17              ȫ������ ALT2
#define CAN1_RX     PTE25       //PTE25��PTC16              ȫ������ ALT2


#endif  //_FIRE_DRIVERS_CFG_H_


