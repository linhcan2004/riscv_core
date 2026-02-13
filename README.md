# RISC-V Single-Cycle Processor (SystemVerilog)

Đây là đồ án thiết kế bộ vi xử lý RISC-V 32-bit kiến trúc Single-Cycle, hỗ trợ tập lệnh RV32I cơ bản (ADD, SUB, LW, SW, BEQ...).

## Chương trình kiểm thử
CPU hiện tại đang được nạp sẵn một chương trình (trong file `program.hex`) để thực hiện phép tính: **10 + 20 = 30**, sau đó kiểm tra khả năng Ghi/Đọc bộ nhớ.

**Mã nguồn Assembly:**
ADDI x1, x0, 10   ; x1 = 10        (Nạp giá trị 10 vào thanh ghi x1)
ADDI x2, x0, 20   ; x2 = 20        (Nạp giá trị 20 vào thanh ghi x2)
ADD  x3, x1, x2   ; x3 = 10 + 20   (Cộng x1 với x2, lưu kết quả 30 vào x3)
SW   x3, 4(x0)    ; Mem[4] = 30    (Lưu số 30 vào bộ nhớ tại địa chỉ 4)
LW   x4, 4(x0)    ; x4 = Mem[4]    (Đọc lại từ bộ nhớ địa chỉ 4 vào x4 để kiểm tra)

## Cách chạy mô phỏng (Simulation):
```bash
iverilog -g2012 -o sim/riscv_test rtl/*.sv tb/riscv_tb.sv && vvp sim/riscv_test
