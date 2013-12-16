//Nadine Dabby
//May 18, 2004
//Main Program: Produce Market
//
//This is the main program of the Produce Market. The Produce Market, main program along with 
//its classes and header files simulates the inventory and register functions of a real market
//it acts like a store, so that it keeps track of the stock on hand of each product and can 
//increase or decrease the quantity of the products bought and sold and keep track of the cash 
//on hand. It reads data from a file (of market transactions in which the allowed action is
//listed first--that is what the program assumes at least) and then it outputs the request as 
//well as the results of each transaction if it occurred or a message explaining why
//the transaction did not occur to a new file called "ProduceMarketTransactions.txt".
//
//Since no input was posted, I created my own input file called "test.txt" on which the program
//can run, so if you decide to test the program on a file please recopy that file into "test.txt"
//or change the name of the input file in this program (thank you). 

#include "Product.h"
#include "ProduceMarket.h"

using std::endl;
using std::ios;
using std::ifstream;

int main()
{ 
	ifstream fin("test.txt", ios::in );							//opens file "test.txt"
	ofstream fout("ProduceMarketTransactions.txt", ios::out);	//opens or creates output file.

	string word = "";			//this variable will be used to hold the action desired
	double money = 0;			//this variable will be used to store the input cash 
	string name = "";			//this variable will be used to store the input product name
	string kind = "";			//this variable will be used to store the input product type
	int amount = 0;				//this variable will be used to store the input product quantity
	float price = 0.0;			//this variable will be	used to store the input product price
	double cashbox = 0.0;		//this variable will be used to store the quantity of cash on hand

	vector<Product> v;			//ProduceMarket object declared
	ProduceMarket pm( money, v ); //Product market called pm is constructed.


	if (!fin)									//warning message to indicate if the program 
	{											//could not open the input file.
		fout << "File could not be opened" << endl;
		exit(1);
	}


	while (fin >> word)		//I used a while loop with nested if else statments to read and  							
	{						//perform the actions according to the program. The while loop will
							//continue to read through the file until end of file is reached

		if (word == "start")		//If the keyword "start" is read, this if clause outputs the
		{	fout << word << " ";	//order and inputs the next string as the quantity of money 
			fin >> money;			//on hand. It then calls the start() function to initialize 
			fout << money << endl;	//the money in Produce Market pm. Then it outputs the result.
			pm.start(money);
			fout << "Cash has been initialized to $" << money << "." << endl;
		}

		else if( word == "new" )	//If the keyword "new" is is read(it out puts this word), 
		{	fout << word << " ";	//the program reads the next word and stores it as name
			fin >> name >> kind;	//(outputs this) then reads the next word and stores it
									//it as kind. It then calls the function addNew()	
			fout << name << " " << kind << endl;	//if addNew returns true, the product has
													//been added, else the product already
			if (pm.addNew(name, kind, 0))			//exists.
			{fout << name << " of type " << kind << " has been added." << endl;
			}
			else 
			{fout << "This Product already exists." << endl;
			}
		}

		else if( word == "buy" )	//If the keyword "buy" is read, the program stores
									//the next word as name and the next word as kind and 
									//the next word as amount and the next word as price.
									//It then calls function buy(), passing these quantities
									//to the function. 
									//If buy() returns true, the program outputs the result
									//if not it informs the reader why.
									//It also stores the value returned by totalcash() to 
									//cashbox so that the cash on hand can be output.
		{	fout << word << " ";
			fin >> name >> kind >> amount >> price;
			fout << name << "(s) " << kind << " "<< amount << " " << price << endl;
			
			if (pm.buy(name, price, amount))
			{	cashbox = pm.totalcash();
				fout << amount << " " << name << "(s) purchased at " << price;
				fout << " for $" << (price * amount) << ". New cash balance is $";
				fout << cashbox << "." <<endl;
			}
			else
			{	fout << "Cannot perform this transaction, not enough cash." <<endl;
			}
		}

		else if( word == "sell" )	//If the keyword "sell" is read, the program stores
									//the next word as name and the next word as kind and 
									//the next word as amount and the next word as price.
									//It then calls function sell(), passing these quantities.
									//If sell() returns true, the program outputs the result
									//if not it informs the reader why.
		{	fout << word << " ";
			fin >> name >> kind >> amount >> price;
			fout << name << " " << kind << " "<< amount << " " << price << endl;

			if (pm.sell(name, price, amount))
			{	cashbox = pm.totalcash();
				fout << amount << " " << name << "(s) sold at " << price;
				fout << " for $" << (price * amount) << ". New cash balance is $";
				fout << cashbox << "." <<endl;
			}
			else
			{	fout << "Cannot perform this transaction, " << name << " is out of stock." <<endl;
			}
		}

		else if( word == "printall" )	//If the keyword "printall" is read, the program 
		{	fout << word << endl;		//passes the ofstream ref. into the printall() function
			pm.printall(fout);			//so that the inventory is printed directly to file.
		}
		
		else if( word == "print" )		//If the keyword "print" is read, the program stores
		{	fout << word << " ";		//the next word as "kind". it then passes the kind and 
			fin >> kind;				//ofstream ref into the function print() which will
			fout << kind << endl;		//print the inventory of all products of the same type 
			pm.print(kind, fout);		//as "kind" directly to the file.
		}

		else if( word == "totalcash" )	//If the keyword "totalcash" is read the program 
		{	fout << word << endl;		//stores the cash returned from totalcash() to cashbox
			cashbox = pm.totalcash();	//and then outputs the cash on hand.
			fout << "Cash balance is $" << cashbox << "." << endl;
		}

	}
	return 0;
}



