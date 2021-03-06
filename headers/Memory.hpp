
#ifndef MEMORY
#define MEMORY

#include "Logger.hpp"

class Memory {
public:
	Memory(int size, Logger* logger);
	~Memory();
	void put(int address, char value);
	char get(int address);
	bool isInstruction(int address);
	bool isStack(int address);
	void setAsInstruction(int address);
	void setAsStack(int address);
private:
	char* memoryCells;
	bool* instructionMarkers;
	bool* stackMarkers;
	int memorySize;
	Logger* logger;
};

#endif
