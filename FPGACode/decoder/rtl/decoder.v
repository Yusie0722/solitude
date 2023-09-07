module decoder(

    input   wire    [2:0]   a,
    output  reg     [7:0]   b

);

    always @(*)begin
        
        // if(a == 3'b000)begin
        //     b = 8'b0111_1111;
        // end
        case(a)

            3'b000 : b = 8'b1111_1110;
            3'b001 : b = 8'b1111_1101;
            3'b010 : b = 8'b1111_1011;
            3'b011 : b = 8'b1111_0111;
            3'b100 : b = 8'b1110_1111;
            3'b101 : b = 8'b1101_1111;
            3'b110 : b = 8'b1011_1111;
            3'b111 : b = 8'b0111_1111;
            default : b = 8'b0000_0000;//出错为0

        endcase

    end

endmodule