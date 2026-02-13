`timescale 1ns/1ps

module riscv_tb;
    // Khai bao tin hieu
    logic clk;
    logic rst_n;
    logic [31:0] test_result; // Gia tri ALU Result dua ra ngoai

    // Goi con CPU
    riscv_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .test_result(test_result)
    );

    // Tao xung Clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Kich ban chay thu
    initial begin
        $dumpfile("sim/riscv_wave.vcd");
        $dumpvars(0, riscv_tb);
        
        $monitor("Time=%0t | PC=%d | Result(ALU)=%d", $time, dut.pc, test_result);

        rst_n = 0;
        #10;
        rst_n = 1;
        
        // Cho CPU chay khoang 100ns (du cho 5 cau lenh)
        #100;
        
        $finish;
    end

endmodule
