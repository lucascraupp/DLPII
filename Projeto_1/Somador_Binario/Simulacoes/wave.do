onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /som_bin/clk
add wave -noupdate /som_bin/rst
add wave -noupdate -divider Entradas
add wave -noupdate /som_bin/a
add wave -noupdate /som_bin/b
add wave -noupdate -divider Saidas
add wave -noupdate /som_bin/bcd0
add wave -noupdate /som_bin/bcd1
add wave -noupdate /som_bin/bcd2
add wave -noupdate /som_bin/bcd3
add wave -noupdate /som_bin/bcd4
add wave -noupdate -divider Sinal
add wave -noupdate /som_bin/s_aux
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {525 ps}
