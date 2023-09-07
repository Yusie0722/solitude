module test (
    input       clk     ,
    input       rst_n       //reset复位 _n低电平有效
    
);

//计数器 晶振 50Mhz 一个系统时钟周期20ns
//一定要在时序逻辑电路里面

    //计数1s    50_000_000个时钟周期
    parameter TIME_1S = 50_000_000;
    reg     [25:0]  cnt;//计数器    计数50_000_000     位宽26个

    //时序逻辑电路
    always @(posedge clk or negedge rst_n)begin
        if(rst_n == 1'b0)begin

            cnt <= 26'd0;               //cnt初值

        end
        else if(cnt == TIME_1S - 1)begin

            cnt <= 26'd0;                //cnt归0

        end
        else begin
            
            cnt <= cnt + 1'b1;           //+1

        end

    end


    //计数0.2s
    parameter TIME_200MS = 10_000_000;
    reg [23:0] cnt1;
    always @(posedge clk or negedge rst_n)begin
    
        if(rst_n == 1'b0)
            cnt1 <= 24'd0;
        else if(cnt1 == TIME_200MS)
            cnt1 <= 24'd0;
        else
            cnt1 <= cnt + 1'b1;

    end


    //计数2s
    parameter TIME_2S = 100_000_000;
    reg     [26:0]      cnt2;
    wire                add_cnt2;
    wire                end_cnt2;

    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)begin
            cnt2 <= 27'b0;
        end
        else if(add_cnt2)begin          //启用计数器
            if(end_cnt2)                //计数器计数到了最大值
                cnt2 <= 27'b0;
            else
                cnt2 = cnt2 + 1'b1;     //+1
        end
        else begin
            cnt2 <= 27'b0;
        end

    end

    assign add_cnt2 = 1'b1;             //什么时候启用计数器 一直为1 就是一直启用
    assign end_cnt2 = add_cnt2 && cnt2 == TIME_2S - 1;      //计数器启用的时候 才会有最大值

    
endmodule
