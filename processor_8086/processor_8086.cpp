#include <string.h>

//	http://www.electronics.dit.ie/staff/tscarff/8086_instruction_set/8086_instruction_set.html


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
	
	void ADC(char* arg1, char* arg2){
		if(getValue(arg1) + getValue(arg2)/TOP_BOUNDARY > 0)
			STC();
		ADD(arg1, arg2);
	}
	void ADD(char* arg1, char* arg2){
		setValue(arg1, getValue(arg1) + getValue(arg2));
	}
	void AND(char* arg1, char* arg2){
		setValue(arg1, getValue(arg1) & getValue(arg2));
	}
	void CALL();
	void CBW();
	void CLC(){
		flags = (flags & ~CARRY_FLAG);
	}
	void CLD(){
		flags = (flags & ~DIRECTION_FLAG);
	}
	void CLI(){
		flags = (flags & ~INTERRUPT_FLAG);
	}
	void CMC(){
		if(flags & CARRY_FLAG)
			CLC();
		else
			STC();
	}
	void CMP(char* arg1, char* arg2){
		int result = getValue(arg1) - getValue(arg2);
		
		if(result == 0)
			flags = flags | ZERO_FLAG;
		//else if(result > 0) TODO
			
	}
	void CMPSB();
	void CMPSW();
	void CWD();
	void DAA();
	void DAS();
	void DEC();
	void DIV(char* arg){
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
	void ESC();
	void HLT();
	void IDIV();
	void IMUL();
	void IN();
	void INC(char* arg){
		setValue(getValue(arg)+1);
	}
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
	void STC(){
		flags = flags | CARRY_FLAG;
	}
	void STD(){
		flags = flags | DIRECTION_FLAG;
	}
	void STI(){
		flags = flags | INTERRUPT_FLAG;
	}
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
	
	bool isByteRegistry(char* arg){
		if(strcmp(arg, "AL") == 0)
			return 1;
		else if(strcmp(arg, "BL") == 0)
			return 1;
		else if(strcmp(arg, "CL") == 0)
			return 1;
		else if(strcmp(arg, "DL") == 0)
			return 1;
		else if(strcmp(arg, "AH") == 0)
			return 1;
		else if(strcmp(arg, "BH") == 0)
			return 1;
		else if(strcmp(arg, "CH") == 0)
			return 1;
		else if(strcmp(arg, "DH") == 0)
			return 1;
		else
			return 0;
	}
	
	bool isWordRegistry(char* arg){
		if(strcmp(arg, "AX") == 0)
			return 1;
		else if(strcmp(arg, "BX") == 0)
			return 1;
		else if(strcmp(arg, "CX") == 0)
			return 1;
		else if(strcmp(arg, "DX") == 0)
			return 1;
		else
			return 0;
	}
};
 
