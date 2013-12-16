#include <string>
using namespace std;

#ifndef MEME_H
#define MEME_H


class meme{
	public:
		meme(string, int, int, meme* = NULL);
		meme(meme* = NULL);
		string getName();
		int getBase();
		int getMemUsed();
		int getSize();
		void replace(string, int);
	//	void ConsolidateWith(meme&);
	//	meme* eliminateExcess();

		void setBase(int);
		void setLink(meme*);
		meme* link();

		void operator =(meme&);			//overloaded =

	private:
		string name;
		int base;
		int memUsed;
		int size;
		meme* link_field;


};


#endif