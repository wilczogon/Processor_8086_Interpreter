#ifndef INSTRUCTION_READER
#define ISTRUCTION_READER
#include "Instruction.hpp"
#include "Logger.hpp"
#include <list>

using namespace std;

class InstructionReader{
public:
	Instruction** getListOfInstructions();
	int getNumberOfInstructions();
	void readInstructions();

	InstructionReader(char* fileName, Logger* logger);

private:
	Logger* logger;
	list<Instruction>* instructionList;
};

#endif
