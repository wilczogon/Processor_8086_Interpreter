#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "../headers/Instruction.hpp"

char* Instruction::getName(){
	return name;
}
	
int Instruction::getNumberOfArguments(){
	return argsNo;
}
	
char* Instruction::getArgument(int no){
	return args[no];
}
	
int Instruction::getAddress(){
	return address;
}

Instruction::Instruction(char* name, int address, int numberOfArgs, char** args){
	this->name = strdup(name);
	this->address = address;
	this->argsNo = numberOfArgs;
	this->args = (char**)malloc(numberOfArgs*sizeof(char*));
	int i;
	for(i = 0; i < numberOfArgs; ++i)
		this->args[i] = strdup(args[i]);
}

Instruction::~Instruction(){
	free(name);
	int i;
	for(i = 0; i < argsNo; ++i)
		free(args[i]);
}