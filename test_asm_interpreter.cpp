#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "headers/Instruction.hpp"
#include "headers/Message.hpp"
#include "headers/Logger.hpp"
//#include <>

int main(int argNo, char** args){
	
	
	printf("Test of Instruction\n");
	char** arguments = (char**)malloc(2*sizeof(char*));
	arguments[0] = (char*)"AX";
	arguments[1] = (char*)"BX";
	Instruction* instruction = new Instruction((char*)"MOV", 20, 2, arguments);
	
	if(strcmp(instruction->getName(), "MOV") != 0)
		printf("\tError: getName()\n");
	
	if(instruction->getAddress() != 20)
		printf("\tError: getAddress()\n");
	
	if(instruction->getNumberOfArguments() != 2)
		printf("\tError: getNumberOfArguments()\n");
	
	if(strcmp(instruction->getArgument(0), "AX") != 0)
		printf("\tError: getArgument() [1]\n");
	
	if(strcmp(instruction->getArgument(1), "BX") != 0)
		printf("\tError: getArgument() [2]\n");
	
	delete instruction;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	printf("Test of Message\n");
	char* messageText = (char*)"Error occured";
	Message* message = new Message(messageText, ERROR);
	
	if(strcmp(message->getText(), messageText) != 0)
		printf("\tError: getText()\n");
	
	if(message->getType() != ERROR)
		printf("\tError: getType()\n");
	
	delete message;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	printf("Test of Logger\n");
	
	Logger* logger = new Logger((char*)"testLog");
	
	logger->log(new Message((char*)"Initiated", NOTIFICATION));
	logger->log(new Message((char*)"Warning", WARNING));
	logger->log(new Message((char*)"Error occured", ERROR));
	
	if(logger->getNumberOfMessages() != 3)
		printf("\tError: getNumberOfMessages() [1]\n");
	
	Message** messages = logger->getListOfMessages();
	
	if(strcmp(messages[2]->getText(), "Error occured") != 0)
		printf("\tError: getListOfMessages() [1]\n");
	
	if(messages[2]->getType() != ERROR)
		printf("\tError: getListOfMessages() [2]\n");
	
	logger->flush();
	
	if(logger->getNumberOfMessages() != 0)
		printf("\tError: getNumberOfMessages() [2]\n");
	
	delete logger;
	
	return 0;
}
