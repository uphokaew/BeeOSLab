ASM = nasm
QEMU = qemu-system-x86_64
IMG_SIZE = 1440k
ASMFLAGS = -f bin
QEMUFLAGS = -fda

BOOTLOADER_SRC = bootloader/main.asm
KERNEL_SRC = kernel/main.asm
BUILDDIR = build

BOOTLOADER_BIN = $(BUILDDIR)/bootloader.bin
KERNEL_BIN = $(BUILDDIR)/kernel.bin
IMAGE = $(BUILDDIR)/main.img

.PHONY: all clean run check-tools

all: check-tools $(IMAGE)

check-tools:
	@which $(ASM) >/dev/null || { echo "Error: $(ASM) not found"; exit 1; }
	@which truncate >/dev/null || { echo "Error: truncate not found"; exit 1; }
	@which $(QEMU) >/dev/null || { echo "Error: $(QEMU) not found"; exit 1; }

$(BUILDDIR):
	@mkdir -p $@

$(BOOTLOADER_BIN): $(BOOTLOADER_SRC) | $(BUILDDIR)
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "Compiled bootloader -> $@"

$(KERNEL_BIN): $(KERNEL_SRC) | $(BUILDDIR)
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "Compiled kernel -> $@"

$(IMAGE): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	@cp $(BOOTLOADER_BIN) $@
	@cat $(KERNEL_BIN) >> $@
	@truncate -s $(IMG_SIZE) $@
	@echo "Created bootable image -> $@ (size: $(IMG_SIZE))"

run: $(IMAGE)
	$(QEMU) $(QEMUFLAGS) $<

clean:
	@rm -f $(BUILDDIR)/*.bin $(BUILDDIR)/*.img
	@echo "Cleaned build directory"

