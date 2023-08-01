do AP1_run_msim_rtl_vhdl.do
vcom -reportprogress 300 -93 -work work ../../AP1.vhd 
vsim work.ap1
do wave.do

force -freeze sim:/ap1/a0 0000 0, 0001 100, 1001 200

force -freeze sim:/ap1/a1 0000 0, 0001 300, 1001 400

force -freeze sim:/ap1/a2 0000 0, 1001 500

force -freeze sim:/ap1/a3 0000 0, 1001 600


force -freeze sim:/ap1/b0 0000 0, 0001 100, 1001 200

force -freeze sim:/ap1/b1 0000 0, 0001 300, 1001 400

force -freeze sim:/ap1/b2 0000 0, 1001 500

force -freeze sim:/ap1/b3 0000 0, 1001 600

run 700