vlib work
vmap work work
                                           
#编译testbench文件                          
vlog    top_tb.v
#编译     设计文件                             
vlog ../rtl/seg_led_dynamic.v
vlog ../rtl/time_count.v
vlog ../rtl/top.v
                                            
#指定仿真顶层                                  
vsim -novopt work.top_tb
#添加信号到波形窗                             
add wave -position insertpoint sim:/top_tb//*
