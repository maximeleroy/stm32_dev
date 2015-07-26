#!/bin/sh
############################################
# Description: Download tools and libraries
# author     : maxime leroy
# date       : 20152507
# 
############################################

ROOT=${PWD}

log() {                                                                                                       
case "${1}" in                                                                                                
    "info")                                                                                                   
    # Bold Blue black background                                                                              
    echo -e "\033[34;1m${2}\033[0m"                                                                           
    ;;                                                                                                        
    "warning")                                                                                                
    # Bold Orange black background                                                                            
    echo -e "\033[33;1m${2}\033[0m"                                                                           
    ;;                                                                                                        
    "error")                                                                                                  
    # Bold Red black background                                                                               
    echo -e "\033[31;1m${2}\033[0m"                                                                           
    ;;                                                                                                        
    "debug")                                                                                                  
    # Bold green black background                                                                             
    echo -e "\033[32;1m${2}\033[0m"                                                                           
    ;;                                                                                                        
	esac                                                                                                          
}

log info "#####################################"                                                                
log info "# Start of downloading dependencies #"                                                                
log info "#####################################" 

if [ ! -d ${ROOT}/tools ]
then
    mkdir -p ${ROOT}/tools
    cd ${ROOT}/tools/
    
	# Download toolchain
    wget https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q2-update/+download/gcc-arm-none-eabi-4_9-2015q2-20150609-linux.tar.bz2
    tar xjvf ./gcc-arm-none-eabi-4_9-2015q2-20150609-linux.tar.bz2
    
	# Download openocd (on-chip debugging, In-System programming and boundary scan testing
    wget http://sourceforge.net/projects/openocd/files/openocd/0.9.0/openocd-0.9.0.tar.bz2/download
    mv download openocd-0.9.0.tar.bz2
    tar xjvf openocd-0.9.0.tar.bz2
    cd openocd-0.9.0
    ./configure
    make 
    sudo make install
else
	log info "Tools already installed, skipping downloading operation..." 
fi

if [ ! -d ${ROOT}/stm32_cube_f4 ]
then
    cd ${ROOT}
    mkdir -p ${ROOT}/stm32_cube_f4/
    cd ${ROOT}/stm32_cube_f4/
    # Download STM32CubeF4 framework
    wget http://www.st.com/st-web-ui/static/active/en/st_prod_software_internet/resource/technical/software/firmware/stm32cubef4.zip
    unzip stm32cubef4.zip
else
	log info "STM32 Cube F4 librairies already installed, skipping downloading operation..."
fi

if [ ! -d ${ROOT}/documents/doc_micro/stm32f4 ]
then
    cd ${ROOT}
    mkdir -p ${ROOT}/documents/doc_micro/stm32f4/
    cd ${ROOT}/documents/doc_micro/stm32f4/
    wget http://www.st.com/web/en/resource/technical/document/reference_manual/DM00031020.pdf
else
	log info "Documents already downloaded, skipping operation..."
fi

log info "###################################"
log info "# End of downloading dependencies #"
log info "###################################"


