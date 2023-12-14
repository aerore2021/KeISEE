onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Risc5CPU_tb_v/clk
add wave -noupdate /Risc5CPU_tb_v/reset
add wave -noupdate /Risc5CPU_tb_v/JumpFlag
add wave -noupdate /Risc5CPU_tb_v/Instruction_id
add wave -noupdate /Risc5CPU_tb_v/ALU_A
add wave -noupdate /Risc5CPU_tb_v/ALU_B
add wave -noupdate /Risc5CPU_tb_v/ALUResult_ex
add wave -noupdate /Risc5CPU_tb_v/PC
add wave -noupdate /Risc5CPU_tb_v/MemDout_mem
add wave -noupdate /Risc5CPU_tb_v/Stall
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {446206 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2363550 ps}
