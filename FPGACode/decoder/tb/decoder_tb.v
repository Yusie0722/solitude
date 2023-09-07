`timescale 1ns/1ns  //定义仿真尺度
module decoder_tb();//tb文件没有输入输出

//作用：模拟源文件输入信号  看输出是否预期相符合

    reg     [2:0]   tb_a;//设计输入  定义为reg
    wire    [7:0]   tb_b;

    //例化模块      连接起来
    decoder     inst_decoder(
        .a      (tb_a),     //.前面模块 ()当前模块
        .b      (tb_b)
    );

    initial begin   //产生激励  设计输入信号
        
        tb_a = 3'b000;
        #50;    //#代表延时  50ns
        tb_a = 3'b001;
        #50;
        tb_a = 3'b010;
        #50;
        tb_a = 3'b011;
        #50;
        tb_a = 3'b100;
        #50;
        tb_a = 3'b101;
        #50;
        tb_a = 3'b110;
        #50;
        tb_a = 3'b111;
        #50;
        tb_a = 3'bxxx;
        #50;
        $stop;

    end

endmodule