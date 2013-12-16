//Nadine Dabby
//July 13, 2004
//
//BigInteger implementation file 




#include "BigInt2.h"
#include <math.h>  //contains ceil and floor function

#include <iostream>
using namespace std;



namespace main_savitch_5
{	
	
	BigInteger::BigInteger()		//default constructor, so that I can 
	{head_ptr = NULL;				//declare an empty linked list
	many_nodes = 0;
	strnumber = "";
	}
	
	
	BigInteger::BigInteger(string input){			//This constructor creates a 
		char n;										//BigInteger using a string. 
		bool sentinel = true;						
		for (int i = 0; i < input.length(); i++){	//First the function tests that the 
			n = input[i];							//string entered only contains digits
			switch (n) {							//if a punctuation mark is entered 
			case '0':								//the sentinel value is changed and as a 
			case '1':								//result the BigInteger will be intialized
			case '2':								//to zero.
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
				break;
			default: cout << "You did not enter a big integer, so this number will be zero!";
				sentinel = false;
				i = input.length();
				break;
			}			
			
	}

	if (sentinel == true){							//if the string is a valid integer,
	trimzero(input);								//the function removes leading zeros from the 
	strnumber = input;								//string then saves the string as strnumber
	}
	else {strnumber = "0";}

	if (strnumber == "\0") {strnumber = "0";}
	head_ptr = NULL;									//initializes head_ptr to NULL
	int digits = input.length();						//calculates number of nodes
	int nodes = ceil(digits/3.0);
	many_nodes = nodes;
	int length = input.length();
	int mynumber=0;

	while (length > 0)									//next the function converts characters 
		{int digit1 = (input[length -1])- '0';			//to integers and stores them in a linked
		int digit2 = ((input[length-2])-'0') * 10;		//list in groups of three.
		int digit3 = ((input[length-3]) - '0') * 100;	//in my class, the most significant digits 
		if (length==1) {mynumber = digit1;}				//are stored at the head.
		if (length==2) {mynumber = digit1 + digit2;}
		if (length >= 3) {mynumber = digit1 + digit2 + digit3;}
		list_head_insert(head_ptr, mynumber);
		length = length - 3;
		}
	
	}



	BigInteger::BigInteger(const BigInteger& source)	//Copy Constructor
	{head_ptr = NULL;									//this constructor copies another BigInteger
	node *tail_ptr = NULL;
	list_copy(source.head_ptr, head_ptr, tail_ptr);
	many_nodes = source.many_nodes;
	strnumber = source.strnumber;
	}



	BigInteger::~BigInteger()							//Destructor
	{ 
	list_clear(head_ptr);
	many_nodes = 0;
	}
	


	void BigInteger::operator =(const BigInteger &source)	//Overloaded = operator
	{node *tail_ptr = NULL;									//This functions first tests for 
															//self assignment, it then clears 
	if (this == &source)									//the original linked list and 
		return;												//copies new list into original list					


	list_clear(head_ptr);
	many_nodes = 0;

	list_copy(source.head_ptr, head_ptr, tail_ptr);			
	many_nodes = source.many_nodes;
	strnumber = source.strnumber;
	
	}
	


	BigInteger operator +(const BigInteger b1, const BigInteger b2){	//overloaded +
		node* summand = list_reverse(b1.head_ptr);		//reverse b1 and store as summand
		node* summand2 = list_reverse(b2.head_ptr);		//reverse b2 and store as summand2
		node* SUM = NULL;								//this is where the sum will be stored
		
		node* s1 = summand;			//create pointers to the heads of these three lists
		node* s2 = summand2;		//so they can be deleted later
		node* s3 = SUM;

		node* cursor = NULL;		//pointers cursor and other, will allow the function
		node* other = NULL;			//to pick the smaller list to traverse first
		int addend = 0;				
		int carry = 0;
		string ABC = "";
		
		if (b1.many_nodes <= b2.many_nodes){
			cursor = summand;
			other = summand2;}
		else {
			cursor = summand2;
			other = summand;}
		
	while (cursor != NULL){		
		addend = (summand->data() + summand2->data()+ carry) % 1000 ;
		carry = (summand->data() + summand2->data() + carry) / 1000;
		list_head_insert(SUM, addend);
		cursor = cursor->link();			//the smaller list is traversed, and each node is 
		summand = summand->link();			//added to the  equivalent node in the other list
		summand2 = summand2->link();		//the amount to be carried is stored and added to the 
		other=other->link();				//next integer. the %1000 of the number is stored 
		}									//at the head of SUM

	while (other != NULL){							//after the smaller number's list is traversed 
		addend = (other->data() + carry) % 1000;	//the rest of the bigger list is traversed and
		carry = (other->data() + carry) / 1000;		//added to SUM
		list_head_insert(SUM, addend);
		other= other->link();
		}
	if (carry != 0){
	list_head_insert(SUM, carry);
	}

	
	while (SUM != NULL){						//Sum is converted to a string
		ABC = ABC + myItoA(SUM->data());
		SUM = SUM->link();
		}

	trimzero(ABC);								//Leading zeros are removed

	BigInteger SUMMER(ABC);						//the big integer is created 

	list_clear(s1);								//and the linked lists used for the addition
	list_clear(s2);								//are cleared to release memory
	list_clear(s3);

	return SUMMER;
	}

	
	BigInteger operator -(const BigInteger b1, const BigInteger b2){   //Overloaded - operator
		if (b1 <= b2){
			BigInteger Nil("0");						//if the number to be subtracted is the
			return Nil;									//bigger number, the function returns zero
		}												
		else{											//otherwise...
			node* c1 = list_reverse(b1.head_ptr);		//reverse b1 and store as c1
			node* c2 = list_reverse(b2.head_ptr);		//reverse b1 and store as c2
			node* SUM = NULL;							//Sum will store the result of the operation
			node* subtractor = c1;				//also I again created pointers to the heads of these
			node* subtractee = c2;				//three lists so they can be deleted later
			int addend = 0;
			int borrow = 0;
			string ABC = "";						
			while (subtractee != NULL){
				if (subtractor->data() - borrow >= subtractee->data()){
					addend = (subtractor->data() - subtractee->data()- borrow) % 1000;
					borrow = 0;
				}
				else{
					addend = ((1000 + subtractor->data()) - subtractee->data() - borrow) % 1000;
					borrow = 1;
				}								//Now I traverse the subtractee's list and define 
												//borrowing and subtraction as it works in 3rd grade 
				list_head_insert(SUM, addend);	//ie, if the subtracting digits are too small, I borrow
				subtractor = subtractor->link();	//one from the node's neighbor and later subtract
				subtractee = subtractee->link();	//it when calculating the next result.
			}

			while (subtractor != NULL){			//Now we traverse the rest of the subtractor's list
				if (subtractor->data() - borrow >= 0){
					addend = (subtractor->data() - borrow) % 1000;
					borrow = 0;
					list_head_insert(SUM, addend);
					subtractor = subtractor->link();
				}
				else {
					addend =(1000 + subtractor->data() - borrow) % 1000;
					borrow = 1;
					list_head_insert(SUM, addend);
					subtractor = subtractor->link(); 
				}
			}


			node* c3 = SUM;
			while (SUM != NULL){				//the resulting number is converted to a string
				ABC = ABC + myItoA(SUM->data());
				SUM = SUM->link();
			}

			trimzero(ABC);						//leading zeros are removed
			
			BigInteger SUMMER(ABC);				//the big integer is constructed using the string

			list_clear(c1);						//and the utilized lists are cleared to 
			list_clear(c2);						//release memory
			list_clear(c3);

			return SUMMER;
		}
	

	}
						


		
	bool operator <(const BigInteger b1, const BigInteger b2){	//overloaded < operator
		if (b1.many_nodes < b2.many_nodes)				//firsts tests to see which number has
			return true;								//more nodes. if these are equivalent
		if (b1.many_nodes > b2.many_nodes)				//it compares the data stored in the nodes 
			return false;								//starting with the most significant
		// (b1.many_nodes == b2.many_nodes)				// digits at the node's head
		node * c1 = b1.head_ptr;						
		node * c2 = b2.head_ptr;

		while ((c1 != NULL) && c1->data() == c2->data()) {
			c1 = c1->link();
			c2 = c2->link();
		}
		
		return (c1 == NULL? false: (c1->data() < c2->data()));
		
	}


	bool operator >(const BigInteger b1, const BigInteger b2){	//overloaded > operator	
		if (b1.many_nodes > b2.many_nodes)				//firsts tests to see which number has
			return true;								//more nodes. if these are equivalent
		if (b1.many_nodes < b2.many_nodes)				//it compares the data stored in the nodes
			return false;								//starting with the most significant
		// (b1.many_nodes == b2.many_nodes)				// digits at the node's head
		node * c1 = b1.head_ptr;
		node * c2 = b2.head_ptr;

		while ((c1 != NULL) && c1->data() == c2->data()) {
			c1 = c1->link();
			c2 = c2->link();
		}
		
		return (c1==NULL ? false : c1->data() > c2->data());
	}		
		

	bool operator <=(const BigInteger b1, const BigInteger b2){	//overloaded <= operator
		if ( (b1 < b2) || (b1.strnumber == b2.strnumber) )
			return true;
		else return false;
	}

	bool operator >=(const BigInteger b1, const BigInteger b2){	//overloaded >= operator
		if ((b1 > b2) || (b1.strnumber == b2.strnumber) )
			return true;
		else return false;
	}




	BigInteger operator *(const BigInteger& b1, const BigInteger& b2){ //overloaded * operator
		node* multiplier = list_reverse(b1.head_ptr);	// the reversed list of b1 is stored
		node* multiplied = list_reverse(b2.head_ptr);	//the reversed list of b2 is stored
		node* cursor1 = multiplier;				//these pointers are created so they can
		node* cursor2 = multiplied;				//be used to clear the lists later
		node* storage = NULL;						//this is where interim values will be stored

		int carry = 0;
		int holdem = 0;
		string ABC = "";
		int count = 0;

		BigInteger container;			//multiplication is performed using two while loops
		BigInteger product;				//to multiply every node of b1 by every node of b2
										//after each iteration of the outer loop the value is 		
		while (cursor1 != NULL){		//stored in Big integer container and the sums are 		
			cursor2 = multiplied;		//added to big integer Product.
			for (int q = 0; q < count; q++){
				list_head_insert(storage, 000);
				}
			while (cursor2 != NULL){	
				holdem = (cursor1->data() * cursor2->data() + carry) % 1000;
				carry = (cursor1->data() * cursor2->data() + carry) / 1000;
				list_head_insert(storage, holdem);
				cursor2 = cursor2->link();
			}
			if (carry > 0){
				list_head_insert(storage, carry);
				carry = 0;
			}
			node* cursor3 = storage;
			while (storage!=NULL){
				ABC = ABC + myItoA(storage->data()); 
				storage = storage->link();
			}
			trimzero(ABC);
			node* tail_ptr = NULL;
			list_copy(cursor3, container.head_ptr, tail_ptr);
			container.many_nodes = list_length(cursor3);
			container.strnumber = ABC;
			product = product + container;
			cursor1 = cursor1->link();
			list_clear(cursor3);
			count++;
		}


		list_clear(multiplier);			//the lists are cleared to release memory
		list_clear(multiplied);
				

		return product;
	}




		
		
		
		
	BigInteger operator /(const BigInteger b1, const BigInteger b2){ //overloaded / operator
		
		if (b2 > b1){							//this function first checks that b2
			BigInteger quotient("0");			//is neither less than nor equal to b1.
			return quotient;
		}
		if (b1.strnumber == b2.strnumber){
			BigInteger quot("1"); 
			return quot;
		}
		
		BigInteger leftbound("0");				//the function finds the quotient using a 
		BigInteger rightbound(b1);				//binary search that tests that the dummy 
		BigInteger dummy(div2(b1));				//variable is in a range defined by 
		BigInteger nil("0");					// 0 <= b1 - b2 * dummy < b2
		BigInteger one("1");
		while (  (b1-b2) >= (b2 * dummy) || b1 < (b2* dummy)){
			
			if ( (b1-b2) >= (b2 * dummy) ){		//if the dummy is too small, the left bound	
				leftbound = dummy + one;		//is changed to equal dummy + one
			}
			else if ( b1 < (b2* dummy)){		//if the dummy is too big, the right bound
				rightbound = dummy - one;		//is changed to equal dummy - one
			}
			dummy = div2(leftbound + rightbound);	//dummy becomes new midpoint

		}
		return dummy;
		
	}
				
				
			










	BigInteger div2(const BigInteger b1){			//This function implements division by 2
		node* tail_ptr = NULL;						//by dividing every node by two.
		node* dividend = NULL;
		node* cursor = dividend;
		list_copy(b1.head_ptr, dividend, tail_ptr);
		node* revquotient = NULL;
		string ABC = "";


		int holder = 0;
		int carry= 0; 

		while (dividend != NULL){
			holder = (((carry * 1000) + dividend->data())/2);
			carry = (((carry * 1000) + dividend->data())%2);
			list_head_insert(revquotient, holder);
			dividend = dividend->link();
		}
		
		node* quotient = list_reverse(revquotient);
		node* cursor2 = quotient;
		while (quotient != NULL){
				ABC = ABC + myItoA(quotient->data());
				quotient = quotient->link();
			}

		trimzero(ABC);

		BigInteger divided(ABC);

		list_clear(cursor);
		list_clear(revquotient);
		list_clear(cursor2);

		return divided;
	}



	string myItoA(int i)					//this function converts an integer to a string
	{char h = i/100 + '0';
	char t = (i%100)/10 + '0';
	char o = i%10 + '0';
	string s = "";
	s = s+h;
	s = s+t;
	s = s+o;
	return s;
	}



	void trimzero(string& s){				//This function removes leading zeros from
		int i = 0;							//the string that the big integer is constructed from
		while (s[i]=='0'){
			i++;
		}
		s = s.substr(i);
		return;
	}



	string BigInteger::toString()			//returns strnumber	
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
	{	o << b.toString();
		return o;
	}
  
}
