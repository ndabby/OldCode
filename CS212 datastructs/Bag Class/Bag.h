//Nadine Dabby
//June 21, 2004
//
//Bag Class Header File
//
//This class's definitions and implementation are modeled after the bag class of section
//3.1 in our book. I added the two operators and a get function to display results.



#ifndef BAG_H
#define BAG_H


const int CAPACITY = 30;
class bag
{
public:
	typedef int value_type;

	bag(int b = 0); 

	int erase(const value_type& target);
	bool erase_one(const value_type& target);
	void insert(const value_type& entry);
	void operator +=(const bag& addend);
	friend bag operator +(const bag& b1, const bag& b2);

	void operator -=(const bag& sub);					//overloaded -= operator
	friend bag operator -(const bag& b1, const bag& b2);//overloaded - operator	


	int size() const {return used;}
	int count(const value_type& target) const;
	
	value_type getelement(int i);				//I added this function to display elements

private:

	value_type data[CAPACITY];
	int used;

};


#endif