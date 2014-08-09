#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "../headers/Debugger.hpp"

bool Debugger::step(){
	return processor->execute(getInstruction(processor->nextStep()));
}

void Debugger::run(){
	start();
	while(step()){
		usleep(instructionTime);
	}
}

void Debugger::start(/*adres startowy?*/){
	//ustaw na poczatku czy co?
}

//void break...
//void continue();

void Debugger::setInstructionTime(int milis){
	instructionTime = milis;
}

void Debugger::showInstructionTime(){
	printf("Czas wykonania pojedynczej operacji jest ustawiony na %d milisekund.\n", instructionTime);
}

//void showMemoryView();
//void showErrorView();

Instruction* Debugger::getInstruction(int address){
	int i;
	for(i = 0; i< instructionNo; ++i)
		if(instructions[i]->getAddress() == address)
			return instructions[i];

	return NULL;
}

Debugger::Debugger(char* fileName){
	logger = new Logger((char*)"logs");
	InstructionReader* reader = new InstructionReader(fileName, logger);
	instructions = reader->getListOfInstructions();
	//instructionNo = reader->getNumberOfInstructions();
	delete reader;
	processor = new Processor_8086(new Memory(10000, logger), 100, logger);
	instructionTime = 1000;
}

Debugger::Debugger(char* fileName, bool isVisualized){
	//Debugger(fileName); popraw
}

Debugger::~Debugger(){
	delete processor;
	delete logger;
	free(instructions);
}

