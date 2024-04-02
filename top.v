module top (
    input reset,
    input clk
);

    wire [3:0] addr;
    wire [7:0] instruction;

    /* verilator lint_off UNUSED */
    reg [3:0] btn;
    reg [3:0] led;

    wire write_req;
    reg [7:0] w_addr;
    reg [7:0] w_data;
    /* verilator lint_on UNUSED */

    cpu cpu1(reset, clk, btn, led, addr, instruction);
    ram ram1(reset, clk, 0, {4'b0000, addr}, instruction, w_addr, w_data);

    initial begin
        btn = 4'b0000;
        led = 4'b0000;
        w_addr = 8'b0000_0000;
        w_data = 8'b0000_0000;
    end

    always @(posedge clk) begin
        if (reset == 1) begin
        end else begin
        end
    end

endmodule
