//Nadine Dabby
//CS 340
//October 11, 2004
//
//Assignment 1: Main program
//
//PLEASE NOTE, when you enter the number of devices (n), they will be numbered from 
//0 to (n-1). Numbers from 0 to 9 are acceptable. If an invalid number is entered
//the system will assume you mean zero.   
//For a summary of object functions and implementations, please see the notes on the
// .h or .cpp file of the object you seek.

#include "ndsystem.h"
#include <stdlib.h>

using std::cout;
using std::cin;
using std::endl;

int main(){


	int pnumber = -1;
	int dnumber = -1;
	int cnumber = -1;
	char c;
	char *d = &c;

	cout << "Welcome to the Device Installer!" <<endl;

	while (pnumber < 0){
		cout << "Please enter the number of printers you would like to install?" <<endl;
		cout << "(choose a number from 0 to 9), otherwise the system will assume you mean zero" <<endl;
		cin >> c;
		if (47 > atoi(d) && atoi(d) > 57){
			cout << "this is not a valid number." << endl;
			pnumber =0;
			break;
		}
		else pnumber = atoi(d);
		break;

	}
	
	
	while (dnumber < 0){
		cout << "Please enter the number of disks you would like to install?" <<endl;
		cout << "(choose a number from 0 to 9), otherwise the system will assume you mean zero" <<endl;
		cin >> c;

		if (47 > atoi(d) && atoi(d) > 57){
			cout << "this is not a valid number." << endl;
			dnumber =0;
			break;
		}
		else dnumber = atoi(d);
		break;
	}	

	while (cnumber < 0){
		cout << "Please enter the number of CD-RWs you would like to install?" <<endl;
		cout << "(choose a number from 0 to 9), otherwise the system will assume you mean zero" <<endl;
		cin >> c;

		if (47 > atoi(d) && atoi(d) > 57){
			cout << "this is not a valid number." << endl;
			cnumber =0;
			break;
		}
		else cnumber = atoi(d);
		break;
	}

	ndsystem sys(pnumber, dnumber, cnumber); //system is generated

	sys.menu();								//prints menu

	char choice;
	int number;
	
	int x = -1;

	while (x < 0){
		cin >> choice;
		switch (choice){

		case 's':
			sys.getSysStatus();
			break;

		case 'm':
			sys.changeMode();
			break;

		case 'p':
			cin >> number;
			if (/*isdigit((int)number) != 0 &&*/ 0 <= number && number < pnumber ){
				if (device::getMode() == 0){		//user mode
					sys._print[number]->printprompt();
				}
				else sys._print[number]->onOff();	//system mode
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;
		case 'd':
			cin >> number;
			if (/*isdigit(number) == 1 && */ 0 <= number && number < dnumber){
				if (device::getMode() == 0){		//user mode
					sys._disk[number]->prompt();
				}
				else sys._disk[number]->onOff();	//system mode
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;
		case 'c':
			cin >> number;
			if (/*isdigit(number) == 1 &&*/ 0 <= number && number < cnumber){
				if (device::getMode() == 0){		//user mode
					sys._cd[number]->prompt();
				}
				else sys._cd[number]->onOff();		//system mode
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;

		case 'P':
			cin >> number;
			if (/*isdigit(number) == 1 &&*/ 0 <= number && number < pnumber){
				sys._print[number]->pop();
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;
		
		case 'D':
			cin >> number;
			if (/*isdigit(number) == 1 &&*/ 0 <= number && number < dnumber){
				sys._disk[number]->pop();
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;
		
		case 'C':
			cin >> number;
			if (/*isdigit(number) == 1 &&*/ 0 <= number && number < cnumber){			
				sys._cd[number]->pop();
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;

		case 'Q':								//exit
			x = 1;
			break;

		default:
			cout << "That was an invalid choice.";
			break;
		}
	}

	return 0;
}
