---

## 📄 README.md

### 💾 ASM Bootable Image with NASM and QEMU

โปรเจกต์นี้ช่วยให้คุณสามารถเขียน Assembly ด้วย [NASM](https://www.nasm.us/) และสร้าง bootable image (.img) ที่สามารถรันบน [QEMU](https://www.qemu.org/) ได้โดยง่ายผ่าน `Makefile`

---

### 📁 โครงสร้างโปรเจกต์

```bash
.
├── Makefile
├── build/             # ไฟล์ output ที่ build แล้ว (bin และ img)
└── src/
    └── main.asm       # ไฟล์ Assembly หลัก
```

---

### ⚙️ วิธีใช้งาน

#### ✅ ตรวจสอบว่าเครื่องคุณมีเครื่องมือดังต่อไปนี้:

* `nasm` – ใช้สำหรับ compile assembly
* `qemu-system-x86_64` – ใช้สำหรับจำลองการรัน image
* `truncate` – ใช้กำหนดขนาดของ image

#### 🔧 คำสั่ง Makefile

| คำสั่ง                 | รายละเอียด                                           |
| ---------------------- | ---------------------------------------------------- |
| `make` หรือ `make all` | ตรวจสอบเครื่องมือ, compile assembly, และสร้าง `.img` |
| `make run`             | รัน image บน QEMU                                    |
| `make clean`           | ลบไฟล์ที่สร้างใน `build/`                            |

---

### 🧪 วิธีทดลอง

1. ใส่โค้ดของคุณใน `src/main.asm`
2. รันคำสั่ง:

   ```bash
   make run
   ```
3. ระบบจะเปิด QEMU พร้อมบูต image ที่คุณสร้างขึ้น

---

### 🧹 ล้างไฟล์ที่ build แล้ว

```bash
make clean
```

---

### ✍️ ผู้เขียน

```text
uphokaew
```

---
