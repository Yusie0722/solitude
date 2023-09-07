`timescale 1ns/1ns 
module beep_tb();

    reg             tb_clk      ;
    reg             tb_rst_n    ;
    wire            tb_pwm      ;

    beep#(.CLK_PRE(5000),.TIME_300MS(1500))        inst_beep(
        .clk        (tb_clk     )   ,
        .rst_n      (tb_rst_n   )   ,
        .pwm        (tb_pwm     )    
    );

    reg      [15:0]     charac  ;
    always @(*)begin
        case(inst_beep.X)
            inst_beep.DO : charac = "DO";
            inst_beep.RE : charac = "RE";
            inst_beep.MI : charac = "MI";
            inst_beep.FA : charac = "FA";
            inst_beep.SO : charac = "SO";
            inst_beep.LA : charac = "LA";
            inst_beep.SI : charac = "SI";
            default : charac = "DO";
        endcase
    end

    parameter CYCLE = 20;
    always #(CYCLE / 2) tb_clk = ~tb_clk;

    initial begin
        tb_clk = 1'b0;
        tb_rst_n = 1'b0;
        #(CYCLE * 3);
        tb_rst_n = 1'b1;
        #(CYCLE * 1500 * 48);
        $stop;
    end


endmodule