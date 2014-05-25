
all:
	gcc -I./processor_8086/ asm_interpreter.cpp processor_8086/processor_8086.cpp -o asm_interpreter
