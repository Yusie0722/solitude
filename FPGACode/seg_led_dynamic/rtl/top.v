module top#(parameter TIME_20US = 1000, TIME_1S = 50_000_000)(

    input               clk,
    input               rst_n,
    output    [5:0]     sel,
    output    [7:0]     dig

);

    wire    [16:0]    dout;

    seg_led_dynamic#(.TIME_20US(TIME_20US))     u_seg_led_dynamic(

        .clk        (clk),
        .rst_n      (rst_n),
        .din        (dout),
        .dig        (dig),
        .sel        (sel)

    );

    time_count#(.TIME_1S(TIME_1S))      u_time_count(

        .clk        (clk),
        .rst_n      (rst_n),
        .dout       (dout)

    );

endmodule