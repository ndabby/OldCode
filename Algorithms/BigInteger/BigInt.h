//Nadine Dabby
//July 7, 2004
//
//BigInteger header file 




#ifndef MAIN_SAVITCH_BIGINT_H  
#define MAIN_SAVITCH_BIGINT_H

#include "Node.h"
#include <string>
//using namespace std;

#include <istream>
//using namespace std;

#include <ostream>		
using namespace std;

namespace main_savitch_5	//using the same namespace as the node class
{

	class BigInteger
	{
	public:
	BigInteger();			//default constructor
	BigInteger(string);		//string constructor
	BigInteger(const BigInteger&);	//copy constructor
	~BigInteger();			//destructor
	
	void operator =(const BigInteger&);		//overloaded = operator
	
	string toString();		//returns strnumber
 
	friend istream& operator >>(istream&, BigInteger&);				//overloaded >> operator
	friend ostream& operator <<(ostream&, /*const*/ BigInteger&);	//overloaded << operator


	//int myAtoi(string);    //this function is in reserve for part 2 of this assignment

	
	private:
	
	node * head_ptr;		//pointer to linked list
	int many_nodes;			//number of nodes
	string strnumber;		//integer in string format
	};
}

#endif