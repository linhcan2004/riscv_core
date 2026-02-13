module immgen (
    input  logic [31:0] inst, // Instruction lay tu IMEM
    output logic [31:0] imm
);

    always @(*) begin
        case (inst[6:0])
            // Lenh I-Type
            // Opcode: 0010011 (ADDI), 0000011 (LW), 1100111 (JALR)
            7'b0010011, 7'b0000011, 7'b1100111: begin
                imm = {{20{inst[31]}}, inst[31:20]};
            end

            // Lenh S-Type
            // Opcode: 0100011 (SW)
            7'b0100011: begin
                imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
            end

            // Lenh B-Type
            // Opcode: 1100011 (Branch)
            7'b1100011: begin
                imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
            end

            // Lenh U-Type
            // Opcode: 0110111 (LUI), 0010111 (AUIPC)
            7'b0110111, 7'b0010111: begin
                imm = {inst[31:12], 12'b0};
            end

            // Lenh J-Type
            // Opcode: 1101111 (JAL)
            7'b1101111: begin
                imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
            end

            default: imm = 32'b0;
        endcase
    end

endmodule
