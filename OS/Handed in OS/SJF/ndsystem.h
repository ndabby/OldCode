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
#include <vector>
#include <string>
#include <stdlib.h>
#include <ctype.h>
using namespace std;

#ifndef NDSYSTEM_H
#define NDSYSTEM_H

class ndsystem{
public:
	ndsystem(int, int, int, float);		//constructor
	~ndsystem();					//destructor
	void changeMode();			//changes the static boolean mode variable
	void getSched(int*);			//prints out list of things in queue
	void getSysStatus();			//prints out a list of the status of all devices and their 
									//associated print queues.
	
	void arrive();					//signals an arrival
	int myownatoi(string);			//atoi funtion
	int cpuexitprompt();			//prompts user for exit info
	void schedkill(int);			//kills an item in the scheduler
	void suicide(int);				//finds a pid in any of the devices or scheduler and kills it

	void menu();					//prints a menu of options for the main program.
	
	myqueue scheduler;			//scheduler
	vector<device*> _print;		//printer
	vector<device*> _disk;		//disk
	vector<device*> _cd;		//cd-rw

};

#endif