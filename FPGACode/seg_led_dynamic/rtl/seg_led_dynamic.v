module seg_led_dynamic#(parameter TIME_20US = 1000)(

    input                   clk,
    input                   rst_n,
    input           [16:0]  din,
    output   reg    [7:0]   dig,
    output   reg    [5:0]   sel

);
    parameter ZER = 7'b100_0000,
              ONE = 7'b111_1001,
              TWO = 7'b010_0100,
              THR = 7'b011_0000,
              FOU = 7'b001_1001,
              FIV = 7'b001_0010,
              SIX = 7'b000_0010,
              SEV = 7'b111_1000,
              EIG = 7'b000_0000,
              NIN = 7'b001_0000;

    reg    [9:0]    cnt;
    wire            add_cnt;
    wire            end_cnt;

    reg    [3:0]    data;       //寄存器 寄存多少秒
    reg             dot;        //小数点

    wire   [3:0]    sec_l;      //秒低位
    wire   [2:0]    sec_h;      //秒高位
    wire   [3:0]    min_l;      //分低位
    wire   [2:0]    min_h;      //分高位
    wire   [3:0]    hou_l;      //时低位
    wire   [1:0]    hou_h;      //时高位

    assign sec_l = din[5:0]     % 10;
    assign sec_h = din[5:0]     / 10;
    assign min_l = din[11:6]    % 10;
    assign min_h = din[11:6]    / 10;
    assign hou_l = din[16:12]   % 10;
    assign hou_h = din[16:12]   / 10;



    //计数器20US
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt <= 10'd0;
        else if(add_cnt)
            if(end_cnt)
                cnt <= 10'd0;
            else
                cnt <= cnt + 1'b1;
        else
            cnt <= cnt;

    end
    assign add_cnt = 1'b1;
    assign end_cnt = add_cnt && cnt == TIME_20US - 1;


    //位选
    always @(posedge clk or negedge rst_n)begin

        if(!rst_n)
            sel <= 6'b011_111;
        else if(end_cnt)
            sel <= {sel[0],sel[5:1]};
        else
            sel <= sel;

    end

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)begin
            data <= 4'hf;
            dot <= 1'b1;
        end
        else

            case(sel)

                6'b011_111 :begin
                    data <= sec_l;
                    dot <= 1'b1;
                end

                6'b101_111 :begin
                    data <= sec_h;
                    dot <= 1'b1;
                end

                6'b110_111 :begin
                    data <= min_l;
                    dot <= 1'b0;
                end

                6'b111_011 :begin
                    data <= min_h;
                    dot <= 1'b1;
                end

                6'b111_101 :begin
                    data <= hou_l;
                    dot <= 1'b0;
                end

                6'b111_110 :begin
                    data <= hou_h;
                    dot <= 1'b1;
                end

                default :begin
                    data <= 4'hf;
                    dot <= 1'b1;
                end

            endcase

    end

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            dig <= 8'hff;
        else

            case(data)

                0   :   dig <= {dot,ZER};
                1   :   dig <= {dot,ONE};
                2   :   dig <= {dot,TWO};
                3   :   dig <= {dot,THR};
                4   :   dig <= {dot,FOU};
                5   :   dig <= {dot,FIV};
                6   :   dig <= {dot,SIX};
                7   :   dig <= {dot,SEV};
                8   :   dig <= {dot,EIG};
                9   :   dig <= {dot,NIN};
                default : dig <= 8'hff;

            endcase

    end



endmodule