cmake_minimum_required(VERSION 3.27)
project(STM32F429_HAL_CMake C ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)

set(TOOLCHAIN_PREFIX arm-none-eabi)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}-objcopy)
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}-size)
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}-objdump)

set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/STM32F429ZITX_FLASH.ld)

set(CPU_FLAGS "-mcpu=cortex-m4" "-mthumb" "-mfpu=fpv4-sp-d16" "-mfloat-abi=hard")
set(COMMON_FLAGS ${CPU_FLAGS} -Wall -O0 -g)

add_compile_options(${COMMON_FLAGS})
add_link_options(${CPU_FLAGS} "-T${LINKER_SCRIPT}" "-Wl,-Map=output.map,--gc-sections")

set(SRC
    Src/main.c
    Src/syscalls.c
    Inc/system_stm32f4xx.c
    startup/startup_stm32f429zitx.s
)

set_source_files_properties(startup/startup_stm32f429zitx.s PROPERTIES LANGUAGE ASM)

include_directories(
    Inc
    Drivers/STM32F4xx_HAL_Driver/Inc
    Drivers/CMSIS
    Drivers/CMSIS/Include
)

add_executable(${PROJECT_NAME}.elf ${SRC})

add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary ${PROJECT_NAME}.elf ${PROJECT_NAME}.bin
    COMMAND ${CMAKE_OBJDUMP} -h ${PROJECT_NAME}.elf > ${PROJECT_NAME}.sections.txt
    COMMENT "Generating HEX and BIN files"
)
