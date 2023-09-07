module fsm_key#(parameter TIME_20MS = 1000_000, W = 3)(

    input               clk,
    input               rst_n,
    input       [W-1:0] key_in,
    output reg  [W-1:0] key_out

);

    //描述上升沿 下降沿
    reg     [W-1:0] key_r0;
    reg     [W-1:0] key_r1;
    wire    [W-1:0] posEdge;
    wire    [W-1:0] negEdge;
    
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)begin
            key_r0 <= {W{1'b1}};
        end
        else begin
            key_r0 <= key_in;
            key_r1 <= key_r0;
        end

    end

    assign negEdge = ~key_r0 & key_r1;
    assign posEdge = key_r0  & ~key_r1;


    //状态参数定义
    parameter   IDLE = 4'b0001,
                DOWN = 4'b0010,
                HOLD = 4'b0100,
                UP   = 4'b1000;

    //状态寄存器
    reg [3:0] state_c;
    reg [3:0] state_n;

    //状态转移条件
    wire idle2down;
    wire down2hold;
    wire down2idle;
    wire hold2up;
    wire up2idle;

    //计数器
    reg [19:0] cnt;
    wire add_cnt;
    wire end_cnt;

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt <= 20'd0;
        else if(add_cnt)
            if(end_cnt)
                cnt <= 20'd0;
            else
                cnt <= cnt + 1'b1;
        else
            cnt <= 20'd0;

    end

    assign add_cnt = state_c == DOWN || state_c == UP;
    assign end_cnt = add_cnt && cnt == TIME_20MS - 1;

    //第一段 时序逻辑 描述状态转移
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            state_c <= IDLE;
        else
            state_c <= state_n;

    end

    //第二段 组合逻辑 判断状态转移条件 描述状态转移的规律
    always @(*)begin
        
        case(state_c)

            IDLE    :   if(idle2down)
                            state_n = DOWN;
                        else
                            state_n = state_c;
            DOWN    :   if(down2hold)
                            state_n = HOLD;
                        else if(down2idle)
                            state_n = IDLE;
                        else
                            state_n = state_c;
            HOLD    :   if(hold2up)
                            state_n = UP;
                        else
                            state_n = state_c;
            UP      :   if(up2idle)
                            state_n = IDLE;
                        else
                            state_n = state_c;
            default :   state_n = state_c;

        endcase

    end
    
    assign idle2down = state_c == IDLE && negEdge != 1'b0;
    assign down2hold = state_c == DOWN && end_cnt && posEdge == 1'b0;
    assign down2idle = state_c == DOWN && posEdge != 1'b0;
    assign hold2up   = state_c == HOLD && posEdge != 1'b0;
    assign up2idle   = state_c == UP   && end_cnt;

    //第三段 描述输出
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            key_out <= {W{1'b1}};
        else if(state_c == HOLD)
            key_out <= key_r1;
        else
            key_out <= {W{1'b1}};

    end

endmodule