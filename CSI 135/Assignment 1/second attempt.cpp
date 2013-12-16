// Interest Calculator
// by Nadine L. Dabby
// March 5, 2004

#include <iostream>
#include <cmath>

using std::cout;
using std::cin;
using std::endl;

int main ()
{
	char selection = 0; //Selection denotes the user's numerical choice.
	double principal = 100.00; //principal
	double principaln;
	float rate = 0.05;	   //interest rate
	int years = 1;	   //number of years
	int counter = 0;

	for (counter; counter != -399; counter++)
	{
	cout << "PLEASE TYPE A NUMBER FROM 1 TO 6 TO INDICATE WHAT YOU WANT TO DO: \n\n";
	cout << "1. Change the principal amount. \n";
	cout << "2. Change the interest rate. \n";
	cout << "3. Calculate the principal after a selected number of years. \n";
	cout << "4. Calculate the number of years it will take for the principal to \n"; 
	cout << "   reach a selected amount. \n";
	cout << "5. Display the Current principal and interest rate. \n";
	cout << "6. Quit the program. \n";

	cin >> selection;
	
	switch ( selection ) {
		
		case '1':
			cout << "Enter a new principal amount, in dollars and cents:\n";
			cin >> principal;
			if (principal < 0)
				cout << "Not valid data";
			break; 

		case '2':
			cout << "Enter a new interest rate, as a decimal, not a percentage: \n";
			cin >> rate;
			if (rate < 0)
				cout << "Not valid data";
			break;

		case '3':
			cout << "Enter a whole number of years greater than 0. \n";
			cin >> years;
			if (years < 0)
				cout << "Invalid data";
			else
			{principal = pow((1 + rate), years);
			cout << "$" << principal << endl;}
			break;

		case '4': 
			cout << "Enter an amount greater than the current principal amount.\n";
			cin >> principaln;
			if ( principaln <= principal)
				cout << "Invalid amount. \n";
			else {
				while (principal < principaln)
				{principaln = principal * pow((1 + rate), years);
				years++;
					}
				cout << "This will take " << years << "years." << endl;
			}
			break;

		case '5':
			cout << "Principal = " << principal << endl << endl;
			cout << "Interest  = " << rate << endl;
			break;

		case '6':
			counter = -399;
			break;

		case '\n':
		case '\t':
		case ' ':
			break;

		default:
			cout << "Not a valid choice \n";
			break;

	}


	}
return 0;

}