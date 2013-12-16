//Nadine Dabby
//June 21, 2004
//
//Bag Class Main File
//
//This file tests the - and -= overloaded operators for the bag class.


#include "Bag.h"
#include <iostream>
using namespace std;

int main()
{
bag a;				//creates Bag A
a.insert(2);		//inserts the numbers 2, 5, 7, and 7 into Bag A
a.insert(5);
a.insert(7);
a.insert(7);

cout << "Bag A contains:" << endl;	//outputs the contents of Bag A
for (int k=0; k < a.size(); k++)
{cout << a.getelement(k);}

cout << endl;

bag b;				//creates Bag B
b.insert(2);		//inserts the numbers 2 and 7 into Bag B
b.insert(7);


cout << "Bag B contains:" << endl;	//outputs the contents of Bag B
for (int g=0; g < b.size(); g++)
{cout << b.getelement(g);}

cout << endl;


bag c = a - b;		//creates Bag C as the contents of Bag A - Bag B

cout << "Bag C (composed of Bag A - Bag B) contains:" << endl;	
for (int r=0; r < c.size(); r++)	//outputs the  contents of Bag C
{cout << c.getelement(r);}

cout << endl;



c -= b;				//subtracts Bag B from Bag C

cout << "Bag C - Bag B contains:" << endl; 
for (int z=0; z < c.size(); z++)		//outputs the new contents of Bag C
{cout << c.getelement(z);}

cout << endl;



c -= c;				//subtracts Bag C from Bag C

cout << "Bag C (minus the contents of bag C) contains:" << endl; 
for (int i=0; i < c.size(); i++)		//outputs the contents of Bag C
{cout << c.getelement(i);}

cout << endl; 

a -= b;				//subtracts Bag B from Bag A

cout << "Bag A (minus the contents of bag B) contains:" << endl; 
for (int j=0; j < a.size(); j++)		//outputs the contents of Bag A
{cout << a.getelement(j);}

cout << endl;

a -= b;				//Subtracts Bag B from Bag A again

cout << "Bag A (minus the contents of bag B, again) contains:" << endl; 
for (int t=0; t < a.size(); t++)		//outputs the contents of Bag B
{cout << a.getelement(t);}

cout << endl;



return 0;

}