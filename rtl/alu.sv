module alu (
	input  logic [31:0] a,
	input  logic [31:0] b,
	input  logic [3:0] alu_op,
	output logic [31:0] result,
	output logic zero
);

	typedef enum logic [3:0] {
		ALU_ADD  = 4'b0000,
		ALU_SUB  = 4'b0001,
		ALU_AND  = 4'b0010,
		ALU_OR   = 4'b0011,
		ALU_XOR  = 4'b0100,
		ALU_SLL  = 4'b0101, //Shift Left Logical
		ALU_SRL  = 4'b0111, //Shift Right Logical
		ALU_SRA  = 4'b1000, //Shift Right Arithmetic
		ALU_SLT  = 4'b1001, //Set Less Than
		ALU_SLTU = 4'b1010, //Set Less Than Unsigned
	} alu_op_t;

	always_comb begin
		case(alu_op)
			ALU_ADD: 
				result = a + b;
			ALU_SUB:
				result = a - b;
			ALU_AND:
				result = a & b;
			ALU_OR:
				result = a | b;
			ALU_XOR:
				result = a ^ b;
			ALU_SLL:
				result = a << b[4:0];
			ALU_SRL:
				result = a >> b[4:0];
			ALU_SRA:
				result = $signed(a) >>> b[4:0];
			ALU_SLT:
				result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
			ALU_SLTU:
				result = (a < b) ? 32'd1 : 32'd0;
			default: result = 32'b0;
		endcase
	end

	assign zero = (result == 32'b0);

endmodule
