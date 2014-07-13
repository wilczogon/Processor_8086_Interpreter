#ifndef INSTRUCTION
#define INSTRUCTION
#include "Operand.hpp"

class Instruction{
public:
	char* getName();
	int getNumberOfArguments();
	Operand* getArgument(int no);
	int getAddress();
	Instruction(char* name, int address, int numberOfArgs, Operand** args);
	~Instruction();

private:
	char* name;
	int argsNo;
	Operand** args;
	int address;
};

#endif
