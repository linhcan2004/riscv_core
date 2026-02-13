module dmem (
	input logic clk,
	input logic we,
	input logic [31:0] addr,
	input logic [31:0] wdata,
	output logic [31:0] rdata
);
	// Tao mang RAM
	logic [31:0] RAM [0:63];
	
	// Doc du lieu
	assign rdata = RAM[addr[31:2]];

	// Ghi du lieu
	always_ff @(posedge clk) begin
		if (we) begin
			RAM[addr[31:2]] <= wdata;
		end
	end

endmodule
