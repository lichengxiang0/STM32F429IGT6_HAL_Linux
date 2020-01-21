/*
 * system_main.cpp
 *
 *  Created on: Jan 21, 2020
 *      Author: lcx
 */


extern "C"{
#include "led.h"
#include "tick.h"
#include "sys.h"
}


int main(void)
{

    HAL_Init();
    Stm32_Clock_Init(360,25,2,8);
    tick_delay_init(180);
    LED_Init();



	while(1)
	{

		LED0 = !LED0;
//		LED1 = !LED1;
		delay_ms(500);

	}
	return 0;
}

