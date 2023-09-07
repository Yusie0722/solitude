module beep_key#(parameter CLK_PRE = 50_000_000 ,TIME_300MS = 15_000_000, TIME_400MS = 20_000_000)(
    input           clk     ,
    input           rst_n   ,
    input   [2:0]   key     ,
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

    reg     [24:0]      cnt2        ;   //计数器时间300ms 每一个音符都发300ms时间
    wire                add_cnt2    ;
    wire                end_cnt2    ;

    reg     [6:0]       cnt3        ;   //乐谱计数器 计数*个
    wire                add_cnt3    ;
    wire                end_cnt3    ;

    reg     [4:0]       cnt4;    
    wire                add_cnt4;
    wire                end_cnt4;

    reg     [7:0]       cnt5;    
    wire                add_cnt5;
    wire                end_cnt5;

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

    assign add_cnt1 = key == 3'b110 || key == 3'b101 || key == 3'b011;
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

    assign add_cnt2 = key == 3'b110 || key == 3'b101 || key == 3'b011;
    assign end_cnt2 = add_cnt2 && cnt2 == TIME_300MS - 1;

    //茉莉花
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

    assign add_cnt3 = key == 3'b110 && end_cnt2;
    assign end_cnt3 = add_cnt3 && cnt3 == 93 - 1;

    //祝你生日快乐
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt4 <= 5'd0;
        end
        else if(add_cnt4)begin
            if(end_cnt4)begin
                cnt4 <= 5'd0;
            end
            else begin
                cnt4 <= cnt4 + 1'b1;
            end
        end
        else begin
            cnt4 <= cnt4;
        end
    end

    assign add_cnt4 = key == 3'b101 && end_cnt2;
    assign end_cnt4 = add_cnt4 && cnt4 == 28 - 1;

    //听海
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt5 <= 8'd0;
        end
        else if(add_cnt5)begin
            if(end_cnt5)begin
                cnt5 <= 8'd0;
            end
            else begin
                cnt5 <= cnt5 + 1'b1;
            end
        end
        else begin
            cnt5 <= cnt5;
        end
    end

    assign add_cnt5 = key == 3'b011 && end_cnt2;
    assign end_cnt5 = add_cnt5 && cnt5 == 158 - 1;



    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            X <= 16'd1;
        end
        else begin
            if(key == 3'b110)begin
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
            else if(key == 3'b101)begin
                case(cnt4)
                        0   : X <= SO;
                        1   : X <= SO;
                        2   : X <= LA;
                        3   : X <= SO;

                        4   : X <= DO;
                        5   : X <= SI;
                        6   : X <= 1;

                        7   : X <= SO;
                        8   : X <= SO;
                        9   : X <= LA;
                        10  : X <= SO;

                        11  : X <= RE;
                        12  : X <= DO;
                        13  : X <= 1;

                        14  : X <= SO;
                        15  : X <= SO;
                        16  : X <= SO;
                        17  : X <= MI;

                        18  : X <= DO;
                        19  : X <= SI;
                        20  : X <= LA;

                        21  : X <= FA;
                        22  : X <= FA;
                        23  : X <= MI;
                        24  : X <= DO;

                        25  : X <= RE;
                        26  : X <= DO;
                        27  : X <= 1;

                        default :
                              X <= 1;

                    endcase

            end
            else if(key == 3'b011)begin
                case(cnt5)
                        0   : X <= 1;
                        1   : X <= DO;
                        2   : X <= RE;

                        3   : X <= MI;
                        4   : X <= MI;
                        5   : X <= MI;
                        6   : X <= 1;
                        7   : X <= DO;
                        8   : X <= FA;
                        9   : X <= MI;
                        10  : X <= RE;
                        11  : X <= DO;

                        12  : X <= RE;
                        13  : X <= MI;
                        14  : X <= MI;
                        15  : X <= 1;
                        16  : X <= DO;
                        17  : X <= RE;

                        18  : X <= MI;
                        19  : X <= 1;
                        20  : X <= MI;
                        21  : X <= MI;
                        22  : X <= 1;
                        23  : X <= DO;
                        24  : X <= FA;
                        25  : X <= MI;
                        26  : X <= RE;
                        27  : X <= DO;

                        28  : X <= SI;
                        29  : X <= 1;
                        30  : X <= SO;
                        31  : X <= LA;
                        32  : X <= SO;
                        33  : X <= 1;
                        34  : X <= SO;
                        35  : X <= FA;
                        36  : X <= MI;

                        37  : X <= FA;
                        38  : X <= LA;
                        39  : X <= FA;
                        40  : X <= 1;
                        41  : X <= FA;
                        42  : X <= FA;
                        43  : X <= MI;
                        44  : X <= RE;

                        45  : X <= MI;
                        46  : X <= 1;
                        47  : X <= 1;
                        48  : X <= MI;
                        49  : X <= MI;
                        50  : X <= RE;
                        51  : X <= DO;

                        52  : X <= RE;
                        53  : X <= MI;
                        54  : X <= 1;
                        55  : X <= RE;
                        56  : X <= DO;
                        57  : X <= RE;
                        58  : X <= RE;
                        59  : X <= DO;

                        60  : X <= SO;
                        61  : X <= 1;
                        62  : X <= RE;
                        63  : X <= 1;
                        64  : X <= RE;
                        65  : X <= DO;

                        66  : X <= MI;
                        67  : X <= 1;
                        68  : X <= SO;
                        69  : X <= RE;
                        70  : X <= RE;
                        71  : X <= MI;
                        72  : X <= DO;
                        73  : X <= DO;
                        74  : X <= RE;
                        75  : X <= MI;

                        76  : X <= SO;
                        77  : X <= FA;
                        78  : X <= 1;
                        79  : X <= FA;
                        80  : X <= MI;
                        81  : X <= RE;
                        82  : X <= RE;
                        83  : X <= MI;
                        84  : X <= RE;
                        85  : X <= MI;

                        86  : X <= RE;
                        87  : X <= 1;
                        88  : X <= DO;
                        89  : X <= DO;
                        90  : X <= 1;

                        91  : X <= SO;
                        92  : X <= RE;
                        93  : X <= DO;
                        94  : X <= SI;

                        95  : X <= DO;
                        96  : X <= 1;
                        97  : X <= MI;
                        98  : X <= FA;
                        99  : X <= SO;

                        100 : X <= LA;
                        101 : X <= LA;
                        102 : X <= LA;
                        103 : X <= LA;
                        104 : X <= SO;
                        105 : X <= SO;
                        106 : X <= LA;
                        107 : X <= LA;
                        108 : X <= 1;
                        109 : X <= LA;
                        110 : X <= LA;
                        111 : X <= SI;
                        112 : X <= DO;

                        113 : X <= RE;
                        114 : X <= 1;

                        115 : X <= 1;
                        116 : X <= SI;
                        117 : X <= SI;
                        118 : X <= SI;
                        119 : X <= MI;
                        120 : X <= MI;
                        121 : X <= SO;
                        122 : X <= SO;
                        123 : X <= MI;
                        124 : X <= SO;

                        125 : X <= SI;
                        126 : X <= DO;
                        127 : X <= SI;
                        128 : X <= DO;
                        129 : X <= DO;
                        130 : X <= RE;
                        131 : X <= MI;

                        132 : X <= LA;
                        133 : X <= DO;
                        134 : X <= RE;
                        135 : X <= MI;
                        136 : X <= LA;
                        137 : X <= LA;
                        138 : X <= RE;
                        139 : X <= DO;

                        140 : X <= RE;
                        141 : X <= 1;
                        142 : X <= 1;

                        143 : X <= LA;
                        144 : X <= LA;
                        145 : X <= SO;
                        146 : X <= LA;
                        147 : X <= SI;
                        148 : X <= DO;
                        149 : X <= DO;
                        150 : X <= 1;
                        151 : X <= SO;
                        152 : X <= FA;
                        153 : X <= MI;
                        154 : X <= DO;

                        155 : X <= RE;
                        156 : X <= 1;
                        157 : X <= DO;

                        default :
                              X <= 1;
                    endcase

            end
            
        end

    end

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            pwm_ctrl <= 1'b0;
        end
        else if(cnt2 > ((TIME_300MS >> 1) + (TIME_300MS >> 2) + (TIME_300MS >> 3)))begin
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