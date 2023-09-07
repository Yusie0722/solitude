module beep#(parameter CLK_PRE = 50_000_000, TIME_300MS = 15_000_000)(

    input           clk,
    input           rst_n,
    output   reg    pwm

);

    //频率控制音色  占空比控制音量(占空比越大 低电平越少 音量越小)
    parameter DO = CLK_PRE / 523,      //DO所需的时钟周期
              RE = CLK_PRE / 587,
              MI = CLK_PRE / 659,
              FA = CLK_PRE / 698,
              SO = CLK_PRE / 784,
              LA = CLK_PRE / 880,
              SI = CLK_PRE / 988;

    reg     [16:0]      cnt1;       //计数频率
    wire                add_cnt1;
    wire                end_cnt1;
    reg     [16:0]      X;          //cnt1计数器最大值 就是当前发哪个声音

    reg     [23:0]      cnt2;       //计数时间300MS 每一个音符都发300MS时间
    wire                add_cnt2;
    wire                end_cnt2;

    reg     [5:0]       cnt3;       //乐谱计数器 计数48个
    wire                add_cnt3;
    wire                end_cnt3;

    reg                 pwm_ctr1;   //过滤后面%25 1不发声音

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt1 <= 17'd0;
        end
        else if(end_cnt2)
            cnt1 <= 17'd0;
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
        if(!rst_n)
            cnt2 <= 24'd0;
        else if(add_cnt2)
            if(end_cnt2)
                cnt2 <= 24'd0;
            else
                cnt2 <= cnt2 + 1'b1;
        else
            cnt2 <= cnt2;
    end

    assign add_cnt2 = 1'b1;
    assign end_cnt2 = add_cnt2 && cnt2 == TIME_300MS - 1;
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)
            cnt3 <= 6'd0;
        else if (add_cnt3) begin
            if(end_cnt3)
                cnt3 <= 6'd0;
            else
                cnt3 <= cnt3 + 1'b1;
        end
        else
            cnt3 <= cnt3;
 
    end

    assign add_cnt3 = end_cnt2;
    assign end_cnt3 = add_cnt3 && cnt3 == 48 - 1;

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            X <= 16'd1;
        else
            case(cnt3)
                0            : X <= DO;
                1            : X <= RE;
                2            : X <= MI;
                3            : X <= DO;

                4            : X <= DO;
                5            : X <= RE;
                6            : X <= MI;
                7            : X <= DO;

                8            : X <= MI;
                9            : X <= FA;
                10           : X <= SO;
                11           : X <= 1;

                12           : X <= MI;
                13           : X <= FA;
                14           : X <= SO;
                15           : X <= SO;

                16           : X <= SO;
                17           : X <= LA;
                18           : X <= SO;
                19           : X <= FA;

                20           : X <= MI;
                21           : X <= 1;
                22           : X <= DO;
                23           : X <= 1;

                24           : X <= SO;
                25           : X <= LA;
                26           : X <= SO;
                27           : X <= FA;

                28           : X <= MI;
                29           : X <= 1;
                30           : X <= DO;
                31           : X <= 1;

                32           : X <= RE;
                33           : X <= 1;
                34           : X <= SO;
                35           : X <= 1;

                36           : X <= DO;
                37           : X <= 1;
                38           : X <= 1;
                39           : X <= 1;

                40           : X <= RE;
                41           : X <= 1;
                42           : X <= SO;
                43           : X <= 1;

                44           : X <= DO;
                45           : X <= 1;
                46           : X <= 1;
                47           : X <= 1;

                default      : X <= 1; 
            endcase

    end

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            pwm_ctr1 <= 1'b0;
        else if(cnt2 > ((TIME_300MS >> 1) + (TIME_300MS >> 2) + (TIME_300MS >> 3)))     //50% + 25%
            pwm_ctr1 <= 1'b1;
        else if(X == 1)
            pwm_ctr1 <= 1'b1;
        else
            pwm_ctr1 <= 1'b0;

    end

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            pwm <= 1'b1;        //复位之后不响
        else if(pwm_ctr1)       //pwm_ctr1有效不响
            pwm <= 1'b1;
        else if(cnt1 < (X >> 1))
            pwm <= 1'b0;
        else
            pwm <= 1'b1;

    end


endmodule