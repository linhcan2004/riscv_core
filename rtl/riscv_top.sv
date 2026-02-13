module riscv_top (
    input logic clk,
    input logic rst_n,
    output logic [31:0] test_result
);
    
    // Khai bao day noi noi bo
    logic [31:0] instr;
    logic [31:0] pc, alu_result, write_data, read_data;
    logic zero;
    
    // Cac tin hieu dieu khien
    logic pc_src;
    logic [1:0] result_src;
    logic mem_write;
    logic alu_src;
    logic reg_write;
    logic [2:0] alu_control;
    logic funct7b5;

    // Datapath
    datapath dp (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .pc_src(pc_src),
        .result_src(result_src),
        .alu_control(alu_control),
        .instr(instr),
        .read_data(read_data),
        .zero(zero),
        .pc_out(pc),
        .alu_result(alu_result),
        .write_data(write_data)
    );

    // Control Unit
    assign funct7b5 = instr[30];

    control_unit cu (
        .op(instr[6:0]),
        .funct3(instr[14:12]),
        .funct7b5(funct7b5),
        .zero(zero),
        .pc_src(pc_src),
        .result_src(result_src),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_control(alu_control)
    );

    // Bo nho lenh (IMEM)
    imem my_imem (
        .addr(pc),
        .data(instr)
    );

    // Bo nho du lieu (DMEM)
    dmem my_dmem (
        .clk(clk),
        .we(mem_write),
        .addr(alu_result),
        .wdata(write_data),
        .rdata(read_data)
    );

    // Dua ket qua ALU ra ngoai de xem tren song
    assign test_result = alu_result;

endmodule
