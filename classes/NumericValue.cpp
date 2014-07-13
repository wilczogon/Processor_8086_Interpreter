#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/NumericValue.hpp"

NumericValue::NumericValue(char* expression, int value){
	this->expression = strdup(expression);
	this->value = value;
}

NumericValue::~NumericValue(){
	free(expression);
}
	
char* NumericValue::getExpression(){
	return expression;
}

int NumericValue::getValue(){
	return value;
}
