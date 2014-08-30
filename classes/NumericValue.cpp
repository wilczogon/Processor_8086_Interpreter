#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/Operand.hpp"
#include "../headers/NumericValue.hpp"

NumericValue::NumericValue(char* expression): Operand(expression){
	this->value = 0;
}

int NumericValue::getValue(){
	return value;
}
