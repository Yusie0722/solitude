module led#(parameter TIME_1S = 50_000_000, TIME_500MS = 25_000_000)(

    input       clk           ,
    input       rst_n         ,
    output  reg [3:0]   LED

);
    //组合逻辑
    //assign LED = 4'b1111;

    //时序逻辑
    // always @(posedge clk or negedge rst_n)begin
    //     if(!rst_n)
    //         LED <= 4'b0000;
    //     else
    //         LED <= 4'b1111;
    // end


    //计数1S LED翻转
    // parameter TIME_1S = 50_000_000;
    // reg [25:0] cnt;
    // wire    add_cnt;
    // wire    end_cnt;
    // always @(posedge clk or negedge rst_n)begin
        
    //     if(!rst_n)
    //         cnt <= 26'd0;
    //     else if(add_cnt)begin
    //         if(end_cnt)
    //             cnt <= 26'd0;
    //         else
    //             cnt <= cnt + 1'b1;
    //     end
    //     else   
    //         cnt <= 26'd0;

    // end
    // assign add_cnt = 1'b1;
    // assign end_cnt = add_cnt && cnt == TIME_1S - 1;
    
    // always @(posedge clk or negedge rst_n)begin
    //     if(!rst_n)
    //         LED <= 4'b0000;
    //     else if(end_cnt)
    //         LED <= ~LED;
    //     else
    //         LED <= LED;
    // end





    //计数0.5S  流水灯
    //parameter TIME_500MS = 25_000_000;
    reg [24:0]  cnt;
    wire    add_cnt;
    wire    end_cnt;
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt <= 25'd0;
        else if(add_cnt)begin
            if(end_cnt)
                cnt <= 25'd0;
            else
                cnt <= cnt + 1'b1;
        end
        else
            cnt <= 25'd0;

    end
    assign add_cnt = 1'b1;
    assign end_cnt = add_cnt && cnt ==TIME_500MS -1;

    always @(posedge clk or negedge rst_n)begin

        if(!rst_n)
            LED <= 4'b0001;
        else if(end_cnt)
            LED <= {LED[2:0] , LED[3]};
        else
            LED <= LED;

    end





    //计数0.2S 流水灯
    // parameter TIME_200MS = 10_000_000;
    // reg [23:0]  cnt;
    // reg [1:0]   loca;
    // wire add_cnt;
    // wire end_cnt;

    // always @(posedge clk or negedge rst_n)begin

    //     if(!rst_n)
    //         cnt <= 24'd0;
    //     else if(add_cnt)
    //         if(end_cnt)
    //             cnt <= 24'd0;
    //         else
    //             cnt <= cnt + 1'b1;
    //     else
    //         cnt <= 24'd0;

    // end

    // assign add_cnt = 1'b1;
    // assign end_cnt = add_cnt && cnt == TIME_200MS - 1;

    // always @(posedge clk or negedge rst_n)begin

    //     if(!rst_n)begin
    //         LED <= 4'b0000;
    //         loca <= 2'b00;
    //     end
    //     else if(end_cnt)
    //         if(loca == 2'b11)
    //             loca <= 2'b00;
    //         else
    //             loca <= loca + 1'b1;
    //     else
    //         loca <= loca;
        
    //     case(loca)

    //         2'b00 : LED = 4'b0001;
    //         2'b01 : LED = 4'b0010;
    //         2'b10 : LED = 4'b0100;
    //         2'b11 : LED = 4'b1000;
    //         default : LED = 4'b0000;

    //     endcase

    // end




    // //跑马灯
    // //parameter TIME_500MS = 25_000_000;
    // reg [24:0]  cnt;
    // wire    add_cnt;
    // wire    end_cnt;

    // always @(posedge clk or negedge rst_n)begin
        
    //     if(!rst_n)
    //         cnt <= 25'd0;
    //     else if(add_cnt)
    //         if(end_cnt)
    //             cnt <= 25'd0;
    //         else
    //             cnt = cnt + 1'b1;
    //     else
    //         cnt <= 25'd0;

    // end

    // assign add_cnt = 1'b1;
    // assign end_cnt = add_cnt && cnt == TIME_500MS - 1;

    // always @(posedge clk or negedge rst_n)begin
        
    //     if(!rst_n)
    //         LED <= 4'b0000;
    //     else if(end_cnt)
    //         LED <= {LED[2:0],~(LED[3])};
    //     else
    //         LED <= LED;

    // end






endmodule