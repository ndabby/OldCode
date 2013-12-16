#include "qt.h"



queue::queue(int c){
	capacity = c;
	data = new node* [capacity];
	used = 0;
}


queue::~queue(){
	delete [] data;
}


node* queue::pop(){
	node* mynumber = data[0];
	data[0] = data[used-1];
	used--;
	int i = 0;
	node* temp;

	while ((2*i + 1) < used && (data[i]->freq > data[leftchild(i)]->freq || data[i]->freq > data[rightchild(i)]->freq)){
		if (data[leftchild(i)]->freq <= data[rightchild(i)]->freq){
			temp = data[i];
			data[i] = data[leftchild(i)];
			data[leftchild(i)] = temp;
			i = leftchild(i);
		}
		else if (data[leftchild(i)]->freq > data[rightchild(i)]->freq){
			temp = data[i];
			data[i] = data[rightchild(i)];
			data[rightchild(i)] = temp;
			i = rightchild(i);
		}
	
	}

	return mynumber;
}

void queue::push( node* entry){
	data[used] = entry;
	node* temp;
	int i = used;
	
	while (data[i]->freq < data[parent(i)]->freq){
		temp = data[i];
		data[i] = data[parent(i)];
		data[parent(i)] = temp;
		i = parent(i);
	}
	used++;	
}


bool queue::empty(){
	if (used == 0)
		return true;
	else return false;
}


int queue::size(){
	return used;
}


node* queue::top(){	
	return data[0];
}


int queue::leftchild(int i){	//given an index of an entry this will return the index of the child
	if (((2*i) + 1) < used){
		return ((2*i) + 1);
	}
	else return i;
}


int queue::rightchild(int i){  //given an index of an entry this will return the index of the child
	if (((2*i) + 2) < used){
		return ((2*i) + 2);
	}
	else return i;

}

int queue::parent(int i){  //given an index of an entry this will return the index of the parent
	if (i > 0){
		return ((i-1) / 2);
	}
	else return 0;
}