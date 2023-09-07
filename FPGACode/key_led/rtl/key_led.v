module key_led#(parameter TIME_500MS = 25_000_000) (

    input                   clk,
    input                   rst_n,
    input          [2:0]    key,
    output  reg    [3:0]    led

);

    //计数器
    reg    [24:0]   cnt;
    wire            add_cnt;
    wire            end_cnt;
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt <= 0;
        end 
        else if(add_cnt)begin 
            if(end_cnt)begin 
                cnt <= 0;
            end
            else begin 
                cnt <= cnt + 1;
            end 
        end
    end 
    assign add_cnt = 1'b1;
    assign end_cnt = add_cnt && cnt ==  TIME_500MS - 1;







    //
    always @(posedge clk or negedge rst_n)begin
        
        if(!rst_n)
            led <= 4'b0001;
        else
            case(key)

                3'b111 : led <= 4'b0001;
                3'b110 :
                    if(end_cnt)
                        led <= {led[2:0],led[3]};
                    else
                        led <= led;
                3'b101 :
                    if(end_cnt)
                        led <= {led[0],led[3:1]};
                    else
                        led <= led;
                3'b011 :
                    if(end_cnt)
                        led <= ~led;
                    else
                        led <= led;
                default :
                    led <= 4'b0000;

            endcase

    end

endmodule