%option noyywrap

%{
#include "../headers/InstructionReader.hpp"
	
static inline bool isWhiteSpace(char* ptr){
	return *ptr == ' ' || *ptr == '\t' || *ptr == ',' || *ptr == 0;
}
	
static inline char* extractArgument(char* lineptr, int argnr){
	const char* temp = lineptr;
	int len;
	int ii, cc;
	for(ii = 0; ii < argnr; ii++){
		while(isWhiteSpace(lineptr+cc))
			cc++;
		temp = lineptr+cc;
		while(!isWhiteSpace(lineptr+cc)){
			if(*(lineptr+cc) == '['){
				while(*(lineptr+cc) != ']')
					cc++;
			}
			cc++;
		}
		len = (lineptr+cc) - temp;
	}
	char* result = (char*) malloc(sizeof(char) * len);
	strncpy(result,temp,len);
	return result;
}

InstructionReader* currentInstructionReader;
int instructionCounter;
%}

AAA			"AAA"|"aaa"
AAD			"AAD"|"aad"
AAM			"AAM"|"aam"
AAS			"AAS"|"aas"
ADC			"ADC"|"adc"
ADD			"ADD"|"add"
AND			"AND"|"and"
CALL		"CALL"|"call"
CBW			"CBW"|"cbw"
CLC			"CLC"|"clc"
CLD			"CLD"|"cld"
CLI			"CLI"|"cli"
CMC			"CMC"|"cmc"
CMP			"CMP"|"cmp"

CMPSB		"CMPSB"|"cmpsb"
CMPSW		"CMPSW"|"cmpsw"
CWD			"CWD"|"cwd"
DAA			"DAA"|"daa"
DAS			"DAS"|"das"
DEC			"DEC"|"dec"
DIV			"DIV"|"div"
HLT			"HLT"|"hlt"
IDIV		"IDIV"|"idiv"
IMUL		"IMUL"|"imul"
IN			"IN"|"in"
INC			"INC"|"inc"
INT			"INT"|"int"
INTO		"INTO"|"into"
IRET		"IRET"|"iret"
JA			"JA"|"ja"

JAE			"JAE"|"jae"
JB			"JB"|"jb"
JBE			"JBE"|"jbe"
JC			"JC"|"jc"
JCXZ		"JCXZ"|"jcxz"
JE			"JE"|"je"
JG			"JG"|"jg"
JGE			"JGE"|"jge"
JL			"JL"|"jl"
JLE			"JLE"|"jle"
JMP			"JMP"|"jmp"
JNA			"JNA"|"jna"
JNAE		"JNAE"|"jnae"
JNB			"JNB"|"jnb"

JNBE		"JNBE"|"jnbe"
JNC			"JNC"|"jnc"
JNE			"JNE"|"jne"
JNG			"JNG"|"jng"
JNGE		"JNGE"|"jnge"
JNL			"JNL"|"jnl"
JNLE		"JNLE"|"jnle"
JNO			"JNO"|"jno"
JNP			"JNP"|"jnp"
JNS			"JNS"|"jns"
JNZ			"JNZ"|"jnz"
JO			"JO"|"jo"
JP			"JP"|"jp"
JPE			"JPE"|"jpe"

JPO			"JPO"|"jpo"
JS			"JS"|"js"
JZ			"JZ"|"jz"
LAHF		"LAHF"|"lahf"
LDS			"LDS"|"lds"
LEA			"LEA"|"lea"
LES			"LES"|"les"
LODSB		"LODSB"|"lodsb"
LODSW		"LODSW"|"lodsw"
LOOP		"LOOP"|"loop"
LOOPE		"LOOPE"|"loope"
LOOPNE		"LOOPNE"|"loopne"
LOOPNZ		"LOOPNZ"|"loopnz"
LOOPZ		"LOOPZ"|"loopz"

MOV			"MOV"|"mov"
MOVSB		"MOVSB"|"movsb"
MOVSW		"MOVSW"|"movsw"
MUL			"MUL"|"mul"
NEG			"NEG"|"neg"
NOP			"NOP"|"nop"
NOT			"NOT"|"not"
OR			"OR"|"or"
OUT			"OUT"|"out"
POP			"POP"|"pop"
POPA		"POPA"|"popa"
POPF		"POPF"|"popf"
PUSH		"PUSH"|"push"
PUSHA		"PUSHA"|"pusha"
PUSHF		"PUSHF"|"pushf"
RCL			"RCL"|"rcl"

RCR			"RCR"|"rcr"
REP			"REP"|"rep"
REPE		"REPE"|"repe"
REPNE		"REPNE"|"repne"
REPNZ		"REPNZ"|"repnz"
REPZ		"REPZ"|"repz"
RET			"RET"|"ret"
RETF		"RETF"|"retf"
ROL			"ROL"|"rol"
ROR			"ROR"|"ror"
SAHF		"SAHF"|"sahf"
SAL			"SAL"|"sal"
SAR			"SAR"|"sar"
SBB			"SBB"|"sbb"

SCASB		"SCASB"|"scasb"
SCASW		"SCASW"|"scasw"
SHL			"SHL"|"shl"
SHR			"SHR"|"shr"
STC			"STC"|"stc"
STD			"STD"|"std"
STI			"STI"|"sti"
STOSB		"STOSB"|"stosb"
STOSW		"STOSW"|"stosw"
SUB			"SUB"|"sub"
TEST		"TEST"|"test"
XCHG		"XCHG"|"xchg"
XLATB		"XLATB"|"xlatb"
XOR			"XOR"|"xor"

label			[:alnum:]+
SREG			{DS}|{ES}|{SS}|{CS}
REG				{AX}|{BX}|{CX}|{DX}|{SI}|{DI}|{AL}|{BL}|{CL}|{DL}|{AH}|{BH}|{CH}|{DH}
memory			"["({BX}|{SI}|{DI}|{immediate})([ /t]*("+"|"-")[ /t]*({BX}|{SI}|{DI}|{immediate}))*"]"|label
address			{memory}
immediate		([:digit:]+|[:digit:A-Fa-f]+"h"|[01]+"b")([ /t]*"+"[ /t]*([:digit:]+|[:digit:A-Fa-f]+"h"|[01]+"b"))*
value			\'[:alnum:]+\'

AX			"AX"|"ax"
BX			"BX"|"bx"
CX			"CX"|"cx"
DX			"DX"|"dx"
SI			"SI"|"si"
DI			"DI"|"di"
AL			"AL"|"al"
BL			"BL"|"bl"
CL			"CL"|"cl"
DL			"DL"|"dl"
AH			"AH"|"ah"
BH			"BH"|"bh"
CH			"CH"|"ch"
DH			"DH"|"dh"
DS			"DS"|"ds"
ES			"ES"|"es"
SS			"SS"|"ss"
CS			"CS"|"cs"

%%



"end"[ /t]+{label}[ /t/n]+			{
	
}

";"[\^\n]*"/n"	{
	
}

{label}[ /t]+":"[ /t/n]+	{
								//marker
								currentInstructionReader->addLabel(yytext);
							}

{AAA}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AAA");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AAD}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AAD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AAM}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AAM");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AAS}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AAS");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADC}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADC}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADC}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADC}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADC}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADD}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADD}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADD}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADD}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ADD}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ADD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AND}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AND");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AND}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AND");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AND}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AND");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AND}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AND");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{AND}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"AND");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CALL}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"CALL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CALL}[ /t]+{address}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"CALL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CBW}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CBW");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CLC}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CLC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CLD}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CLD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CLI}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CLI");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMC}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CMC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMP}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CMP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMP}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CMP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMP}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CMP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMP}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CMP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMP}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CMP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMPSB}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"CMPSB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CMPSW}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"CMPSW");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{CWD}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"CWD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{DAA}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"DAA");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{DAS}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"DAS");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{DEC}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"DEC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{DEC}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"DEC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{DIV}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"DIV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{DIV}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"DIV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{HLT}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"HLT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IDIV}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"IDIV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IDIV}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"IDIV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IMUL}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"IMUL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IMUL}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"IMUL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IN}[ /t]+{AL}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"IN");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IN}[ /t]+{AL}[ /t]*","[ /t]*{DX}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"IN");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IN}[ /t]+{AX}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"IN");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IN}[ /t]+{AX}[ /t]*","[ /t]*{DX}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"IN");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{INC}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"INC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{INC}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"INC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{INT}[ /t]+{immediate}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new NumericValue(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"INT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{INTO}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"INTO");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{IRET}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"IRET");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JA}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JA");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JAE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JAE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JB}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JBE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JBE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JC}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JCXZ}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"JCXZ");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JG}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JG");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JGE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JGE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JL}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JLE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JLE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JMP}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JMP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNA}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNA");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNAE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"JNAE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNB}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNBE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"JNBE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNC}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNG}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNG");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNGE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"JNGE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNL}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNLE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"JNLE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNO}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNO");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNP}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNS}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNS");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JNZ}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JNZ");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JO}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JO");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JP}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JPE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JPE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JPO}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"JPO");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JS}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JS");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{JZ}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"JZ");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LAHF}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"LAHF");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LDS}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"LDS");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LEA}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"LEA");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LES}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"LES");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LODSB}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"LODSB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LODSW}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"LODSW");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LOOP}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"LOOP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LOOPE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"LOOPE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LOOPNE}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(6 * sizeof(char));
											strcpy(instrString,"LOOPNE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LOOPNZ}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(6 * sizeof(char));
											strcpy(instrString,"LOOPNZ");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{LOOPZ}[ /t]+{label}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"LOOPZ");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{SREG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{memory}[ /t]*","[ /t]*{SREG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{REG}[ /t]*","[ /t]*{SREG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOV}[ /t]+{SREG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MOV");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOVSB}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"MOVSB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MOVSW}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"MOVSW");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MUL}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MUL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{MUL}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"MUL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{NEG}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"NEG");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{NEG}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"NEG");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{NOP}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"NOP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{NOT}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"NOT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{NOT}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"NOT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OR}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"OR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OR}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"OR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OR}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"OR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OR}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"OR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OR}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(2 * sizeof(char));
											strcpy(instrString,"OR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OUT}[ /t]+{immediate}[ /t]*","[ /t]*{AL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new NumericValue(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"OUT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OUT}[ /t]+{immediate}[ /t]*","[ /t]*{AX}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new NumericValue(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"OUT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OUT}[ /t]+{DX}[ /t]*","[ /t]*{AL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"OUT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{OUT}[ /t]+{DX}[ /t]*","[ /t]*{AX}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"OUT");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{POP}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"POP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{POP}[ /t]+{SREG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"POP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{POP}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"POP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{POPA}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"POPA");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{POPF}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"POPF");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{PUSH}[ /t]+{REG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"PUSH");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{PUSH}[ /t]+{SREG}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"PUSH");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{PUSH}[ /t]+{memory}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"PUSH");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{PUSH}[ /t]+{immediate}	{
											Operand** args = (Operand**) malloc(1 * sizeof(Operand*));
											args[0] = new NumericValue(extractArgument(yytext,1));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"PUSH");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,1,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{PUSHA}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"PUSHA");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{PUSHF}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"PUSHF");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCL}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCL}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCL}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCL}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCR}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCR}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCR}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RCR}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RCR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{REP}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"REP");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{REPE}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"REPE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{REPNE}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"REPNE");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{REPNZ}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"REPNZ");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{REPZ}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"REPZ");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RET}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"RET");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{RETF}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"RETF");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROL}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROL}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROL}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROL}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROR}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROR}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROR}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{ROR}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"ROR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAHF}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"SAHF");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAL}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAL}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAL}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAL}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAR}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAR}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAR}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SAR}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SAR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SBB}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SBB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SBB}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SBB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SBB}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SBB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SBB}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SBB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SBB}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SBB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SCASB}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"SCASB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SCASW}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"SCASW");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHL}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHL}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHL}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHL}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHL");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHR}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHR}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHR}[ /t]+{memory}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SHR}[ /t]+{REG}[ /t]*","[ /t]*{CL}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SHR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{STC}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"STC");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{STD}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"STD");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{STI}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"STI");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{STOSB}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"STOSB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{STOSW}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"STOSW");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SUB}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SUB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SUB}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SUB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SUB}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SUB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SUB}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SUB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{SUB}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"SUB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{TEST}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"TEST");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{TEST}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"TEST");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{TEST}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"TEST");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{TEST}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"TEST");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{TEST}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"TEST");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XCHG}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"XCHG");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XCHG}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"XCHG");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XCHG}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(4 * sizeof(char));
											strcpy(instrString,"XCHG");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XLATB}	{
											Operand** args = NULL;
											
											char* instrString = (char *) malloc(5 * sizeof(char));
											strcpy(instrString,"XLATB");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,0,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XOR}[ /t]+{REG}[ /t]*","[ /t]*{memory}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new MemoryAddress(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"XOR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XOR}[ /t]+{memory}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"XOR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XOR}[ /t]+{REG}[ /t]*","[ /t]*{REG}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new Registry(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"XOR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XOR}[ /t]+{memory}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new MemoryAddress(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"XOR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}

{XOR}[ /t]+{REG}[ /t]*","[ /t]*{immediate}	{
											Operand** args = (Operand**) malloc(2 * sizeof(Operand*));
											args[0] = new Registry(extractArgument(yytext,1));
											args[1] = new NumericValue(extractArgument(yytext,2));
											
											char* instrString = (char *) malloc(3 * sizeof(char));
											strcpy(instrString,"XOR");
											Instruction* instruction = new Instruction(instrString,instructionCounter++,2,args);
											
											currentInstructionReader->addInstruction(instruction);
										}


%%
//todo
#include <stdio.h>
#include <stdlib.h>
#include <iterator>
#include "../headers/InstructionReader.hpp"
#include "../headers/Instruction.hpp"


Instruction** InstructionReader::getListOfInstructions(){
	Instruction** instructions = (Instruction**)malloc(instructionList->size()*sizeof(Instruction*));
	//copy(instructionList->begin(),instructionList->end(), *instructions);
	int i = 0;
	for (list<Instruction>::iterator it=instructionList->begin(); it!=instructionList->end(); it++){
	  instructions[i] = &(*it);
	  ++i;
	 }
	
	return instructions;
}

int InstructionReader::getNumberOfInstructions(){
	return InstructionReader::instructionList->size();
}

void InstructionReader::readInstructions(){
	instructionCounter = 0;
	currentInstructionReader = this;
	yylex();
}

void InstructionReader::addInstruction(Instruction* instruction){
	instructionList->push_back(*instruction);
}

void InstructionReader::addLabel(char* text){
	string* temp = new string(text);
	InstructionReader::labelList->push_back(*temp);
	delete temp;
	InstructionReader::labelAddressList->push_back(instructionCounter);
	
	//labelMap->insert( std::pair<string,int>(*(new string(text)),instructionCounter) );
}

InstructionReader::InstructionReader(char* fileName, Logger* logger){
	InstructionReader::logger = logger;
	InstructionReader::instructionList = new list<Instruction>();
	InstructionReader::labelList = new list<string>();
	InstructionReader::labelAddressList = new list<int>();
	yyin = fopen( fileName, "r" );
}