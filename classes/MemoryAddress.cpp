#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/Operand.hpp"
#include "../headers/MemoryAddress.hpp"

MemoryAddress::MemoryAddress(char* expression, int value): Operand(expression){
	this->value = value;
}

int MemoryAddress::getValue(){
	return value;
}
