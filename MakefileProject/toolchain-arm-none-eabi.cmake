# toolchain-arm-none-eabi.cmake
set(CMAKE_SYSTEM_NAME      Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# 编译标准
set(CMAKE_C_STANDARD 11)
# 指定目标系统和处理器架构
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)
# 工具链前缀
set(TOOLCHAIN_PREFIX arm-none-eabi)

# 指定编译器和工具
set(CMAKE_C_COMPILER   ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-g++)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_OBJCOPY      ${TOOLCHAIN_PREFIX}-objcopy)
set(CMAKE_SIZE         ${TOOLCHAIN_PREFIX}-size)
set(CMAKE_OBJDUMP      ${TOOLCHAIN_PREFIX}-objdump)


# 不测试能否运行生成的可执行文件
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

add_compile_options(
    -mcpu=cortex-m4
    -mthumb
    -mfpu=fpv4-sp-d16
    -mfloat-abi=hard
    -ffreestanding
    -nostdlib
    -Wall
    -O0
    -g
)

# 编译器flags
#set(CPU_FLAGS "-mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard")

# 基础编译选项（可以根据需要调整）
#set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CPU_FLAGS} -ffreestanding -nostdlib -Wall -O0 -g")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CPU_FLAGS} -ffreestanding -nostdlib -Wall -O0 -g")

# 链接选项，注意LINKER_SCRIPT不是toolchain文件里定义的，应该由顶层CMake传入或者定义
# 这里先不加 -T 链接脚本参数，由顶层传入
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -nostartfiles -Wl,--gc-sections")