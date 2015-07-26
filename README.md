
###  STM32 development under Linux with GNU tools
This repository is tested under Ubuntu 14.04 kernel 3.13 x86_64 

#### 1 - Repository content
This repository is a collection of projects for STM32 micro controllers. <br/> 
Two template projects are available in directory **./projects_stm32f4**: <br/>                                                                                         
- template_project_f405_pyboard                                                                         
- template_project_f411_nucleo

```
$ tree -L 3
.
├── download_dependencies.sh
├── how_to_dev_stm32.txt
├── LICENSE
├── projects_stm32f4
│   ├── template_project_f405_pyboard
│   │   ├── debug_pgm.sh
│   │   ├── delay.c
│   │   ├── delay.h
│   │   ├── gcc_cmd_compile.sh
│   │   ├── main.c
│   │   ├── Makefile
│   │   ├── startup_stm32f405xx.s
│   │   ├── STM32F405RG_FLASH.ld
│   │   ├── stm32f4xx.h
│   │   └── system.c
│   └── template_project_f411_nucleo
│       ├── debug_pgm.sh
│       ├── delay.c
│       ├── delay.h
│       ├── gcc_cmd_compile.sh
│       ├── main.c
│       ├── Makefile
│       ├── startup_stm32f411xe.s
│       ├── STM32F411RE_FLASH.ld
│       ├── stm32f4xx.h
│       ├── system.c
│       ├── usart.c
│       └── usart.h
└── README.md
```

#### 2 - Download dependencies
In order to be able to build and debug a project, internet access is required and 
script **download_dependencies.sh** must be run fisrt to retreive and install:
- tools (gcc /openocd)
- STM32Cube library collection 
- documentation 

```
> sh download_dependencies.sh
```
Once download operation ended repository structure should look like this:

```
$ tree -L 2
.
├── documents
│   └── doc_micro
├── download_dependencies.sh
├── how_to_dev_stm32.txt
├── LICENSE
├── projects_stm32f4
│   ├── template_project_f405_pyboard
│   └── template_project_f411_nucleo
├── README.md
├── stm32_cube_f4
│   ├── stm32cubef4.zip
│   └── STM32Cube_FW_F4_V1.7.0
└── tools
    ├── gcc-arm-none-eabi-4_9-2015q2
    ├── gcc-arm-none-eabi-4_9-2015q2-20150609-linux.tar.bz2
    ├── openocd-0.9.0
    └── openocd-0.9.0.tar.bz2

```

#### 3 - Build a project
At the time of writing only **template_project_f411_nucleo** is tested. <br/>
Change directory to **projects_stm32f4/template_project_f411_nucleo**: 
```
> cd ./projects_stm32f4/template_project_f411_nucleo
```
And run the following command:

```
> make clean all
```

#### 4 - Run and Debug firmware
Connect nucleo board to your computer and run on-chip debugger openocd:

```
> make openocd
```
##### 4.1 Two options available here:
Use gdb server to load firmware and debug by running **debug_pgm.sh**, please note that debug 
script uses local file **.gdbinit** to run some commands. You may have to create a file **.gdbinit** 
in your home directory with content **set auto-load safe-path /** for gdb to run a local **.gdbinit** <br/>

**Optionally:**
```
> echo "set auto-load safe-path /" > ~/.gdbinit
```
Run debug script:
```
> sh debug_pgm.sh
> (gdb) b main.c:42
> (gdb) continue
```
Or open a telnet session with openocd and load the firmware:
```
> telnet localhost 4444
> reset halt
> flash write_image erase main.hex
> reset run
```
#### 5 - References:
http://regalis.com.pl/en/arm-cortex-stm32-gnulinux/ <br/>
https://balau82.wordpress.com/2015/04/19/libopencm3-on-stm32-nucleo-board/ <br/>
http://openocd.org/ <br/>
https://github.com/Regalis/Rover5-STM32 <br/>
<br/>
