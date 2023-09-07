`timescale 1ns/1ns
module top_tb();

    reg                 clk;
    reg                 rst_n;
    wire     [5:0]      sel;
    wire     [7:0]      dig;

    top#(.TIME_1S(500), .TIME_20US(100))      inst_top(

        .clk         (clk),
        .rst_n       (rst_n),
        .sel         (sel),
        .dig         (dig)

    );

    parameter CYCLE = 20;
    always #(CYCLE /2 ) clk = ~clk;

    initial begin
        
        clk = 1'b0;
        rst_n = 1'b0;
        #(CYCLE * 3);
        rst_n = 1'b1;
        #(CYCLE * 500 * 90);
        $stop;

    end

endmodule