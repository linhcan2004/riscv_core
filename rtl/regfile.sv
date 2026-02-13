module regfile (
    input logic clk,
    input logic rst_n,
    input logic we3, // Write enable
    input logic [4:0] a1, // Read address 1
    input logic [4:0] a2, // Read address 2
    input logic [4:0] a3, // Write address
    input logic [31:0] wd3, // Write data
    output logic [31:0] rd1, // Read data 1
    output logic [31:0] rd2 // Read data 2
);

    logic [31:0] rf [0:31];

    // Doc du lieu
    assign rd1 = (a1 != 0) ? rf[a1] : 32'b0;
    assign rd2 = (a2 != 0) ? rf[a2] : 32'b0;

    // Ghi du lieu
    always_ff @(posedge clk) begin
        if (!rst_n) begin
        end else if (we3) begin
             rf[a3] <= wd3;
        end
    end

endmodule
