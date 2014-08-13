%option noyywrap

%{
#include "../headers/InstructionReader.hpp"

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
registry		ax|bx|cx|dx|si|di
half_registry	al|bl|cl|dl|ah|bh|ch|dh
address			bx|si|di|[:digit:]+|label
nvalue			[:digit:]+
value			\'[':alnum:]+\'

%%

{label}[ /t]+":"[ /t/n]+	{
								//marker
								currentInstructionReader->addLabel(yytext);
							}

%%

#include <stdio.h>
#include <stdlib.h>
#include "../headers/InstructionReader.hpp"
#include "../headers/Instruction.hpp"


Instruction** InstructionReader::getListOfInstructions(){
	Instruction** instructions = (Instruction**)malloc(2*sizeof(Instruction*));
	copy(instructionList->begin(),instructionList->end(),*instructions);;
	return instructions;
}

int InstructionReader::getNumberOfInstructions(){
	return InstructionReader::instructionList->size();
}

void InstructionReader::readInstructions(){
	instructionCounter = 0;
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