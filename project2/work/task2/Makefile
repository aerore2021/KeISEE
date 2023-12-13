CC = /opt/riscv/bin/riscv64-unknown-elf-gcc

build_origin_c:
	$(CC) sm3.c  -mabi=ilp32 -march=rv32imc -static -g -o sm3

build_origin_s:
	$(CC) sm3.s  -mabi=ilp32 -march=rv32imc -static -g -o sm3

build_opt:
	$(CC) sm3opt.s  -mabi=ilp32 -march=rv32imc -static -g -o sm3