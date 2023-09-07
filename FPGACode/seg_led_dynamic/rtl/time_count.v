module time_count#(parameter TIME_1S = 50_000_000)(

    input               clk,
    input               rst_n,
    output     [16:0]   dout    //时分秒

);


    reg     [25:0]  cnt;
    wire            add_cnt;
    wire            end_cnt;

    reg     [5:0]   cnt_s;
    wire            add_cnt_s;
    wire            end_cnt_s;

    reg     [5:0]   cnt_m;
    wire            add_cnt_m;
    wire            end_cnt_m;

    reg     [4:0]   cnt_h;
    wire            add_cnt_h;
    wire            end_cnt_h;


    //计数器1S
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt <= 26'd0;
        else if(add_cnt)
            if(end_cnt)
                cnt <= 26'd0;
            else
                cnt <= cnt + 1'b1;
        else
            cnt <= cnt;  

    end
    assign add_cnt = 1'b1;
    assign end_cnt = add_cnt && cnt == TIME_1S - 1;

    //秒
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt_s <= 6'd0;
        else if(add_cnt_s)
            if(end_cnt_s)
                cnt_s <= 6'd0;
            else
                cnt_s <= cnt_s + 1'b1;
        else
            cnt_s <= cnt_s;

    end
    assign add_cnt_s = end_cnt;
    assign end_cnt_s = add_cnt_s && cnt_s == 60 - 1;

    //分
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt_m <= 6'd0;
        else if(add_cnt_m)
            if(end_cnt_m)
                cnt_m <= 6'd0;
            else
                cnt_m <= cnt_m + 1'b1;
        else
            cnt_m <= cnt_m;  

    end
    assign add_cnt_m = end_cnt_s;
    assign end_cnt_m = add_cnt_m && cnt_m == 60 - 1;


    //时
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            cnt_h <= 5'd0;
        else if(add_cnt_h)
            if(end_cnt_h)
                cnt_h <= 5'd0;
            else
                cnt_h <= cnt_h + 1'b1;
        else
            cnt_h <= cnt_h;  

    end
    assign add_cnt_h = end_cnt_m;
    assign end_cnt_h = add_cnt_h && cnt_h == 24 - 1;

    assign dout = {cnt_h, cnt_m, cnt_s};
    
    



endmodule