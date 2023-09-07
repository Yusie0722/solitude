module seg_led#(parameter TIME_500MS = 25_000_000, 
                parameter ZER = 8'b1100_0000,
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
                          F   = 8'b1000_1110
                )(

    input                   clk,
    input                   rst_n,
    
    input          [2:0]    key,
    output  reg    [7:0]    dig,    //段选
    output  reg    [5:0]    sel

);

    reg     [24:0]  cnt;
    wire            add_cnt;
    wire            end_cnt;

    reg     [3:0]   cnt1;
    wire            add_cnt1;
    wire            end_cnt1;

    //计数器500MS
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt <= 25'd0;
        else if(add_cnt)
            if(end_cnt)
                cnt <= 25'd0;
            else
                cnt <= cnt + 1'b1;
        else
            cnt <= cnt;

    end

    assign add_cnt = key == 3'b110 || 1'b1;
    assign end_cnt = add_cnt && cnt == TIME_500MS - 1;

    //计数器    显示数字切换
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt1 <= 4'd0;
        else if(add_cnt1)
            if(end_cnt1)
                cnt1 <= 4'd0;
            else
                cnt1 <= cnt1 + 1'b1;
        else
            cnt1 <= cnt1;

    end

    assign add_cnt1 = key == 3'b110 || end_cnt;
    assign end_cnt1 = add_cnt1 && cnt1 == 16 - 1;


    //位选
    always @(posedge clk or negedge rst_n)begin

        if(!rst_n)
            sel <= 6'b111111;
        else
            sel <= 6'b000000;

    end

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            dig <= 8'b1111_1111;
        else begin
            
            case(cnt1)

                0  : dig <= ZER;
                1  : dig <= ONE;
                2  : dig <= TWO;
                3  : dig <= THR;
                4  : dig <= FOU;
                5  : dig <= FIV;
                6  : dig <= SIX;
                7  : dig <= SEV;
                8  : dig <= EIG;
                9  : dig <= NIN;
                10 : dig <= A  ;
                11 : dig <= B  ;
                12 : dig <= C  ;
                13 : dig <= D  ;
                14 : dig <= E  ;
                15 : dig <= F  ;
                default :      ;

            endcase

        end



    end






endmodule