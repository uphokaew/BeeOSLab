ASM = nasm
QEMU = qemu-system-x86_64
BUILD_DIR = build

BOOTLOADER = bootloader/main.asm
KERNEL = kernel/main.asm

IMG = $(BUILD_DIR)/main.img

BOOT_BIN = $(BUILD_DIR)/bootloader.bin
KERNEL_BIN = $(BUILD_DIR)/kernel.bin

IMG_SIZE = 1440k
ASMFLAGS = -f bin
QEMUFLAGS = -fda

.PHONY: all clean run check-tools

all: check-tools floppy_image

check-tools:
	@which $(ASM) >/dev/null || { echo "Error: $(ASM) not found"; exit 1; }
	@which mkfs.fat >/dev/null || { echo "Error: mkfs.fat not found (try installing dosfstools)"; exit 1; }
	@which mcopy >/dev/null || { echo "Error: mcopy not found (try installing mtools)"; exit 1; }
	@which $(QEMU) >/dev/null || { echo "Error: $(QEMU) not found"; exit 1; }

$(BUILD_DIR):
	@mkdir -p $@

$(BOOT_BIN): $(BOOTLOADER) | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "Built bootloader -> $@"

$(KERNEL_BIN): $(KERNEL) | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "Built kernel -> $@"

floppy_image: $(IMG)

$(IMG): $(BOOT_BIN) $(KERNEL_BIN)
	# สร้าง image เปล่าขนาด 1.44MB
	dd if=/dev/zero of=$@ bs=512 count=2880

	# ฟอร์แมต FAT12 และตั้งชื่อ volume
	mkfs.fat -F 12 -n "BeeOSLab" $@

	# เขียน bootloader ลง sector แรก
	dd if=$(BOOT_BIN) of=$@ conv=notrunc

	# คัดลอก kernel ลงใน root ของ image
	mcopy -i $@ $(KERNEL_BIN) "::kernel.bin"

	@echo "Floppy image created: $@"

run: $(IMG)
	$(QEMU) $(QEMUFLAGS) $<

clean:
	@rm -rf $(BUILD_DIR)
	@echo "Cleaned build directory"
