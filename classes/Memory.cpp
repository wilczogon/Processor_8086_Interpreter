#include "../headers/Memory.hpp"
#include <stdlib.h>
#include <stdio.h>

Memory::Memory(int memorySize, Logger* logger) {
	Memory::logger = logger;
	Memory::memorySize = memorySize;
	memoryCells = (char*) calloc(memorySize,sizeof(char));
	instructionMarkers = (bool*) calloc(memorySize,sizeof(bool));
	stackMarkers = (bool*) calloc(memorySize,sizeof(bool));

}

Memory::~Memory() {
	free(memoryCells);
	free(instructionMarkers);
	free(stackMarkers);

}

void Memory::put(int address, char value){
	Memory::memoryCells[address] = value;
	logger->log(new Message(NULL,NOTIFICATION));
}

char Memory::get(int address){
	return Memory::memoryCells[address];
	logger->log(new Message(NULL,NOTIFICATION));
}

void Memory::setAsInstruction(int address){
	instructionMarkers[address] = true;
	logger->log(new Message(NULL,NOTIFICATION));
}

void Memory::setAsStack(int address){
	stackMarkers[address] = true;
	logger->log(new Message(NULL,NOTIFICATION));
}

bool Memory::isInstruction(int address){
	return instructionMarkers[address];
	logger->log(new Message(NULL,NOTIFICATION));
}

bool Memory::isStack(int address){
	return stackMarkers[address];
	logger->log(new Message(NULL,NOTIFICATION));
}
