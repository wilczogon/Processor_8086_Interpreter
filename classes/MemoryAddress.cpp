#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/Operand.hpp"
#include "../headers/MemoryAddress.hpp"

MemoryAddress::MemoryAddress(char* expression): Operand(expression){
	this->value = 0;
}

int MemoryAddress::getValue(){
	return value;
}
