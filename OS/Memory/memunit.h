//
//
//
//
// This memory unit object contains a table to keep track of free space and a 
// linked list of mem chunks.
//
//


#include "spacetable.h"
#include "myfile.h"


#ifndef MEMUNIT_H
#define MEMUNIT_H


class memunit{
	public:
	//	memunit(int);
		memunit();
		~memunit();

		void addProcess(myfile*);
		void remProcess(myfile*);
	//	void compactifyLoad(myfile*);

		void printSpace(int*);
		void setSize(int);
		void pushSpace(meme*);
		int getNextFree(int);
		int getRoom();
		meme* getHead();
		void emptyFree();
		void pushFree(meme*);

		int listLength();
		void listHeadInsert(string, int, int); //inserts new mem at head of list
		void listInsert(meme*, string, int, int);//inserts new mem after mem pointed to
		void listInsert(meme*, string, int, int, meme*);
		void listTailInsert(string, int, int);
		meme* listSearch(int);			//finds a base
		meme* listLeaveSearch(int);
	//	void listCopy(meme*, meme*, meme*);
		meme* listHeadRemove();
		meme* listRemove(meme*);
		
		string myItoA(int);


	private:
		spacetable freeSpace;
		meme* headPointer;
//		meme* tailPointer;
		int size;

};


#endif