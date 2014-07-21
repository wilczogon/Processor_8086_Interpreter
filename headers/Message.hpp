#ifndef MESSAGE
#define MESSAGE

enum MessageType{
	NOTIFICATION = 0,
	WARNING,
	ERROR
};

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
