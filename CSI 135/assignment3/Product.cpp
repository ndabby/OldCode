//Nadine Dabby
//May 18, 2004
//Product.cpp File
//
//This file stores the implementations of the functions declared in the Product.h file.

#include "Product.h"

Product::Product(string n, string t, int i)	//The Product constructor has three parameters:
{_name = n;									//two strings and an integer to set the 
_type = t;									//values of the name, type and quantity
_inventory = i;								//of a new Product object. 
};
   

void Product::changeInventoryUp(int i)		//This function has one integer parameter, 
{ _inventory += i;							//which it uses to increase the quantity of 
};											//the product (the parameter itself does not change)
											//and the function does not return any value.

void Product::changeInventoryDown(int i)	//This function has one integer parameter,
{_inventory-= i;							//which it uses to decrease the quantity of 
};											//the product (the parameter itself does not change)
											//and the function does not return any value.

string Product::getName()					//This function has no parameters. It returns
{return _name;								//the name of the product (a string) when called.
};

string Product::getType()					//This function has no parameters. It returns 
{return _type;								//the name of the product type (a string) when called.
};

int Product::getInventory()					//This function has no parameters. It returns 		
{ return _inventory;						//the name of the product type (an integer) when called.
};

ofstream &operator<<(ofstream &o, Product& p)	//This function has parameters, an ofstream 
{	return o;									//reference and a product reference. It returns 
}												//a stream. It declares the extraction operator
												//a friend of the class so that I can use << 
												//to output data in the ProductMarket class.