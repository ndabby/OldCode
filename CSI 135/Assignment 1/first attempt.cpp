//	Interest Calculator
//	by Nadine L. Dabby
//	March 5, 2004
//
//	This program acts like a simple interactive interest calculator. The user is prompted 
//	by a menu which allows the user to change the principal ($100 default), and the 
//	interest rate (5% default). Using this information the user can use the program to 
//	calculate the principal after a select number of years, to calculate the number of 
//	years it will take the principal to reach a certain value and to  display the interest
//	and principal. 

#include <iostream>
using std::cout;
using std::cin;
using std::endl;
using std::fixed;

#include <iomanip>
using std::setprecision;

int main ()
{
	int selection = 0; // Selection denotes the user's numerical choice.
	double principal = 100.00; // This is the principal amount.
	double newPrincipal3;  // This variable is used to determine the principal in case 3.
	double newPrincipal4; // In case 4, this variable (input by user) is compared against a 
						  // growing principal. 
	double varyPrincipal = principal; // This variable is used to store an accumulating  
									  // principal in case 4.
	double rate = 0.05;	   // This is the interest rate.
	int years;	   // This is the number of years.
	double accumulation = 1; // This variable is used to compound the interest in cases 3 and 4.
	int guard = 0; // This is my sentinel,to end the loop when the user wishes to end the program.


	cout << fixed << setprecision(2); // I am setting the floats to show two decimal places.

//	The program is run using a switch mechanism nested in a loop. So when a user is 
//	confronted by the menu, the user may cycle through the loop an undetermined amount 
//	of times until he or she enters the number "6" at which point, the switch case '6'
//	enters the sentinel value into the "guard" variable which will trigger exit from the
//	loop. The switch within this loop allows for each option in the menu (algorithms 
//	for menu commands will appear beside each case). 
//	To enter the switch the user must enter a digit between 1 and 6, and other character
//	will result in an output of "Not a valid choice."

	while ( guard != -399)
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
		
		case 1:		// The user may input a new principal (only positive numbers will be stored).
			
			cout << "Enter a new principal amount, in dollars and cents:\n";
			cin >> principal;
			if (principal < 0)
				cout << "Not valid data\n\n";
			break; 

		case 2:		// The user may input a new rate (only positive numbers will be stored).
			
			cout << "Enter a new interest rate, as a decimal, not a percentage: \n";
			cin >> rate;
			if (rate < 0)
				cout << "Not valid data\n\n";
			break;

		case 3:		// The number of years entered by the user is as a parameter for a counter  
					// that compounds and stored the accumulating interestin the variable
					// "accumulation". When the loop completes, the principal is multiplied by
					// the compounded interest to result in the new principal.
			
			cout << "Enter a whole number of years greater than 0. \n";
			cin >> years;
			accumulation = 1; // Resets the accumulated interest so this function may be rerun.
			if (years < 0)
				cout << "Invalid data\n\n";
			else
				{{for (int timer = 1; timer <= years; timer++)
					accumulation *= (1 + rate);
					}
				newPrincipal3 = principal * accumulation;
				cout << "\n$" << newPrincipal3 << endl << endl;}  //need to set precision
			break;

		case 4:		// The user enters a new principal which is used as a paramter for a loop
					// that compounds the interest (one year at a time) and determines the 
					// new principal at the end of each year, then adds 1 to the cumber of years. 
					// When the new principal exceeds the input principal the loop is completed, 
					// and the number of years (originally set at 0) is output.

			cout << "Enter an amount greater than the current principal amount.\n";
			cin >> newPrincipal4;
			years = 0; // Resets the accumulated years so this function may be rerun.
			accumulation = 1; // Resets the accumulated interest so this function may be rerun.
			varyPrincipal = principal;
			if ( newPrincipal4 <= principal)
				cout << "Invalid amount. \n\n";
			else {
				while (newPrincipal4 > varyPrincipal)
					{accumulation *= (1 + rate);
					varyPrincipal = principal * accumulation;
					years++;}				
				cout << "\nThis will take " << years << " year(s)." << endl << endl;
			}
			break;

		case 5:		// This selection displays the current principal and rate.
			
			cout << "\nPrincipal = " << principal << endl << endl;
			cout << "Interest  = " << rate << endl << endl;
			break;

		case 6:		// This selection sets the "guard" variable to the sentinel value.
			
			guard = -399;
			break;

		case '\n':
		case '\t':
		case ' ':
			break;

		default:
			cout << "Not a valid choice \n\n";
			break;
		}
	}

	
	return 0;


	}