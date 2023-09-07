transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/code/FPGACode/beep/rtl {E:/code/FPGACode/beep/rtl/beep.v}

vlog -vlog01compat -work work +incdir+E:/code/FPGACode/beep/prj/../tb {E:/code/FPGACode/beep/prj/../tb/tb_beep.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_beep

add wave *
view structure
view signals
run -all
