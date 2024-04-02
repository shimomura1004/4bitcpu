module ram (
    input reset,
    input clk,
    input write_req,
    input  [7:0] r_addr,
    output [7:0] r_data,
    input  [7:0] w_addr,
    input  [7:0] w_data
);

    reg [7:0] mem[255:0];

    assign r_data = mem[r_addr];

    initial begin
        mem[0] = 8'b01100000; // inc R0
        mem[1] = 8'b10000000; // jnc 0000
        mem[2] = 8'b10100000; // mvi 0000
        mem[3] = 8'b10010000; // jmp 0
    end

    always @(posedge clk) begin
        if (reset == 1) begin
        end else begin
            if (write_req == 1) begin
                mem[w_addr] <= w_data;
            end
        end
    end

endmodule
