#ifndef MEMORY_ADDRESS
#define MEMORY_ADDRESS

class MemoryAddress{
public:
	MemoryAddress();
	~MemoryAddress();
	
	char* getExpression();
	int getValue();
	
private:
	char* expression;
	int value;
};

#endif
