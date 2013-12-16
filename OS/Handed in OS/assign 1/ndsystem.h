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
#include <vector>
#include <string>
using namespace std;

#ifndef NDSYSTEM_H
#define NDSYSTEM_H

class ndsystem{
public:
	ndsystem(int, int, int);		//constructor
	~ndsystem();					//destructor
	void changeMode();				//changes the static boolean mode variable
	void getSysStatus();			//prints out a list of the status of all devices and their 
									//associated print queues.
	void menu();					//prints a menu of options for the main program.

	vector<device*> _print;		//printer
	vector<device*> _disk;		//disk
	vector<device*> _cd;		//cd-rw

};

#endif