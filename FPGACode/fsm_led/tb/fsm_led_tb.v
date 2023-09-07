`timescale 1ns/1ns
module fsm_led_tb();

    reg             tb_clk  ;
    reg             tb_rst_n;
    wire    [3:0]   tb_led  ;

    //模块例化
    fsm_led#(.TIME_2S(1000))     inst_fsm_led(

        .clk    (tb_clk     )   ,
        .rst_n  (tb_rst_n   )   ,
        .led    (tb_led     )

    );

    parameter CYCLE = 20;
    always #(CYCLE / 2) tb_clk = ~tb_clk;

    initial begin       //产生激励

        tb_clk = 1'b0;
        tb_rst_n = 1'b0;
        #(CYCLE * 3);
        tb_rst_n = 1'b1;
        #(CYCLE * 1000 * 10);
        $stop;

    end

endmodule