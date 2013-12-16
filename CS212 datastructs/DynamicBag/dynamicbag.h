//Nadine Dabby
//June 28, 2004
//
//Dynamic Bag header file



#ifndef DYNAMICBAG_H
#define DYNAMICBAG_H


const int DEFCAPACITY = 30;				//default capacity = 30
class bag
{
public:
	typedef int value_type;

	bag(int cap = DEFCAPACITY);			//constructor with default capacity
	bag(const bag& b);					//copy constructor
	~bag();								//destructor

	void reserve(int newcapacity);				//changes the capacity of the array
	int erase(const value_type& target);		// erases all copies of the target number
	bool erase_one(const value_type& target);	//erases one copy of the target
	void insert(const value_type& entry);		//inserts a number into the bag
	void operator +=(const bag& addend);		//overloaded += operator
	friend bag operator +(const bag& b1, const bag& b2); //overloaded + operator

	void operator -=(const bag& sub);					//overloaded -= operator
	friend bag operator -(const bag& b1, const bag& b2);//overloaded - operator	

	const bag& operator =(const bag &b);				//overloaded = operator

	int size() const {return used;}					//returns quantity of bag used
	int count(const value_type& target) const;		//returns quantity of target in bag 
	
	value_type getelement(int i);			//I added this function to display elements
	int getcapacity() {return capacity;}	//I added this function to display capacity 


private:

	value_type * data;
	int capacity;
	int used;

};


#endif