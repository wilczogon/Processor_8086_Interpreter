#ifndef OPERAND
#define OPERAND

class Operand{
public:
	char* getExpression();
	Operand(char* expression);
	~Operand();

private:
	char* expression;
};

#endif
