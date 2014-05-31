#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "headers/Instruction.hpp"
//#include <>

int main(int argNo, char** args){
	
	
	printf("Test of Instruction\n");
	char** arguments = (char**)malloc(2*sizeof(char*));
	arguments[0] = (char*)"AX";
	arguments[1] = (char*)"BX";
	Instruction* instruction = new Instruction((char*)"MOV", 20, 2, arguments);
	
	if(strcmp(instruction->getName(), "MOV") != 0)
		printf("\tError: getName()\n");
	
	if(instruction->getAddress() != 20)
		printf("\tError: getAddress()\n");
	
	if(instruction->getNumberOfArguments() != 2)
		printf("\tError: getNumberOfArguments()\n");
	
	if(strcmp(instruction->getArgument(0), "AX") != 0)
		printf("\tError: getArgument() [1]\n");
	
	if(strcmp(instruction->getArgument(1), "BX") != 0)
		printf("\tError: getArgument() [2]\n");
	
	delete instruction;
	
	return 0;
}
