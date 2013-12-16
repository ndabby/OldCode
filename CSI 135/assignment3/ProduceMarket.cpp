//Nadine Dabby
//May 18, 2004
//ProduceMarket.cpp File
//
//This file stores the implementations of the functions declared in the ProduceMarket.h file.

#include "Product.h"
#include "ProduceMarket.h"
#include <iostream>
using std::endl;
using std::ios;
#include <fstream>


ProduceMarket::ProduceMarket(double x, vector<Product> y)	//This is the ProduceMarket object
{start(x);													//constructor. It has two parameters:
_productList = y;											//a double and a Product vector. 
}															//The cash is initialized to the 
															//double's value. 

void ProduceMarket::start(double x)				//This function initializes the value of the	
{ _cash = x;									//_cash variable. It takes one parameter (a double)
}												//and it returns nothing.


int ProduceMarket::find(const string x)				//This function is used by other functions in 
{	int location = -1;								//the ProduceMarket class to search the 
	string n;										//_productList for a given string by iteration 
	for (int i = 0; i < _productList.size(); i++)	//in a for loop. It has one parameter (a string).
	{n= _productList[i].getName();					// if it finds the string it returns the 
		if (n == x)									//location of the string in the vector.    
	location = i;									// It returns -1 if the _productList does  
	}												//not contain the string.
return location;
}


bool ProduceMarket::addNew(string s, string t, int i = 0)
{int location;								//This function has three parameters (string, string, 
location = find(s);							//and integer) representing the three values needed to 
Product temp(s, t, i);						//create a class object. The function uses the find 
	if (location != -1)						//function to search the product vector to see if a 
		return false;						//product already exists in the market. It then creates
	else									//and adds the product if it is not there. The function 
		_productList.push_back(temp);		//returns a bool value--true if the product is not there
		return true;						//and false if it is.
}


bool ProduceMarket::buy(string s, float m, int q)	//This function has three parameters (a string,
{if (_cash >= (q*m) && q > 0)						//a float and an integer) representing the
{int location;										//name of the product the going price and the
	location = find(s);								//quantity requested. When called the function
	_productList[location].changeInventoryUp(q);	//first tests to make sure that there is enough
	_cash -= (m*q);									//cash to purchase the quantity requested and
	return true;}									//that the quantity requested is a positive 
else												//number. If so, the function uses the search  
		return false;								//function to locate the product and uses the 
}													//Product member funtion changeInventoryUp to
													//increase the quantity of that inventory by q. 
													//It then subtracts m*q or the total spent from
													//the _cash variable. This function returns a
													//bool--true if the transaction can occur and
													//false if there was not enough money or if
													//a negative quantity was entered.	

bool ProduceMarket::sell(string s, float m, int q)	//This function has three parameters (a string,
{int location;										//a float and an integer) representing the
	location = find(s);								//name of the product the going price and the
if ( _productList[location].getInventory() >= q)	//quantity requested. When called the function
{_productList[location].changeInventoryDown(q);		//first locates the product using find()
	_cash += (m*q);									//then it tests to make sure that there is 
													//enough of an inventory to sell (if quantity
	return true;}									//of the product is greater then or equal to  
else												//the amount requested. If so it calls the	
return false;										//Product member function:
}													//_productList[location].changeInventoryDown(q);
													//to decrease the quantity in stock by q. It 
													//then adds m*q or the total spent to
													//the _cash variable. This function returns a
													//bool--true if the transaction can occur and
													//false if there was not enough Product to sell.						//a negative quantity was entered.


double ProduceMarket::totalcash()			//This function has no parameters. It returns the 	
{ return _cash;								//Cash on hand (a double) when called.
}


void ProduceMarket::printall(ofstream& fout)		//This function has one parameters (an ofstream
{													//reference. When called the function uses an  				 
	for (int i=0; i < _productList.size(); i++)		//iterative loop to print the name, type and
	{fout << _productList[i].getName() << " ";		//quantity of every product in the Market.
	fout << _productList[i].getType() << " ";		//The function prints directly to the file 
	fout << _productList[i].getInventory() << endl;	//since the ofstream is passed into the function.
	}												//It returns nothing.
}

void ProduceMarket::print(string x, ofstream& fout)	//This function has two parameters (a string
{													//and an ofstream reference). When called the
	for (int i=0; i< _productList.size(); i++)		//function uses an iterative loop to compare
	{if (_productList[i].getType() == x)			//the string entered by the user to the type
	{fout << _productList[i].getName() << " ";		//of each product. It then prints the name,
	fout << _productList[i].getType() << " ";		//type and quantity of every product of that 
	fout << _productList[i].getInventory() << endl;	//type directly to the file. It returns 
	};												//nothing.
	};
}