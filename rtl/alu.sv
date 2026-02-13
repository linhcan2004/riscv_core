module alu (
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [2:0] alu_control,
    output logic [31:0] result,
    output logic zero
);

    always_comb begin
        case (alu_control)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b101: result = (a < b) ? 32'd1 : 32'd0;
            default: result = 32'b0;
        endcase
    end

    // Co Zero: Neu ket qua bang 0 thi bat len 1
    assign zero = (result == 32'b0);

endmodule
