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
}
  
void GraphicSystem::paintMemoryView(){
}
  
void GraphicSystem::paintErrorView(){
}
  
GraphicSystem::GraphicSystem(Processor_8086* processor, Logger* logger){
  this->processor = processor;
  this->logger = logger;
}