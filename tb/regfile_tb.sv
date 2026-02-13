`timescale 1ns/1ps

module regfile_tb;
    logic clk;
    logic rst_n_tb;
    logic [4:0] rs1_addr_tb, rs2_addr_tb, rd_addr_tb;
    logic we_tb;
    logic [31:0] wdata_tb;
    logic [31:0] rdata1_tb, rdata2_tb;

    regfile dut (
        .clk(clk),
        .rst_n(rst_n_tb),
        .rs1_addr(rs1_addr_tb),
        .rs2_addr(rs2_addr_tb),
        .rdata1(rdata1_tb),
        .rdata2(rdata2_tb),
        .we(we_tb),
        .rd_addr(rd_addr_tb),
        .wdata(wdata_tb)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("sim/regfile_wave.vcd");
        $dumpvars(0, regfile_tb);
        
        $monitor("Time=%0t | We=%b | Write_addr=%d | Data=%h | Read1_addr=%d | Out1=%h | Read2_addr=%d | Out2=%h", $time, we_tb, rd_addr_tb, wdata_tb, rs1_addr_tb, rdata1_tb, rs2_addr_tb, rdata2_tb);

        rst_n_tb = 0; we_tb = 0; rs1_addr_tb = 0; rs2_addr_tb = 0; 
		rd_addr_tb = 0; wdata_tb = 0;
        #10;
        rst_n_tb = 1;
        #10;

        // Ghi gia tri 0xADCBECAF vao thanh ghi so 1
        @(posedge clk);
        we_tb = 1; rd_addr_tb = 5'd1; wdata_tb = 32'hADCBECAF;
        #10;
        
        @(posedge clk);
        we_tb = 0;
        rs1_addr_tb = 5'd1;
        #5;

        // Thu ghi du lieu vao thanh ghi x0
        @(posedge clk);
        we_tb = 1; rd_addr_tb = 5'd0; wdata_tb = 32'hFFFFFFFF;
        
        @(posedge clk);
        we_tb = 0;
        rs1_addr_tb = 5'd0;
        #5;

        // Doc 2 cong cung mot luc
        // Ghi vao thanh ghi so 2 gia tri 0xFDACBDAC
        @(posedge clk);
        we_tb = 1; rd_addr_tb = 5'd2; wdata_tb = 32'hFDACBDAC;
        @(posedge clk);
        we_tb = 0;
        rs1_addr_tb = 5'd1;
        rs2_addr_tb = 5'd2;
        #10;

        $finish;
    end

endmodule
