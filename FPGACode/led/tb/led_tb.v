`timescale 1ns/1ns
module led_tb ();

reg         tb_clk  ;     //输入信号定义为reg     initial描述
reg         tb_rst_n;
wire [3:0]  tb_LED  ;    //输出定义为wire   相当于就是一个硬件连线



//模块例化

    //#固定用法
    led#(.TIME_1S(5000), .TIME_500MS(2500))     inst_led(       //跨模块传递参数

            .clk   (tb_clk  )     ,
            .rst_n (tb_rst_n)     ,
            .LED   (tb_LED  )

    );

    parameter CYCLE = 20;   //时钟周期
    always  #(CYCLE / 2) tb_clk = ~tb_clk;  //每10ns翻转一次时钟信号
        
    initial begin

        tb_clk = 1'b0;      //初始值
        tb_rst_n = 1'b0;    //开始复位
        #(CYCLE * 3);       //延迟
        tb_rst_n = 1'b1;    //停止复位
        #(CYCLE * 2500 * 10);//2500个时钟周期 LED移位一次
        $stop;

    end


endmodule