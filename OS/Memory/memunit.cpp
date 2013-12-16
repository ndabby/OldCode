#include "memunit.h"

/*
memunit::memunit(int x){
	size = x;
	headPointer = NULL;
	tailPointer = NULL;
	meme* initial = new meme("hole", 0, x);  //fix dynamic allocation
	freeSpace.push(initial);
} */

memunit::memunit(){
	size = 0;
	headPointer = NULL;
	//tailPointer = NULL;
}

memunit::~memunit(){
	meme* cursor = headPointer;
	while (headPointer != NULL){
		headPointer = headPointer->link();
		delete cursor;
		cursor = headPointer;
	}
	freeSpace.emptyMe();
}


void memunit::addProcess(myfile* x){
	string nombre = myItoA(x->getPid());
	int local =	freeSpace.getNextLargest(x->getPhysSize());
	if (local >= 0){
		x->setPhysAddress( freeSpace.getData(local)->getBase());
		freeSpace.pop(local, x->getPhysSize());
		
		if (listLength() == 0 || (listLength() > 0 && x->getPhysAddress() < headPointer->getBase())){
			listHeadInsert(nombre, x->getPhysAddress(), x->getPhysSize());
//			tailPointer = headPointer;
		}
		else{ 
			meme* previous = listSearch(x->getPhysAddress());
			if (previous == NULL){
				listTailInsert(nombre, x->getPhysAddress(), x->getPhysSize());
			}
			else {listInsert(previous, nombre, x->getPhysAddress(), x->getPhysSize());
			}
		}
	}
}

void memunit::remProcess(myfile* x){
	meme* removed;
	if (x->getPhysAddress() == headPointer->getBase()){
		removed = listHeadRemove();
	}
	else {
		meme* previous = listLeaveSearch(x->getPhysAddress());
		removed = listRemove(previous);
	}
	removed->replace("hole", 0);
	freeSpace.push(removed);
	
}

/*

void memunit::compactifyLoad(myfile* x){
	string nombre = myItoA(x->getPid());
	if(x->getPhysSize() <= freeSpace.getFree()){
		meme* cursor = headPointer;
		meme* follow = cursor;
		cursor->setBase(0);
		cursor = cursor->link();
		while (cursor != NULL){
			cursor->setBase(follow->getBase() + follow->getSize() - 1);
			cursor = cursor->link();
			follow = follow->link();
		}
		int add = follow->getBase() + follow->getSize();
		int total = freeSpace.getFree();
		freeSpace.emptyMe(); 
		meme* consolidate = new meme("hole", add, total); 
		freeSpace.push(consolidate);         //need to consolidate it all here
		//x->setPhysAddress(add);
		//freeSpace.pop(0, x->getPhysSize());
		//meme* previous = listSearch(x->getPhysAddress());
		//listTailInsert(nombre, x->getPhysAddress(), x->getPhysSize());
	}
}

*/

void memunit::printSpace(int* counter){
	char n;
	std::cout << freeSpace.getHoles() << " fragments; Space available in order of size:" << endl;
	for (int i = 0; i < freeSpace.getUsed(); i++){
		freeSpace.printData(i);
		(*counter)++;
		if (*counter >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> n;
			*counter = 0;
		}
	}
}

void memunit::setSize(int s){		//for constructor
	size = s;
}


void memunit::pushSpace(meme* x){	//for constructor
	freeSpace.push(x);
}

int memunit::getNextFree(int x){
	int me = freeSpace.getNextLargest(x);
	return me;
}


int memunit::getRoom(){
	return freeSpace.getFree();
}

meme* memunit::getHead(){
	return headPointer;
}

void memunit::emptyFree(){
	freeSpace.emptyMe();
}

void memunit::pushFree(meme* x){
	freeSpace.push(x);
}



int memunit::listLength(){
	int len = 0;
	meme* curt = headPointer;
	while (curt != NULL){
		++len;
		curt = curt->link();
	}
	return len;
}

void memunit::listHeadInsert(string st, int b, int s){
	meme* me = new meme(st, b, s);
	if (headPointer == NULL){
		headPointer = me;
		headPointer->setLink(NULL);
	}
	else {
	me->setLink(headPointer->link());
	headPointer = me;
	}
}

void memunit::listInsert(meme* w, string st, int b, int s){
	meme* me = new meme(st, b, s);
	meme* point = w->link();
	me->setLink(point);
	w->setLink(me);
}

void memunit::listInsert(meme* w, string st, int b, int s, meme* p){
	meme* me = new meme(st, b, s, p);
	meme* point = w->link();
	me->setLink(point);
	w->setLink(me);
}


void memunit::listTailInsert(string st, int b, int s){
	meme* me = new meme(st, b, s);
	meme* cursor = headPointer;
	while (cursor->link() != NULL ){
		cursor = cursor->link();
	}
	cursor->setLink(me);
	//tailPointer = me;
} 

meme* memunit::listSearch(int base){
	meme* cursor = headPointer;
	meme* answer = NULL;
	while (cursor->link() != NULL){	
		if (base <= cursor->link()->getBase()){
			answer = cursor;
//			return answer;
		}
		cursor = cursor->link();
	}
	return answer;	
}

meme* memunit::listLeaveSearch(int base){
	meme* cursor = headPointer;
	meme* answer = NULL;
	while (cursor->link() != NULL){	
		if (base == cursor->link()->getBase()){
			answer = cursor;
//			return answer;
		}
		cursor = cursor->link();
	}
	return answer;	
}

/*
void memunit::listCopy(meme* source, meme* head, meme* tail){
	head = NULL;
	tail = NULL;
	meme* cursor;
	cursor = source;
	if (source == NULL){
		return;
	}
	else {
		head = new meme(source->getName(), source->getBase(), source->getSize(), source->link());
		while (cursor->link() != NULL){
			cursor = cursor->link();
			listInsert(head, cursor->getName(),cursor->getBase(),cursor->getSize(), cursor->link());
			tail = cursor;
		}
		return;
	}
}
*/
meme* memunit::listHeadRemove(){
	meme* me = headPointer;
	headPointer = headPointer->link();
	return me;
}

meme* memunit::listRemove(meme* previous){
	meme* me = previous->link();
	previous->setLink(me->link());
	return me;
}



string memunit::myItoA(int i){					//this function converts an integer to a string
	char th = 1/1000 + '0';
	char h = (i%1000)/100 + '0';
	char t = (i%100)/10 + '0';
	char o = i%10 + '0';
	string s = "";
	s = s + th;
	s = s+h;
	s = s+t;
	s = s+o;
	return s;
}


