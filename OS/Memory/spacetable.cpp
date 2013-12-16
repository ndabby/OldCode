#include "spacetable.h"

/*
spacetable::spacetable(int x){					//constructor
	holes = 1;
	freesp = x;
	used = 1;
	meme init("hole", 0, x);
	meme* initial = &init;
	data[0] = initial;
};*/

spacetable::spacetable(){
	holes = 0;
	freesp = 0;
	used = 0;
}

		
void spacetable::sortme(){				//sorts array in order of smallest to largest
	meme* temp;
	if (used < 2){
		return;
	}
	for (int i = 0; i < (used - 1); i++){
		for (int j = 0; j < (used - 1 - i); j++){
			if (data[j]->getSize() > data[j + 1]->getSize()){
				temp = data[j];
				data[j] = data[j+1];
				data[j+1] = temp;
			}
		}
	}
};


meme* spacetable::pop(int x, int amount){				//removes an element at location x
	meme* me;
	me = data[x];
	int space = me->getSize() - amount;
	int nuBase = me->getBase() + amount;
	data[x] = data[used - 1];
	data.pop_back();
	used--;
	holes--;
	freesp = freesp - me->getSize();
	if (space > 0){
		meme* left = new meme("hole", nuBase, space);
		push(left);
	}
//	sortme();
	return me;
};


void spacetable::push(meme* me){			//adds an element
	data.push_back(me);
	used++;
	holes++;
	freesp = freesp + me->getSize();
	sortme();
};

/*
int spacetable::getLargest(){
	return data[used-1]->getSize();
};*/


int spacetable::getNextLargest(int x){
	int me = -1;
	int i = 0;
	while (i < used){
		if (data[i]->getSize() >= x){
			me = i;
			break;
		}
		else i++;
	}
	return me;
}

meme* spacetable::getData(int x){
	return data[x];
}


int spacetable::getUsed(){
	return used;
}

int spacetable::getHoles(){
	return holes;
}

int spacetable::getFree(){
	return freesp;
}

void spacetable::increaseFree(int x){
	freesp = freesp + x;
}

void spacetable::decreaseFree(int x){
	freesp = freesp - x;
}

void spacetable::emptyMe(){
	for (int i = 0; i < used; i++){
		delete data[i];
	}
	while (used > 0){
		data.pop_back();
		used--;
	}
	used = 0;
	holes = 0;
	freesp = 0;
}

void spacetable::printData(int i){
	std::cout << data[i]->getName() << " base: " << data[i]->getBase() << " limit: " 
		<< (data[i]->getBase() + data[i]->getSize() - 1 ) << " size: " << data[i]->getSize() << endl;
}



