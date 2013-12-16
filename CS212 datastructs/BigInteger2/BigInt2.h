//Nadine Dabby
//July 13, 2004
//
//BigInteger2 header file 




#ifndef MAIN_SAVITCH_BIGINT2_H  
#define MAIN_SAVITCH_BIGINT2_H

#include "Node.h"

#include <string>
using namespace std;

#include <istream>
using namespace std;

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
	
	void operator =(const BigInteger&);										//overloaded = operator
	friend BigInteger operator +(const BigInteger b1, const BigInteger b2);	//overloaded + operator
	friend BigInteger operator -(const BigInteger b1, const BigInteger b2);	//overloaded - operator
	friend bool operator <(const BigInteger b1, const BigInteger b2);		//overloaded < operator
	friend bool operator >(const BigInteger b1, const BigInteger b2);		//overloaded > operator
	friend bool operator <=(const BigInteger b1, const BigInteger b2);		//overloaded <= operator
	friend bool operator >=(const BigInteger b1, const BigInteger b2);		//overloaded >= operator
	friend BigInteger operator *(const BigInteger& b1, const BigInteger& b2);//overloaded * operator
    friend BigInteger operator /(const BigInteger b1, const BigInteger b2);	//overloaded / operator	
	friend BigInteger div2(const BigInteger);			// dision by 2 (used in / implementation)
	
	friend string myItoA(int);			//converts an integer into a string representation
	friend void trimzero(string&);		//removes leading zeros from BigInteger


	string toString();		//returns strnumber
 
	friend istream& operator >>(istream&, BigInteger&);				//overloaded >> operator
	friend ostream& operator <<(ostream&, /*const*/ BigInteger&);	//overloaded << operator


	private:
	node * head_ptr;		//pointer to linked list
	int many_nodes;			//number of nodes
	string strnumber;		//integer in string format
	};
}

#endif