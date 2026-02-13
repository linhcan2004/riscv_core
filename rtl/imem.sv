module imem (
	input logic [31:0] addr,
	output logic [31:0] data
);
	
	// Tao mang bo nho RAM
	logic [31:0] RAM [0:63];
	
	// Doc file program.hex va nap vao RAM
	initial begin
		$readmemh("program.hex", RAM);
	end

	// Doc du lieu tu RAM
	assign data = RAM[addr[31:2]];

endmodule
