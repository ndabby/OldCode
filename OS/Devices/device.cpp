//Nadine Dabby
//CS 340
//Oct. 11, 2004
//
//device implementation file
//
//This file implements the functions in the device header file.


#include "device.h"

device::device(){					//Constructor takes zero arguments. It sets the
	online = 1;						//on/off button to on and the status to idle.
	status = "idle";
};


device::~device(){					//Destructor deletes files pointed to from queue
	while (Q.empty() == 0){			//before popping them off, in the case that the 
		delete Q.front();			//program is exited before all the queues are empty.
		Q.pop();
	}
};

void device::pushme(myfile* s){		//This function takes a pointer to a file as an argument
	if (online ==1){				//if the device is online, it adds it to the queue and
		if(Q.empty() == 1){			//sets the status to busy.
			Q.push(s);
			status = "busy";		
		}
		else Q.push(s);				//The program should never get to the line below.
	}								//I added it in case I may need it later.
	else std::cout << "ERROR: Device is offline, nothing could be added to this queue." << endl;
};


void device::pop(){					//This function deletes and pops the file from the 
	if (online ==1){				//queue is the device is online.
		if(Q.empty() == 1){
			std::cout << "Queue is empty." << endl;
			return;
		}
		else {						
			delete Q.front();		
			Q.pop();
			std::cout << "Current task is completed, ready for next job!" << endl;
		}
		if(Q.empty() == 1){
			status = "idle";		//If the machine is not online it will print
		}							//the error message below
	}
	else std::cout << "ERROR: Device is offline, to complete task you must put device online." << endl;
	
};



void device::listFiles(int* counter){					//This function takes a pointer to an int,
	std::cout << "Status: " <<	getStatus() << endl;	//it creates a queue of pointers to
	queue<myfile*,list<myfile*> > f;					//point to the files Q points to 
	f = Q;												//then iterates through the queue
	int n = Q.size();									//printing out the data associated
														//with each file. It increments the counter
														//from the getSysStatus function.
	for (int i=0; i<n; i++){	
		std::cout << f.front()->getType() << " " << f.front()->getName() << " "
			<< f.front()->getAddress() << " " << f.front()->getLength() << endl;
		f.pop();
		(*counter)++;
		if (*counter >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> n;
			counter = 0;
		}
	}
};


string device::getStatus(){			//This function takes no arguments and it 
	return status;					//returns a string (the status of the device)
	
};




void device::onOff(){				//This function takes no arguments.
	if (getMode() == 1){			//It allows you to turn a device on or off
		if (online ==1){			//if and only if you are in system mode.
			online = 0;
			status = "offline";
		}
		else {
			online = 1;
			if (Q.empty() == 1){
				status = "idle";
			}
			else status = "busy";
		}
	}

};

void device::prompt(){				//If device is online, this function prompts you for data
	if (online ==1){				//about a file to be added to the queue and then pushes that
		string ty;					//newly created file onto the queue.
		string na;					//When using be sure to write "read" or "write" in lower
		string ad;					//case, and make the name and address each one word.
		unsigned int le;			
		int n = -1;
		while (n == -1){
			std::cout << "Is this a read or write request? (Please enter in lower case)" << endl;
			std::cin >> ty;
			if (ty == "read" || ty == "write"){
				n = 0;
			}
		}
		std::cout << "Please enter the name of your file (one word): " << endl;
		std::cin >> na;
		std::cout << "Please enter the address of your file: " << endl;
		std::cin >> ad;
		n = -1;
		while (n == -1){
			std::cout << "Please enter the length of your file as a non-negative integer value of bytes" << endl;
			std::cin >> le;
			if (n < (int)le){
				n = 0;
			}
		}
		myfile* x = new myfile(ty, na, ad, le);
		pushme(x);					//If the device is not online it will print the 
	}								//message below:
	else {std::cout << "ERROR: Device is offline, to complete task you must put device online." << endl;}
};


void device::printprompt(){				//If device is online, this function prompts you for data
	if (online ==1){				//about a file to be added to the queue and then pushes that
		string ty;					//newly created file onto the queue.
		string na;					//When using be sure to write "read" or "write" in lower
		string ad;					//case, and make the name and address each one word.
		unsigned int le;			
		int n = -1;
		while (n == -1){
			std::cout << "Is this a read or write request? (Please enter in lower case)" << endl;
			std::cin >> ty;
			if (ty == "write"){
				n = 0;
			}
			if (ty == "read"){
				std::cout<< "Error, you cannot read from a printer, select a new command.";
				return;
			}
		}
		std::cout << "Please enter the name of your file (one word): " << endl;
		std::cin >> na;
		std::cout << "Please enter the address of your file: " << endl;
		std::cin >> ad;
		n = -1;
		while (n == -1){
			std::cout << "Please enter the length of your file as a non-negative integer value of bytes" << endl;
			std::cin >> le;
			if (n < (int)le){
				n = 0;
			}
		}
		myfile* x = new myfile(ty, na, ad, le);
		pushme(x);					//If the device is not online it will print the 
	}								//message below:
	else {std::cout << "ERROR: Device is offline, to complete task you must put device online." << endl;}
};	

bool device::getMode(){			//This function takes no arguments and it 
	return mode;				//returns a boolean value (mode) to anyone 
};								//that wants to see it.

bool device::mode;			




