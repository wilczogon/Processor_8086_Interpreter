#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "../headers/Debugger.hpp"
#include "../headers/GraphicSystem.hpp"
#include <map>
#include <iterator>

bool Debugger::step(){
	return processor->execute(getInstruction(processor->nextStep()));
}

void Debugger::run(){
	start(string("start"));
	gui->paintStandardView();
	usleep(instructionTime);
	while(step()){
		gui->paintStandardView();
		usleep(instructionTime);
	}
}

void Debugger::start(string label){
      printf("start: %d\n", getAdressByLabel(label));	//TODO
      processor->setIP(getAdressByLabel(label));
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

int Debugger::getAdressByLabel(string label){
  int i;
  printf("size: %d\n", labelMap->size());	//TODO
  map<string,int>::iterator it = labelMap->find(label);
  if(it == labelMap->end())
    return -1;
  else return it->second;
  
}

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
	reader->readInstructions();
	instructions = reader->getListOfInstructions();
	instructionNo = reader->getNumberOfInstructions();
	labelMap = reader->getMapOfLabels();
	if(instructionNo <= 0)
	  logger->log(new Message((char*)"Number of instructions is equal or less than zero", WARNING));
	delete reader;
	processor = new Processor_8086(new Memory(10000, logger), 0, logger);
	gui = new GraphicSystem(processor, logger);
	instructionTime = 1000;
}

Debugger::Debugger(char* fileName, bool isVisualized){
	//Debugger(fileName); popraw
}

Debugger::~Debugger(){
	delete gui;
	delete processor;
	delete logger;
	free(instructions);
}

