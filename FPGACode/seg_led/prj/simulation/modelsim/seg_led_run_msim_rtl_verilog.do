transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led/rtl {E:/code/FPGACode/seg_led/rtl/top.v}
vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led/rtl {E:/code/FPGACode/seg_led/rtl/fsm_key.v}
vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led/rtl {E:/code/FPGACode/seg_led/rtl/seg_led.v}

vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led/prj/../tb {E:/code/FPGACode/seg_led/prj/../tb/tb_top.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_top

add wave *
view structure
view signals
run -all
