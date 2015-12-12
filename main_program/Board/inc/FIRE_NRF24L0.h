/******************** (C) COPYRIGHT 2011 Ұ��Ƕ��ʽ���������� ********************
 * �ļ���       ��NRF24L0.h
 * ����         ��NRF24L0������
 *
 * ʵ��ƽ̨     ��Ұ��kinetis������
 * ��汾       ��
 * Ƕ��ϵͳ     ��
 *
 * ����         ��Ұ��Ƕ��ʽ����������
 * �Ա���       ��http://firestm32.taobao.com
 * ����֧����̳ ��http://www.ourdev.cn/bbs/bbs_list.jsp?bbs_id=1008
**********************************************************************************/
#ifndef _NRF24L0_H_
#define _NRF24L0_H_     1


//������Ӳ������
#define NRF_SPI         SPI0
#define NRF_CS          SPIn_PCS0

#define NRF_CE_PTXn     PTA25
#define NRF_IRQ_PTXn    PTA19

//�������û����õ�ѡ��

#define DATA_PACKET             32      //һ�δ�������֧�ֵ��ֽ�����1~32��
#define RX_FIFO_PACKET_NUM      80      //���� FIFO �� �� ��Ŀ ( �ܿռ� ����Ҫ���� һ��ͼ��Ĵ�С������ û�������� )
#define ADR_WIDTH               5       //�����ַ���ȣ�3~5��
#define IS_CRC16                1       //1��ʾʹ�� CRC16��0��ʾ ʹ��CRC8 (0~1)


//���õ��������

typedef enum
{
    NRF_TXING,              //������
    NRF_TX_ERROR,           //���ʹ���
    NRF_TX_OK,              //�������
} nrf_tx_state_e;


//��������
extern  uint8   nrf_init(void);              //��ʼ��NRF24L01+

extern  uint8   nrf_link_check(void);        //���NRF24L01+�뵥Ƭ���Ƿ�ͨ������

extern  uint32  nrf_rx(uint8 *rxbuf, uint32 len);   //����
extern  uint8   nrf_tx(uint8 *txbuf, uint32 len);   //����

extern  nrf_tx_state_e nrf_tx_state ();             //����״̬(�������ݺ��ѯ�Ƿ��ͳɹ�)


extern  void    nrf_handler(void);                  //NRF24L01+ �� �жϷ�����

//����ĺ��� ���� ������Ϣ������� �ĺ���ʹ�ã�һ���û��ò���
extern  uint8  nrf_rx_fifo_check(uint32 offset,uint16 * val);    //��ȡ ����FIFO ������


#endif      //_NRF24L0_H_
