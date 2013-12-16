//Nadine Dabby
//July 26, 2004
//
//Queue main program


#include "queue.h"

#include <iostream>
using std::cout;
using std::cin;
using std::endl;


int main(){
	
	queue myHeap(12);								         //test constructor

	int data[10] = {4, 1, 90, 99, 28, 17, 31, 38, 90, 91};
	

	cout << "I have entered an array of the following numbers: " << endl;

	for (int i = 0; i < 10; i++){
		cout << data[i] << " ";
	}

	cout << endl;

	

	cout << "I will now return them to you in the correct priority" << endl;
	
	for (int j = 0; j < 10; j++){							//test push
		myHeap.push(data[j]);
	}

	
	cout << "The highest priority item in the queue is: " << myHeap.top(); //test top & children
	cout << endl;
	cout << "The left child of this item is: " << myHeap.getData(myHeap.leftchild(0));
	cout << endl;
	cout << "The right child of this item is: " << myHeap.getData(myHeap.rightchild(0));
	cout << endl;
	cout << "The size of my queue is: " << myHeap.size() << endl;
	cout << "The capacity of my queue is: " << myHeap.getCapacity() << endl;

	while (myHeap.empty() == false){						//test pop
		cout << myHeap.pop() << " ";
	}
	


	return 0;
}