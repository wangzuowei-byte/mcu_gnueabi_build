# Toolchain
CC       = arm-none-eabi-gcc
AS       = arm-none-eabi-gcc
OBJCOPY  = arm-none-eabi-objcopy
OBJDUMP  = arm-none-eabi-objdump
SIZE     = arm-none-eabi-size

# MCU and flags
CPU      = -mcpu=cortex-m4 -mthumb -mfpu=fpv4-sp-d16 -mfloat-abi=hard
CFLAGS   = $(CPU) -Wall -O0 -g -std=c11
ASFLAGS  = $(CPU) -x assembler-with-cpp
LDFLAGS  = $(CPU) -TSTM32F429ZITX_FLASH.ld -Wl,-Map=output.map,--gc-sections

# Project and paths
TARGET   = STM32F429_HAL_CMake
BUILD_DIR = build

# Source files
C_SOURCES = \
    Src/main.c \
    Src/syscalls.c \
        Inc/system_stm32f4xx.c

ASM_SOURCES = \
    startup/startup_stm32f429zitx.s

# Include directories
INCLUDES = \
    -IInc \
    -IDrivers/STM32F4xx_HAL_Driver/Inc \
    -IDrivers/CMSIS \
    -IDrivers/CMSIS/Include

# Object files
C_OBJS   = $(C_SOURCES:.c=.o)
ASM_OBJS = $(ASM_SOURCES:.s=.o)

OBJS     = $(C_OBJS) $(ASM_OBJS)

# Rules
.PHONY: all clean

all: $(TARGET).elf $(TARGET).hex $(TARGET).bin sections

$(TARGET).elf: $(OBJS)
        $(CC) $(LDFLAGS) -o $@ $^
        $(SIZE) $@

%.o: %.c
        $(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

%.o: %.s
        $(AS) $(ASFLAGS) -c $< -o $@

%.hex: %.elf
        $(OBJCOPY) -O ihex $< $@

%.bin: %.elf
        $(OBJCOPY) -O binary $< $@

sections: $(TARGET).elf
        $(OBJDUMP) -h $< > $(TARGET).sections.txt

clean:
        rm -f $(C_OBJS) $(ASM_OBJS) $(TARGET).elf $(TARGET).hex $(TARGET).bin $(TARGET).map $(TARGET).sections.txt

		