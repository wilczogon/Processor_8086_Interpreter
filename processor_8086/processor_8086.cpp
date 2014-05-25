#include <string.h>


class Processor_8086{
public:
	
	Processor_8086(){
		AX = 0;
		BX = 0;
		CX = 0;
		DX = 0;
		
		SI = 0;
		DI = 0;
		BP = 0;
		SP = 0;
	
		IP = 0;
	
		CS = 0;
		DS = 0;
		ES = 0;
		SS = 0;
	
		flags = 0;
	
	}
	
	// lista instrukcji
	void AAA();
	void AAD();
	void AAM();
	void AAS();
	
	void ADC();
	void ADD();
	void AND();
	void CALL();
	void CBW();
	void CLC();
	void CLD();
	void CLI();
	void CMC();
	void CMP();
	void CMPSB();
	void CMPSW();
	void CWD();
	void DAA();
	void DAS();
	void DEC();
	void DIV();
	void ESC();
	void HLT();
	void IDIV();
	void IMUL();
	void IN();
	void INC();
	void INT();
	void INTO();
	void IRET();
	void Jcc();
	void JCXZ();
	void JMP();
	void LAHF();
	void LDS();
	void LEA();
	void LES();
	void LOCK();
	void LODSB();
	void LODSW();
	void LOOP();
	void LOOPx();
	void MOV(char* arg1, char* arg2){
		setValue(arg1, getValue(arg2));
	}
	void MOVSB();
	void MOVSW();
	void MUL();
	void NEG();
	void NOP();
	void NOT();
	void OR();
	void OUT();
	void POP();
	void POPF();
	void PUSH();
	void PUSHF();
	void RCL();
	void RCR();
	void REPxx();
	void RET();
	void RETN();
	void RETF();
	void ROL();
	void ROR();
	void SAHF();
	void SAL();
	void SAR();
	void SBB();
	void SCASB();
	void SCASW();
	void SHL();
	void SHR();
	void STC();
	void STD();
	void STI();
	void STOSB();
	void STOSW();
	void SUB();
	void TEST();
	void WAIT();
	void XCHG();
	void XLAT();
	void XOR();
	
private:
	
	const static int TOP_BOUNDARY = 65536; 
	
	// AX, BX, CX, DX
	int AX, BX, CX, DX;
	
	// SI, DI, BP, SP - 16 bit
	int SI, DI, BP, SP;
	
	int IP;
	
	// CS, DS, ES, SS - 16 bit
	int CS, DS, ES, SS;
	
	int flags;
	
	// stos
	
	// lista etykiet
	
	// struktura pamięci - http://www.cosc.brocku.ca/~bockusd/3p92/Local_Pages/8086_achitecture.htm
	
	int getValue(char* arg){
		if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "BX") == 0)
			return BX;
		else if(strcmp(arg, "CX") == 0)
			return CX;
		else if(strcmp(arg, "DX") == 0)
			return DX;
		/*else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;
		else if(strcmp(arg, "AX") == 0)
			return AX;*/
		else return 0;// w takim wypadku musisz policzyć wartosć wyrażenia
			
	}
	
	void setValue(char* arg, int value){
		if(strcmp(arg, "AX") == 0)
			AX = value % TOP_BOUNDARY;
		else if(strcmp(arg, "BX") == 0)
			BX = value % TOP_BOUNDARY;
		else if(strcmp(arg, "CX") == 0)
			CX = value % TOP_BOUNDARY;
		else if(strcmp(arg, "DX") == 0)
			DX = value % TOP_BOUNDARY;
	}
};
 
