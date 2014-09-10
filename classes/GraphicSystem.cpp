#include <stdio.h>
#include <stdlib.h>
#include "../headers/GraphicSystem.hpp"
#include "../headers/Logger.hpp"
#include "../headers/Processor_8086.hpp"


void GraphicSystem::paintStandardView(){
  printf("AH: %d\tAL: %d\n", processor->getRegistryValue("AH"), processor->getRegistryValue("AL"));
  printf("BH: %d\tBL: %d\n", processor->getRegistryValue("BH"), processor->getRegistryValue("BL"));
  printf("CH: %d\tCL: %d\n", processor->getRegistryValue("CH"), processor->getRegistryValue("CL"));
  printf("DH: %d\tDL: %d\n", processor->getRegistryValue("DH"), processor->getRegistryValue("DL"));
  
  printf("CS: %d\n", processor->getRegistryValue("CS"));
  printf("DS: %d\n", processor->getRegistryValue("DS"));
  printf("ES: %d\n", processor->getRegistryValue("ES"));
  printf("SS: %d\n", processor->getRegistryValue("SS"));
  
  printf("SI: %d\n", processor->getRegistryValue("SI"));
  printf("DI: %d\n", processor->getRegistryValue("DI"));
  printf("SP: %d\n", processor->getRegistryValue("SP"));
  printf("BP: %d\n", processor->getRegistryValue("BP"));
  
  int flags = processor->getRegistryValue("flags");
  
  printf("|CF|PF|AF|ZF|SF|TF|IF|DF|OF|\n| %d| %d| %d| %d| %d| %d| %d| %d| %d|\n", flags & processor->CARRY_FLAG != 0 ? 1:0,
	flags & processor->PARITY_FLAG != 0 ? 1:0,
	flags & processor->AUX_CARRY_FLAG != 0 ? 1:0,
	flags & processor->ZERO_FLAG != 0 ? 1:0,
	flags & processor->SIGN_FLAG != 0 ? 1:0,
	flags & processor->TRAP_FLAG != 0 ? 1:0,
	flags & processor->INTERRUPT_FLAG != 0 ? 1:0,
	flags & processor->DIRECTION_FLAG != 0 ? 1:0,
	flags & processor->OVERFLOW_FLAG != 0 ? 1:0);
}
  
void GraphicSystem::paintMemoryView(){
}
  
void GraphicSystem::paintErrorView(){
}
  
GraphicSystem::GraphicSystem(Processor_8086* processor, Logger* logger){
  this->processor = processor;
  this->logger = logger;
}