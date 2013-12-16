#include <vector>
#include "meme.h"
#include <iostream>

using namespace std;

#ifndef SPACETABLE_H
#define SPACETABLE_H

class spacetable{
	public:
//		spacetable(int);		//constructor
		spacetable();
		void sortme();	//sorts array in order of smallest to largest
		meme* pop(int, int);	//removes an element
		void push(meme*);	//adds an element
//		int getLargest();		// gets size of largest element in pool
		int getNextLargest(int); //gets location of next largest when given a size <= to its size
		
		meme* getData(int);
		int getUsed();
		int getHoles();
		int getFree();
		void increaseFree(int);
		void decreaseFree(int);

		void emptyMe();

		void printData(int);

	private:
		vector<meme*> data;	//vector of pointer to files	
		int holes;				
		int freesp;
		int used;		//number of elements in vector
};



#endif