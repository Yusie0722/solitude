`timescale 1ns/1ns
module tb_top();

    reg             clk;
    reg             rst_n;
    reg     [2:0]   key;
    wire    [7:0]   dig;
    wire    [5:0]   sel;

    top#(.TIME_500MS(200))       inst_top( 

        .clk        (clk),
        .rst_n      (rst_n),
        .key        (key),
        .dig        (dig),
        .sel        (sel)
        
    );

    parameter CYCLE = 20;
    always #(CYCLE / 2) clk = ~clk;

    reg     [23:0]      charac;
    always @(*)begin
        
        case(inst_top.dig)
            inst_top.ZER : charac = "ZER";
            inst_top.ONE : charac = "ONE";
            inst_top.TWO : charac = "TWO";
            inst_top.THR : charac = "THR";
            inst_top.FOU : charac = "FOU";
            inst_top.FIV : charac = "FIV";
            inst_top.SIX : charac = "SIX";
            inst_top.SEV : charac = "SEV";
            inst_top.EIG : charac = "EIG";
            inst_top.NIN : charac = "NIN";
            inst_top.A   : charac = "A";
            inst_top.B   : charac = "B";
            inst_top.C   : charac = "C";
            inst_top.D   : charac = "D";
            inst_top.E   : charac = "E";
            inst_top.F   : charac = "F";
            default      :;

        endcase

    end

    initial begin
        
        clk = 1'b0;
        rst_n = 1'b0;
        #(CYCLE * 3);
        rst_n = 1'b1;        
        #(CYCLE * 200 * 16);
        $stop;

    end







endmodule