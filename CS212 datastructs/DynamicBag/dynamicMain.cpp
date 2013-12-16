//Nadine Dabby
//June 28, 2004
//
//Dynamic Bag Test Program

#include "dynamicbag.h"
#include <iostream>
using namespace std;

int main()
{
bag a(5);				//creates Bag A with regular constructor

cout << "The initial capacity of A is:" << endl;	//outputs capacity of A 
cout << a.getcapacity() << endl;					
cout << "The initial size of A is: " << endl;		//outputs size of A
cout << a.size() << endl;

a.insert(2);		//inserts the numbers 2, 5, 7, and 7 into Bag A
a.insert(5);
a.insert(7);
a.insert(7);

cout << "Bag A contains:" << endl;	//outputs the contents of Bag A
for (int k=0; k < a.size(); k++)
{cout << a.getelement(k) << ", ";}

cout << endl;						
cout << "The capacity of Bag A after 4 elements are inserted is:" << endl;
cout << a.getcapacity() << endl;				//outputs the new capacity of A
cout << "The size of Bag A after 4 elements are inserted is: " << endl;
cout << a.size() << endl;						//outputs the new size of A

a.reserve(12);									//changes capacity of A
cout << "Using the reserve function, capacity of A has been changed to: " << a.getcapacity(); 
a.reserve(10);									//changes capacity of A
cout << endl << "Using the reserve function capacity has been returned to: " <<a.getcapacity();
cout << endl;


bag b(a);				//creates a bag with copy constructor


cout << "Bag B (constructed as a copy of bag A) contains:" << endl;	//outputs the contents of Bag B
for (int j=0; j < b.size(); j++)
{cout << b.getelement(j) << ", ";}

cout << endl;

b.erase(7);					//erase all 7's from B

cout << "Bag B (after erasing all 7's) contains:" << endl;	//outputs the contents of Bag B
for (int l=0; l < b.size(); l++)
{cout << b.getelement(l) << ", ";}

cout << endl;

cout << "Bag A still contains: " << endl;		//outputs contents of Bag A
for (int q=0; q < a.size(); q++)
{cout << a.getelement(q) << ", ";}

cout << endl;

bag c = a - b;					//creates C as the result of A - B

cout << "Bag C (constructed as the result of Bag A - Bag B) contains:" << endl;	
for (int i=0; i < c.size(); i++)							//outputs the contents of Bag C
{cout << c.getelement(i) << ", ";}

cout << endl;

cout <<"The number of 7's in Bag C is: " << c.count(7) << endl; //counts 7's in Bag C

c.erase_one(7);									//erases one 7 in Bag C
cout << "Bag C (after one 7 is erased) contains:" << endl;	
for (int v=0; v < c.size(); v++)							//outputs the contents of Bag C
{cout << c.getelement(v) << ", ";}

cout << endl;
cout <<"The number of 7's in Bag C is: " << c.count(7) << endl; //counts 7's in Bag C


c = b;										//testing get operator
b.erase(2);									//erases all 2's in Bag B

cout << "Bag C (after it is set to = B, and 2 is erased from B) contains:" << endl;	
for (int g=0; g < c.size(); g++)							//outputs the contents of Bag C
{cout << c.getelement(g) << ", ";}

cout << endl;


cout << "Bag B contains:" << endl;	//outputs the contents of Bag B
for (int h=0; h < b.size(); h++)
{cout << b.getelement(h) << ", ";}

cout << endl;

bag d = a + b;					//creates Bag D as the sum of Bags A and B

cout << "Bag D (constructed as the result of Bag A + Bag B) contains:" << endl;	
for (int m=0; m < d.size(); m++)							//outputs the contents of Bag D
{cout << d.getelement(m) << ", ";}

cout << endl;

d-= a;														//tests the -= operator
cout << "Bag D (-= Bag A ) contains:" << endl;	
for (int n=0; n < d.size(); n++)							//outputs the contents of Bag C
{cout << d.getelement(n) << ", ";}

cout << endl;

d+= a;														//tests the += operator
cout << "Bag D (+= Bag A ) contains:" << endl;	
for (int p=0; p < d.size(); p++)							//outputs the contents of Bag C
{cout << d.getelement(p) << ", ";}

cout << endl;

d-= b;														//tests the -= operator
cout << "Bag D (-= Bag B ) contains:" << endl;	
for (int u=0; u < d.size(); u++)							//outputs the contents of Bag C
{cout << d.getelement(u) << ", ";}

cout << endl;

d+= b;														//tests the += operator
cout << "Bag D (+= Bag B ) contains:" << endl;	
for (int x=0; x < d.size(); x++)							//outputs the contents of Bag C
{cout << d.getelement(x) << ", ";}

cout << endl;



return 0;
}