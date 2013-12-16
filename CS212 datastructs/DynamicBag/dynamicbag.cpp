//Nadine Dabby
//June 28, 2004
//
//Dynamic Bag implementation file


#include <algorithm>	//contains copy function
#include <cassert>		//contains assert function
#include "dynamicbag.h"

using namespace std;


bag::bag(int cap)						//constructor
{
capacity = cap;
data = new value_type [capacity];
used = 0;
}


bag::bag(const bag& b)					//Copy constructor creates a new bag
{										//by copying another bag.
data = new value_type[b.capacity];
capacity = b.capacity;
used = b.used;
copy(b.data, b.data + b.used, data);
}


bag::~bag()								//destructor
{delete [] data;
}


void bag::reserve(int newcapacity)		//This function allows user to change the 
{value_type *biggerArray;				//capacity of the array.

if (newcapacity ==capacity)				//If the new capacity is the same as the old 
return;									//capacity, nothing changes.

if (newcapacity < used)					//This clause protects the used data, by not 
newcapacity = used;						//allowing the new capacity to be lower than
										//the amount of space used.	
biggerArray = new value_type[newcapacity];		//A new array is created with the new capacity,
copy(data, data + used, biggerArray);			//The data is copied from the old array to 
delete [] data;									//the new array and the old array is deleted.
data = biggerArray;								//The pointer to the old array now points to 
capacity = newcapacity;							//the new array, and the capacity is changed.
}



int bag::erase(const value_type& target)	//This function erases all copies of a target 	
{int index = 0;								//using a while loop.
int removed = 0;
while (index < used)
	{	if (data[index] == target)
		{--used;
		data[index] = data[used];
		++removed;}
		else ++index;
	}
return removed;
	}
	
	

bool bag::erase_one(const value_type& target)		//This function erases a single copy of 
{int index = 0;										//the target.
while ((index < used) && (data[index] != target))	
	++index;
if (index == used)
	return false;
else
--used;
data[index] = data [used];
return true;
}



void bag::insert(const value_type& entry)	//This function inserts an item into the array
{if (size() >= (getcapacity()/2))			//If the used space in the array is >= capacity,
	reserve(capacity * 2);					//the capacity is doubled by calling the reserve	
data[used] = entry;							//function.
++used;
}
	

void bag::operator +=(const bag& addend)			//overloaded += operator
{if((size() + addend.size()) >= getcapacity())
	{reserve(2* used + 2*addend.used);
	}
copy(addend.data, addend.data + addend.used, data + used);
used += addend.used;
}



bag operator +(const bag& b1, const bag& b2)		//overloaded + operator
{bag answer(2*b1.size() + 2*b2.size());
answer += b1;
answer += b2;

return answer; 
}



void bag::operator -=(const bag& b2)		//this is the overloaded -= operator. It takes
{bag dummy(b2);								//a bag as a parameter and returns nothing.
int amountremoved; 							//The function creates a new bag as a copy of b2		 
	for (int i = 0; i < dummy.size(); i++)		//and then searches both the copy and the calling
		{for (int j = 0; j < size(); j++)		//bag for the targets to be removed, and removes 
			if (data[j] == dummy.data[i])		//them from both bags to keep track of what
				{amountremoved = dummy.count(dummy.data[i]);	//has been removed.	
				if ( dummy.count(dummy.data[i]) < count(dummy.data[i]))	
					{for (int q=0; q <amountremoved; q++)  
				 		erase_one(dummy.data[i]);
						dummy.erase_one(dummy.data[i]);
					}
				else erase(dummy.data[i]);				
				}
			
	}											
}												


bag operator -(const bag& b1, const bag& b2)	//this is the overload - operator. it takes two bag 
{bag answer;									//references as parameters and returns a bag.
answer += b1;									//the function constructs a bag then adds the 
answer -= b2;									//contents of bag 1 and substracts the contents of 
return answer;									//bag 2, then returns the bag.
}



const bag& bag::operator =(const bag &b)        //This is the overloaded = operator. If a bag 
{if (this == &b)								//attempts to "get" itself, the bag itself is 
	return *this;								//returned.
capacity = b.capacity;							//otherwise the bag's capacity is changed to the 
used = b.used;									//capacity of b2, and a new bag is created with 
int *t = new int[capacity];						//this capacity, all of the elements are copied 	
for (int c = 0; c < b.used; c++)				//the new bag. then the original bag is deleted
	t[c] = b.data[c];							//and the original pointer is changed to point to the
delete [] data;									//new bag.
data = t;
return *this;
}





int bag::count(const value_type& target) const	//this function counts the number of copies
{												//of the target that are in the bag
int answer;
int i;

answer = 0;
for (i=0; i < used; ++i)
	{if (target == data[i])
	++answer;
	}
return answer;
}

bag::value_type bag::getelement(int i)    //this function retrieves element i from the bag
{assert(i < used);						  //it takes an integer parameter and returns a 
return data[i];							  //a value_type.
}