#include "mohu.h"


int Fuzzy_kp(int P,int D,char m) 
{
    int ZO= 20;
    int PS= 25;
    int PM= 32;
    int PB= 40;
    #define FMAX 100
    #define DMAX 100
  
    char Pn=0,Dn=0;
    int t1,t2,t3,t4;
    int Un[4];
    int  PF[2],DF[2];
    int U;

    int PFF[4]={20,60,100,180};    //偏差的变化范围，从左向右为ZO，PS，PM，PL    
    int DFF[7]={-25,-15,-5,0,5,15,25};       //偏差微分的变化范围，从左向右为ZO，PS，PM，PL

    int rule[7][4]={
//误差   0,  1,  2,  3      // 变化
        {PS, PM, PB, PB},   //   -3
        {ZO, PS, PM, PB},   //   -2
        {ZO, PS, PM, PB},   //   -1
        {ZO, ZO, PS, PM},   //   0
        {ZO, PS, PM, PB},   //   1
        {ZO, PS, PM, PB},   //   2
        {PS, PM, PB, PB},   //   3
    };

     //求偏差的隶属度
    if(P<PFF[0])
    {
       Pn=2;
       PF[0]=100; 
    }
    else if(P<PFF[1])
    {
       Pn=2;
       PF[0]=(int)(FMAX*(PFF[1]-P)/(PFF[1]-PFF[0]));    
    }
    else if(P<PFF[2])
    {
       Pn=3;
       PF[0]=(int)(FMAX*(PFF[2]-P)/(PFF[2]-PFF[1]));    
    }
    else if(P<PFF[3])
    {
       Pn=4;
       PF[0]=(int)(FMAX*(PFF[3]-P)/(PFF[3]-PFF[2]));    
    }
    else
    {
       Pn=5;
       PF[0]=100;    
    }

    PF[1]=FMAX-PF[0];


  
    //求偏差变化的隶属度
    if(D<DFF[0])
    {
       Dn=2;
       DF[0]=100; 
    }
    else if(D<DFF[1])
    {
       Dn=2;
       DF[0]=(int)(DMAX*(DFF[1]-D)/(DFF[1]-DFF[0]));    
    }
    else if(D<DFF[2])
    {
       Dn=3;
       DF[0]=(int)(DMAX*(DFF[2]-D)/(DFF[2]-DFF[1]));    
    }
    else if(D<DFF[3])
    {
       Dn=4;
       DF[0]=(int)(DMAX*(DFF[3]-D)/(DFF[3]-DFF[2]));    
    }
    else if(D<DFF[4])
    {
       Dn=5;
       DF[0]=(int)(DMAX*(DFF[4]-D)/(DFF[4]-DFF[3]));    
    }
    else if(D<DFF[5])
    {
       Dn=6;
       DF[0]=(int)(DMAX*(DFF[5]-D)/(DFF[5]-DFF[4]));    
    }
    else if(D<DFF[6])
    {
       Dn=7;
       DF[0]=(int)(DMAX*(DFF[5]-D)/(DFF[5]-DFF[4]));    
    }
    else
    {
       Dn=8;
       DF[0]=100;
    }

    DF[1]=DMAX-DF[0];

    
    Un[0]=rule[Dn-2][Pn-2];
    Un[1]=rule[Dn-1][Pn-2];
    Un[2]=rule[Dn-2][Pn-1];
    Un[3]=rule[Dn-1][Pn-1];

    /*重心法反模糊*/
    t1=Un[0]*PF[0]*DF[0];
    t2=Un[2]*PF[1]*DF[0];
    t3=Un[1]*DF[1]*PF[0];
    t4=Un[3]*DF[1]*PF[1];

 
    U=(t1+t2+t3+t4)/1000;

    return U;
  
}

int Fuzzy_kd(int P,int D,char m) 
{
    int ZO= 80;
    int PS= 120;
    int PM= 180;
    int PB= 300;

  
    char Pn=0,Dn=0;
    int t1,t2,t3,t4;
    int Un[4];
    int  PF[2],DF[2];
    int U;

    int PFF[4]={20,60,100,180};    //偏差的变化范围，从左向右为ZO，PS，PM，PL    
    int DFF[7]={-20,-10,-5,0,5,10,20};       //偏差微分的变化范围，从左向右为ZO，PS，PM，PL

    int rule[7][4]={
//误差   0,  1,  2,  3      // 变化
        {ZO, ZO, ZO, ZO},   //   -3
        {PS, PS, PS, PS},   //   -2
        {PS, PS, PS, PS},   //   -1
        {PM, PM, PM, PM},   //   -0
        {PM, PM, PM, PM},   //   1
        {PB, PB, PB, PB},   //   2
        {PB, PB, PB, PB},   //   3
    };

     //求偏差的隶属度
    if(P<PFF[0])
    {
       Pn=2;
       PF[0]=100; 
    }
    else if(P<PFF[1])
    {
       Pn=2;
       PF[0]=(int)(FMAX*(PFF[1]-P)/(PFF[1]-PFF[0]));    
    }
    else if(P<PFF[2])
    {
       Pn=3;
       PF[0]=(int)(FMAX*(PFF[2]-P)/(PFF[2]-PFF[1]));    
    }
    else if(P<PFF[3])
    {
       Pn=4;
       PF[0]=(int)(FMAX*(PFF[3]-P)/(PFF[3]-PFF[2]));    
    }
    else
    {
       Pn=5;
       PF[0]=100;    
    }

    PF[1]=FMAX-PF[0];


  
    //求偏差变化的隶属度
    if(D<DFF[0])
    {
       Dn=2;
       DF[0]=100; 
    }
    else if(D<DFF[1])
    {
       Dn=2;
       DF[0]=(int)(DMAX*(DFF[1]-D)/(DFF[1]-DFF[0]));    
    }
    else if(D<DFF[2])
    {
       Dn=3;
       DF[0]=(int)(DMAX*(DFF[2]-D)/(DFF[2]-DFF[1]));    
    }
    else if(D<DFF[3])
    {
       Dn=4;
       DF[0]=(int)(DMAX*(DFF[3]-D)/(DFF[3]-DFF[2]));    
    }
    else if(D<DFF[4])
    {
       Dn=5;
       DF[0]=(int)(DMAX*(DFF[4]-D)/(DFF[4]-DFF[3]));    
    }
    else if(D<DFF[5])
    {
       Dn=6;
       DF[0]=(int)(DMAX*(DFF[5]-D)/(DFF[5]-DFF[4]));    
    }
    else if(D<DFF[6])
    {
       Dn=7;
       DF[0]=(int)(DMAX*(DFF[5]-D)/(DFF[5]-DFF[4]));    
    }
    else
    {
       Dn=8;
       DF[0]=100;
    }

    DF[1]=DMAX-DF[0];

    
    Un[0]=rule[Dn-2][Pn-2];
    Un[1]=rule[Dn-1][Pn-2];
    Un[2]=rule[Dn-2][Pn-1];
    Un[3]=rule[Dn-1][Pn-1];

    /*重心法反模糊*/
    t1=Un[0]*PF[0]*DF[0];
    t2=Un[2]*PF[1]*DF[0];
    t3=Un[1]*DF[1]*PF[0];
    t4=Un[3]*DF[1]*PF[1];

 
    U=(t1+t2+t3+t4)/1000;

    return U;
  
}