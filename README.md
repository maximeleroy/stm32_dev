
###  Dev stm32 on linux with GNU tools
This repository is tested under Ubuntu 14.04 kernel 3.13 x86_64 

#### 1 - Repository content
This repository is a collection projects for STM32 micro controllers
--**projects_stm32f4**                                                                                          
- template_project_f405_pyboard                                                                         
- template_project_f411_nucleo

#### 2 - Download dependencies
In order to be able to build and debug a project, internet access is required and 
script download_dependencies.sh must be run fisrt to retreive and install tools / STM32Cube 
library collection and documentation:
sh download_dependencoies.sh

#### 3 - Build a project
At the time of writing only template_project_f411_nucleo is tested
Change directory to projects_stm32f4/template_project_f411_nucleo
run the following command:
cd ./projects_stm32f4/template_project_f411_nucleo
make clean all

#### 4 - Run and Debug firmware
Connect nucleo board to your computer and run on-chip debugger openocd
make openocd

##### 4.1 Two options available here:
- Use gdb server to load firmware and debug by running debug_pgm.sh, please note that debug 
script uses local file .gdbinit to run some commands. You may have to create a file .gdbinit 
in your home directory with content "set auto-load safe-path /" to gdb to run a local .gdbinit
echo "set auto-load safe-path /" > ~/.gdbinit
sh debug_pgm.sh
(gdb) b main.c:42
(gdb) continue

- Or open a telnet session with openocd and load the firmware
telnet localhost 4444
> reset halt
> flash write_image erase main.hex
> reset run

#### 5 - References:
http://regalis.com.pl/en/arm-cortex-stm32-gnulinux/
https://balau82.wordpress.com/2015/04/19/libopencm3-on-stm32-nucleo-board/
http://openocd.org/
https://github.com/Regalis/Rover5-STM32

