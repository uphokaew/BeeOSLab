---

## 🧠 Hobby OS Experiment — Bootloader & Kernel in Assembly

โปรเจกต์นี้เป็นโปรเจกต์ส่วนตัวเพื่อการเรียนรู้และทดลองการสร้างระบบบูต (bootable system) เบื้องต้นด้วยภาษา Assembly โดยใช้ `NASM` ในการเขียนและ `QEMU` เพื่อจำลองการรัน โดยจะแยกการเขียนเป็น **Bootloader** และ **Kernel** คนละส่วนเพื่อให้เข้าใจโครงสร้าง OS เบื้องต้นมากขึ้น

---

### 📁 โครงสร้างโปรเจกต์

```bash
.
├── bootloader/         # โค้ด bootloader หลัก (main.asm)
├── kernel/             # โค้ด kernel (main.asm)
├── build/              # โฟลเดอร์สำหรับไฟล์ที่ compile แล้ว
├── Makefile            # ไฟล์ควบคุมการ build และ run
└── README.md
```

---

### 🔧 เครื่องมือที่จำเป็นก่อนใช้งาน

ก่อนจะสามารถ build หรือ run โปรเจกต์นี้ได้ ต้องติดตั้งเครื่องมือต่อไปนี้ในระบบของคุณ:

* [`nasm`](https://www.nasm.us/) – สำหรับ compile โค้ด Assembly
* [`qemu-system-x86_64`](https://www.qemu.org/) – สำหรับจำลองเครื่องคอมพิวเตอร์เสมือน
* `truncate` – ใช้สำหรับกำหนดขนาดไฟล์ `.img` ที่จะนำไป boot

#### ติดตั้งบนระบบ Debian/Ubuntu:

```bash
sudo apt update
sudo apt install nasm qemu-utils qemu-system-x86
```

#### ติดตั้งบน Fedora:

```bash
sudo dnf install nasm qemu-system-x86
```

---

### 🚀 วิธีการใช้งาน

1. แก้ไขไฟล์ Assembly ตามใจคุณ:

   * `bootloader/main.asm` — โหลดและควบคุมการ boot
   * `kernel/main.asm` — สิ่งที่ bootloader จะโหลดให้ทำงานต่อ

2. รันคำสั่งต่อไปนี้เพื่อ build ทั้งหมด:

```bash
make
```

3. เพื่อทดสอบรันบน QEMU:

```bash
make run
```

4. หากต้องการล้างไฟล์ที่ถูก build แล้ว:

```bash
make clean
```

---

### 📌 หมายเหตุ

* ขนาดของ `.img` ไฟล์ถูกตั้งไว้ที่ 1.44MB ตามมาตรฐาน floppy disk
* ไฟล์ `bootloader.bin` จะถูกรวมกับ `kernel.bin` ผ่าน `cat` เพื่อสร้าง bootable image
* โครงสร้างนี้สามารถต่อยอดไปทำ multi-stage bootloader หรือ simple OS ได้

---

### ✨ เป้าหมายของโปรเจกต์นี้

* ศึกษาการทำงานของ bootloader และ OS พื้นฐาน
* ฝึกฝนการเขียน Assembly
* เข้าใจการทำงานระดับล่างของระบบคอมพิวเตอร์
* ทดสอบและเรียนรู้การทำงานของ QEMU

---

### 🙋‍♂️ ผู้พัฒนา

```text
[uphokaew](https://github.com/uphokaew/)
Hobbyist & Learner in Low-Level Programming
```

---
