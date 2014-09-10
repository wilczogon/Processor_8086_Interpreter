#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <map>
#include <string>
#include "../headers/Processor_8086.hpp"
#include "../headers/Debugger.hpp"
#include "../headers/Memory.hpp"
#include "../headers/Stack.hpp"
#include "../headers/Logger.hpp"
#include "../headers/Message.hpp"
#include "../headers/Operand.hpp"
#include "../headers/Registry.hpp"
#include "../headers/MemoryAddress.hpp"
#include "../headers/NumericValue.hpp"

Processor_8086::Processor_8086(std::map<std::string,int>* labelMap, Memory* memory, int offset, Logger* logger){
	this->labelMap = labelMap;
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
	return IP++;
}

bool Processor_8086::execute(Instruction* instruction){
	if(instruction == NULL){
	  printf("\n\nEnd of instructions.\n");
	  logger->log(new Message((char*)"End of instructions.", NOTIFICATION));
	  return false;
	}
	
	char* msg = (char*)malloc(200*sizeof(char));

	if(instruction->getNumberOfArguments() <=2 && instruction->getNumberOfArguments() >= 0){
		if(instruction->getNumberOfArguments() == 2){
			sprintf(msg, "Instruction execution attemption: %s %s %s.", instruction->getName(),
				instruction->getArgument(0)->getExpression(),
				instruction->getArgument(1)->getExpression());
			
			if(strcmp(instruction->getName(), "ADC") == 0)
			  ADC(instruction->getArgument(0), instruction->getArgument(1));
			else if(strcmp(instruction->getName(), "ADD") == 0)
			  ADD(instruction->getArgument(0), instruction->getArgument(1));
			else if(strcmp(instruction->getName(), "AND") == 0)
			  AND(instruction->getArgument(0), instruction->getArgument(1));
			//else if(strcmp(instruction->getName(), "AAS") == 0)
			  //AAS();
			else if(strcmp(instruction->getName(), "MOV") == 0)
			  MOV(instruction->getArgument(0), instruction->getArgument(1));
			else
			  logger->log(new Message((char*)"Unknown instruction.", ERROR));
			
			logger->log(new Message(msg, NOTIFICATION));
			
		} else if(instruction->getNumberOfArguments() == 1){
			sprintf(msg, "Instruction execution attemption: %s %s.", instruction->getName(),
				instruction->getArgument(0)->getExpression());
			
			if(strcmp(instruction->getName(), "CALL") == 0)
			  CALL(instruction->getArgument(0));
			else
			  logger->log(new Message((char*)"Unknown instruction.", ERROR));
			
			logger->log(new Message(msg, NOTIFICATION));
			
		} else if(instruction->getNumberOfArguments() == 0){
			sprintf(msg, "Instruction execution attemption: %s.", instruction->getName());
			
			logger->log(new Message(msg, NOTIFICATION));
			
			if(strcmp(instruction->getName(), "AAA") == 0)
			  AAA();
			else if(strcmp(instruction->getName(), "AAD") == 0)
			  AAD();
			else if(strcmp(instruction->getName(), "AAM") == 0)
			  AAM();
			else if(strcmp(instruction->getName(), "AAS") == 0)
			  AAS();
			else if(strcmp(instruction->getName(), "CBW") == 0)
			  CBW();
			else if(strcmp(instruction->getName(), "CLC") == 0)
			  CLC();
			else if(strcmp(instruction->getName(), "CLD") == 0)
			  CLD();
			else if(strcmp(instruction->getName(), "CLI") == 0)
			  CLI();
			else if(strcmp(instruction->getName(), "RET") == 0)
			  RET();
			else
			  logger->log(new Message((char*)"Unknown instruction.", ERROR));
		}

	} else{
		sprintf(msg, "Incorrect number of arguments: %s - %d arguments.", instruction->getName(), instruction->getNumberOfArguments());
		logger->log(new Message(msg, WARNING));
	}

	free(msg);
}

void Processor_8086::AAA(){
	if((AL & 0x11111111)>9 || flags & AUX_CARRY_FLAG){
	  AL += 6;
	  AH++;
	  flags = flags | AUX_CARRY_FLAG;
	  flags = flags | CARRY_FLAG;
	} else{
	  flags = flags & ~AUX_CARRY_FLAG;
	  flags = flags & ~CARRY_FLAG;
	}
	
	AL = (AL & 0x11111111);
	
}

void Processor_8086::AAD(){
	AL = (AH * 10) + AL;
	AH = 0;
}

void Processor_8086::AAM(){
  AH = AL/10;
  AL = AL%10;
}

void Processor_8086::AAS(){
  if((AL & 0x11111111)>9 || flags & AUX_CARRY_FLAG){
	  AL -= 6;
	  AH--;
	  flags = flags | AUX_CARRY_FLAG;
	  flags = flags | CARRY_FLAG;
	} else{
	  flags = flags & ~AUX_CARRY_FLAG;
	  flags = flags & ~CARRY_FLAG;
	}
	
	AL = (AL & 0x11111111);
}

void Processor_8086::ADC(Operand* arg1, Operand* arg2){
  int valueOfArg1;
  int valueOfArg2;
    
  setValue(arg1, getValue(arg1) + getValue(arg2) + (flags & CARRY_FLAG != 0 ? 1: 0)); 
}

void Processor_8086::ADD(Operand* arg1, Operand* arg2){
	setValue(arg1, getValue(arg1) + getValue(arg2));
}

void Processor_8086::AND(Operand* arg1, Operand* arg2){
	setValue(arg1, getValue(arg1) & getValue(arg2));
}

void Processor_8086::CALL(Operand* arg){
  stack->push(IP);
  
  std::map<std::string,int>::iterator it;
  for(it = labelMap->begin(); it != labelMap->end(); ++it)
    if(it->first.compare(arg->getExpression()) == 0){
      IP = it->second;
      break;
    }
    
  stack->pushJumpData();
}

void Processor_8086::CBW(){
  // TODO
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

/*void Processor_8086::CMC(){
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

	void Processor_8086::MOV(Operand* arg1, Operand* arg2){
	  setValue(arg1, getValue(arg2));
	}
	
	void Processor_8086::RET(){
	  stack->popJumpData();
	  IP = stack->pop();
	}

	int Processor_8086::getValue(Operand* arg){
	  if(dynamic_cast<Registry*>(arg) != NULL){
	    Registry* reg = dynamic_cast<Registry*>(arg);
	    return getRegistryValue(reg->getExpression());
	    
	  } else if(dynamic_cast<MemoryAddress*>(arg) != NULL){
	    MemoryAddress* mem = dynamic_cast<MemoryAddress*>(arg); //TODO
	    return memory->get(mem->getValue());
	    
	  } else if(dynamic_cast<NumericValue*>(arg) != NULL){
	    NumericValue* val = dynamic_cast<NumericValue*>(arg);
	    return val->getValue();
	    
	  }
	}
	
	void Processor_8086::setValue(Operand* arg, int value){
	  if(dynamic_cast<Registry*>(arg) != NULL){
	    Registry* reg = dynamic_cast<Registry*>(arg);
	    setRegistryValue(reg->getExpression(), value);
	    
	  } else if(dynamic_cast<MemoryAddress*>(arg) != NULL){
	    MemoryAddress* mem = dynamic_cast<MemoryAddress*>(arg); //TODO
	    memory->put(mem->getValue(), value);
	    
	  }
	}
	
	void Processor_8086::setIP(int ip){
	  IP = ip;
	}
	
	int Processor_8086::getRegistryValue(const char* arg){
		if(strcmp(arg, "AX") == 0)
		  return AH*256 + AL;
		else if(strcmp(arg, "BX") == 0)
		  return BH*256 + BL;
		else if(strcmp(arg, "CX") == 0)
		  return CH*256 + CL;
		else if(strcmp(arg, "DX") == 0)
		  return DH*256 + DL;
		else if(strcmp(arg, "AL") == 0)
			return AL;
		else if(strcmp(arg, "BL") == 0)
			return BL;
		else if(strcmp(arg, "CL") == 0)
			return CL;
		else if(strcmp(arg, "DL") == 0)
			return DL;
		else if(strcmp(arg, "AH") == 0)
			return AH;
		else if(strcmp(arg, "BH") == 0)
			return BH;
		else if(strcmp(arg, "CH") == 0)
			return CH;
		else if(strcmp(arg, "DH") == 0)
			return DH;
		else if(strcmp(arg, "CS") == 0)
			return CS;
		else if(strcmp(arg, "DS") == 0)
			return DS;
		else if(strcmp(arg, "ES") == 0)
			return ES;
		else if(strcmp(arg, "SS") == 0)
			return SS;
		else if(strcmp(arg, "SI") == 0)
			return SI;
		else if(strcmp(arg, "DI") == 0)
			return DI;
		else if(strcmp(arg, "SP") == 0)
			return SP;
		else if(strcmp(arg, "BP") == 0)
			return BP;
		else if(strcmp(arg, "flags") == 0)
			return flags;
			
	}
	
	void Processor_8086::setRegistryValue(const char* arg, int value){
		if(strcmp(arg, "AX") == 0){
			  AL = value %256;
			  AH = value/256;
		}else if(strcmp(arg, "BX") == 0){
			  BL = value %256;
			  BH = value/256;
		}else if(strcmp(arg, "CX") == 0){
			  CL = value %256;
			  CH = value/256;
		}else if(strcmp(arg, "DX") == 0){
			  DL = value %256;
			  DH = value/256;
		}else if(strcmp(arg, "AL") == 0)
			AL = value;
		else if(strcmp(arg, "BL") == 0)
			BL = value;
		else if(strcmp(arg, "CL") == 0)
			CL = value;
		else if(strcmp(arg, "DL") == 0)
			DL = value;
		else if(strcmp(arg, "AH") == 0)
			AH = value;
		else if(strcmp(arg, "BH") == 0)
			BH = value;
		else if(strcmp(arg, "CH") == 0)
			CH = value;
		else if(strcmp(arg, "DH") == 0)
			DH = value;
		else if(strcmp(arg, "CS") == 0)
			CS = value;
		else if(strcmp(arg, "DS") == 0)
			DS = value;
		else if(strcmp(arg, "ES") == 0)
			ES = value;
		else if(strcmp(arg, "SS") == 0)
			SS = value;
	}
	
/*bool Processor_8086::isByteRegistry(char* arg){
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

bool isLabel(char* arg){
	return false;
}*/

