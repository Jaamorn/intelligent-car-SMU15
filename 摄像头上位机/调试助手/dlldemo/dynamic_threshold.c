#include <windows.h>

#define DLL_EXPORT __declspec(dllexport)

#ifdef _WINDOWS_
typedef unsigned int uint32; 
#else
typedef unsigned long uint32; //记得跟据单片机进行修改
#endif

DLL_EXPORT void ImgProc(const char *imgIn, char *imgOut, uint32 width, uint32 height)
{	
	uint32 size = width * height;
	uint32 i;
	unsigned char max = imgIn[0];
	unsigned char min = imgIn[0];
	unsigned char mid;

	for(i = 0; i < size; ++i)
	{
       if((unsigned char)imgIn[i] > max)
		   max = (unsigned char)imgIn[i];
       if((unsigned char)imgIn[i] < min)
		   min = (unsigned char)imgIn[i];
	}
	mid = ((unsigned int)max + (unsigned int)min )/2;

	for(i = 0; i < size; ++i)
	{
		imgOut[i] = (imgIn[i] > mid ? 255 : 0);
	}
}

