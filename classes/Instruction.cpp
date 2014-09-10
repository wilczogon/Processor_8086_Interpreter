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

char* Instruction::toCharArray(){
  char* tmp = (char*)malloc(100);
  sprintf(tmp, "%s ", getName());
  
  int i;
  for(i = 0; i<argsNo; ++i)
    sprintf(tmp, "%s %s", tmp, getArgument(i)->getExpression());
  
  return tmp;
}

Instruction::Instruction(char* name, int address, int numberOfArgs, Operand** args){
	this->name = strdup(name);
	this->address = address;
	this->argsNo = numberOfArgs;
	this->args = args;
}

Instruction::Instruction(const Instruction& instruction){
  this->name = strdup(instruction.name);
  this->address = instruction.address;
  this->argsNo = instruction.argsNo;
  this->args = (Operand**)malloc(argsNo*sizeof(Operand*));
  int i;
  for(i = 0; i<argsNo; ++i)
    args[i] = instruction.args[i];
}

Instruction::~Instruction(){
	free(name);
	int i;
	for(i = 0; i < argsNo; ++i)
		delete(args[i]);
}
