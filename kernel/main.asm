[bits 16]
[org 0x0000] ; เมื่อโหลดจาก FAT12 BIOS จะโหลดไฟล์ใน memory ตามที่บอก

start:
    mov ah, 0x0E        ; BIOS teletype function
    mov si, msg

.print:
    lodsb
    or al, al
    jz .done
    int 0x10
    jmp .print

.done:
    hlt
    jmp $

msg: db "Hello from Kernel!", 0
