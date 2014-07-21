Components = Instruction.x Message.x Logger.x Stack.x NumericValue.x MemoryAddress.x Registry.x Operand.x Processor_8086.x Debugger.x Memory.x InstructionReader.x
CXX = g++
CXXFLAGS = 
ComponentsFolder = classes/

all: test


ready:
	$(CXX) -I./Processor_8086/ asm_interpreter.cpp Processor_8086/Processor_8086.cpp -o asm_interpreter

test: $(Components:.x=.o) test_asm_interpreter.o
	$(CXX) $(Components:.x=.o) test_asm_interpreter.o -o test_asm_interpreter

$(Components:.x=.o) :
	$(CXX) -c $(CXXFLAGS) $(ComponentsFolder)$(@:.o=.cpp) -o $@

test_asm_interpreter.o:
	$(CXX) -c $(CXXFLAGS) test_asm_interpreter.cpp -o test_asm_interpreter.o

clean:
	rm -f test/
	rm *.o