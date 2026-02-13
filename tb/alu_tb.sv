`timescale 1ns/1ps

module alu_tb;
    logic [31:0] a_tb;
    logic [31:0] b_tb;
    logic [2:0] alu_control_tb; // 3 bit dieu khien
    
    logic [31:0] result_tb;
    logic zero_tb;

    alu dut (
        .a(a_tb),
        .b(b_tb),
        .alu_control(alu_control_tb),
        .result(result_tb),
        .zero(zero_tb)
    );

    // Kich ban kiem thu
    initial begin
        $dumpfile("sim/alu_wave.vcd");
        $dumpvars(0, alu_tb);

        $monitor("Time=%0t | A=%d | B=%d | Control=%b | Res=%d | Zero=%b", $time, a_tb, b_tb, alu_control_tb, result_tb, zero_tb);

        // 10 + 20 = 30
        a_tb = 32'd10; b_tb = 32'd20; alu_control_tb = 3'b000;
        #10;

        // 20 - 10 = 10
        a_tb = 32'd20; b_tb = 32'd10; alu_control_tb = 3'b001;
        #10;

        // 10 - 20 = -10
        a_tb = 32'd10; b_tb = 32'd20; alu_control_tb = 3'b001;
        #10;

        // 00001111 AND 01010101 = 00000101
        a_tb = 32'h0F; b_tb = 32'h55; alu_control_tb = 3'b010;
        #10;

        // 00001111 OR 01010101 = 01011111
        a_tb = 32'h0F; b_tb = 32'h55; alu_control_tb = 3'b011;
        #10;

        // So sanh be hon giua 10 va 20
        a_tb = 32'd10; b_tb = 32'd20; alu_control_tb = 3'b101;
        #10;
        a_tb = 32'd20; b_tb = 32'd10; alu_control_tb = 3'b101;
        #10;

        // Kiem tra co Zero
        a_tb = 32'd50; b_tb = 32'd50; alu_control_tb = 3'b001;
        #10;

        $finish;
    end

endmodule
