#ifndef OPERAND
#define OPERAND

class Operand{
public:
	char* getExpression();
	Operand(char* expression);
	virtual ~Operand();

protected:
	char* expression;
};

#endif
