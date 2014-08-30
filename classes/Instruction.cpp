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
	
Operand* Instruction::getArgument(int no){
	return args[no];
}
	
int Instruction::getAddress(){
	return address;
}

Instruction::Instruction(char* name, int address, int numberOfArgs, Operand** args){
	this->name = strdup(name);
	this->address = address;
	this->argsNo = numberOfArgs;
	this->args = args;
}

Instruction::Instruction(const Instruction& instruction){
  printf("begin");
  this->name = strdup(instruction.name);
  this->address = instruction.address;
  this->argsNo = instruction.argsNo;
  this->args = (Operand**)malloc(argsNo*sizeof(Operand*));
  int i;
  for(i = 0; i<argsNo; ++i)
    args[i] = instruction.args[i];
  printf("end");
}

Instruction::~Instruction(){
	free(name);
	int i;
	for(i = 0; i < argsNo; ++i)
		delete(args[i]);
}