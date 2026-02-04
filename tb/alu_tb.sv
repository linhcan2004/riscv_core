`timescale 1ns/1ps

import riscv_pkg::*;

module alu_tb;
	logic [31:0] a_tb;
	logic [31:0] b_tb;
	alu_op_t alu_op_tb;
	logic [31:0] result_tb;
	logic zero_tb;

	alu dut (
		.a(a_tb),
		.b(b_tb),
		.alu_op(alu_op_tb),
		.result(result_tb),
		.zero(zero_tb)
	);

	initial begin
		$dumpfile("sim/alu_wave.vcd");
		$dumpvars(0, alu_tb);

		$monitor("Time=%0t | Op=%b | A=%d | B=%d | Res=%d | Zero=%b", $time, alu_op_tb, a_tb, b_tb, result_tb, zero_tb);

		a_tb = 32'd10;
		b_tb = 32'd20;
		alu_op_tb = ALU_ADD;
		#10;

		alu_op_tb = ALU_SUB;
		#10;

		alu_op_tb = ALU_AND;
		#10;

		alu_op_tb = ALU_OR;
		#10;

		alu_op_tb = ALU_XOR;
		#10;

		alu_op_tb = ALU_SLL;
		#10;

		alu_op_tb = ALU_SRL;
		#10;

		alu_op_tb = ALU_SRA;
		#10;

		alu_op_tb = ALU_SLT;
		#10;

		alu_op_tb = ALU_SLTU;
		#10;

		$finish;
	end

endmodule
