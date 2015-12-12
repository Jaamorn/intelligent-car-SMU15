/*!
 *     COPYRIGHT NOTICE
 *     Copyright (c) 2013,Ұ��Ƽ�
 *     All rights reserved.
 *     �������ۣ�Ұ���ѧ��̳ http://www.chuxue123.com
 *
 *     ��ע�������⣬�����������ݰ�Ȩ����Ұ��Ƽ����У�δ����������������ҵ��;��
 *     �޸�����ʱ���뱣��Ұ��Ƽ��İ�Ȩ������
 *
 * @file       MK60_uart.c
 * @brief      uart���ں���
 * @author     Ұ��Ƽ�
 * @version    v5.0
 * @date       2013-06-26
 */


#include "common.h"
#include "MK60_uart.h"

UART_MemMapPtr UARTN[UART_MAX] = {UART0_BASE_PTR, UART1_BASE_PTR, UART2_BASE_PTR, UART3_BASE_PTR, UART4_BASE_PTR, UART5_BASE_PTR}; //�������ָ�����鱣�� UARTN �ĵ�ַ


/*!
 *  @brief      ��ʼ�����ڣ����ò�����
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      baud        �����ʣ���9600��19200��56000��115200��
 *  @since      v5.0
 *  @note       UART���õĹܽ��� fire_drivers_cfg.h ��������ã�
                printf���õĹܽźͲ������� k60_fire.h ���������
 *  Sample usage:       uart_init (UART3, 9600);        //��ʼ������3��������Ϊ9600
 */
void uart_init (UARTn_e uratn, uint32 baud)
{
    register uint16 sbr, brfa;
    uint8 temp;
    uint32 sysclk;     //ʱ��

    /* ���� UART���ܵ� ���ùܽ� */
    switch(uratn)
    {
    case UART0:
        SIM_SCGC4 |= SIM_SCGC4_UART0_MASK;      //ʹ�� UART0 ʱ��

        if(UART0_RX == PTA1)
        {
            port_init( PTA1, ALT2);             //��PTA1��ʹ��UART0_RXD
        }
        else if(UART0_RX == PTA15)
        {
            port_init( PTA15, ALT3);            //��PTA15��ʹ��UART0_RXD
        }
        else if(UART0_RX == PTB16)
        {
            port_init( PTB16, ALT3);            //��PTB16��ʹ��UART0_RXD
        }
        else if(UART0_RX == PTD6)
        {
            port_init( PTD6, ALT3);             //��PTD6��ʹ��UART0_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }

        if(UART0_TX == PTA2)
        {
            port_init( PTA2, ALT2);             //��PTA2��ʹ��UART0_RXD
        }
        else if(UART0_TX == PTA14)
        {
            port_init( PTA14, ALT3);            //��PTA14��ʹ��UART0_RXD
        }
        else if(UART0_TX == PTB17)
        {
            port_init( PTB17, ALT3);            //��PTB17��ʹ��UART0_RXD
        }
        else if(UART0_TX == PTD7)
        {
            port_init( PTD7, ALT3);             //��PTD7��ʹ��UART0_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }

        break;

    case UART1:
        SIM_SCGC4 |= SIM_SCGC4_UART1_MASK;

        if(UART1_RX == PTC3)
        {
            port_init( PTC3, ALT3);             //��PTC3��ʹ��UART1_RXD
        }
        else if(UART1_RX == PTE1)
        {
            port_init( PTE1, ALT3);             //��PTE1��ʹ��UART1_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }

        if(UART1_TX == PTC4)
        {
            port_init( PTC4, ALT3);             //��PTC4��ʹ��UART1_RXD
        }
        else if(UART1_TX == PTE0)
        {
            port_init( PTE0, ALT3);             //��PTE0��ʹ��UART1_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }

        break;

    case UART2:
        SIM_SCGC4 |= SIM_SCGC4_UART2_MASK;
        port_init( PTD3, ALT3);                 //��PTD3��ʹ��UART2_TXD����
        port_init( PTD2, ALT3);                 //��PTD2��ʹ��UART2_RXD
        break;

    case UART3:
        SIM_SCGC4 |= SIM_SCGC4_UART3_MASK;

        if(UART3_RX == PTB10)
        {
            port_init( PTB10, ALT3);              //��PTB10��ʹ��UART3_RXD
        }
        else if(UART3_RX == PTC16)
        {
            port_init( PTC16, ALT3);             //��PTC16��ʹ��UART3_RXD
        }
        else if(UART3_RX == PTE5)
        {
            port_init( PTE5, ALT3);             //��PTE5��ʹ��UART3_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }

        if(UART3_TX == PTB11)
        {
            port_init( PTB11, ALT3);             //��PTB11��ʹ��UART3_RXD
        }
        else if(UART3_TX == PTC17)
        {
            port_init( PTC17, ALT3);            //��PTC17��ʹ��UART3_RXD
        }
        else if(UART3_TX == PTE4)
        {
            port_init( PTE4, ALT3);             //��PTE4��ʹ��UART3_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }
        break;

    case UART4:
        SIM_SCGC1 |= SIM_SCGC1_UART4_MASK;

        if(UART4_RX == PTC14)
        {
            port_init( PTC14, ALT3);            //��PTC14��ʹ��UART4_RXD
        }
        else if(UART4_RX == PTE25)
        {
            port_init( PTE25, ALT3);            //��PTE25��ʹ��UART4_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }

        if(UART4_TX == PTC15)
        {
            port_init( PTC15, ALT3);            //��PTC15��ʹ��UART4_RXD
        }
        else if(UART4_TX == PTE24)
        {
            port_init( PTE24, ALT3);            //��PTE24��ʹ��UART4_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }
        break;

    case UART5:
        SIM_SCGC1 |= SIM_SCGC1_UART5_MASK;

        if(UART5_RX == PTD8)
        {
            port_init( PTD8, ALT3);             //��PTD8��ʹ��UART5_RXD
        }
        else if(UART5_RX == PTE9)
        {
            port_init( PTE9, ALT3);             //��PTE9��ʹ��UART5_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }

        if(UART5_TX == PTD9)
        {
            port_init( PTD9, ALT3);             //��PTD9��ʹ��UART5_RXD
        }
        else if(UART5_TX == PTE8)
        {
            port_init( PTE8, ALT3);             //��PTE8��ʹ��UART5_RXD
        }
        else
        {
            ASSERT(0);                           //���������������㣬ֱ�Ӷ���ʧ���ˣ����ùܽ�����
        }
        break;
    default:
        break;
    }

    //���õ�ʱ��Ӧ�ý�ֹ���ͽ���
    UART_C2_REG(UARTN[uratn]) &= ~(0
                                   | UART_C2_TE_MASK
                                   | UART_C2_RE_MASK
                                  );


    //���ó�8λ��У��ģʽ
    //���� UART ���ݸ�ʽ��У�鷽ʽ��ֹͣλλ����ͨ������ UART ģ����ƼĴ��� C1 ʵ�֣�
    UART_C1_REG(UARTN[uratn]) |= (0
                                  //| UART_C2_M_MASK                    //9 λ�� 8 λģʽѡ�� : 0 Ϊ 8λ ��1 Ϊ 9λ��ע���˱�ʾ0����8λ�� �������9λ��λ8��UARTx_C3�
                                  //| UART_C2_PE_MASK                   //��żУ��ʹ�ܣ�ע���˱�ʾ���ã�
                                  //| UART_C2_PT_MASK                   //У��λ���� : 0 Ϊ żУ�� ��1 Ϊ ��У��
                                 );

    //���㲨���ʣ�����0��1ʹ���ں�ʱ�ӣ���������ʹ��busʱ��
    if ((uratn == UART0) || (uratn == UART1))
    {
        sysclk = core_clk_khz * 1000;                                   //�ں�ʱ��
    }
    else
    {
        sysclk = bus_clk_khz * 1000;                                    //busʱ��
    }

    //UART ������ = UART ģ��ʱ�� / (16 �� (SBR[12:0] + BRFA))
    //������ BRFA ������£� SBR = UART ģ��ʱ�� / (16 * UART ������)
    sbr = (uint16)(sysclk / (baud * 16));
    if(sbr > 0x1FFF)sbr = 0x1FFF;                                       //SBR �� 13bit�����Ϊ 0x1FFF

    //��֪ SBR ���� BRFA =  = UART ģ��ʱ�� / UART ������ - 16 ��SBR[12:0]
    brfa = (sysclk / baud)  - (sbr * 16);
    ASSERT( brfa <= 0x1F);                  //���ԣ������ֵ�����������������õ�����������Ĵ���������
                                            //����ͨ����������������������

    //д SBR
    temp = UART_BDH_REG(UARTN[uratn]) & (~UART_BDH_SBR_MASK);           //���� ��� SBR �� UARTx_BDH��ֵ
    UART_BDH_REG(UARTN[uratn]) = temp |  UART_BDH_SBR(sbr >> 8);        //��д��SBR��λ
    UART_BDL_REG(UARTN[uratn]) = UART_BDL_SBR(sbr);                     //��д��SBR��λ

    //д BRFD
    temp = UART_C4_REG(UARTN[uratn]) & (~UART_C4_BRFA_MASK) ;           //���� ��� BRFA �� UARTx_C4 ��ֵ
    UART_C4_REG(UARTN[uratn]) = temp |  UART_C4_BRFA(brfa);             //д��BRFA



    //����FIFO(FIFO���������Ӳ�������ģ������������)
    UART_PFIFO_REG(UARTN[uratn]) |= (0
                                     | UART_PFIFO_TXFE_MASK               //ʹ��TX FIFO(ע�ͱ�ʾ��ֹ)
                                     //| UART_PFIFO_TXFIFOSIZE(0)         //��ֻ����TX FIFO ��С��0Ϊ1�ֽڣ�1~6Ϊ 2^(n+1)�ֽ�
                                     | UART_PFIFO_RXFE_MASK               //ʹ��RX FIFO(ע�ͱ�ʾ��ֹ)
                                     //| UART_PFIFO_RXFIFOSIZE(0)         //��ֻ����RX FIFO ��С��0Ϊ1�ֽڣ�1~6Ϊ 2^(n+1)�ֽ�
                                    );

    /* �����ͺͽ��� */
    UART_C2_REG(UARTN[uratn]) |= (0
                                  | UART_C2_TE_MASK                     //����ʹ��
                                  | UART_C2_RE_MASK                     //����ʹ��
                                  //| UART_C2_TIE_MASK                  //�����жϻ�DMA��������ʹ�ܣ�ע���˱�ʾ���ã�
                                  //| UART_C2_TCIE_MASK                 //��������ж�ʹ�ܣ�ע���˱�ʾ���ã�
                                  //| UART_C2_RIE_MASK                  //�������жϻ�DMA��������ʹ�ܣ�ע���˱�ʾ���ã�
                                 );

    //�����Ƿ�������պͷ����жϡ�ͨ������ UART ģ��� C2 �Ĵ�����
    //RIE �� TIE λʵ�֡����ʹ���жϣ���������ʵ���жϷ������
}

/*!
 *  @brief      �ȴ�����1���ֽ�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      ch          ���յ�ַ
 *  @since      v5.0
 *  @note       �����Ҫ��ѯ����״̬������ uart_query ��
                �����Ҫ��ѯ�������ݣ����� uart_querychar
 *  Sample usage:       char ch = uart_getchar (UART3);   //�ȴ�����1���ֽڣ����浽 ch��
 */
void uart_getchar (UARTn_e uratn, char *ch)
{
    //�ȴ����յ����ݣ�ʹ����FIFO���������ַ��������У�����һ������˼��
    //while( !UART_RCFIFO_REG(UARTN[uratn]) );                                //�ȴ����յ�����������0
    //while( (UART_SFIFO_REG(UARTN[uratn]) & UART_SFIFO_RXEMPT_MASK)) ;     //�ȴ����ջ�����/FIFO �ǿյ�

    //���·����Ƿ�˼�����ٷ������ṩ�ķ���
    while (!(UART_S1_REG(UARTN[uratn]) & UART_S1_RDRF_MASK));       //�ȴ���������

    // ��ȡ���յ���8λ����
    *ch =  UART_D_REG(UARTN[uratn]);

    // ��ȡ 9λ���ݣ�Ӧ���ǣ���Ҫ�޸ĺ����ķ������ͣ���
    // *ch =   ((( UARTx_C3_REG(UARTN[uratn]) & UART_C3_R8_MASK ) >> UART_C3_R8_SHIFT ) << 8)   |   UART_D_REG(UARTN[uratn]);  //����9bit

}


/*!
 *  @brief      ��ѯ����1���ַ�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      ch          ���յ�ַ
 *  @return     1Ϊ���ճɹ���0Ϊ����ʧ��
 *  @since      v5.0
 *  @note       �����Ҫ�ȴ����գ����� uart_getchar
 *  Sample usage:       char ch ;
                        if( uart_querychar (UART3,&ch) == 1)     //��ѯ����1���ַ������浽 ch��
                        {
                            printf("�ɹ����յ�һ���ֽ�");
                        }
 */
char uart_querychar (UARTn_e uratn, char *ch)
{
    if( UART_RCFIFO_REG(UARTN[uratn]) )         //��ѯ�Ƿ���ܵ�����
    {
        *ch  =   UART_D_REG(UARTN[uratn]);      //���ܵ�8λ������
        return  1;                              //���� 1 ��ʾ���ճɹ�
    }

    *ch = 0;                                    //���ղ�����Ӧ������˽�����
    return 0;                                   //����0��ʾ����ʧ��
}


/*!
 *  @brief      ��ѯ�����ַ���
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      str         ���յ�ַ
 *  @param      max_len     �����ճ���
 *  @return     ���յ����ֽ���Ŀ
 *  @since      v5.0
 *  Sample usage:       char str[100];
                        uint32 num;
                        num = uart_pendstr (UART3,&str,100);
                        if( num != 0 )
                        {
                            printf("�ɹ����յ�%d���ֽ�:%s",num,str);
                        }
 */
char uart_querystr (UARTn_e uratn, char *str, uint32 max_len)
{
    uint32 i = 0;
    while(uart_querychar(uratn, str + i)  )
    {
        if( *(str + i) == NULL )    //���յ��ַ���������
        {
            return i;
        }

        i++;
        if(i >= max_len)            //�����趨�����ֵ���˳�
        {
            return i;
        }
    };

    return i;
}


/*!
 *  @brief      ��ѯ����buff
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      str         ���յ�ַ
 *  @param      max_len     �����ճ���
 *  @return     ���յ����ֽ���Ŀ
 *  @since      v5.0
 *  Sample usage:       char buff[100];
                        uint32 num;
                        num = uart_pendbuff (UART3,&buff,100);
                        if( num != 0 )
                        {
                            printf("�ɹ����յ�%d���ֽ�:%s",num,buff);
                        }
 */
char uart_querybuff (UARTn_e uratn, char *buff, uint32 max_len)
{
    uint32 i = 0;
    while(uart_querychar(uratn, buff + i))
    {
        i++;
        if(i >= max_len)            //�����趨�����ֵ���˳�
        {
            return i;
        }
    };

    return i;
}


/*!
 *  @brief      ���ڷ���һ���ֽ�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      ch          ��Ҫ���͵��ֽ�
 *  @since      v5.0
 *  @note       printf��Ҫ�õ��˺���
 *  @see        fputc
 *  Sample usage:       uart_putchar (UART3, 'A');  //�����ֽ�'A'
 */
void uart_putchar (UARTn_e uratn, char ch)
{
    //�ȴ����ͻ�������
    while(!(UART_S1_REG(UARTN[uratn]) & UART_S1_TDRE_MASK));

    //��������
    UART_D_REG(UARTN[uratn]) = (uint8)ch;
}

/*!
 *  @brief      ��ѯ�Ƿ���ܵ�һ���ֽ�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @return     ���յ����ݷ���1��û���յ����ݷ���0
 *  @since      v5.0
 *  Sample usage:       char ch;
                        if(uart_query (UART3) == 1)     //��ѯ�Ƿ���յ�����
                        {
                            ch = uart_getchar (UART3);  //�ȴ�����һ�����ݣ����浽 ch��
                        }
 */
char uart_query (UARTn_e uratn)
{
    if(UART_RCFIFO_REG(UARTN[uratn]))                 //���յ�����������0
        //if(!(UART_SFIFO_REG(UARTN[uratn]) & UART_SFIFO_RXEMPT_MASK))
        //if(UART_S1_REG(UARTN[uratn]) & UART_S1_TDRE_MASK)
    {
        return 1;
    }
    else
    {
        return 0;
    }
    //return UART_RCFIFO_REG(UARTN[uratn]);
}

/*!
 *  @brief      ����ָ��len���ֽڳ������� ������ NULL Ҳ�ᷢ�ͣ�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      buff        �����ַ
 *  @param      len         ��������ĳ���
 *  @since      v5.0
 *  Sample usage:       uart_putbuff (UART3,"1234567", 3); //ʵ�ʷ�����3���ֽ�'1','2','3'
 */
void uart_putbuff (UARTn_e uratn, uint8 *buff, uint32 len)
{
    while(len--)
    {
        uart_putchar(uratn, *buff);
        buff++;
    }
}


/*!
 *  @brief      �����ַ���(�� NULL ֹͣ����)
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @param      str         �ַ�����ַ
 *  @since      v5.0
 *  Sample usage:       uart_putstr (UART3,"1234567"); //ʵ�ʷ�����7���ֽ�
 */
void uart_putstr (UARTn_e uratn, const uint8 *str)
{
    while(*str)
    {
        uart_putchar(uratn, *str++);
    }
}

/*!
 *  @brief      �����ڽ����ж�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @since      v5.0
 *  Sample usage:       uart_rx_irq_en(UART3);         //������3�����ж�
 */
void uart_rx_irq_en(UARTn_e uratn)
{
    UART_C2_REG(UARTN[uratn]) |= UART_C2_RIE_MASK;                          //ʹ��UART�����ж�
    enable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));                  //ʹ��IRQ�ж�
}

/*!
 *  @brief      �����ڷ����ж�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @since      v5.0
 *  Sample usage:       uart_tx_irq_en(UART3);         //������3�����ж�
 */
void uart_tx_irq_en(UARTn_e uratn)
{
    UART_C2_REG(UARTN[uratn]) |= UART_C2_TIE_MASK;                          //ʹ��UART�����ж�
    enable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));                  //ʹ��IRQ�ж�
}

/*!
 *  @brief      �����ڷ�������ж�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @since      v5.0
 *  Sample usage:       uart_tx_irq_en(UART3);         //������3�����ж�
 */
void uart_txc_irq_en(UARTn_e uratn)
{
    UART_C2_REG(UARTN[uratn]) |= UART_C2_TCIE_MASK;                         //ʹ��UART�����ж�
    enable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));                  //ʹ��IRQ�ж�
}

/*!
 *  @brief      �ش��ڽ����ж�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @since      v5.0
 *  Sample usage:       uart_rx_irq_dis(UART3);         //�ش���3�����ж�
 */
void uart_rx_irq_dis(UARTn_e uratn)
{
    UART_C2_REG(UARTN[uratn]) &= ~UART_C2_RIE_MASK;                         //��ֹUART�����ж�

    //��������жϻ�û�йأ��򲻹ر�IRQ
    if(!(UART_C2_REG(UARTN[uratn]) & (UART_C2_TIE_MASK | UART_C2_TCIE_MASK)) )
    {
        disable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));             //��IRQ�ж�
    }
}

/*!
 *  @brief      �ش��ڷ����ж�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @since      v5.0
 *  Sample usage:       uart_tx_irq_dis(UART3);         //�ش���3�����ж�
 */
void uart_txc_irq_dis(UARTn_e uratn)
{
    UART_C2_REG(UARTN[uratn]) &= ~UART_C2_TCIE_MASK;                        //��ֹUART��������ж�

    //��������жϻ�û�йأ��򲻹ر�IRQ
    if(!(UART_C2_REG(UARTN[uratn]) & UART_C2_RIE_MASK) )
    {
        disable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));             //��IRQ�ж�
    }
}

/*!
 *  @brief      �ش��ڷ����ж�
 *  @param      UARTn_e       ģ��ţ�UART0~UART5��
 *  @since      v5.0
 *  Sample usage:       uart_tx_irq_dis(UART3);         //�ش���3�����ж�
 */
void uart_tx_irq_dis(UARTn_e uratn)
{
    UART_C2_REG(UARTN[uratn]) &= ~UART_C2_TIE_MASK;                         //��ֹUART�����ж�

    //��������жϻ�û�йأ��򲻹ر�IRQ
    if(!(UART_C2_REG(UARTN[uratn]) & UART_C2_RIE_MASK) )
    {
        disable_irq((IRQn_t)((uratn << 1) + UART0_RX_TX_IRQn));             //��IRQ�ж�
    }
}

/*!
 *  @brief      UART3�����жϷ�����
 *  @since      v5.0
 *  @warning    �˺�����Ҫ�û������Լ�������ɣ�����������ṩһ��ģ��
 *  Sample usage:       set_vector_handler(UART3_RX_TX_VECTORn , uart3_test_handler);    //�� uart3_handler ������ӵ��ж�����������Ҫ�����ֶ�����
 */
void uart3_test_handler(void)
{
    UARTn_e uratn = UART3;

    if(UART_S1_REG(UARTN[uratn]) & UART_S1_RDRF_MASK)   //�������ݼĴ�����
    {
        //�û���Ҫ�����������

    }

    if(UART_S1_REG(UARTN[uratn]) & UART_S1_TDRE_MASK )  //�������ݼĴ�����
    {
        //�û���Ҫ����������

    }
}