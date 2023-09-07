module top(

    input           clk,
    input           rst_n,
    input   [2:0]   key,
    output  [7:0]   dig,
    output  [5:0]   sel

);

    parameter       TIME_500MS;
    
    parameter       ZER = 8'b1100_0000,
                    ONE = 8'b1111_1001,
                    TWO = 8'b1010_0100,
                    THR = 8'b1011_0000,
                    FOU = 8'b1001_1001,
                    FIV = 8'b1001_0010,
                    SIX = 8'b1000_0010,
                    SEV = 8'b1111_1000,
                    EIG = 8'b1000_0000,
                    NIN = 8'b1001_0000,
                    A   = 8'b1000_1000,
                    B   = 8'b1000_0011,
                    C   = 8'b1100_0110,
                    D   = 8'b1010_0001,
                    E   = 8'b1000_0110,
                    F   = 8'b1000_1110;
    wire    [2:0]   key_out;

    fsm_key         inst_fsm_key(

        .clk        (clk),
        .rst_n      (rst_n),
        .key_in     (key),
        .key_out    (key_out)

    );

    seg_led#(

        .TIME_500MS(TIME_500MS),
        .ZER(ZER),
        .ONE(ONE),        
        .TWO(TWO),        
        .THR(THR),        
        .FOU(FOU),        
        .FIV(FIV),
        .SIX(SIX),
        .SEV(SEV),
        .EIG(EIG),
        .NIN(NIN),
        .A(A),  
        .B(B),  
        .C(C),  
        .D(D),  
        .E(E),  
        .F(F)

        )        inst_seg_led(

        .clk        (clk),
        .rst_n      (rst_n),
        .key        (key_out),
        .dig        (dig),
        .sel        (sel)
    );

endmodule