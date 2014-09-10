#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "../headers/Debugger.hpp"
#include "../headers/GraphicSystem.hpp"
#include <map>
#include <iterator>

bool Debugger::step(){
      Instruction* instruction = getInstruction(processor->nextStep());
      
      if(instruction == NULL)
	return false;
      
      char* tmp = instruction->toCharArray();
      printf("\nNext step: %s\n\n", tmp);
      free(tmp);
      return processor->execute(instruction);
}

void Debugger::paintStandardView(){
  gui->paintStandardView();
}

void Debugger::run(){
	start(string("start"));
	gui->paintStandardView();
	usleep(1000*instructionTime);
	while(step()){
		gui->paintStandardView();
		usleep(1000*instructionTime);
	}
}

void Debugger::start(string label){
      processor->setIP(getAdressByLabel(label));
}

//void break...
//void continue();

void Debugger::setInstructionTime(int milis){
	instructionTime = milis;
}

void Debugger::showInstructionTime(){
	printf("Instruction time is set to %d miliseconds.\n", instructionTime);
}

//void showMemoryView();
//void showErrorView();

int Debugger::getAdressByLabel(string label){
  
  map<string,int>::iterator it;
  for(it = labelMap->begin(); it != labelMap->end(); ++it)
    if(it->first.compare(label) == 0)
      return it->second;
  
  return -1;
  
  //map<string,int>::iterator it = labelMap->find(label);
  //if(it == labelMap->end())
    //return -1;
  //else return it->second;
  
}

Instruction* Debugger::getInstruction(int address){
	int i;
	for(i = 0; i< instructionNo; ++i)
	    if(instructions[i] == NULL)
	      logger->log(new Message((char*)"Instruction on list is NULL", ERROR));
	    else{ 
	      if(instructions[i]->getAddress() == address)
		return instructions[i];
	    }

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
	processor = new Processor_8086(labelMap, new Memory(10000, logger), 0, logger);
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

