#ifndef STACK
#define STACK

#include "../headers/Logger.hpp"

class Stack{
public:
	class StackElement{
	public:
		char getValue();
		bool isJumpData();
		StackElement(char value, bool jumpData);
	
	private:
		char value;
		bool jumpData;
	};
	
	void push(char value);
	char pop();
	void pushJumpData();
	void popJumpData();
	Stack(int size, Logger* logger);
	~Stack();
	
private:
	int stackIndicator;
	StackElement** stack;
	Logger* logger;
	int size;
};

#endif
