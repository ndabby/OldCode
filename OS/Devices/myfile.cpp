//Nadine Dabby
//CS 340
//October 11, 2004
//
// file object implementation file
//
//This file implements the functions from the file object header. 



#include "myfile.h"


myfile::myfile(string t, string n, string a, unsigned int l){	
	type = t;					
	name = n;								//The constructor takes 4 arguments:
	address = a;							//three strings and an unsigned int
	length = l;								//to create the file object.
};

string myfile::getType(){					//This function takes no arguments 	
	return type;							//and returns a string (the type).
};

string myfile::getName(){					//This function takes no arguments 	
	return name;							//and returns a string (the name).
};

string myfile::getAddress(){				//This function takes no arguments 	
	return address;							//and returns a string (the address).
};

unsigned int myfile::getLength(){			//This function takes no arguments 	
	return length;							//and returns an unsigned int(the length).
};

