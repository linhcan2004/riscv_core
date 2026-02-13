`timescale 1ns/1ps

module regfile_tb;
    // Khai bao tin hieu
    logic clk;
    logic rst_n_tb;
    logic we3_tb; // Write Enable
    logic [4:0]  a1_tb, a2_tb; // Read Address
    logic [4:0]  a3_tb; // Write Address
    logic [31:0] wd3_tb; // Write Data
    logic [31:0] rd1_tb, rd2_tb; // Read Data

    regfile dut (
        .clk(clk),
        .rst_n(rst_n_tb),
        .we3(we3_tb),
        .a1(a1_tb),
        .a2(a2_tb),
        .a3(a3_tb),
        .wd3(wd3_tb),
        .rd1(rd1_tb),
        .rd2(rd2_tb)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Kich ban test
    initial begin
        $dumpfile("sim/regfile_wave.vcd");
        $dumpvars(0, regfile_tb);

        $monitor("Time=%0t | We=%b | Wr(x%0d)=%d | Rd(x%0d)=%d | Rd(x%0d)=%d", $time, we3_tb, a3_tb, wd3_tb, a1_tb, rd1_tb, a2_tb, rd2_tb);

        rst_n_tb = 0; 
		we3_tb = 0; a1_tb = 0; a2_tb = 0; a3_tb = 0; wd3_tb = 0;
        #10;
        rst_n_tb = 1;

        // Ghi so 100 vao x1
        a3_tb = 5'd1; wd3_tb = 32'd100; we3_tb = 1;
        #10;
        we3_tb = 0;

        // Doc lai x1
        a1_tb = 5'd1;
        #10;

        // Ghi so 200 vao x2
        a3_tb = 5'd2; wd3_tb = 32'd200; we3_tb = 1;
        #10;
        we3_tb = 0;

        // Doc dong thoi x1 va x2
        a1_tb = 5'd1; a2_tb = 5'd2;
        #10;

        // Ghi vao x0
        a3_tb = 5'd0; wd3_tb = 32'd999; we3_tb = 1;
        #10;
        we3_tb = 0;

        // Doc lai x0
        a1_tb = 5'd0;
        #10;

        $finish;
    end

endmodule
