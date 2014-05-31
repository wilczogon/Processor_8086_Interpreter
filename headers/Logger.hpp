#ifndef LOGGER
#define LOGGER

#include "Message.hpp"

class Logger{
public:
	void log(Message* message);
	void flush();
	int getNumberOfMessages();
	Message** getListOfMessages();
	Logger(char* fileName);
	~Logger();
	
private:
	Message** messages;
	int messagesNo;
	char* fileName;
};

#endif
