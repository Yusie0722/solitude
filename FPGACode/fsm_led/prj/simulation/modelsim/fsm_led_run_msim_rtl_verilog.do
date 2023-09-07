transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/FPGA_project/fsm_led/rtl {E:/FPGA_project/fsm_led/rtl/fsm_led.v}

vlog -vlog01compat -work work +incdir+E:/FPGA_project/fsm_led/prj/../tb {E:/FPGA_project/fsm_led/prj/../tb/fsm_led_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  fsm_led_tb

add wave *
view structure
view signals
run -all
