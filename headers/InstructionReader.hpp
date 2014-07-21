#ifndef INSTRUCTION_READER
#define ISTRUCTION_READER
#include "Instruction.hpp"
#include "Logger.hpp"

class InstructionReader{
public:
	Instruction** getListOfInstructions();
	int getNumberOfInstructions();

	InstructionReader(char* fileName, Logger* logger);

private:
	Logger* logger;
};

#endif
