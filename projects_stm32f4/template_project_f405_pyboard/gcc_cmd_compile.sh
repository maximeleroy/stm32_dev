#!/bin/sh

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc \
	-Wall \
	-mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb -I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
	-I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Include -DSTM32F405xx \
	-Os -c system.c -o system.o

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc \
	-Wall \
	-mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb -I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
	-I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Include -DSTM32F405xx \
	-Os -c main.c -o main.o

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc \
	-Wall \
	-mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb -I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
	-I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Include -DSTM32F405xx \
	-Os -c startup_stm32f405xx.s -o startup_stm32f405xx.o

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc -mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb \
	-DSTM32F405xx \
	-TSTM32F405RG_FLASH.ld \
	-Wl,--gc-sections system.o main.o startup_stm32f405xx.o -o main.elf
