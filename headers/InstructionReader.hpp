#ifndef INSTRUCTION_READER
#define INSTRUCTION_READER
#include "Instruction.hpp"
#include "Registry.hpp"
#include "NumericValue.hpp"
#include "MemoryAddress.hpp"
#include "Logger.hpp"
#include <list>
#include <map>
#include <string>

using namespace std;

class InstructionReader{
public:
	Instruction** getListOfInstructions();
	int getNumberOfInstructions();
	void readInstructions();
	void addLabel(char* label);
	void addInstruction(Instruction* instruction);

	InstructionReader(char* fileName, Logger* logger);

private:
	Logger* logger;
	list<Instruction>* instructionList;
	list<string>* labelList;
	list<int>* labelAddressList;
};

#endif
