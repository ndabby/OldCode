//Nadine Dabby
//
//
//long term scheduler implementation file


#include "LongTerm.h"



longterm::longterm(){					//constructor
	used = 0;
};
		
void longterm::sortme(){				//sorts array in order of smallest to largest
	myfile* temp;
	for (int i = 0; i < (used - 1); i++){
		for (int j = 0; j < (used - 1 - i); j++){
			if (data[j]->getPhysSize() > data[j + 1]->getPhysSize()){
				temp = data[j];
				data[j] = data[j+1];
				data[j+1] = temp;
			}
		}
	}
};


myfile* longterm::pop(int x){				//removes an element at location x
	myfile* me;
	me = data[x];
	data[x] = data[used - 1];
	data.pop_back();
	used--;
	sortme();
	return me;
};


void longterm::push(myfile* me){			//adds an element
	data.push_back(me);
	used++;
	sortme();
};


int longterm::getLargest(){
	return data[used-1]->getPhysSize();
};


int longterm::getNextLargest(int x){
	int me = -1;
	int i = used - 1;
	while (i >= 0){
		if (data[i]->getPhysSize() <= x){
			me = i;
			break;
		}
		else i--;
	}
	return me;
}

	
/*int longterm::searchNext(int x){			//finds next element it can replace when given size of biggest hole

};
*/

bool longterm::isEmpty(){
	if (used == 0){
		return true;
	}
	else return false;
}

int longterm::getUsed(){
	return used;
}

myfile* longterm::getData(int i){
	return data[i];
}

void longterm::operator =(longterm &source){	//overloaded =
	for (int j=0; j<used; j++){
		data.pop_back();
	}
	used = source.getUsed();
	for (int i = 0; i < used; i ++){
		data.push_back(source.getData(i));
	}
}
