#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../headers/Message.hpp"

int Message::getType(){
	return type;
}

char* Message::getText(){
	return text;
}

Message::Message(char* text, int type){
	this->text = strdup(text);
	this->type = type;
}

Message::~Message(){
	delete text;
}
 
