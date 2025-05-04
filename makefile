
ASM = nasm
QEMU = qemu-system-x86_64
SRCDIR = src
BUILDDIR = build
IMG_SIZE = 1440k
ASMFLAGS = -f bin
QEMUFLAGS = -fda

.PHONY: all clean run check-tools
all: check-tools $(BUILDDIR)/main.img

check-tools:
	@which $(ASM) >/dev/null || { echo "Error: $(ASM) not found"; exit 1; }
	@which truncate >/dev/null || { echo "Error: truncate not found"; exit 1; }
	@which $(QEMU) >/dev/null || { echo "Error: $(QEMU) not found"; exit 1; }

$(BUILDDIR):
	@mkdir -p $@

$(BUILDDIR)/main.bin: $(SRCDIR)/main.asm | $(BUILDDIR)
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "Compiled $< -> $@"

$(BUILDDIR)/main.img: $(BUILDDIR)/main.bin
	@cp $< $@
	@truncate -s $(IMG_SIZE) $@
	@echo "Created $@ (size: $(IMG_SIZE))"

run: $(BUILDDIR)/main.img
	$(QEMU) $(QEMUFLAGS) $<

clean:
	@rm -f $(BUILDDIR)/*.bin $(BUILDDIR)/*.img
	@echo "Cleaned $(BUILDDIR)"
