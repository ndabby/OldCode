//Interactive Function-ator
//by Nadine L. Dabby
//March 17, 2004 

//This program displays an interactive menu of mathematical functions to the user. 
//The user is prompted to choose between a mathematical function to perform: 
//The program can check whether a number is perfect or prime, determine the nth
//number in the Fibonacci sequence or find the length of a hailstorm sequence.
//After choosing which function to perform, the user is prompted to enter the
//number on which to perform said function. After the program performs the function
//and outputs the result, the menu is displayed again (until the user chooses 
//to quit).

#include <iostream>

using namespace std;


void menu ();			//This function displays the menu.
int perfect (int);		//This function determines whether a number is perfect.
int prime (int);		//This function determines whether a number is prime.
int fibonacci (int);	//This function finds the Fibonacci number you seek.
int hail (long unsigned);//This function determines the length of a hailstorm sequence.

int main () 
{  
	bool sentinel = true;	//This variable stores the sentinel value.
	char choice;			//Choice denotes the user's selection.
	int Pentry;				//Pentry is the number upon which the perfect function acts.
	int pentry;				//pentry is the number upon which the prime function acts.
	int Fentry;				//Fentry is the number upon which the fibonacci function acts.
	long unsigned Hentry;	//Hentry is the number upon which the hail function acts.

//	The program is run using a switch mechanism nested in a loop. So when a user is 
//	confronted by the menu, the user may cycle through the loop an undetermined amount 
//	of times until he or she enters the choice "q" or "Q" at which point, the switch case 'q'
//	enters changes the boolean sentinel value which will trigger exit from the
//	loop. The switch within this loop allows for each option in the menu. 
//	To enter the switch the user must enter either P, p, F, H, q or Q. Any other
//	character will result in an output of "That was an invalid choice."

	while (sentinel == true)	
	{	menu ();			 //The menu is displayed.
		cin >> choice;		 //The user enters their choice.

		switch (choice) {	 
		
		case 'P':			//If the user enters a positive integer,
							//this choice calls the perfect function. 
			cout << "Enter a positive integer you think may be perfect: ";
			cin >> Pentry;
			if ((Pentry > 0) && ((Pentry % 1) == 0))
			{if (perfect(Pentry) == 1) 
			cout << Pentry << " is perfect." << endl << endl;
			else cout << Pentry << " is not perfect." << endl << endl; 
			}
			break;
		
		
		case 'p':			//If the user enters a positive integer,
							//this choice calls the prime function. 
			cout << "Enter a positive integer that you wish to check for primality: ";
			cin >> pentry;
			if ((pentry > 0) && ((pentry % 1) == 0))
			{if (prime(pentry) == 1)
			cout << pentry << " is prime." << endl << endl;
			else cout << pentry << " is not prime." << endl << endl; 
			}
			break;
	
		case 'F':			//If the user enters a positive integer,
							//this choice calls the fibonacci function. 
			cout << "Enter the position in the Fibonacci sequence: ";
			cin >> Fentry;
			if ((Fentry > 0) && ((Fentry % 1) == 0))
			{ cout << "The Fibonacci number is ";
			  cout << fibonacci(Fentry) << endl << endl;
			}
			break;

			
		case 'H':			//If the user enters a positive integer,
							//this choice calls the hail function. 
			cout << "Enter a large positive integer: ";
			cin >> Hentry;
			if ((Hentry > 0) && ((Hentry % 1) == 0))
			{cout << "The length of the hail storm sequence is "; 
			cout << hail(Hentry) << endl << endl;
			}
			break; 

		case 'q':			//This choice changes the sentinel value causing the
		case 'Q':			//program to terminate.
			sentinel = false;
			break;

		default:
			cout << "That was an invalid choice.\n\n";
			break;

		};
		};
	

	return 0;

}



//The menu function has no parameters; it simply prints the menu when it is called.

void menu ()
{ cout << "PLEASE TYPE THE LETTER THAT CORRESPONDS TO THE CHOICE BELOW: \n\n";
  cout << "P\tCheck whether a number is a perfect number.\n\n";
  cout << "p\tCheck whether a number is a prime number.\n\n";
  cout << "F\tFind a given Fibonacci number.\n\n";
  cout << "H\tFind the length of a Hailstorm sequence.\n\n";
  cout << "q,Q\tQuit the program.\n\n";
}


//The perfect function has one parameter, an integer. The function adds each 
//factor of the entered integer to the variable "checker" and compares this value 
//with that of the integer to determine if the number is perfect. The 
//function then returns 1 if the number is perfect and 0 if the number is not perfect. 
//This function does not change the value of the entered number. 

int perfect (int n)
{	
	int checker = 0;

	for (int counter = 1; counter < n; counter++)
		{if ( n % counter == 0)
			checker = checker + counter; 
		}

	if (checker == n)
		return 1;
	else return 0;
}


//The prime function has one parameter, an integer. The function counts the factors 
//of the entered integer and compares this value ("primer") with two  to determine 
//if the number is prime (since a prime has only two factors--itself and one). The 
//function then returns 1 if the number is prime and 0 if the number is not prime. 
//This function does not change the value of the entered number. 

int prime (int n)
{
	int primer = 0;
	for (int counter = 1; counter <= n; counter++)
		{if (n % counter == 0)
		primer++;
		}
	
	if (primer == 2)
		return 1;
	else return 0;
}



//The fibonacci function has one parameter, an integer. Using three variables, 
//initialized to one, the function adds the two previous entries of the sequence 
//denoted "sum" and "previousSum" to determine the next value and store it in 
//the variable "Newsum". The for loop begins with sequence entries greater than
//two, so the first two numbers in the sequence are one. After calculating the 
//Newsum, previous sum takes on the current sum value, and sum takes on the current 
//Newsum value. The loop continues until the counter passes the entered number.
//The function then returns the sum. This function does not change the value 
//of the entered number.

int fibonacci (int n)
{
	int sum = 1;
	int previousSum = 1;
	int Newsum = 1;

	for (int counter = 0; counter <= n; counter++)
	{if (counter > 2)
	{Newsum = sum + previousSum;
	}	
		
	previousSum = sum;
		sum = Newsum;
	}

	return sum;
}



//The hail function has one parameter, a long unsigned integer, which is manipulated by 
//the function. If the number is even it is divided by two, if not it is multiplied by 
//three, added to one and then divided by two. The number continues to run through this
//loop until it is equal to one.The function then returns the value of the counter which
//is the length of the hail storm sequence. 

int hail (long unsigned n)
{  
	long unsigned begin = n;

	for (int counter = 1; n != 1; counter++)
		if (n % 2 == 0)
			n = n / 2;
		else n = ((3 * n) + 1) / 2;
 
	return counter;
}