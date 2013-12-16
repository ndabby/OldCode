//Nadine Dabby
//June 21, 2004
//
//Bag Class Implementation File
//
//Since the majority of implementations here are based on the one in the book I will explain 
//the ones I added per the assignment (the - and -= overloaded operators and the getelement 
//function. (((PLEASE SCROLL DOWN)))

#include <algorithm>	//contains copy function
#include <cassert>      //contains assert function
#include "Bag.h"

using namespace std;



bag::bag(int b)
{
used = b;
}

int bag::erase(const value_type& target)
{int index = 0;
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
	
	
bool bag::erase_one(const value_type& target)
{int index = 0;
while ((index < used) && (data[index] != target))
	++index;
if (index == used)
	return false;
--used;
data[index] = data [used];
return true;
}


void bag::insert(const value_type& entry)
{assert(size() < CAPACITY);

data[used] = entry;
++used;
}
	
void bag::operator +=(const bag& addend)
{assert((size() + addend.size()) <= CAPACITY);
copy(addend.data, addend.data + addend.used, data + used);
used += addend.used;
}


bag operator +(const bag& b1, const bag& b2)
{bag answer;
assert((b1.size() + b2.size() ) <= CAPACITY);

answer += b1;
answer += b2;

return answer; 
}



void bag::operator -=(const bag& b2)		//this is the overloaded -= operator. it takes a bag
{int amountremoved = 0;						//and, using two for loops, compares each element to 
	for (int i = 0; i < b2.size(); i++)		//to the elements in the bag to the left of the 
		{for (int j = 0; j < size(); j++)	//operator. Then using a nested if structure,
			if (b2.data[i] == data[j])							//each common element is counted
				{if ( b2.count(b2.data[i]) < count(b2.data[i]))	//in both bags and if bag 2 
					{amountremoved = b2.count(b2.data[i]);		//contains fewer copies of the
					for (int k = 0; k < amountremoved; k++)		//element then the calling bag,
						erase_one(b2.data[i]);					//the quantity of bag 2's element
					}											//are removed from the calling 	
				else erase(b2.data[i]);							//bag. If bag 2 has more copies,
				}												//then all copies of that element
	}															//are removed from the caller.
}																//this function returns nothing.


bag operator -(const bag& b1, const bag& b2)	//this is the overload - operator. it takes two bag 
{bag answer;									//references as parameters and returns a bag.
answer += b1;									//the function constructs a bag then adds the 
answer -= b2;									//contents of bag 1 and substracts the contents of 
return answer;									//bag 2, then returns the bag.
}


int bag::count(const value_type& target) const
{
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