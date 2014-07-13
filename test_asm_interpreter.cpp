#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "headers/Instruction.hpp"
#include "headers/Message.hpp"
#include "headers/Logger.hpp"
#include "headers/Stack.hpp"
#include "headers/Operand.hpp"
//#include <>

int main(int argNo, char** args){
	
	printf("Test of Operand\n");
	char* expression = (char*)"example";
	Operand* operand = new Operand(expression);
	
	if(strcmp(operand->getExpression(), expression) != 0)
		printf("\tError: getExpression()\n");
	
	delete operand;
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	printf("Test of Instruction\n");
	Operand** arguments = (Operand**)malloc(2*sizeof(Operand*));
	arguments[0] = new Operand((char*)"AX");
	arguments[1] = new Operand((char*)"BX");
	Instruction* instruction = new Instruction((char*)"MOV", 20, 2, arguments);
	
	if(strcmp(instruction->getName(), "MOV") != 0)
		printf("\tError: getName()\n");
	
	if(instruction->getAddress() != 20)
		printf("\tError: getAddress()\n");
	
	if(instruction->getNumberOfArguments() != 2)
		printf("\tError: getNumberOfArguments()\n");
	
	if(strcmp(instruction->getArgument(0)->getExpression(), "AX") != 0)
		printf("\tError: getArgument() [1]\n");
	
	if(strcmp(instruction->getArgument(1)->getExpression(), "BX") != 0)
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
	
	Logger* logger = new Logger((char*)"test/testLog");
	
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
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	printf("Test of Stack\n");
	
	Logger* stackLogger = new Logger((char*)"test/testStackLog");
	Stack* stack = new Stack(1, stackLogger);
	
	stackLogger->log(new Message((char*)"Below should be one overflow message.", NOTIFICATION));
	
	stack->push('a');
	stack->pushJumpData();
	
	delete stack;
	
	stack = new Stack(3, stackLogger);
	stack->push('a');
	stack->pushJumpData();
	stack->push('b');
	
	if(stack->pop() != 'b')
		printf("\tError: pop() [1]\n");
	
	stack->popJumpData();
	
	if(stack->pop() != 'a')
		printf("\tError: pop() [2]\n");
	
	stackLogger->log(new Message((char*)"Below should be one message about poping from empty stack.", NOTIFICATION));
	
	if(stack->pop() != 0)
		printf("\tError: pop() [3]\n");
	
	delete stack;
	
	stack = new Stack(2, stackLogger);
	
	stack->push('a');
	stack->pushJumpData();
	
	stackLogger->log(new Message((char*)"Below should be two messages about wrong poping method.", NOTIFICATION));
	
	if(stack->pop() != 0)
		printf("\tError: pop() [4]\n");
	
	stack->popJumpData();
	
	delete stack;
	
	delete stackLogger;
	
	return 0;
}
