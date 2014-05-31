#ifndef MESSAGE
#define MESSAGE

const int NOTIFICATION = 0;
const int WARNING = 1;
const int ERROR = 2;

class Message{
public:
	int getType();
	char* getText();
	Message(char* text, int type);
	~Message();

private:
	int type;
	char* text;
};

#endif
