#!/bin/sh

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc \
	-Wall \
	-mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb -I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
	-I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Include -DSTM32F411xE \
	-g -c system.c -o system.o

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc \
	-Wall \
	-mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb -I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
	-I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Include -DSTM32F411xE \
	-g -c main.c -o main.o

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc \
	-Wall \
	-mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb -I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Device/ST/STM32F4xx/Include \
	-I../STM32Cube_FW_F4_V1.5.0/Drivers/CMSIS/Include -DSTM32F411xE \
	-g -c startup_stm32f411xe.s -o startup_stm32f411xe.o

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-gcc -mcpu=cortex-m4 \
	-mlittle-endian \
	-mthumb \
	-DSTM32F411xE \
	-TSTM32F411RE_FLASH.ld \
	-Wl,--gc-sections system.o main.o startup_stm32f411xe.o -o main.elf

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-objcopy -O binary main.o main.bin

../gcc-arm-none-eabi-4_9-2015q1/bin/arm-none-eabi-objcopy -Oihex main.elf main.hex


