module pc (
    input logic clk,
    input logic rst_n,
    input logic [31:0] pc_next,
    output logic [31:0] pc_out
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_out <= 32'b0;
        end else begin
            pc_out <= pc_next;
        end
    end

endmodule
