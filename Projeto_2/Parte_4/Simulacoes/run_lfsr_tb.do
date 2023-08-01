vcom -reportprogress 300 -93 -work work ../../top_timer_de2_115.vhd 
vcom -93 -work work {../../bcd2ssd.vhd}
vcom -reportprogress 300 -93 -work work ../../bcd2ssd.vhd 
vcom -93 -work work {../../list_09_05_06_timer_CORRIGIDO_50mhz.vhd}
vcom -reportprogress 300 -93 -work work ../../list_09_05_06_timer_CORRIGIDO_50mhz.vhd 
vcom -93 -work work {../../PLL_500KHz.vhd}
vcom -reportprogress 300 -93 -work work ../../PLL_500KHz.vhd 

# Iniciando a simulacao
vsim work.timer

# Adicionando os sinais de clock e reset
add wave -position insertpoint  \
sim:/timer/clk \
sim:/timer/reset

# Adicionando os sinais com "radix" unsigned
add wave -position insertpoint -radix unsigned \
sim:/timer/msU \
sim:/timer/fb \
sim:/timer/r_reg \
sim:/timer/LFSR_reg

# Force reset e criando o clock
force -freeze sim:/timer/clk 1 0, 0 {50 ps} -r 100ps
force -freeze sim:/timer/reset 1 0
run 5ns
force -freeze sim:/timer/reset 0 0
run 5ns

# 100ps * 500 = 50ns
run 51ns