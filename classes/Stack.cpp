#include <stdlib.h>
#include <stdio.h>
#include "../headers/Stack.hpp"
#include "../headers/Logger.hpp"
#include "../headers/Message.hpp"

char Stack::StackElement::getValue(){
	return value;
}
	
bool Stack::StackElement::isJumpData(){
	return jumpData;
}
	
Stack::StackElement::StackElement(char value, bool jumpData){
	this->value = value;
	this->jumpData = jumpData;
}

void Stack::push(char value){
	if(stackIndicator >= size){
		logger->log(new Message((char*)"Stack overflow.", ERROR));
		return;
	}		
		
	stack[stackIndicator] = new StackElement(value, false);
	++stackIndicator;
}

char Stack::pop(){
	if(stackIndicator <= 0){
		logger->log(new Message((char*)"Attemption to read data from empty stack.", ERROR));
		return 0;
	} else if(stack[stackIndicator-1]->isJumpData()){
		logger->log(new Message((char*)"Reading jump data.", WARNING));
		--stackIndicator;
		delete stack[stackIndicator];
		return 0;
	}
	
	--stackIndicator;
	char tmp = stack[stackIndicator]->getValue();
	delete stack[stackIndicator];
	return tmp;
}

void Stack::pushJumpData(){
	if(stackIndicator >= size){
		logger->log(new Message((char*)"Stack overflow.", ERROR));
		return;
	}		
		
	stack[stackIndicator] = new StackElement(0, true);
	++stackIndicator;
}

void Stack::popJumpData(){
	if(stackIndicator <= 0){
		logger->log(new Message((char*)"Attemption to read data from empty stack.", ERROR));
	} else if(!stack[stackIndicator-1]->isJumpData()){
		logger->log(new Message((char*)"Reading not jump data.", WARNING));
		--stackIndicator;
		delete stack[stackIndicator];
	} else{
		--stackIndicator;
		delete stack[stackIndicator];
	}
}

Stack::Stack(int size, Logger* logger){
	stackIndicator = 0;
	stack = (StackElement**)malloc(size*sizeof(StackElement*));
	this->logger = logger;
	this->size = size;
}

Stack::~Stack(){
	int i;
	for(i = 0; i<stackIndicator; ++i)
		delete stack[i];
	free(stack);
}
