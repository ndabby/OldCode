//Nadine Dabby
//CS 340
//Oct. 11, 2004
//
//file object header file
//
//The file class has four main components: an enumerated type (read or write), a string name,
//a string address, and an unsigned integer length.
//The four public functions allow for this data to be retrieved.

#include <string>
using std::string;


#ifndef MYFILE_H
#define MYFILE_H

class myfile{
public:
	myfile(string, string, string, unsigned int = 0);
	string getType();				//returns type
	string getName();				//returns name
	string getAddress();			//returns address
	unsigned int getLength();		//returns length

private:
	string type;
	string name;
	string address;
	unsigned int length;
	enum ttype {read, write};
};

#endif
