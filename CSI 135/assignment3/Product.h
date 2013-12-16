//Nadine Dabby
//May 18, 2004
//Product.h header file
//
//This file declares the Product class. It contains three members: name, type and inventory.
//It also contains functions to manipulate and retrieve the data stored in these members.
//(Parameters and Return Values as well as function explanations will be included in the 
//Product.cpp file.

#ifndef PRODUCT_H
#define PRODUCT_H

#include <string>
using std::string;

#include <fstream>
using std::ofstream;

class Product {

public:

	Product(string n, string t, int i = 0);	//This is the class object constructor.
	void changeInventoryUp(int);			//This function increases the quantity of a product.
	void changeInventoryDown(int);			//This function decreases the quantity of a product.
	string getName();						//This function retrieves the name of a product.
	string getType();						//This function retrieves the type of a product.				
	int getInventory();						//This function retrieves the inventory of a product.					

	friend ofstream& operator<<(ofstream&, Product&);	//I added << overloaded operator to aid 
														//in printing the Product object in 
														//ProductMarket.

private:

	string _name;							//Name of product.
	string _type;							//Type of product.
	int _inventory;							//Inventory stores the quantity of product.
	enum Type {citrus, berry, leaf, legume,		//This is a list of possible produce types. 
		nightshade, drupe, melon, pome, squash, onion, root, tuber, stalk};
};

#endif

