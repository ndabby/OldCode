//Nadine Dabby
//July 13, 2004
//
// Main program to test Big Integer


#include <iostream>
using std::cin;
using std::cout;
using std::endl;

#include "BigInt2.h"
using namespace main_savitch_5;

int main()
{
BigInteger mynumber;	//tests default constructor

cout << "Please enter a number of any size without commas; if you enter an invalid number ";
cout << "the computer will initialize this number to zero..."<< endl;

cin >> mynumber;	//tests >> operator and string constructor

cout << endl << "You entered: " << mynumber.toString() <<endl;	//tests toString function

BigInteger number2 = "12345";		//tests = operator

cout << "number2 was created and initialized to: " <<endl << number2 <<endl; //tests << operator

BigInteger number3(number2);	//tests copy constructor

cout << "number3 was created as a copy of number2, it has the following value: ";
cout <<endl <<number3 <<endl;	

number2 = number3 + mynumber;	//tests + operator
cout << "number2 was changed to equal number3 + the number you entered, it now has the value: ";
cout <<endl <<number2 <<endl;

number2 = number2 - mynumber;		//tests - operator
cout << "number2 was changed to equal number2 - the number you entered, it now has the value: ";
cout <<endl <<number2 <<endl;



BigInteger number5;
number5 = div2(number2);		//tests div2 function
cout << "number5 was created and set to equal half of number2, it now has the value: ";
cout <<endl <<number5 <<endl;



BigInteger number4;
number4 = number2 * mynumber;	//tests * operator
cout << "number4 was created and set to equal the number you entered * number2, it now has the value: ";
cout <<endl <<number4 <<endl;


BigInteger number6;
number6 = number5/number5;		//tests / operator
cout << "number6 was set to equal the number5 / number5, it now has the value: ";
cout <<endl <<number6 <<endl;

number6 = number5/mynumber;		// tests / operator
cout << "number6 was set to equal number5 /the number you entered; it now has the value: ";
cout <<endl <<number6 <<endl;


number6 = number4 / mynumber;	//tests / operator
cout << "number6 was set to equal number4 / the number you entered; it now has the value: ";
cout <<endl <<number6 <<endl;

cout << "Now we can determine which numbers are bigger or smaller using the < and > operators...";
cout << endl;

if (number6 > number5)			//tests > operator
	cout << "number6 is greater than number5" <<endl; 
else cout << "number6 is not greater than number5" <<endl;

if (number6 < number5)			//tests < operator
	cout << "number6 is less than number5" <<endl; 
else cout << "number6 is not less than number5" <<endl;

if (number3 <= number4)			//tests <= operator
	cout << "number3 is <= number4" << endl;
else cout << "number3 is not <= number4" << endl;

if (mynumber >= number3)		//tests >= operator
	cout << "the number you entered is >= number3" <<endl;
else cout << "the number you entered is not >= number3" <<endl;


return 0;
}
