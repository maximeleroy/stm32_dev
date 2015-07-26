#
# 
# Copyright (C) Patryk Jaworski <regalis@regalis.com.pl>
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# Tested with Arch GNU/Linux @ 3.15.7-1
#
LIBRARY_PATH=../../stm32_cube_f4/STM32Cube_FW_F4_V1.7.0/
ROOT_TOOLCHAIN=../../tools/gcc-arm-none-eabi-4_9-2015q2/bin/

CC=$(ROOT_TOOLCHAIN)arm-none-eabi-gcc
LD=$(ROOT_TOOLCHAIN)arm-none-eabi-ld
OC=$(ROOT_TOOLCHAIN)arm-none-eabi-objcopy
AS=$(ROOT_TOOLCHAIN)arm-none-eabi-as
AR=$(ROOT_TOOLCHAIN)arm-none-eabi-ar

MCU_CORE=cortex-m4
MCU=STM32F411xE
OPENOCD_SCRIPT=/usr/share/openocd/scripts/board/st_nucleo_f411re.cfg

CCFLAGS=-Wall -mcpu=$(MCU_CORE) -mlittle-endian -mthumb \
		-ffunction-sections -fdata-sections

CCFLAGS+=$(INCLUDE) $(DEFS) -g -Os -Werror


INCLUDE_PATH=Drivers/CMSIS/Device/ST/STM32F4xx/Include \
		Drivers/CMSIS/Include \
        .	

LD_SCRIPT=STM32F411RE_FLASH.ld
DEFS=-D$(MCU)
STARTUP_CODE=startup_stm32f411xe.s
INCLUDE=$(patsubst %, -I$(LIBRARY_PATH)%, $(INCLUDE_PATH))
SOURCES_PATH := .
SOURCES := $(foreach DIR,$(SOURCES_PATH),$(wildcard $(DIR)/*.c $(DIR)/*.cpp))
OBJS := $(patsubst %.c,%.o,$(filter %.c, $(SOURCES)))
OBJS+=$(patsubst %.cpp, %.o, $(filter %.cpp, $(SOURCES)))
OBJS+=startup_stm32f411xe.o

#
# Dependency based section
#

all: main.hex

main.elf: $(OBJS) 
	$(CC) $(CCFLAGS) -T$(LD_SCRIPT) -Wl,--gc-sections $^ -o $@

main.hex: main.elf
	$(OC) -Oihex $< $@

startup_stm32f401xe.o: $(STARTUP_CODE)
	$(CC) $(CCFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CCFLAGS) -c $< -o $@

openocd:
	openocd -f $(OPENOCD_SCRIPT)

cc_cmd:
	@echo $(CC) $(CCFLAGS) -c INPUT -o OUTPUT
	
clean:
	@rm -v $(OBJS) || /bin/true
	@rm -v main.elf main.hex || /bin/true

.PHONY: clean openocd cc_cmd
