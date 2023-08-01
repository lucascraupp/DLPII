onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Soma1
add wave -noupdate -radix unsigned /ap1/a0
add wave -noupdate -radix unsigned /ap1/b0
add wave -noupdate -radix unsigned /ap1/s0
add wave -noupdate -divider Soma2
add wave -noupdate /ap1/cin1
add wave -noupdate -radix unsigned /ap1/a1
add wave -noupdate -radix unsigned /ap1/b1
add wave -noupdate -radix unsigned /ap1/s1
add wave -noupdate -divider Soma3
add wave -noupdate /ap1/cin2
add wave -noupdate -radix unsigned /ap1/a2
add wave -noupdate -radix unsigned /ap1/b2
add wave -noupdate -radix unsigned /ap1/s2
add wave -noupdate -divider Soma4
add wave -noupdate /ap1/cin3
add wave -noupdate -radix unsigned /ap1/a3
add wave -noupdate -radix unsigned /ap1/b3
add wave -noupdate -radix unsigned /ap1/s3
add wave -noupdate -divider Soma5
add wave -noupdate /ap1/cout4
add wave -noupdate -radix unsigned /ap1/s4
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
WaveRestoreZoom {0 ps} {735 ps}
