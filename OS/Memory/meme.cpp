#include "meme.h"

meme::meme(string n, int b, int s, meme* x){
	name = n;
	base = b;
	memUsed = s;
	size = s;
	link_field = x;
};
meme::meme(meme* P){				//only for function moving
	name = "hole";
	base = 0;
	memUsed = 0;
	size = 0;
	link_field = P;
}

string meme::getName(){
	return name;
};

int meme::getBase(){
	return base;
};

int meme::getMemUsed(){
	return memUsed;
};

int meme::getSize(){
	return size;
};

void meme::replace(string s, int x){
	name = s;
	memUsed = x;
};

/*void meme::ConsolidateWith(meme& me){
	size = size + me.getSize();	
};

meme* meme::eliminateExcess(){
	meme* leftover = new meme();
	leftover->size = size - memUsed;
	leftover->base = base + memUsed + 1;
	leftover->memUsed = 0;
	
	size = memUsed;
	return leftover;
}; */

void meme::setBase(int b){
	base = b;
}

void meme::setLink(meme* P){
	link_field = P;
};

meme* meme::link(){
	return link_field;
};

void meme::operator =( meme& source){			//overloaded =
	name = source.getName();
	base = source.getBase();
	memUsed = source.getMemUsed();
	size = source.getSize();
};