# Dinh nghia cac thu muc
RTL_DIR = rtl
TB_DIR  = tb
SIM_DIR = sim

# Dinh nghia trinh bien dich va co
CC = iverilog
FLAGS = -g2012
SIMULATOR = vvp
WAVE = gtkwave

# Danh sach file
ALU_SRC = $(RTL_DIR)/riscv_pkg.sv \
          $(RTL_DIR)/alu.sv \
          $(TB_DIR)/alu_tb.sv

# Ten file chay
ALU_OUT = $(SIM_DIR)/alu_test

# Cac lenh
all: build run

# Bien dich
build:
	mkdir -p $(SIM_DIR)
	$(CC) $(FLAGS) -o $(ALU_OUT) $(ALU_SRC)

# Chay mo phong
run:
	$(SIMULATOR) $(ALU_OUT)

# Xem song
wave:
	$(WAVE) $(SIM_DIR)/alu_wave.vcd &

# Don dep rac
clean:
	rm -rf $(SIM_DIR)
