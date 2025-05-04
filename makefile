ASM = nasm
QEMU = qemu-system-x86_64
BUILD_DIR = build
BOOTLOADER_DIR = bootloader
KERNEL_DIR = kernal
IMG = $(BUILD_DIR)/main.img
IMG_SIZE = 2880      # จำนวน sectors (512 * 2880 = 1.44MB)
ASMFLAGS = -f bin
QEMUFLAGS = -fda

.PHONY: all clean run check-tools

all: check-tools $(IMG)

check-tools:
	@which $(ASM) >/dev/null || { echo "Error: $(ASM) not found"; exit 1; }
	@which $(QEMU) >/dev/null || { echo "Error: $(QEMU) not found"; exit 1; }
	@which dd >/dev/null || { echo "Error: dd not found"; exit 1; }

$(BUILD_DIR):
	@mkdir -p $(BUILD_DIR)

# Compile Bootloader
$(BUILD_DIR)/bootloader.bin: $(BOOTLOADER_DIR)/main.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "Compiled bootloader -> $@"

# Compile Kernel
$(BUILD_DIR)/kernel.bin: $(KERNEL_DIR)/main.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "Compiled kernel -> $@"

# Create 1.44MB floppy image with bootloader + kernel
$(IMG): $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/kernel.bin
	@dd if=/dev/zero of=$(IMG) bs=512 count=$(IMG_SIZE) status=none
	@dd if=$(BUILD_DIR)/bootloader.bin of=$(IMG) conv=notrunc status=none
	@dd if=$(BUILD_DIR)/kernel.bin of=$(IMG) bs=512 seek=1 conv=notrunc status=none
	@echo "Created floppy image: $(IMG)"

run: $(IMG)
	$(QEMU) $(QEMUFLAGS) $(IMG)

clean:
	@rm -rf $(BUILD_DIR)
	@echo "Cleaned build directory"
