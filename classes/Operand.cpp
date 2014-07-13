#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "../headers/Operand.hpp"

char* Operand::getExpression(){
	return expression;
}


Operand::Operand(char* expression){
	this->expression = strdup(expression);
}

Operand::~Operand(){
	free(expression);
}