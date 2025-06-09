cmake_minimum_required(VERSION 3.10)
project(STM32F429_HAL_CMake)

set(CMAKE_C_STANDARD 11)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)

set(TOOLCHAIN_PREFIX arm-none-eabi)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}-objcopy)
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}-size)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}-objcopy)
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}-objdump)

set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/STM32F429ZITX_FLASH.ld)

set(SRC
    Src/main.c
    Src/syscalls.c
    startup/startup_stm32f429zitx.s
)

include_directories(
    Inc
    Drivers/STM32F4xx_HAL_Driver/Inc
    Drivers/CMSIS
    Drivers/CMSIS/Include
)

add_executable(${PROJECT_NAME}.elf ${SRC})

#target_link_options(${PROJECT_NAME}.elf PRIVATE "-T${CMAKE_SOURCE_DIR}/STM32F429ZI_FLASH.ld")
set_target_properties(${PROJECT_NAME}.elf PROPERTIES
    LINK_FLAGS "-T${LINKER_SCRIPT}"
)


add_custom_command(TARGET STM32F429_HAL_CMake.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex    STM32F429_HAL_CMake.elf STM32F429_HAL_CMake.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary  STM32F429_HAL_CMake.elf STM32F429_HAL_CMake.bin

    COMMAND ${CMAKE_OBJDUMP} -h STM32F429_HAL_CMake.elf > STM32F429_HAL_CMake.sections.txt

    COMMENT "Generating HEX and BIN files"
)
