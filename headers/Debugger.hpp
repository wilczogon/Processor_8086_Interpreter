#ifndef DEBUGGER
#define DEBUGGER
#include "Instruction.hpp"
#include "Processor_8086.hpp"
#include "Logger.hpp"

class Debugger{
public:
	void step();
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
	Instruction** instructions;
	Processor_8086* processor;
	Logger* logger;
};

#endif
