#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "headers/Debugger.hpp"

int main(int argc, char** args){

	char* fileName;

	if(argc == 2)
		fileName = args[1];
	else if(argc == 1)
		fileName = (char*)"test";
	else{
		printf("\nIncorrect format.\n\nPlease use one of following:\n----------------------------\n\t./asm_interpreter\n\t./asm_interpreter <name of input file>\n\n");
		exit(-1);
	}
	Debugger* debugger = new Debugger(fileName);

	char* input = (char*)malloc(100*sizeof(char*));
	
	printf("\nWelcome into Asembler Interpreter.\n\nWe have delight to introduce you our totally impractical PROGRAM!!!\n\nSo, dear User, please enjoy our way of making art. (I suggest you to type 'help' first)\n\n");

	while(true){

		printf("Debugger << ");

		scanf("%s", input);

		printf("\n");
		
		if(strcmp(input, "quit") == 0)
			break;
		else if(strcmp(input, "help") == 0){
		  printf("Valid commands:\n---------------\n\trun\n\tstep\n\thelp\n\tquit\n");
		} else if(strcmp(input, "run") == 0){
		  debugger->run();
		} else if(strcmp(input, "step") == 0){
		  debugger->step();
		}

		printf("\n");
	}

	delete debugger;

	return 0;
}
