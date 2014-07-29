#ifndef DEBUGGER
#define DEBUGGER
#include "Instruction.hpp"
#include "Processor_8086.hpp"
#include "Logger.hpp"
#include "InstructionReader.hpp"
#include "Memory.hpp"

class Debugger{
public:
	bool step();
	void run();
	void start();
	//void break...
	//void continue();
	void setInstructionTime(int milis);
	void showInstructionTime();
	//void showMemoryView();
	//void showErrorView();
	Debugger(char* fileName);
	Debugger(char* fileName, bool isVisualized);
	~Debugger();

private:
	Instruction* getInstruction(int address);
	int instructionTime;
	Instruction** instructions;
	Processor_8086* processor;
	Logger* logger;
};

#endif
