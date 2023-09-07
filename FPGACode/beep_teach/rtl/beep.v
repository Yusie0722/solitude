module beep#(parameter CLK_PRE = 50_000_000 , TIME_400MS = 20_000_000)(
    input           clk     ,
    input           rst_n   ,
    output  reg     pwm              
);
    //频率控制音色 占空比控制音量 (占空比越大 低电平越少 音量越小)
    parameter   DO  =   CLK_PRE / 523,      //DO所需要的时钟周期   
                RE  =   CLK_PRE / 587,
                MI  =   CLK_PRE / 659,
                FA  =   CLK_PRE / 698,
                SO  =   CLK_PRE / 784,
                LA  =   CLK_PRE / 880,
                SI  =   CLK_PRE / 988;

    reg     [16:0]      cnt1        ;   //计数频率
    wire                add_cnt1    ;
    wire                end_cnt1    ;
    reg     [16:0]      X           ;  //cnt1计数器最大值 就是当前发哪一个的声音

    reg     [24:0]      cnt2        ;   //计数器时间600ms 每一个音符都发600ms时间
    wire                add_cnt2    ;
    wire                end_cnt2    ;

    reg     [6:0]       cnt3        ;   //乐谱计数器 计数48个
    wire                add_cnt3    ;
    wire                end_cnt3    ;

    reg                 pwm_ctrl    ;   //过滤后面25%  1不发声音 

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt1 <= 17'd0;
        end
        else if(end_cnt2)begin
            cnt1 <= 17'd0;
        end
        else if(add_cnt1)begin
            if(end_cnt1)begin
                cnt1 <= 17'd0;
            end
            else begin
                cnt1 <= cnt1 + 1'b1;
            end
        end
        else begin
            cnt1 <= cnt1;
        end
    end

    assign add_cnt1 = 1'b1;
    assign end_cnt1 = add_cnt1 && cnt1 == X - 1;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt2 <= 25'd0;
        end
        else if(add_cnt2)begin
            if(end_cnt2)begin
                cnt2 <= 25'd0;
            end
            else begin
                cnt2 <= cnt2 + 1'b1;
            end
        end
        else begin
            cnt2 <= cnt2;
        end
    end

    assign add_cnt2 = 1'b1;
    assign end_cnt2 = add_cnt2 && cnt2 == TIME_400MS - 1;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt3 <= 7'd0;
        end
        else if(add_cnt3)begin
            if(end_cnt3)begin
                cnt3 <= 7'd0;
            end
            else begin
                cnt3 <= cnt3 + 1'b1;
            end
        end
        else begin
            cnt3 <= cnt3;
        end
    end

    assign add_cnt3 = end_cnt2;
    assign end_cnt3 = add_cnt3 && cnt3 == 93 - 1;

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            X <= 16'd1;
        end
        else begin
            case(cnt3)
                0   : X <= MI;
                1   : X <= MI;
                2   : X <= SO;
                3   : X <= LA;
                4   : X <= DO;
                5   : X <= DO;
                6   : X <= LA;

                7   : X <= SO;
                8   : X <= SO;
                9   : X <= LA;
                10  : X <= SO;
                11  : X <= 1;

                12  : X <= MI;
                13  : X <= MI;
                14  : X <= SO;
                15  : X <= LA;
                16  : X <= DO;
                17  : X <= DO;
                18  : X <= LA;

                19  : X <= SO;
                20  : X <= SO;
                21  : X <= LA;
                22  : X <= SO;
                23  : X <= 1;

                24  : X <= SO;
                25  : X <= SO;
                26  : X <= SO;
                27  : X <= MI;
                28  : X <= SO;

                29  : X <= LA;
                30  : X <= LA;
                31  : X <= SO;
                32  : X <= SO;
                33  : X <= 1;

                34  : X <= MI;
                35  : X <= RE;
                36  : X <= MI;
                37  : X <= SO;
                38  : X <= MI;
                39  : X <= RE;

                40  : X <= DO;
                41  : X <= DO;
                42  : X <= RE;
                43  : X <= DO;
                44  : X <= 1;

                45  : X <= MI;
                46  : X <= RE;
                47  : X <= DO;
                48  : X <= MI;
                49  : X <= RE;
                50  : X <= MI;

                51  : X <= SO;
                52  : X <= LA;
                53  : X <= DO;
                54  : X <= SO;
                55  : X <= 1;

                56  : X <= RE;
                57  : X <= MI;
                58  : X <= SO;
                59  : X <= RE;
                60  : X <= MI;
                61  : X <= DO;
                62  : X <= LA;

                63  : X <= SO;
                64  : X <= 1;
                65  : X <= LA;
                66  : X <= LA;
                67  : X <= DO;

                68  : X <= RE;
                69  : X <= MI;
                70  : X <= DO;
                71  : X <= RE;
                72  : X <= DO;
                73  : X <= LA;

                74  : X <= SO;
                75  : X <= 1;
                76  : X <= 1;
                77  : X <= 1;

                78  : X <= SO;
                79  : X <= 1;
                80  : X <= LA;
                81  : X <= LA;
                82  : X <= DO;

                83  : X <= RE;
                84  : X <= MI;
                85  : X <= DO;
                86  : X <= RE;
                87  : X <= DO;
                88  : X <= LA;

                89  : X <= SO;
                90  : X <= 1;
                91  : X <= 1;
                92  : X <= 1;

                default : X <= 1;
            endcase
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            pwm_ctrl <= 1'b0;
        end
        else if(cnt2 > TIME_400MS)begin
            pwm_ctrl <= 1'b1;
        end
        else if(X == 1)begin
            pwm_ctrl <= 1'b1;
        end
        else begin
            pwm_ctrl <= 1'b0;
        end
    end

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin     //复位之后不响
            pwm <= 1'b1;
        end
        else if(pwm_ctrl)begin  //pwm_ctrl有效不响
            pwm <= 1'b1;
        end
        else if(cnt1 < (X >> 4))begin
            pwm <= 1'b0;
        end
        else begin
            pwm <= 1'b1;
        end
    end

endmodule 