
all: test


ready:
	g++ -I./Processor_8086/ asm_interpreter.cpp Processor_8086/Processor_8086.cpp -o asm_interpreter


test: test_asm_interpreter.o Instruction.o
	g++ Instruction.o test_asm_interpreter.o -o test_asm_interpreter

test_asm_interpreter.o:
	g++ -c test_asm_interpreter.cpp -o test_asm_interpreter.o

Instruction.o:
	g++ -c Instruction/Instruction.cpp -o Instruction.o
	
	
clean:
	rm Instruction.o & rm test_asm_interpreter.o
