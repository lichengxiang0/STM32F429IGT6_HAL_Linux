
#include "led.h"
#include "tick.h"
#include "sys.h"

int main(void)
{

    HAL_Init();                     //初始化HAL库
    Stm32_Clock_Init(360,25,2,8);   //设置时钟,180Mhz
    tick_delay_init(180);
    LED_Init();                     //初始化LED

    while(1)
    {
        HAL_GPIO_WritePin(GPIOB,GPIO_PIN_1,GPIO_PIN_RESET); //LED0对应引脚PB1拉低，亮，等同于LED0(0)
        HAL_GPIO_WritePin(GPIOB,GPIO_PIN_0,GPIO_PIN_SET);   //LED1对应引脚PB0拉高，灭，等同于LED1(1)
        delay_ms(500);										//延时500ms
        HAL_GPIO_WritePin(GPIOB,GPIO_PIN_1,GPIO_PIN_SET);   //LED0对应引脚PB1拉高，灭，等同于LED0(1)
        HAL_GPIO_WritePin(GPIOB,GPIO_PIN_0,GPIO_PIN_RESET); //LED1对应引脚PB0拉低，亮，等同于LED1(0)
        delay_ms(500);                                      //延时500ms
    }

	return 0;
}






