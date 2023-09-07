`timescale 1ns/1ns
module fsm_key_tb();

    parameter W = 3;

    reg               clk;
    reg               rst_n;
    reg   [W-1:0]     key_in;
    wire  [W-1:0]     key_out;

    fsm_key#(.TIME_20MS(500), .W(W))     inst_fsm_key(

        .clk        (clk    )   ,
        .rst_n      (rst_n  )   ,
        .key_in     (key_in )   ,
        .key_out    (key_out)  

    );

    parameter CYCLE = 20;
    always #(CYCLE / 2) clk = ~clk;

    initial begin
        
        clk = 1'b0;
        rst_n = 1'b0;
        key_in = 3'b111;
        #(CYCLE * 3);
        rst_n = 1'b1;
        #(CYCLE * 200);
        key_in = 3'b110;  //按键按下(抖动)
        #(CYCLE * 200); //按键按下200个
        key_in = 3'b111;  //按键松开
        #(CYCLE * 1000);

        key_in = 3'b110;
        #(CYCLE * 1500);
        key_in = 3'b111;
        #(CYCLE * 1000);

        key_in = 3'b101;
        #(CYCLE * 1500);
        key_in = 3'b111;
        #(CYCLE * 700);
        $stop;

    end

endmodule