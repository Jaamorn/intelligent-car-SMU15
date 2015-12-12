/***************************乐声电子科技有限公司****************************
**  工程名称：YS-SYN6288语音合成配套程序
**	CPU: STC89LE52
**	晶振：22.1184MHZ
**	波特率：9600 bit/S
**	配套产品信息：YS-SYN6288语音合成模块
**                http://yuesheng001.taobao.com
**  作者：zdings
**  联系：751956552@qq.com
**  修改日期：2012.8.25
**  说明：。。
*****************************************************************************/



#ifndef SYN6288_H
#define SYN6288_H

extern void SYN_FrameInfo(uint8 Music,char *HZdata);
extern void YS_SYN_Set(char *Info_data);


#endif