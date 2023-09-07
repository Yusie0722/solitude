transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led_dynamic/rtl {E:/code/FPGACode/seg_led_dynamic/rtl/top.v}
vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led_dynamic/rtl {E:/code/FPGACode/seg_led_dynamic/rtl/time_count.v}
vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led_dynamic/rtl {E:/code/FPGACode/seg_led_dynamic/rtl/seg_led_dynamic.v}

vlog -vlog01compat -work work +incdir+E:/code/FPGACode/seg_led_dynamic/prj/../tb {E:/code/FPGACode/seg_led_dynamic/prj/../tb/top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_tb

add wave *
view structure
view signals
run -all
