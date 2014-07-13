
all: test


ready:
	g++ -I./Processor_8086/ asm_interpreter.cpp Processor_8086/Processor_8086.cpp -o asm_interpreter


test: test_asm_interpreter.o Instruction.o Message.o Logger.o Stack.o NumericValue.o MemoryAddress.o Operand.o Processor_8086.o
	g++ Instruction.o Message.o Logger.o Stack.o Operand.o NumericValue.o MemoryAddress.o Processor_8086.o test_asm_interpreter.o -o test_asm_interpreter

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
	
Operand.o:
	g++ -c classes/Operand.cpp -o Operand.o
	
NumericValue.o:
	g++ -c classes/NumericValue.cpp -o NumericValue.o
	
MemoryAddress.o:
	g++ -c classes/MemoryAddress.cpp -o MemoryAddress.o
	
Processor_8086.o:
	g++ -c classes/Processor_8086.cpp -o Processor_8086.o
	
clean:
	rm test/* & rm Instruction.o & rm test_asm_interpreter.o & rm Message.o & rm Logger.o & rm Stack.o & rm Operand.o & rm NumericValue.o & rm MemoryAddress.o & rm Processor_8086.o
