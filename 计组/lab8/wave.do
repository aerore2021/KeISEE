onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /adder_32bits_tb/a
add wave -noupdate /adder_32bits_tb/b
add wave -noupdate /adder_32bits_tb/ci
add wave -noupdate /adder_32bits_tb/s
add wave -noupdate /adder_32bits_tb/co
add wave -noupdate /glbl/GSR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {104723 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {155648 ps}
