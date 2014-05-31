
all: test


ready:
	g++ -I./Processor_8086/ asm_interpreter.cpp Processor_8086/Processor_8086.cpp -o asm_interpreter


test: test_asm_interpreter.o Instruction.o Message.o Logger.o Stack.o
	g++ Instruction.o Message.o Logger.o Stack.o test_asm_interpreter.o -o test_asm_interpreter

test_asm_interpreter.o:
	g++ -c test_asm_interpreter.cpp -o test_asm_interpreter.o

Instruction.o:
	g++ -c classes/Instruction.cpp -o Instruction.o
	
Message.o:
	g++ -c classes/Message.cpp -o Message.o
	
Logger.o:
	g++ -c classes/Logger.cpp -o Logger.o
	
Stack.o:
	g++ -c classes/Stack.cpp -o Stack.o
	
clean:
	rm test/* & rm Instruction.o & rm test_asm_interpreter.o & rm Message.o & rm Logger.o & rm Stack.o
