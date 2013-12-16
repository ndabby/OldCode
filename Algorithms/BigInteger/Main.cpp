//Nadine Dabby
//July 7, 2004
//
//Main Program to test BigInteger class


#include <iostream>
using std::cin;
using std::cout;
using std::endl;

#include "Bigint.h"
using namespace main_savitch_5;

int main()
{
BigInteger mynumber;	//tests default constructor

cout << "Please enter a number of any size without commas" <<endl;

cin >> mynumber;	//tests >> operator and string constructor

cout << endl << "You entered: " << mynumber.toString() <<endl;	//tests toString function

BigInteger number2 = "12345";		//tests = operator

cout << "number2 was created and initialized to: " <<endl << number2 <<endl; //tests << operator

BigInteger number3(number2);	//tests copy constructor

cout << "number3 was created as a copy of number2, it has the following value: ";
cout <<endl <<number3 <<endl;

number2 = mynumber;
cout << "number2 was changed to equal the number you entered, it now has the value: ";
cout <<endl <<number2 <<endl;

return 0;
}