
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
sim:/top_timer_de2_115/t0/LFSR_reg \
sim:/top_timer_de2_115/t0/mT_reg \
sim:/top_timer_de2_115/t0/mU_reg \
sim:/top_timer_de2_115/t0/sT_reg \
sim:/top_timer_de2_115/t0/sU_reg \
sim:/top_timer_de2_115/t0/msC_reg \
sim:/top_timer_de2_115/t0/msT_reg \
sim:/top_timer_de2_115/t0/msU_reg 

# Criando clock e forçando reset
force -freeze sim:/top_timer_de2_115/clk_500khz 1 0, 0 {10000 ps} -r 20ns
force -freeze sim:/top_timer_de2_115/KEY 0 0 
run 40ns
force -freeze sim:/top_timer_de2_115/KEY 1 0 
run 40ns


# Forcando alguns valores de borda para verificar o funcionamento
# Verificando o incremento dos msissegundos
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/msU_reg 10#9 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/msU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msT_reg 10#9 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns

# Verificando o incremento dos segundos
force -freeze sim:/top_timer_de2_115/t0/msU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msT_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msC_reg 10#9 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/msU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msT_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msC_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/sU_reg 10#9 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns

# Verificando o incremento dos minutos
force -freeze sim:/top_timer_de2_115/t0/msU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msT_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msC_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/sU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/sT_reg 10#5 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/msU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msT_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msC_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/sU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/sT_reg 10#5 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/mU_reg 10#9 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns

# Zerando tudo
force -freeze sim:/top_timer_de2_115/t0/msU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msT_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/msC_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/sU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/sT_reg 10#5 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/mU_reg 10#9 0 -cancel 20ns
force -freeze sim:/top_timer_de2_115/t0/mT_reg 10#5 0 -cancel 20ns
run 100ns
force -freeze sim:/top_timer_de2_115/t0/LFSR_reg 10#140 0 -cancel 20ns
run 100ns