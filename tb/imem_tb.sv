`timescale 1ns/1ps

module imem_tb;
	logic [31:0] addr_tb;
	logic [31:0] data_tb;

	imem dut (
		.addr(addr_tb),
		.data(data_tb)
	);

	initial begin
		$dumpfile("sim/imem_wave.vcd");
		$dumpvars(0, imem_tb);

		$monitor("Time=%0t | PC_addr=%d | Instruction=%h", $time, addr_tb, data_tb);
		addr_tb = 32'd0;
		#10;

		addr_tb = 32'd4;
		#10;

		addr_tb = 32'd8;
		#10;

		addr_tb = 32'd12;
		#10;

		$finish;
	end

endmodule
