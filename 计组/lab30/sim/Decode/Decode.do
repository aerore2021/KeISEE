onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Decode_tb/Instruction
add wave -noupdate /Decode_tb/MemtoReg
add wave -noupdate /Decode_tb/RegWrite
add wave -noupdate /Decode_tb/MemWrite
add wave -noupdate /Decode_tb/MemRead
add wave -noupdate /Decode_tb/ALUCode
add wave -noupdate /Decode_tb/ALUSrcA
add wave -noupdate /Decode_tb/ALUSrcB
add wave -noupdate /Decode_tb/Jump
add wave -noupdate /Decode_tb/JALR
add wave -noupdate /Decode_tb/Imm
add wave -noupdate /Decode_tb/offset
add wave -noupdate /glbl/GSR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3849906 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {4096 ns}
