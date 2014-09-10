#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <iostream>
#include "../headers/Registry.hpp"
#include "../headers/Operand.hpp"


Registry::Registry(char* expression): Operand(expression){
  this->expression = strdup(expression);
  int i = 0;
  while (this->expression[i])
  {
    this->expression[i]=toupper(this->expression[i]);
    i++;
  }
}
