#ifndef PROCESSOR_8086
#define PROCESSOR_8086

#include "Stack.hpp"
#include "Memory.hpp"
#include "Logger.hpp"
#include "Instruction.hpp"
#include "Operand.hpp"
#include <map>
#include <string>

class Processor_8086{
public:
	
	//Processor_8086();
	
	Processor_8086(std::map<std::string,int>* labelMap, Memory* memory, int offset, Logger* logger);
	~Processor_8086();
	
	int nextStep();

	bool execute(Instruction* instruction);
	
	// lista instrukcji
	void AAA();
	void AAD();
	void AAM();
	void AAS();
	
	void ADC(Operand* arg1, Operand* arg2);
	void ADD(Operand* arg1, Operand* arg2);
	void AND(Operand* arg1, Operand* arg2);
	void CALL(Operand* arg);
	void CBW();
	void CLC();
	void CLD();
	void CLI();
	void CMC();
	void CMP(char* arg1, char* arg2);
	void CMPSB();
	void CMPSW();
	void CWD();
	void DAA();
	void DAS();
	void DEC(char* arg);
	void DIV(char* arg);
	void ESC();
	void HLT();
	void IDIV(char* arg);
	void IMUL(char* arg);
	void IN(char* arg1, char* arg2);
	void INC(char* arg);
	void INT(char* arg);
	void INTO();
	void IRET();
	
	void JA(char* arg);
	void JAE(char* arg);
	void JB(char* arg);
	void JBE(char* arg);
	void JC(char* arg);
	void JE(char* arg);
	void JG(char* arg);
	void JGE(char* arg);
	void JL(char* arg);
	void JLE(char* arg);
	
	void JO(char* arg);
	void JP(char* arg);
	void JPE(char* arg);
	void JPO(char* arg);
	void JS(char* arg);
	void JZ(char* arg);
	
	void JCXZ(char* arg);
	void JMP(char* arg);
	void LAHF();
	void LDS(char* arg1, char* arg2);
	void LEA(char* arg1, char* arg2);
	void LES(char* arg1, char* arg2);
	void LOCK();	//TODO
	void LODSB();
	void LODSW();
	void LOOP(char* arg);
	void LOOPE(char* arg);
	void LOOPNE(char* arg);
	void LOOPNZ(char* arg);
	void LOOPZ(char* arg);
	void MOV(Operand* arg1, Operand* arg2);
	void MOVSB();
	void MOVSW();
	void MUL(char* arg);
	void NEG(char* arg);
	void NOP();
	void NOT(char* arg);
	void OR(char* arg1, char* arg2);
	void OUT(char* arg1, char* arg2);
	
	void POP(char* arg);
	void POPF();
	void PUSH(char* arg);
	void PUSHF();
	
	void RCL(char* arg1, char* arg2);
	void RCR(char* arg1, char* arg2);
	
	void REP(char* arg);
	void REPE(char* arg);
	void REPNE(char* arg);
	void REPNZ(char* arg);
	void REPZ(char* arg);
	
	
	void RET();
	void RETN();
	void RETF();
	
	void ROL(char* arg1, char* arg2);
	void ROR(char* arg1, char* arg2);
	
	void SAHF();
	void SAL(char* arg1, char* arg2);
	void SAR(char* arg1, char* arg2);
	
	void SBB(char* arg1, char* arg2);
	void SCASB();
	void SCASW();
	
	void SHL(char* arg1, char* arg2);
	void SHR(char* arg1, char* arg2);
	
	void STC();
	void STD();
	void STI();
	
	void STOSB();
	void STOSW();
	
	void SUB(char* arg1, char* arg2);
	void TEST(char* arg1, char* arg2);
	void WAIT();	// TODO
	void XCHG(char* arg1, char* arg2);
	void XLAT();	// TODO
	void XOR(char* arg1, char* arg2);
	
	int getValue(Operand* arg);
	int getRegistryValue(const char* arg);
	void setIP(int);
	
private:
	
	const static int WORD_BOUNDARY = 1<<16;
	const static int BYTE_BOUNDARY = 1<<8;
	
	const static int CARRY_FLAG 	= 1;
	const static int PARITY_FLAG 	= 1<<2;
	const static int AUX_CARRY_FLAG = 1<<4;
	const static int ZERO_FLAG 		= 1<<6;
	const static int SIGN_FLAG 		= 1<<7;
	const static int TRAP_FLAG 		= 1<<8;
	const static int INTERRUPT_FLAG = 1<<9;
	const static int DIRECTION_FLAG = 1<<10;
	const static int OVERFLOW_FLAG 	= 1<<11;
	
	// AX, BX, CX, DX
	int AH, AL, BH, BL, CH, CL, DH, DL;
	
	// SI, DI, BP, SP - 16 bit
	int SI;
	int DI;
	int BP;
	int SP;
	
	// CS, DS, ES, SS - 16 bit
	int CS;
	int DS;
	int ES;
	int SS;
	
	int flags;
	int IP;
	
	std::map<std::string,int>* labelMap;
	Stack* stack;
	Memory* memory;
	Logger* logger;
	
	// lista etykiet
	
	// struktura pamięci - http://www.cosc.brocku.ca/~bockusd/3p92/Local_Pages/8086_achitecture.htm
	
	void setValue(Operand* arg, int value);
	
	void setRegistryValue(const char* arg, int value);
	/*
	bool isByteRegistry(char* arg);
	bool isWordRegistry(char* arg);
	bool isValue(char* arg);
	bool isMemoryAddress(char* arg);
	bool isLabel(char* arg);
	*/
	
};

#endif
