//Nadine Dabby
//Nov 8, 2004
//
//this is the scheduler header file -- it is implemented as a min priority queue

#include "myfile.h"
#include <vector>
using namespace std;



#ifndef MYQUEUE_H
#define MYQUEUE_H


class myqueue{
	public:
		myqueue();					//constructor
		myfile* pop();				//pops top item off
		void push(myfile*);			//pushes an item onto the queue
		bool empty();				//tests if empty
		int size();					//returns number of elements in queue
		myfile* top();				//returns copy of what is on top
		myfile* getData(int i);		//returns data at any point
		int getOrder(int i);

		int leftchild(int);			//returns left child
		int rightchild(int);		//returns right child
		int parent(int);			//returns parent

		void operator =( myqueue&);	//overloaded =

	private:
		int used;				//number of elements in tree
		vector<myfile*> data;	//vector of elements	
		vector<int> order;		
		

};


#endif