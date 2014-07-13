#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/Operand.hpp"
#include "../headers/NumericValue.hpp"

NumericValue::NumericValue(char* expression, int value): Operand(expression){
	this->value = value;
}

int NumericValue::getValue(){
	return value;
}
