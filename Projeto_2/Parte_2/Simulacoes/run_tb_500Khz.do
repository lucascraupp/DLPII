
# Iniciando a simulacao
vsim work.top_timer_de2_115

# Adicionando os sinais de clock e reset
add wave -position insertpoint  \
sim:/top_timer_de2_115/clk_500khz \
sim:/top_timer_de2_115/KEY 

# Adicionando os sinais com "radix" unsigned
add wave -position insertpoint -radix unsigned \
sim:/top_timer_de2_115/minT \
sim:/top_timer_de2_115/minU \
sim:/top_timer_de2_115/secT \
sim:/top_timer_de2_115/secU \
sim:/top_timer_de2_115/msC \
sim:/top_timer_de2_115/msT \
sim:/top_timer_de2_115/msU \
sim:/top_timer_de2_115/t0/r_reg \
sim:/top_timer_de2_115/t0/ms_reg \
sim:/top_timer_de2_115/t0/s_reg \
sim:/top_timer_de2_115/t0/m_reg 

# Criando clock e forçando reset
force -freeze sim:/top_timer_de2_115/clk_500khz 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/top_timer_de2_115/KEY 0 0 
run 40ns
force -freeze sim:/top_timer_de2_115/KEY 1 0 
run 40ns


# Forcando alguns valores de borda para verificar o funcionamento
# Verificando o incremento dos msissegundos
force -freeze sim:/top_timer_de2_115/t0/r_reg 10#499 0 -cancel 20ns
run 600ns
force -freeze sim:/top_timer_de2_115/t0/r_reg 10#499 0 -cancel 20ns
run 600ns

# Verificando o incremento dos segundos
force -freeze sim:/top_timer_de2_115/t0/ms_reg 10#999 0 -cancel 20ns
run 600ns
force -freeze sim:/top_timer_de2_115/t0/r_reg 10#499 0 -cancel 20ns
run 600ns
force -freeze sim:/top_timer_de2_115/t0/ms_reg 10#999 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/r_reg 10#499 0 -cancel 20ns
run 600ns

# Verificando o incremento dos minutos
force -freeze sim:/top_timer_de2_115/t0/s_reg 10#59 0 -cancel 20ns
run 600ns
force -freeze sim:/top_timer_de2_115/t0/r_reg 10#499 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/ms_reg 10#999 0 -cancel 20ns
run 600ns
force -freeze sim:/top_timer_de2_115/t0/r_reg 10#499 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/ms_reg 10#999 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/s_reg 10#59 0 -cancel 20ns
run 600ns

# Zerando tudo
force -freeze sim:/top_timer_de2_115/t0/m_reg 10#59 0 -cancel 20ns
run 600ns
force -freeze sim:/top_timer_de2_115/t0/r_reg 10#499 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/ms_reg 10#999 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/s_reg 10#59 0 -cancel 20ns
run 600ns
