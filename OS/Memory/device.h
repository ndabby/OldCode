//Nadine Dabby
//CS 340
//Oct. 11, 2004
//
//device header file
//
//The device object has three private members (a queue of pointers to files, a bool online  
//button, and an enumerated status (offline, idle or busy)) and one public static member, 
//a bool mode that can be seen by every instantiated device.
//The functions are described below:
//

#include "myfile.h"
#include <list>
#include <queue>
//#include <iostream>
using namespace std;

#ifndef DEVICE_H
#define DEVICE_H

class device{
public:
	device();							//constructor
	~device();							//destructor (releases memory)
	void pushme(myfile*);				//pushes a pointer to a file onto the queue
	myfile* pop();							//destroys the front file and pops it off the queue  
	void listFiles(int*);					//lists the data associated with file in the queue
	string getStatus();					//returns status
	void onOff();						//online-offline button
	bool isOnline();					//tests whether device is online
	bool isEmpty();						//tests whether device queue is empty
	int devatoi(string);				//atoi function for device
	void prompt(myfile*);						//prompts user for info for file to be added to queue
	void printprompt(myfile*);
//	void findkillme(int);				//finds and kills a process in device
	int getSize();
	queue<myfile*, list<myfile*> > getQ();
	void setQ(queue<myfile*, list<myfile*> >);

	static bool mode;			//system = 1, user = 0
	static bool getMode();				//returns value of mode

private:

	queue<myfile*,list<myfile*> > Q;	//queue
	bool online;						//online = 1, offline = 0
	string status;						//idle, busy or offline
	enum tstatus {idle, busy, offline};
};
	
#endif