#ifndef INSTRUCTION
#define INSTRUCTION

class Instruction{
public:
	char* getName();
	int getNumberOfArguments();
	char* getArgument(int no);
	int getAddress();
	Instruction(char* name, int address, int numberOfArgs, char** args);
	~Instruction();

private:
	char* name;
	int argsNo;
	char** args;
	int address;
};

#endif
