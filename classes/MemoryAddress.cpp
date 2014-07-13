#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/MemoryAddress.hpp"

MemoryAddress::MemoryAddress(char* expression, int value){
	this->expression = strdup(expression);
	this->value = value;
}

MemoryAddress::~MemoryAddress(){
	free(expression);
}
	
char* MemoryAddress::getExpression(){
	return expression;
}

int MemoryAddress::getValue(){
	return value;
}
 
