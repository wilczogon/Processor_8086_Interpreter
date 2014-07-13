#ifndef NUMERIC_VALUE
#define NUMERIC_VALUE

class NumericValue{
public:
	NumericValue(char* expression, int value);
	~NumericValue();
	
	char* getExpression();
	int getValue();
	
private:
	char* expression;
	int value;
};

#endif