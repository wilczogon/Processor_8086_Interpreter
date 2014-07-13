#ifndef MEMORY_ADDRESS
#define MEMORY_ADDRESS

class MemoryAddress: public Operand{
public:
	MemoryAddress(char* expression, int value);
	int getValue();
	
private:
	int value;
};

#endif