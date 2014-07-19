#include <stdio.h>
#include <stdlib.h>
#include "../headers/Debugger.hpp"
#include "../headers/InstructionReader.hpp"
#include "../headers/Memory.hpp"

//void Debbuger::step();
//void Debugger::run();
//void Debugger::start();

//void break...
//void continue();

//void Debugger::setInstructionTime(int milis);
//void Debugger::showInstructionTime();

//void showMemoryView();
//void showErrorView();

Debugger::Debugger(char* fileName){
	logger = new Logger((char*)"logs");
	InstructionReader* reader = new InstructionReader(fileName, logger);
	instructions = reader->getListOfInstructions();
	delete reader;
	processor = new Processor_8086(new Memory(10000, logger), 100, logger);
}

Debugger::Debugger(char* fileName, bool isVisualized){
	//Debugger(fileName); popraw
}

Debugger::~Debugger(){
	delete logger;
	delete processor;
	free(instructions);
}

