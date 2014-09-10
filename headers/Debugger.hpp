#ifndef DEBUGGER
#define DEBUGGER
#include "Instruction.hpp"
#include "Processor_8086.hpp"
#include "Logger.hpp"
#include "InstructionReader.hpp"
#include "Memory.hpp"
#include "GraphicSystem.hpp"

class Debugger{
public:
	bool step();
	void run();
	void start(string);
	//void break...
	//void continue();
	void setInstructionTime(int milis);
	void showInstructionTime();
	void paintStandardView();
	//void showMemoryView();
	//void showErrorView();
	int getAdressByLabel(string label);
	Debugger(char* fileName);
	Debugger(char* fileName, bool isVisualized);
	~Debugger();

private:
	Instruction* getInstruction(int address);
	int instructionTime;
	Instruction** instructions;
	Processor_8086* processor;
	Logger* logger;
	GraphicSystem* gui;
	int instructionNo;
	map<string,int>* labelMap;
};

#endif
