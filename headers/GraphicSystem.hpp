#ifndef GRAPHIC_SYSTEM
#define GRAPHIC_SYSTEM
#include "Logger.hpp"
#include "Processor_8086.hpp"


class GraphicSystem{
public:
  void paintStandardView();
  
  void paintMemoryView();
  
  void paintErrorView();
  
  GraphicSystem(Processor_8086* processor, Logger* logger);
  
private:
  Logger* logger;
  Processor_8086* processor;
};

#endif
