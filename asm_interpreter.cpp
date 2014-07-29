#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "headers/Debugger.hpp"

int main(int argc, char** args){

	char* fileName;

	if(argc == 2)
		fileName = args[1];
	else
		fileName = (char*)"test";

	Debugger* debugger = new Debugger(fileName);

	char* input = (char*)malloc(100*sizeof(char*));

	while(true){

		printf("Debugger << ");

		scanf("%s", input);

		if(strcmp(input, "quit") == 0)
			break;
		//else

		printf("\n");
	}

	delete debugger;

	return 0;
}
