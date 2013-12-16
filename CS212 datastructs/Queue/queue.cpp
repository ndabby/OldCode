//Nadine Dabby
//July 26, 2004
//
//queue implementation file


#include "queue.h"



queue::queue(int c){
	capacity = c;
	data = new int [capacity];
	order = new int [capacity];
	used = 0;
}


queue::~queue(){
	delete [] data;
	delete [] order;
}


int queue::pop(){
	int mynumber = data[0];
	data[0] = data[used-1];
	used--;
	int i = 0;
	int temp;

	while ((2*i + 1) < used && (data[i] < data[leftchild(i)] || data[i] < data[rightchild(i)])){
		if (data[leftchild(i)] > data[rightchild(i)]){
			temp = data[i];
			data[i] = data[leftchild(i)];
			data[leftchild(i)] = temp;
			temp = order[i];
			order[i] = order[leftchild(i)];
			order[leftchild(i)] = temp;
			i = leftchild(i);
		}
		else if (data[leftchild(i)] < data[rightchild(i)]){
			temp = data[i];
			data[i] = data[rightchild(i)];
			data[rightchild(i)] = temp;
			temp = order[i];
			order[i] = order[rightchild(i)];
			order[rightchild(i)] = temp;
			i = rightchild(i);
		}
		else if (data[leftchild(i)] == data[rightchild(i)]){
			if (order[leftchild(i)] > order[rightchild(i)]){
				temp = data[i];
				data[i] = data[leftchild(i)];
				data[leftchild(i)] = temp;
				temp = order[i];
				order[i] = order[leftchild(i)];
				order[leftchild(i)] = temp;
				i = leftchild(i);
			}
			else {
			temp = data[i];
			data[i] = data[rightchild(i)];
			data[rightchild(i)] = temp;
			temp = order[i];
			order[i] = order[rightchild(i)];
			order[rightchild(i)] = temp;
			i = rightchild(i);
			}
		}
	
	}

	return mynumber;
}

void queue::push(const int& entry){
	if (used >= (capacity/2)){
		capacity = 2 * capacity;
	}

	data[used] = entry;
	order[used] = used;
	int temp;
	int i = used;
	
	while (data[i] > data[parent(i)]){
		temp = data[i];
		data[i] = data[parent(i)];
		data[parent(i)] = temp;
		temp = order[i];
		order[i] = order[parent(i)];
		order[parent(i)] = temp;
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


int queue::top(){	
	return data[0];
}


int queue::getData(int i){
	return data[i];
}

int queue::getCapacity(){
	return capacity;
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