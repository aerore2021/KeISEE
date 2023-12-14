onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /IF_tb/clk
add wave -noupdate /IF_tb/reset
add wave -noupdate /IF_tb/Branch
add wave -noupdate /IF_tb/Jump
add wave -noupdate /IF_tb/IFWrite
add wave -noupdate /IF_tb/JumpAddr
add wave -noupdate /IF_tb/Instruction_if
add wave -noupdate /IF_tb/IF_flush
add wave -noupdate /IF_tb/PC
add wave -noupdate /glbl/GSR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {2415 ns}
