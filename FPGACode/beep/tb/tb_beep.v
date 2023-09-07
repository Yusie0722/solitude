`timescale 1ns/1ns
module tb_beep();

    reg    clk;
    reg    rst_n;
    wire   pwm;



    beep#(.TIME_300MS(1500), .CLK_PRE(5000))        inst_beep(

        .clk        (clk),
        .rst_n      (rst_n),
        .pwm        (pwm)

    );

    reg     [15:0]      charac;

    always @(*)begin
        
        case(inst_beep.X)

            inst_beep.DO : charac = "DO";
            inst_beep.RE : charac = "RE";
            inst_beep.MI : charac = "MI";
            inst_beep.FA : charac = "FA";
            inst_beep.SO : charac = "SO";
            inst_beep.LA : charac = "LA";
            inst_beep.SI : charac = "SI";
            default      : charac = "DO";

        endcase

    end

    parameter CYCLE = 20;
    always #(CYCLE / 2) clk = ~clk;

    initial begin
        
        clk = 1'b0;
        rst_n = 1'b0;
        #(CYCLE * 3);
        rst_n = 1'b1;
        #(CYCLE * 1500 * 48);
        $stop;

    end


endmodule