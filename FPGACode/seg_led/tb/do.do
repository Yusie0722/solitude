vlib work
vmap work work
                                           
#编译testbench文件                          
vlog    tb_top.v
#编译     设计文件                             
vlog ../rtl/seg_led.v
vlog ../rtl/fsm_key.v
vlog ../rtl/top.v
                                            
#指定仿真顶层                                  
vsim -novopt work.tb_top
#添加信号到波形窗                             
add wave -position insertpoint sim:/tb_top//*
