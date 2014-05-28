#include <stdlib.h>
#include <stdio.h>
#include "Instruction.hpp"

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
	this->name = name;
	this->address = address;
	this->argsNo = numberOfArgs;
	this->args = args;
}
