# commit
vpath %.S stlib
vpath %.c stlib stlib/src HARDWARE/LED HARDWARE/TICK HARDWARE/SYS
vpath %.h stlib stlib/cminc stlib/inc stlib/inc/Legacy HARDWARE/LED HARDWARE/TICK HARDWARE/SYS

# allow use peripherals lib function
DEFS += -DUSE_HAL_DRIVER
#DEFS += -DSTM32F429xx

INCS += -Istlib -Istlib/cminc -Istlib/inc -Istlib/inc/Legacy
INCS += -IHARDWARE/LED -IHARDWARE/TICK -IHARDWARE/SYS

OBJS += stlib/startup_stm32f429_439xx.o stlib/system_stm32f4xx.o

OBJS += stlib/src/stm32f4xx_hal.o stlib/src/stm32f4xx_hal_cortex.o
OBJS += stlib/src/stm32f4xx_hal_rcc.o stlib/src/stm32f4xx_hal_rcc_ex.o
OBJS += stlib/src/stm32f4xx_hal_gpio.o 
OBJS += stlib/src/stm32f4xx_hal_pwr.o stlib/src/stm32f4xx_hal_pwr_ex.o
OBJS += HARDWARE/LED/led.o HARDWARE/TICK/tick.o HARDWARE/SYS/sys.o
OBJS += main.o


#CFLAGS += -mcpu=cortex-m4 -mthumb -Wall
#CFLAGS += -Os
#CFLAGS += -ffunction-sections -fdata-sections
#CFLAGS += -g -Wall
#LFLAGS += -mcpu=cortex-m4 -mthumb 
#LFLAGS += -Wl,--gc-sections



# 使用了编译优化和硬件浮点数
CFLAGS += -mcpu=cortex-m4 -mthumb -Wall 
#CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
CFLAGS += -Os
CFLAGS += -ffunction-sections -fdata-sections

LFLAGS += -mcpu=cortex-m4 -mthumb
#LFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
LFLAGS += -Wl,--gc-sections 

all:$(OBJS)
	@arm-none-eabi-gcc $(LFLAGS) $^ -Tstlib/STM32F429IGT6_FLASH.ld -o blink.elf
#	@arm-none-eabi-ld
	@arm-none-eabi-objcopy -O binary -S blink.elf blink.bin
	@arm-none-eabi-size blink.elf
	@arm-none-eabi-objdump -S blink.elf > blink.dis
%.o:%.S
	@arm-none-eabi-gcc $(CFLAGS) -c $< -o $@
%.o:%.c
	@arm-none-eabi-gcc $(CFLAGS) $(DEFS) $(INCS) -c $< -o $@
	


clean:
	@rm -f $(OBJS) blink.bin blink.elf
	
#burn:blink.bin
#	@st-flash write $< 0x08000000

upload:blink.bin
	@make all
	@JLinkExe jlink.cfg





