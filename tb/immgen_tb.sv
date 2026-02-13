`timescale 1ns/1ps

module immgen_tb;
    logic [31:0] inst_tb;
    logic [31:0] imm_tb;

    immgen dut (
        .inst(inst_tb),
        .imm(imm_tb)
    );

    initial begin
		$dumpfile("sim/immgen_wave.vcd");
		$dumpvars(0, immgen_tb);

        $monitor("Time=%0t | Instruction=%h | Imm_out=%h", 
                 $time, inst_tb, imm_tb);

        // I-Type (ADDI x1, x0, 5)
        // Opcode: 0010011, Imm = 5 (000000000101)
        inst_tb = 32'h00500093;
        #10;

        // I-Type So Am (ADDI x1, x0, -1)
        // Imm = -1
        inst_tb = 32'hfff00093;
        #10;

        // S-Type (SW x1, 4(x0))
        // Opcode: 0100011, Imm = 4
        // SW cat Imm thanh 2 phan: [31:25] va [11:7]
        inst_tb = 32'h00102223;
        #10;

        // B-Type (BEQ x0, x0, 8)
        // Opcode: 1100011, Imm = 8
        inst_tb = 32'h00000463;
        #10;

        // U-Type (LUI x1, 0x12345)
        // Opcode: 0110111, Imm = 0x12345000
        inst_tb = 32'h123450b7;
        #10;

        // J-Type (JAL x1, 8)
        // Opcode: 1101111, Imm = 8
        inst_tb = 32'h008000ef;
        #10;

        $finish;
    end

endmodule
