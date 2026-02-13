`timescale 1ns/1ps

module pc_tb;
	logic clk;
	logic rst_n_tb;
	logic [31:0] pc_next_tb;
	logic [31:0] pc_out_tb;

	pc dut (
		.clk(clk),
		.rst_n(rst_n_tb),
		.pc_next(pc_next_tb),
		.pc_out(pc_out_tb)
	);

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		$dumpfile("sim/pc_wave.vcd");
		$dumpvars(0, pc_tb);

		$monitor("Time=%0t | Reset=%b | PC_next=%d | PC_out=%d", $time, rst_n_tb, pc_next_tb, pc_out_tb);
		
		// Kiem tra Reset
		rst_n_tb = 0; pc_next_tb = 0;
		#10;
		rst_n_tb = 1;

		// Kiem tra viec tang dia chi lenh
		@(posedge clk); pc_next_tb = 32'd4;
		#10;
		@(posedge clk); pc_next_tb = 32'd8;
		#10;

		// Kiem tra lenh nhay coc
		pc_next_tb = 32'd100;
		@(posedge clk);
		#10;
		$finish;
	end

endmodule
