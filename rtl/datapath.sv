module datapath (
    input logic clk,
    input logic rst_n,
    
    // Cac tin hieu dieu khien tu Control Unit
    input logic reg_write, // Co viet vao RegFile
    input logic alu_src, // Chon dau vao B cho ALU (0: Reg, 1: Imm)
    input logic pc_src, // Chon PC tiep theo (0: PC+4, 1: PC_Target)
    input logic [1:0] result_src, // Chon ket qua ghi vao Reg (ALU, Mem, PC+4)
    input logic [2:0] alu_control, // Lenh cho ALU
    input logic [31:0] instr, // Lenh hien tai lay tu IMEM
    input logic [31:0] read_data, // Du lieu doc tu bo nho lay tu DMEM

    // Cac tin hieu gui ra cho Control Unit va Memory
    output logic zero, // Co Zero cua ALU
    output logic [31:0] pc_out, // Dia chi PC hien tai gui cho IMEM
    output logic [31:0] alu_result, // Ket qua ALU dung lam dia chi cho DMEM
    output logic [31:0] write_data   // Du lieu can ghi de gui cho DMEM
);

    logic [31:0] pc_next, pc_plus4, pc_target;
    logic [31:0] imm_ext;
    logic [31:0] src_a, src_b;
    logic [31:0] result;

    // Khoi PC
    pc my_pc (
        .clk(clk),
        .rst_n(rst_n),
        .pc_next(pc_next),
        .pc_out(pc_out)
    );

    // Logic tinh PC tiep theo
    assign pc_plus4 = pc_out + 4;
    assign pc_target = pc_out + imm_ext; // PC khi nhay (Branch/JAL)

    // Bo MUX chon PC
    assign pc_next = (pc_src) ? pc_target : pc_plus4;

    // Khoi Regfile
    regfile my_rf (
        .clk(clk),
        .rst_n(rst_n),
        .we3(reg_write),
        .a1(instr[19:15]), // rs1
        .a2(instr[24:20]), // rs2
        .a3(instr[11:7]), // rd (Thanh ghi dich)
        .wd3(result), // Du lieu can ghi
        .rd1(src_a), // Dau ra A (Noi vao ALU)
        .rd2(write_data) // Dau ra B (Noi vao ALU hoac DMEM)
    );

    // Khoi Immgen
    immgen my_immgen (
        .inst(instr),
        .imm(imm_ext)
    );

    // Khoi ALU
    // Neu alu_src=0: Lay tu RegFile (write_data)
    // Neu alu_src=1: Lay tu ImmGen (imm_ext)
    assign src_b = (alu_src) ? imm_ext : write_data;

    alu my_alu (
        .a(src_a),
        .b(src_b),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero)
    );

    // Bo MUX de chon ket qua cuoi cung
    // Ket qua quay ve ghi vao RegFile
    // 00: ALU (Lenh tinh toan)
    // 01: ReadData (Lenh Load tu bo nho)
    // 10: PC+4 (Lenh JAL/JALR de luu dia chi tra ve)
    always_comb begin
        case (result_src)
            2'b00: result = alu_result;
            2'b01: result = read_data;
            2'b10: result = pc_plus4;
            default: result = 32'b0;
        endcase
    end

endmodule
