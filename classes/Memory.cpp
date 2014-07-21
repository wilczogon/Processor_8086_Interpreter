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
}

char Memory::get(int address){
	return Memory::memoryCells[address];
}

void Memory::setAsInstruction(int address){
	instructionMarkers[address] = true;
}

void Memory::setAsStack(int address){
	stackMarkers[address] = true;
}

bool Memory::isInstruction(int address){
	return instructionMarkers[address];
}

bool Memory::isStack(int address){
	return stackMarkers[address];
}
