#ifndef __LED_H__
#define __LED_H__

#include "sys.h"

//#include "stm32f4xx_hal_gpio.h"
//#include "stm32f4xx_hal_rcc.h"

#define LED0 PBout(1)
#define LED1 PBout(0)

void LED_Init(void);



#endif


