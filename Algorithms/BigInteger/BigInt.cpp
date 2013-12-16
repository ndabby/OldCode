//Nadine Dabby
//July 7, 2004
//
//BigInteger implementation file 




#include "BigInt.h"
#include <math.h>  //contains ceil function



namespace main_savitch_5
{	
	
	BigInteger::BigInteger()		//default constructor, so that I can 
	{head_ptr = NULL;				//declare an empty linked list
	many_nodes = 0;
	strnumber = "";
	}
	
	
	BigInteger::BigInteger(string input)	//this constructor creates a BigInteger using a string
	{strnumber = input;						//saves string as strnumber
	head_ptr = NULL;						//initializes head_ptr to NULL
	int digits = input.length();			//calculates number of nodes
	int nodes = ceil(digits/3);
	many_nodes = nodes;
	int length = input.length();

	while (length > 0)							//converts characters to integers and stores them
		{int digit1 = (input[length -1])- '0';	//in the linked list three at a time
		int digit2 = ((input[length-2])-'0') * 10;
		int digit3 = ((input[length-3]) - '0') * 100;
		int mynumber = digit1 + digit2 + digit3;
		list_head_insert(head_ptr, mynumber);
		length = length - 3;
		}
	
	}



	BigInteger::BigInteger(const BigInteger& source)	//copy constructor
	{head_ptr = NULL;
	node *tail_ptr = NULL;
	list_copy(source.head_ptr, head_ptr, tail_ptr);
	many_nodes = source.many_nodes;
	strnumber = source.strnumber;
	}



	BigInteger::~BigInteger()				//destructor
	{ 
	list_clear(head_ptr);
	many_nodes = 0;
	}
	


	void BigInteger::operator =(const BigInteger &source)	//overloaded = operator
	{node *tail_ptr = NULL;

	if (this == &source)			//first test for self assignment
		return;

	list_clear(head_ptr);			//then clear original list
	many_nodes = 0;

	list_copy(source.head_ptr, head_ptr, tail_ptr);	//copy new list into original list
	many_nodes = source.many_nodes;
	strnumber = source.strnumber;
	
	}
	



	string BigInteger::toString()	//returns strnumber	
	{return strnumber;
	}


	

	istream& operator >>(istream& ins, BigInteger& b)	//overloaded input operator
	{
	string s;
	ins >> s;
	BigInteger temp(s);
	b = temp;
	return ins;
	}
	
	
	


	ostream& operator <<(ostream& o, /*const*/ BigInteger& b) //overloaded output operator
	{
		o << b.toString();
		return o;
	}

////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////
	///// Might need this later //////////////////////////////////
/*

	int BigInteger::myAtoi(string str)  //algorithm borrowed from 
	{						//http://www.eskimo.com/~scs/cclass/asgn.beg/PS4a.html
	int retval = 0;
	int i = 0;

	while(str[i] != '\0')
		{
		int digit = str[i] - '0';
		retval = 10 * retval + digit;
		i++;
		}

	return retval;
	}
*/
	//////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////
  
}

