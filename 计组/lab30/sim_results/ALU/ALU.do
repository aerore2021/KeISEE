onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ALU_tb/ALUCode
add wave -noupdate /ALU_tb/A
add wave -noupdate /ALU_tb/B
add wave -noupdate /ALU_tb/ALUResult
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
configure wave -timelineunits ns
update
WaveRestoreZoom {1195179 ps} {1200254 ps}
