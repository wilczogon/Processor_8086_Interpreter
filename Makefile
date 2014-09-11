Components = Instruction.x Message.x Logger.x Stack.x NumericValue.x MemoryAddress.x Registry.x Operand.x Processor_8086.x Debugger.x Memory.x GraphicSystem.x $(FlexComponents)
FlexComponents = InstructionReader.x
CXX = g++
CXXFLAGS = -g
ComponentsFolder = classes/

all: test ready


ready: $(Components:.x=.o) asm_interpreter.o
	$(CXX) $(Components:.x=.o) asm_interpreter.o -o asm_interpreter

test: $(Components:.x=.o) test_asm_interpreter.o
	$(CXX) $(Components:.x=.o) test_asm_interpreter.o -o test_asm_interpreter

$(FlexComponents:.x=.cpp):
	flex -o $(ComponentsFolder)$(@) $(ComponentsFolder)$(@:.cpp=.l)

$(Components:.x=.o) : $(FlexComponents:.x=.cpp)
	$(CXX) -c $(CXXFLAGS) $(ComponentsFolder)$(@:.o=.cpp) -o $@

asm_interpreter.o:
	$(CXX) -c $(CXXFLAGS) asm_interpreter.cpp -o asm_interpreter.o

test_asm_interpreter.o:
	$(CXX) -c $(CXXFLAGS) test_asm_interpreter.cpp -o test_asm_interpreter.o

clean:
	rm -f test/
	cd $(ComponentsFolder)
	rm -f $(Components:.x=.o)
	rm -f $(FlexComponents:.x=.cpp)
	rm -f *~
	cd ..
	rm -f logs
	rm -f asm_interpreter
	rm -f asm_interpreter.o
	rm -f test_asm_interpreter
	rm -f test_asm_interpreter.o
	rm -f *~
