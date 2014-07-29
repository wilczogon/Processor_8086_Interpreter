#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/Processor_8086.hpp"
#include "../headers/Memory.hpp"
#include "../headers/Stack.hpp"
#include "../headers/Logger.hpp"
#include "../headers/Message.hpp"

Processor_8086::Processor_8086(Memory* memory, int offset, Logger* logger){
	this->memory = memory;
	this->stack = new Stack(1<<24, logger);
	this->logger = logger;
	IP = offset;
	this->logger->log(new Message((char*)"Processor_8086 started.", NOTIFICATION));
}

Processor_8086::~Processor_8086(){
	delete stack;
	logger->log(new Message((char*)"Processor_8086 turned off.", NOTIFICATION));
}

int Processor_8086::nextStep(){
	return ++IP;
}

bool Processor_8086::execute(Instruction* instruction){
	char* msg = (char*)malloc(200*sizeof(char));

	if(instruction->getNumberOfArguments() <=2 && instruction->getNumberOfArguments() >= 0){
		if(instruction->getNumberOfArguments() == 2)
			sprintf(msg, "Instruction execution attemption: %s %s %s.", instruction->getName(),
				instruction->getArgument(0)->getExpression(),
				instruction->getArgument(1)->getExpression());
		else if(instruction->getNumberOfArguments() == 1)
			sprintf(msg, "Instruction execution attemption: %s %s.", instruction->getName(),
				instruction->getArgument(0)->getExpression());
		else if(instruction->getNumberOfArguments() == 0)
			sprintf(msg, "Instruction execution attemption: %s.", instruction->getName());

		logger->log(new Message(msg, NOTIFICATION));

	} else{
		sprintf(msg, "Incorrect number of arguments: %s - %d arguments.", instruction->getName(), instruction->getNumberOfArguments());
		logger->log(new Message(msg, WARNING));
	}

	free(msg);
}

/*void Processor_8086::ADC(char* arg1, char* arg2){
	if(getValue(arg1) + getValue(arg2)/WORD_BOUNDARY > 0)
		STC();
	ADD(arg1, arg2);
}

void Processor_8086::ADD(char* arg1, char* arg2){
	setValue(arg1, getValue(arg1) + getValue(arg2));
}

void Processor_8086::AND(char* arg1, char* arg2){
	setValue(arg1, getValue(arg1) & getValue(arg2));
}

void Processor_8086::CLC(){
	flags = (flags & ~CARRY_FLAG);
}

void Processor_8086::CLD(){
	flags = (flags & ~DIRECTION_FLAG);
}
void Processor_8086::CLI(){
	flags = (flags & ~INTERRUPT_FLAG);
}

void Processor_8086::CMC(){
	if(flags & CARRY_FLAG)
		CLC();
	else
		STC();
}

void Processor_8086::CMP(char* arg1, char* arg2){
	int result = getValue(arg1) - getValue(arg2);
		
	if(result == 0)
		flags = flags | ZERO_FLAG;
	//else if(result > 0) TODO
			
}

void Processor_8086::DIV(char* arg){
	if(isByteRegistry(arg)){
		int ax = getValue("AX");
		setValue("AL", ax / getValue(arg));
		setValue("AH", ax % getValue(arg));
	} else if(isWordRegistry(arg)){
		int dx_ax = getValue("DX")*TOP_BOUNDARY + getValue("AX");
		setValue("AX", dx_ax / getValue(arg));
		setValue("DX", dx_ax % getValue(arg));
	} //else TODO
}

	void INC(char* arg){
		setValue(arg, getValue(arg)+1);
	}

	void MOV(char* arg1, char* arg2){
		setValue(arg1, getValue(arg2));
	}

	void STC(){
		flags = flags | CARRY_FLAG;
	}
	void STD(){
		flags = flags | DIRECTION_FLAG;
	}
	void STI(){
		flags = flags | INTERRUPT_FLAG;
	}
*/
	
	/*int getValue(const char* arg){
		if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "BX") == 0)
			return BX;
		else if(strcmp(arg, "CX") == 0)
			return CX;
		else if(strcmp(arg, "DX") == 0)
			return DX;
		else if(strcmp(arg, "AL") == 0)
			return AX % BYTE_BOUNDARY;
		else if(strcmp(arg, "BL") == 0)
			return BX % BYTE_BOUNDARY;
		else if(strcmp(arg, "CL") == 0)
			return CX % BYTE_BOUNDARY;
		else if(strcmp(arg, "DL") == 0)
			return DX % BYTE_BOUNDARY;
		else if(strcmp(arg, "AH") == 0)
			return AX / BYTE_BOUNDARY;
		else if(strcmp(arg, "BH") == 0)
			return BX / BYTE_BOUNDARY;
		else if(strcmp(arg, "CH") == 0)
			return CX / BYTE_BOUNDARY;
		else if(strcmp(arg, "DH") == 0)
			return DX / BYTE_BOUNDARY;
		//else if(strcmp(arg, "AX") == 0)
		//	return AX;
		else return 0;// w takim wypadku musisz policzyć wartosć wyrażenia TODO
			
	}
	
	void setValue(const char* arg, int value){
		if(strcmp(arg, "AX") == 0)
			AX = value % TOP_BOUNDARY;
		else if(strcmp(arg, "BX") == 0)
			BX = value % TOP_BOUNDARY;
		else if(strcmp(arg, "CX") == 0)
			CX = value % TOP_BOUNDARY;
		else if(strcmp(arg, "DX") == 0)
			DX = value % TOP_BOUNDARY;
		else if(strcmp(arg, "AL") == 0)
			AX = (AX / BYTE_BOUNDARY)*BYTE_BOUNDARY + value % BYTE_BOUNDARY;
		else if(strcmp(arg, "BL") == 0)
			BX = (BX / BYTE_BOUNDARY)*BYTE_BOUNDARY + value % BYTE_BOUNDARY;
		else if(strcmp(arg, "CL") == 0)
			CX = (CX / BYTE_BOUNDARY)*BYTE_BOUNDARY + value % BYTE_BOUNDARY;
		else if(strcmp(arg, "DL") == 0)
			DX = (DX / BYTE_BOUNDARY)*BYTE_BOUNDARY + value % BYTE_BOUNDARY;
		else if(strcmp(arg, "AH") == 0)
			AX = (value % BYTE_BOUNDARY)*BYTE_BOUNDARY + AX % BYTE_BOUNDARY;
		else if(strcmp(arg, "BH") == 0)
			BX = (value % BYTE_BOUNDARY)*BYTE_BOUNDARY + BX % BYTE_BOUNDARY;
		else if(strcmp(arg, "CH") == 0)
			CX = (value % BYTE_BOUNDARY)*BYTE_BOUNDARY + CX % BYTE_BOUNDARY;
		else if(strcmp(arg, "DH") == 0)
			DX = (value % BYTE_BOUNDARY)*BYTE_BOUNDARY + DX % BYTE_BOUNDARY;
	}*/
	
bool Processor_8086::isByteRegistry(char* arg){
	if(strcmp(arg, "AL") == 0)
		return true;
	else if(strcmp(arg, "BL") == 0)
		return true;
	else if(strcmp(arg, "CL") == 0)
		return true;
	else if(strcmp(arg, "DL") == 0)
		return true;
	else if(strcmp(arg, "AH") == 0)
		return true;
	else if(strcmp(arg, "BH") == 0)
		return true;
	else if(strcmp(arg, "CH") == 0)
		return true;
	else if(strcmp(arg, "DH") == 0)
		return true;
	else
		return false;
}
	
bool Processor_8086::isWordRegistry(char* arg){
	if(strcmp(arg, "AX") == 0)
		return true;
	else if(strcmp(arg, "BX") == 0)
		return true;
	else if(strcmp(arg, "CX") == 0)
		return true;
	else if(strcmp(arg, "DX") == 0)
		return true;
	else
		return false;
}
	
bool Processor_8086::isValue(char* arg){
	return false;
}

bool Processor_8086::isMemoryAddress(char* arg){
	return false;
}

bool isLabel(char* arg){
	return false;
}

