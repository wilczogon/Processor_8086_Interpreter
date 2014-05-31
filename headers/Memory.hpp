
#ifndef MEMORY_HPP_
#define MEMORY_HPP_

class Memory {
public:
	Memory(int);
	virtual ~Memory();
	void put(int,char);
	char get(int);
	bool isInstruction(int);
	bool isStack(int);
	void setAsInstruction(int);
	void setAsStack(int);
private:
	char* memoryCells;
	bool* instructionMarkers;
	bool* stackMarkers;
	int memorySize;
};

#endif /* MEMORY_HPP_ */
