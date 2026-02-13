module control_unit (
    input logic [6:0] op, // Opcode (7 bit cuoi cua lenh)
    input logic [2:0] funct3, // Funct3 (Bit [14-12])
    input logic funct7b5, // Funct7 bit 5 (Bit 30 phan biet ADD/SUB)
    input logic zero, // Tin hieu Zero tu ALU de bao hieu a == b
    
    output logic pc_src, // 0: PC+4, 1: PC+Imm
    output logic [1:0] result_src, // 00: ALU, 01: Mem, 10: PC+4
    output logic mem_write, // 1: Ghi bo nho (Store)
    output logic alu_src, // 0: RegB, 1: Imm
    output logic reg_write, // 1: Ghi thanh ghi (RegFile)
    output logic [2:0] alu_control // Lenh dieu khien ALU
);

    logic [1:0] alu_op; // Tin hieu trung gian
    logic branch; // Lenh re nhanh
    logic jump; // Lenh nhay

    // Bo giai ma chinh
    always_comb begin
        // Gia tri mac dinh
        branch = 0;
        jump = 0;
        result_src = 2'b00;
        mem_write = 0;
        alu_src = 0;
        reg_write = 0;
        alu_op = 2'b00;

        case (op)
            // Lenh R-Type (ADD, SUB, AND, OR)
            7'b0110011: begin
                reg_write = 1;
                alu_op = 2'b10; // Bat ALU Decoder
            end

            // Lenh I-Type (ADDI, ANDI)
            7'b0010011: begin
                reg_write = 1;
                alu_src = 1; // Lay so Imm
                alu_op = 2'b10; // Bat ALU Decoder
            end

            // Lệnh LW
            7'b0000011: begin
                reg_write = 1;
                alu_src = 1;
                result_src = 2'b01; // Lay tu Mem
                alu_op = 2'b00; // ALU Cong (tinh dia chi)
            end

            // Lệnh SW
            7'b0100011: begin
                mem_write = 1;
                alu_src = 1;
                alu_op = 2'b00; // ALU Cong
            end

            // Lệnh BEQ
            7'b1100011: begin
                branch = 1;
                alu_op = 2'b01; // ALU Tru (so sanh)
            end
            
            // Lệnh JAL
            7'b1101111: begin
                jump = 1;
                result_src = 2'b10; // Luu PC+4
                reg_write = 1;
                alu_src = 1; 
            end
        endcase
    end

    // Giai ma chi tiet cho ALU
    always_comb begin
        case (alu_op)
            2'b00: alu_control = 3'b000; // Cong (cho LW, SW)
            2'b01: alu_control = 3'b001; // Tru (cho BEQ)
            default: begin // R-Type hoac I-Type
                case (funct3)
                    3'b000: begin
                        if (op == 7'b0110011 && funct7b5) 
                            alu_control = 3'b001; // SUB
                        else 
							alu_control = 3'b000; // ADD
                    end
                    3'b010: alu_control = 3'b101; // SLT
                    3'b110: alu_control = 3'b011; // OR
                    3'b111: alu_control = 3'b010; // AND
                    default: alu_control = 3'b000;
                endcase
            end
        endcase
    end

    // Logic Pc_src
    assign pc_src = jump | (branch & zero);

endmodule
