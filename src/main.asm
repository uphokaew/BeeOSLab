[bits 16]
[org 0x7C00]

start:
	mov ax, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7C00
	mov si, os_msg
	call screen
	sti
	hlt

screen:
	push si
	push ax
	push bx
.L1:
	lodsb
	or al, al
	jz .L2

	mov ah, 0x0E
	mov bh, 0
	int 0x10
	jmp .L1
.L2:
	pop si
	pop ax
	pop bx
	ret

os_msg: db "BeeOS Welcome", 0x0

times 510-($-$$) db 0x0
dw 0xAA55
