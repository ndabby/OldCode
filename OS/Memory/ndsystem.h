//Nadine Dabby
//CS 340
//Oct. 11, 2004
//
//System object header file
//
//The system object has three public members: three vectors of pointers to devices, 
//representing a vector of printers , a vector of disk drives, and a vector of CD-RWs.
// 
//The functions are described below:

#include "device.h"
#include "myqueue.h"
#include "LongTerm.h"
#include "memunit.h"

#include <vector>
#include <string>
#include <stdlib.h>
#include <ctype.h>
using namespace std;

#ifndef NDSYSTEM_H
#define NDSYSTEM_H

class ndsystem{
public:
	ndsystem(int, int, int, float, int);		//constructor
	~ndsystem();					//destructor
	void changeMode();			//changes the static boolean mode variable
	void getSched(int*);			//prints out list of things in queue
	void getlts(int*);
	void getSysStatus();			//prints out a list of the status of all devices and their 
									//associated print queues.
	
	void arrive(int);					//signals an arrival
	int myownatoi(string);			//atoi funtion
	string myItoA(int);
	myfile* memeToFile(meme*);

	int cpuexitprompt();			//prompts user for exit info
	void schedkill(int);			//kills an item in the scheduler
	void ltschedkill(int);
	void suicide(int);				//finds a pid in any of the devices or scheduler and kills it

	void bestFit();					//best fit alg to load new process into memory
	void compactifyLoad(myfile*);
	void menu();					//prints a menu of options for the main program.
	

	memunit ram;				//memory module
	longterm ltscheduler;		//long term scheduler
	myqueue scheduler;			//scheduler
	vector<device*> _print;		//printer
	vector<device*> _disk;		//disk
	vector<device*> _cd;		//cd-rw

};

#endif