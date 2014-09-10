#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/Operand.hpp"
#include "../headers/NumericValue.hpp"

NumericValue::NumericValue(char* expression): Operand(expression){
	int i;
	int tmp = 0;
	if(expression[strlen(expression) -1] == 'd'){
	  for(i = 0; i<strlen(expression)-1; ++i){
	    tmp *= 2;
	    tmp += (expression[i] - '0');
	  }
	  this->value = tmp;
	} else if(expression[strlen(expression) -1] == 'h'){
	  for(i = 0; i<strlen(expression)-1; ++i){
	    tmp *= 16;
	    
	    if(expression[i]>='a' && expression[i]<='f')
	      this->expression[i] += 'A' - 'a';
	    
	    if(this->expression[i]>='A' && this->expression[i]<='F')
	      tmp += this->expression[i] - 'A' + 10;
	    else
	      tmp += expression[i] - '0';
	  }
	  this->value = tmp;
	} else
	  this->value = atoi(expression);
}

int NumericValue::getValue(){
	return value;
}
