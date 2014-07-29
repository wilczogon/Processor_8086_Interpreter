#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include "../headers/Logger.hpp"
#include "../headers/Message.hpp"

void Logger::log(Message* message){
	int fd = open(fileName, O_CREAT | O_APPEND | O_RDWR, 0777);
	
	if(message->getType() == NOTIFICATION)
		write(fd, "NOTIFICATION : ", strlen("NOTIFICATION : "));
	else if(message->getType() == WARNING)
		write(fd, "WARNING      : ", strlen("WARNING      : "));
	else if(message->getType() == ERROR)
		write(fd, "ERROR        : ", strlen("ERROR        : "));
	
	write(fd, message->getText(), strlen(message->getText()));
	write(fd, "\n", 1);
	
	close(fd);
	
	if(messagesNo >= 99)
		return;
	
	messages[messagesNo] = message;
	
	++messagesNo;
}

void Logger::flush(){
	int i;
	for(i = 0; i < messagesNo; ++i)
		delete messages[i];
	messagesNo = 0;
}

int Logger::getNumberOfMessages(){
	return messagesNo;
}

Message** Logger::getListOfMessages(){
	return messages;
}

Logger::Logger(char* fileName){
	messagesNo = 0;
	this->fileName = strdup(fileName);
	messages = (Message**)malloc(100*sizeof(Message*));
}

Logger::~Logger(){
	flush();
	free(fileName);
	free(messages);
}
