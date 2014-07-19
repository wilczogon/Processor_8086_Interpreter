#include <stdio.h>
#include <stdlib.h>
#include "../headers/InstructionReader.hpp"
#include "../headers/Instruction.hpp"


Instruction** InstructionReader::getListOfInstructions(){
	//mock function
	Instruction** instructions = (Instruction**)malloc(2*sizeof(Instruction*));
	instructions[0] = new Instruction((char*)"MOV", 10, 0, null);
	instructions[1] = new Instruction((char*)"MOV2", 11, 0, null);
}

int InstructionReader::getNumberOfInstructions(){
	//mock function
	return 2;
}

InstructionReader::InstructionReader(char* fileName, Logger* logger){
	this->logger = logger
	//tu przetwarzaj sobie jakoś fileName
}

