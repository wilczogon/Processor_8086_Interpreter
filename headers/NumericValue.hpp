#ifndef NUMERIC_VALUE
#define NUMERIC_VALUE

class NumericValue: public Operand{
public:
	NumericValue(char* expression);
	int getValue();
	
private:
	int value;
};

#endif
