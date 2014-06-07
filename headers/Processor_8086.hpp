class Processor_8086{
public:
	
	//Processor_8086();
	
	// lista instrukcji
	void AAA();
	void AAD();
	void AAM();
	void AAS();
	
	void ADC(char* arg1, char* arg2);
	void ADD(char* arg1, char* arg2);
	void AND(char* arg1, char* arg2);
	void CALL(char* arg);
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
	void JA(char* arg);
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
	void LOOPNE(char* arg);
	void LOOPZ(char* arg);
	void MOV(char* arg1, char* arg2);
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
	
	
};
