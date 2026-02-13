module regfile (
	input logic clk,
	input logic rst_n,

	// Cong doc
	input logic [4:0] rs1_addr,
	input logic [4:0] rs2_addr,
	output logic [31:0] rdata1,
	output logic [31:0] rdata2,

	// Cong ghi
	input logic we,
	input logic [4:0] rd_addr,
	input logic [31:0] wdata
);

	logic [31:0] rf [31:0];
	integer i;

	// Ghi
	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			for (i = 0; i < 32; i++) begin
				rf[i] <= 32'b0;
			end
		end else begin
			if (we && (rd_addr != 5'b0)) begin
				rf[rd_addr] <= wdata;
			end
		end
	end

	// Doc
	assign rdata1 = (rs1_addr == 5'b0) ? 32'b0 : rf[rs1_addr];
	assign rdata2 = (rs2_addr == 5'b0) ? 32'b0 : rf[rs2_addr];

endmodule
