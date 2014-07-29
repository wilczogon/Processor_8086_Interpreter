#include <stdio.h>
#include <stdlib.h>
#include "headers/Debugger.hpp"

int main(int argc, char** args){

	char* fileName;

	if(argc == 2)
		fileName = args[1];
	else
		fileName = (char*)"test";

	Debugger* debugger = new Debugger(fileName);
	delete debugger;

	return 0;
}
