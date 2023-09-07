module fsm_led#(parameter TIME_2S = 100_000_000) (

    input               clk     ,
    input               rst_n   ,
    output  reg [3:0]   led

);

    //状态定义
    parameter IDLE = 4'd1,      //独热码编码方式
              D1   = 4'd2,
              D2   = 4'd3,
              D3   = 4'd4,
              D4   = 4'd5,
              D5   = 4'd6,
              D6   = 4'd7,
              D7   = 4'd8;

    //状态跳转条件定义
    wire            idle2d1 ;        //2 -> to idle状态跳转到d1状态
    wire            d12d2   ;
    wire            d22d3   ;
    wire            d32d4   ;
    wire            d42d5   ;
    wire            d52d6   ;
    wire            d62d7   ;
    wire            d72idle ;

    //状态寄存器定义
    reg     [4:0]   state_c;
    reg     [4:0]   state_n;

    //计数器2S
    reg [26:0] cnt;
    wire add_cnt;
    wire end_cnt;

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt <= 26'd0;
        else if(add_cnt)
            if(end_cnt)
                cnt <= 26'd0;
            else
                cnt <= cnt + 1'b1;
        else
            cnt <= 26'd0;

    end

    assign add_cnt = 1'b1;
    assign end_cnt = add_cnt && cnt == TIME_2S - 1;

    //第一段    描述状态转移 时序逻辑
    always @(posedge clk or negedge rst_n)begin

        if(!rst_n)
            state_c <= IDLE;        //一个健全的 一定要有一个初始值
        else
            state_c <= state_n;     //次态和现态之间只相差一个时钟周期

    end

    //第二段    判断状态转移条件 组合逻辑
    always @(*)begin
        
        case(state_c)   //现态  根据现在处于哪一个状态来发生变化

            IDLE    :   if(idle2d1)
                            state_n = D1;
                        else
                            state_n = state_c;
            D1      :   if(d12d2)
                            state_n = D2;
                        else
                            state_n = state_c;
            D2      :   if(d22d3)
                            state_n = D3;
                        else
                            state_n = state_c;
            D3      :   if(d32d4)
                            state_n = D4;
                        else
                            state_n = state_c;
            D4      :   if(d42d5)
                            state_n = D5;
                        else
                            state_n = state_c;
            D5      :   if(d52d6)
                            state_n = D6;
                        else
                            state_n = state_c;
            D6      :   if(d62d7)
                            state_n = D7;
                        else
                            state_n = state_c;
            D7      :   if(d72idle)
                            state_n = IDLE;
                        else
                            state_n = state_c;
            default :   state_n = state_c;

        endcase

    end

    assign idle2d1 = state_c == IDLE    &&  end_cnt;    //当处于IDLE状态下并且2S计数完成
    assign d12d2   = state_c == D1      &&  end_cnt;
    assign d22d3   = state_c == D2      &&  end_cnt;
    assign d32d4   = state_c == D3      &&  end_cnt;
    assign d42d5   = state_c == D4      &&  end_cnt;
    assign d52d6   = state_c == D5      &&  end_cnt;
    assign d62d7   = state_c == D6      &&  end_cnt;
    assign d72idle = state_c == D7      &&  end_cnt;

    //第三段    描述输出    时序逻辑 或 组合逻辑
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)

            led <= 4'b1111;

        else
            //流水灯
            // case(state_c)

            //     IDLE    :   led <= 4'b0000;
            //     D1      :   led <= 4'b0001;
            //     D2      :   led <= 4'b0010;
            //     D3      :   led <= 4'b0100;  
            //     D4      :   led <= 4'b1000;
            //     default :   led <= 4'b1111;

            // endcase

            //跑马灯
            case(state_c)

                IDLE    :   led <= 4'b0000;
                D1      :   led <= 4'b0001;
                D2      :   led <= 4'b0011;
                D3      :   led <= 4'b0111;
                D4      :   led <= 4'b1111;
                D5      :   led <= 4'b1110;
                D6      :   led <= 4'b1100;
                D7      :   led <= 4'b1000;
                default :   led <= 4'b1111;

            endcase

    end

endmodule