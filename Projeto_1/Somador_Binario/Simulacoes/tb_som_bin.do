do som_bin_run_msim_rtl_vhdl.do
vcom -reportprogress 300 -93 -work work ../../som_bin.vhd 
vsim work.som_bin
do wave.do

force -freeze sim:/som_bin/clk 1 0, 0 {10 ps} -r 20
force -freeze sim:/som_bin/rst 1 0, 0 5

force -freeze sim:/som_bin/a 00000000000000 0, 00010001010111 100, 10011100010000 200, 00010001010111 300, 10011100010000 400
force -freeze sim:/som_bin/b 00000000000000 0, 00010001010111 100, 10011100010000 300

run 500