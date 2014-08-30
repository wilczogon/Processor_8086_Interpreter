#include "../headers/Memory.hpp"
#include <stdlib.h>
#include <stdio.h>

Memory::Memory(int memorySize, Logger* logger) {
	Memory::logger = logger;
	Memory::memorySize = memorySize;
	memoryCells = (char*) calloc(memorySize,sizeof(char));
	instructionMarkers = (bool*) calloc(memorySize,sizeof(bool));
	stackMarkers = (bool*) calloc(memorySize,sizeof(bool));
	logger->log(new Message((char*)"Memory initialized.",NOTIFICATION));
}

Memory::~Memory() {
	free(memoryCells);
	free(instructionMarkers);
	free(stackMarkers);
	logger->log(new Message((char*)"Memory finalized.",NOTIFICATION));
}

void Memory::put(int address, char value){
	Memory::memoryCells[address] = value;
	logger->log(new Message((char*)"Memory in.",NOTIFICATION));
}

char Memory::get(int address){
	return Memory::memoryCells[address];
	logger->log(new Message((char*)"Memory out.",NOTIFICATION));
}

void Memory::setAsInstruction(int address){
	instructionMarkers[address] = true;
	logger->log(new Message((char*)"Instruction marked.",NOTIFICATION));
}

void Memory::setAsStack(int address){
	stackMarkers[address] = true;
	logger->log(new Message((char*)"Stack set.",NOTIFICATION));
}

bool Memory::isInstruction(int address){
	return instructionMarkers[address];
}

bool Memory::isStack(int address){
	return stackMarkers[address];
}
