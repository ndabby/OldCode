//Nadine Dabby
//Nov 8, 2004
//
//this is the scheduler header file -- it is implemented as a min priority queue

#include "myfile.h"
#include <vector>
using namespace std;



#ifndef LONGTERM_H
#define LONGTERM_H


class longterm{
	public:
		longterm();		//constructor
		void sortme();	//sorts array in order of smallest to largest
		myfile* pop(int);	//removes an element
		void push(myfile*);	//adds an element
		int getLargest();		// gets size of largest element in pool
		int getNextLargest(int); //gets location of next largest when given a size >= to its size
//		int searchNext(int);	//finds location of next element it can replace

		bool isEmpty();
		int getUsed();
		myfile* getData(int);
		void operator =( longterm&);	//overloaded =



	private:
		int used;				//number of elements in vector
		vector<myfile*> data;	//vector of pointer to files	

};


#endif