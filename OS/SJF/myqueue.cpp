//Nadine Dabby
//July 26, 2004
//
//queue implementation file


#include "myqueue.h"



myqueue::myqueue(){
	used = 0;
}



myfile* myqueue::pop(){				//pops an item off of the queue
	myfile* me = data[0];
	data[0] = data[used-1];
	data.pop_back();
	order[0] = order[used-1];
	order.pop_back();
	used--;
	int i = 0;
	myfile* tempfile;
	int temp;

	while ((2*i + 1) < used && (data[i]->getTremaining() > data[leftchild(i)]->getTremaining()) || 
		(data[i]->getTremaining() > data[rightchild(i)]->getTremaining())){
		if (data[leftchild(i)]->getTremaining() < data[rightchild(i)]->getTremaining()){
			tempfile = data[i];
			data[i] = data[leftchild(i)];
			data[leftchild(i)] = tempfile;
			temp = order[i];
			order[i] = order[leftchild(i)];
			order[leftchild(i)] = temp;
			i = leftchild(i);
		}
		else if (data[leftchild(i)]->getTremaining() > data[rightchild(i)]->getTremaining()){
			tempfile = data[i];
			data[i] = data[rightchild(i)];
			data[rightchild(i)] = tempfile;
			temp = order[i];
			order[i] = order[rightchild(i)];
			order[rightchild(i)] = temp;
			i = rightchild(i);
		}
		else if (data[leftchild(i)]->getTremaining() == data[rightchild(i)]->getTremaining()){
			if (order[leftchild(i)] < order[rightchild(i)]){
				tempfile = data[i];
				data[i] = data[leftchild(i)];
				data[leftchild(i)] = tempfile;
				temp = order[i];
				order[i] = order[leftchild(i)];
				order[leftchild(i)] = temp;
				i = leftchild(i);
			}
			else {
				tempfile = data[i];
				data[i] = data[rightchild(i)];
				data[rightchild(i)] = tempfile;
				temp = order[i];
				order[i] = order[rightchild(i)];
				order[rightchild(i)] = temp;
				i = rightchild(i);
			}
		}
	
	}

	return me;
}

void myqueue::push(myfile* entry){		//pushes an item onto the queue
	data.push_back(entry);
	order.push_back(used);
	int temp;
	myfile* tempfile;
	int i = used;
	
	while (data[i]->getTremaining() < data[parent(i)]->getTremaining()){
		tempfile = data[i];
		data[i] = data[parent(i)];
		data[parent(i)] = tempfile;
		temp = order[i];
		order[i] = order[parent(i)];
		order[parent(i)] = temp;
		i = parent(i);
	}
	used++;	
}


bool myqueue::empty(){				//tests is queue is empty, if so returns true
	if (used == 0)
		return true;
	else return false;
}


int myqueue::size(){				//returns number of elements in queue
	return used;
}


myfile* myqueue::top(){				//returns element on top of queue
	return data[0];
}

myfile* myqueue::getData(int x){	//returns data at any point in queue
	return data[x];
}


int myqueue::getOrder(int x){
	return order[x];
}


int myqueue::leftchild(int i){	//given an index of an entry this will return the index of the child
	if (((2*i) + 1) < used){
		return ((2*i) + 1);
	}
	else return i;
}


int myqueue::rightchild(int i){  //given an index of an entry this will return the index of the child
	if (((2*i) + 2) < used){
		return ((2*i) + 2);
	}
	else return i;

}

int myqueue::parent(int i){  //given an index of an entry this will return the index of the parent
	if (i > 0){
		return ((i-1) / 2);
	}
	else return 0;
}

void myqueue::operator =(myqueue &source){	//overloaded =
	for (int j=0; j<used; j++){
		data.pop_back();
		order.pop_back();
	}
	used = source.size();
	for (int i = 0; i < used; i ++){
		data.push_back(source.getData(i));
		order.push_back(source.getOrder(i));
	}
}
