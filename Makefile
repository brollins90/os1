LINKER = kernel.ld

ELF = bin/kernel.elf
IMAGE = bin/kernel7.img
NM = bin/kernel.nm
LIST = bin/kernel.list

SOURCE = src/

SOURCE_C := $(wildcard $(SOURCE)*.c)
SOURCE_S := $(wildcard $(SOURCE)*.s)
SOURCE_ALL = $(SOURCE_C) $(SOURCE_S)

GCC = arm-none-eabi-gcc -O0 -DRPI2 \
    -mfpu=neon-vfpv4 -mfloat-abi=hard \
    -march=armv7-a -mtune=cortex-a7 \
    -nostartfiles -g -Wl,-T,$(LINKER) \
    $(SOURCE_ALL) -o $(ELF)

all: $(IMAGE) $(LIST) $(NM)

rebuild: all

$(NM) : $(ELF)
	arm-none-eabi-nm $(ELF) > $(NM)

$(LIST) : $(ELF)
	arm-none-eabi-objdump -d $(ELF) > $(LIST)

$(IMAGE) : $(ELF)
	arm-none-eabi-objcopy $(ELF) -O binary $(IMAGE) 

$(ELF) : $(LINKER)
	$(GCC)
