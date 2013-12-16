//Nadine Dabby
//CS 340
//November 8, 2004
//
//Assignment 2: Main program
//
//PLEASE NOTE, when you enter the number of devices (n), they will be numbered from 
//0 to (n-1).  
//For a summary of object functions and implementations, please see the notes on the
// .h or .cpp file of the object you seek.

#include "ndsystem.h"

#include <math.h>

using std::cout;
using std::cin;
using std::endl;

int myatoi(string);

int main(){

	int pnumber = -1;
	int dnumber = -1;
	int cnumber = -1;
	string input;
	char alfy[10];
	double alf = -1;

	cout << "Welcome to the Device Installer!" <<endl;

	while (pnumber < 0){
		cout << "Please enter the number of printers you would like to install?" <<endl;
		cin >> input;
		pnumber = myatoi(input);
		if (pnumber < 0){
			cout << "this is not a valid number." << endl;
		}
	}
	
	
	while (dnumber < 0){
		cout << "Please enter the number of disks you would like to install?" <<endl;
		cin >> input;
		dnumber = myatoi(input);
		if (dnumber < 0){
			cout << "this is not a valid number." << endl;
		}
	}	

	while (cnumber < 0){
		cout << "Please enter the number of CD-RWs you would like to install?" <<endl;
		cin >> input;
		cnumber = myatoi(input);
		if (cnumber < 0){
			cout << "this is not a valid number." << endl;
		}
	}

	while (alf < 0 || alf > 1){
		cout << "Please enter a history parameter whose value is between 0 and 1: " <<endl;
		cout << "(nondigit entries will be interpreted as 0)" <<endl;
		cin >> input;
		for (int qed = 0; qed < 10; qed++){
			alfy[qed] = input[qed];
		}
		alf = atof(alfy);
		cout << "you entered " << alf << endl;
	}

	ndsystem sys(pnumber, dnumber, cnumber, alf); //system is generated

	sys.menu();								//prints menu

	char choice;
	string prenum;
	int number;
	int time;
	int zzz = 1;     //terminator
	myfile* me;
	
	int x = -1;

	while (x < 0){
		cin >> choice;
		switch (choice){

		case 'A':								//process arrival
			if (sys.scheduler.empty() == 0){
				time = sys.cpuexitprompt();
				me = sys.scheduler.pop();
				me->evictFileInterrupt(time);
				sys.scheduler.push(me);
			}
			sys.arrive();
			break;

		case 's':								//system status
			sys.getSysStatus();
			break;

		case 'm':								//change mode
			sys.changeMode();
			break;

		case 'k':								//kill PID
			cin >> prenum;				
			number = myatoi(prenum);
			if (0 < number && number <= myfile::totprocess ){
				if (device::getMode() == 1){		//system mode
					sys.suicide(number);
				}
				else {					//user mode
					std::cout << "Cannot terminate the process in user mode." <<endl;
				}
				break;
			}
			else cout << "Error, you entered an invalid PID." <<endl;
			break;

		case 't':								//terminate current process
			if (sys.scheduler.empty() ==0){
				number = sys.cpuexitprompt();	
				me = sys.scheduler.pop();
				me->evictFileIO(number);
				me->terminate();
				break;
			}
			else cout<< "Error: there is no process in the CPU" <<endl;
			break;

		case 'p':								//send current process to print
			cin >> prenum;
			number = myatoi(prenum);
			if (0 <= number && number < pnumber ){
				if (device::getMode() == 0 ){//user mode
					if (sys._print[number]->isOnline() && sys.scheduler.empty()== 0){
						time = sys.cpuexitprompt();
						me = sys.scheduler.pop();
						me->evictFileIO(time);
						sys._print[number]->printprompt(me);
						sys._print[number]->pushme(me);
					}
					else std::cout << "Task cannot be performed" <<endl;
				}
				else sys._print[number]->onOff();	//system mode
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;

		case 'd':								//sends current process to disk queue
			cin >> prenum;
			number = myatoi(prenum);
			if (0 <= number && number < dnumber){
				if (device::getMode() == 0){		//user mode
					if (sys._disk[number]->isOnline() && sys.scheduler.empty()== 0){
						time = sys.cpuexitprompt();
						me = sys.scheduler.pop();
						me->evictFileIO(time);
						sys._disk[number]->prompt(me);
						sys._disk[number]->pushme(me);
					}
					else std::cout << "Task cannot be performed" <<endl;
				}
				else sys._disk[number]->onOff();	//system mode
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;

		case 'c':								//sends current process to cd queue
			cin >> prenum;
			number = myatoi(prenum);
			if (0 <= number && number < cnumber){
				if (device::getMode() == 0){
					if (sys._cd[number]->isOnline() && sys.scheduler.empty() == 0){//user mode
						time = sys.cpuexitprompt();
						me = sys.scheduler.pop();
						me->evictFileIO(time);
						sys._cd[number]->prompt(me);
						sys._cd[number]->pushme(me);
					}
					else std::cout << "Task cannot be performed" <<endl;
				}
				else sys._cd[number]->onOff();		//system mode
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;

		case 'P':								//Printer interrupt
			cin >> prenum;
			number = myatoi(prenum);
			if (0 <= number && number < pnumber){
				if (sys._print[number]->isOnline() && sys._print[number]->isEmpty() == 0){
					if (sys.scheduler.empty() == 0){
						time = sys.cpuexitprompt();
						me = sys.scheduler.pop();
						me->evictFileInterrupt(time);
						sys.scheduler.push(me);
					}
					me = sys._print[number]->pop();
					sys.scheduler.push(me);
				}
				else std::cout << "Task cannot be performed" <<endl;
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;
		
		case 'D':								//Disk interupt
			cin >> prenum;
			number = myatoi(prenum);
			if (0 <= number && number < dnumber){
				if (sys._disk[number]->isOnline() && sys._disk[number]->isEmpty() == 0){
					if (sys.scheduler.empty() == 0){
						time = sys.cpuexitprompt();
						me = sys.scheduler.pop();
						me->evictFileInterrupt(time);
						sys.scheduler.push(me);
					}
					me = sys._disk[number]->pop();
					sys.scheduler.push(me);
				}
				else std::cout << "Task cannot be performed" <<endl;
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;
			
		case 'C':								//CD interupt
			cin >> prenum;
			number = myatoi(prenum);
			if (0 <= number && number < cnumber){			
				if (sys._cd[number]->isOnline() && sys._cd[number]->isEmpty() == 0){
					if (sys.scheduler.empty() == 0){
						time = sys.cpuexitprompt();
						me = sys.scheduler.pop();
						me->evictFileInterrupt(time);
						sys.scheduler.push(me);
					}
					
					me = sys._cd[number]->pop();
					sys.scheduler.push(me);
				}
				else std::cout << "Task cannot be performed" <<endl;
				break;
			}
			else cout << "Error, you entered an invalid device." <<endl;
			break;

		case 'Q':			//exit
		case 'q':
			for(zzz=1; zzz <= myfile::totprocess; zzz++){
				sys.suicide(zzz);
			}
			x = 1;
			break;

		default:
			cout << "That was an invalid choice.";
			break;
		}
	}

	return 0;
}



int myatoi(string x){						//myatoi, tests to make sure entered string
	int i = 0;								//is a valid number.
	int number = 0;
	char c;
	while(x[i] != 0){
		c = x[i];
		if (0 < atoi(&c) && atoi(&c) <= 9 ){
			number = (number * 10) + atoi(&c);
		}
		else {
			if (0 == isdigit(x[i] - '0')  && c == 48){
				number = (number * 10) + atoi(&c);
			}
			else{
				number = -1;
				return number;
			}
		}
		i++;
	}
	return number;
}


