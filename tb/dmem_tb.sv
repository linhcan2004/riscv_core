`timescale 1ns/1ps

module dmem_tb;
	logic clk;
	logic we_tb;
	logic [31:0] addr_tb;
	logic [31:0] wdata_tb;
	logic [31:0] rdata_tb;

	dmem dut (
		.clk(clk),
		.we(we_tb),
		.addr(addr_tb),
		.wdata(wdata_tb),
		.rdata(rdata_tb)
	);

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		$dumpfile("sim/dmem_wave.vcd");
		$dumpvars(0, dmem_tb);

		$monitor("Time=%0t | WE=%b | Addr=%d | Wdata=%h | Rdata=%h", $time, we_tb, addr_tb, wdata_tb, rdata_tb);

		// Ghi du lieu
		we_tb = 1; addr_tb = 32'd0;
		wdata_tb = 32'hADCEAFCD;
		@(posedge clk);
		#10;

		addr_tb = 32'd4;
		wdata_tb = 32'hDECFECDA;
		@(posedge clk);
		#10;

		// Doc du lieu
		we_tb = 0;
		addr_tb = 32'd0;
		#10;
		addr_tb = 32'd4;
		#10;
		$finish;
	end

endmodule
