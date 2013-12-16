//Nadine Dabby
//May 18, 2004
//ProduceMarket.h header file
//
//This file declares the ProduceMarket class. It contains two members: a double cash variable to 
//store the money on hand and a vector of products to store the product objects in the market.
//It also contains functions to manipulate and retrieve the data stored in these members.
//(Parameters and Return values as well as function explanations will be included in the 
//ProduceMarket.cpp file.


#ifndef PRODUCEMARKET_H
#define PRODUCEMARKET_H

#include <vector>
using std::vector; 

#include "Product.h"

class ProduceMarket {

public:

	ProduceMarket(double, vector<Product>);	//This is the class object constructor.

	void start(double);					//This function initializes the quantity stored in _cash.
	bool addNew(string, string, int);	//This function adds a new product to the Product vector.
	bool buy(string, float, int);		//This function allows the market to buy a given Product.
	bool sell(string, float, int);		//This function allows the market to sell a given Product.
	double totalcash();					//This function retrieves the quantity stored in _cash.
	void printall(ofstream&);			//This funciton prints the list of Products (the current
										//(values name type and quantity).
	void print(string, ofstream&);		//This function prints a list of Products of a given type.
	int find(string);					//This function searches the Product vector for a string.


private:

	double _cash;					//This variable stores the Market's cash.
	vector<Product> _productList;	//This variable stores the Products in the Market.

};

#endif
