%option noyywrap

%%



%%

#include <stdio.h>
#include <stdlib.h>
#include "../headers/InstructionReader.hpp"
#include "../headers/Instruction.hpp"


Instruction** InstructionReader::getListOfInstructions(){
	//mock function
	Instruction** instructions = (Instruction**)malloc(2*sizeof(Instruction*));
	instructions[0] = new Instruction((char*)"MOV", 10, 0, NULL);
	instructions[1] = new Instruction((char*)"MOV2", 11, 0, NULL);

	return instructions;
}

int InstructionReader::getNumberOfInstructions(){
	//mock function
	return 2;
}

void InstructionReader::readInstructions(){
	
}

InstructionReader::InstructionReader(char* fileName, Logger* logger){
	InstructionReader::logger = logger;
	InstructionReader::instructionList = new list<Instruction>();
	yyin = fopen( fileName, "r" );
	//tu przetwarzaj sobie jakoś fileName
}

