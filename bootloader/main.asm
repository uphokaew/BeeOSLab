[bits 16]
[org 0x7C00]

bdb_oem:			DB 'MSWIN4.1'
bdb_bytes_per_sector:		DW 512
bdb_sectors_per_cluster:	DB 1
bdb_reserved_sectors:		DW 1
bdb_fat_count:			DB 2
bdb_dir_entries_count:		DW 0e0h
bdb_total_sectors:		DW 2880
bdb_media_descriptor_type:	DB 0f0h
bdb_sectors_per_fat:		DW 9
bdb_sectors_per_track:		DW 18
bdb_heads:			DW 2
bdb_hidden_sectors:		DD 0
bdb_large_sector_count:		DD 0

ebr_drive_number:		DB 0
				DB 0
ebr_signature:			DB 29h
ebr_volume_id:			DB 12h,34h,56h,78h
ebr_volume_label:		DB '123456789AB'
ebr_system_id:			DB '12345678'

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
