# Iniciando a simulacao
do codec_run_msim_rtl_vhdl.do
vcom -reportprogress 300 -93 -work work ../../codec.vhd 
vsim work.codec

# Adicionando as constantes
add wave -position insertpoint \
sim:/codec/xe \
sim:/codec/valor \
sim:/codec/cntrl/cntrl_reg \
sim:/codec/transmissao/tx_reg

# Adicionando o clock e o reset
add wave -position insertpoint \
sim:/codec/rst \
sim:/codec/pclk


# Adicionando os outros sinais
add wave -position insertpoint \
sim:/codec/fs \
sim:/codec/tx_en \
sim:/codec/tsca \
sim:/codec/dxa \
sim:/codec/i \
sim:/codec/b 

# Gerando a simulacao
force -freeze sim:/codec/pclk 1 0, 0 {244 ns} -r 488 ns
force -freeze sim:/codec/rst 1 0, 0 10
force -freeze sim:/codec/fs 0 0, 1 610 ns, 0 854 ns, 1 130.418 us, 0 130.662 us, 1 133.834 us, 0 134.078 us

#1 bit a cada pulso de clock, 256 bits * 488 ns = 124,928 us 
run 155.000 us