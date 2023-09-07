module top(

    input           clk,
    input           rst_n,
    input   [2:0]   key,
    output          pwm

);

    wire    [2:0]   key_out;

    fsm_key         inst_fsm_key(

        .clk        (clk),
        .rst_n      (rst_n),
        .key_in     (key),
        .key_out    (key_out)

    );

    beep_key        inst_beep_key(

        .clk        (clk),
        .rst_n      (rst_n),
        .key        (key_out),
        .pwm        (pwm)

    );







endmodule