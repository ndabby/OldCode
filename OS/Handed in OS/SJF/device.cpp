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
			return;
		}
		else Q.push(s);
		return;//The program should never get to the line below.
	}								//I added it in case I may need it later.
	else std::cout << "ERROR: Device is offline, nothing could be added to this queue." << endl;
};


myfile* device::pop(){					//This function deletes and pops the file from the 
	myfile* me;
	
/*	if (online ==1){				//queue is the device is online.
		if(Q.empty() == 1){
			std::cout << "Queue is empty." << endl;
			return;
		}
		else {		*/				
	me = Q.front();		
	Q.pop();
		//}
	if(Q.empty() == 1){
			status = "idle";		//If the machine is not online it will print
		}	
	return me;					//the error message below
	//}
	//else std::cout << "ERROR: Device is offline, to complete task you must put device online." << endl;
	
};



void device::listFiles(int* counter){					//This function takes a pointer to an int,
	std::cout << "Status: " <<	getStatus() << endl;	//it creates a queue of pointers to
	queue<myfile*,list<myfile*> > f;					//point to the files Q points to 
	f = Q;												//then iterates through the queue
	int n = Q.size();									//printing out the data associated
	char m;													//with each file. It increments the counter
														//from the getSysStatus function.
	for (int i=0; i<n; i++){	
		std::cout << "PID: " << f.front()->getPid() << " " 
			<< f.front()->getType() << " " << f.front()->getName() << " "
			<< f.front()->getAddress() << " " << f.front()->getLength() << endl;
		f.pop();
		(*counter)++;
		if (*counter >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> m;
			*counter = 0;
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

bool device::isOnline(){			//returns true if device is online, false otherwise
	if (online == 1){
		return true;
	}
	else return false;
}

bool device::isEmpty(){				//returns true if device is empty, flase otherwise
	if (Q.empty() == 1){
		return true;
	}
	else return false;
}

int device::devatoi(string x){		//myatoi function for device to ensure that an entered
	int i = 0;						//string is an integer
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


void device::prompt(myfile* x){		//If device is online, this function prompts you for data
	if (online ==1){				//about a file to be added to the queue.
		string ty;					
		string na;					//When using be sure to write "read" or "write" in lower
		string ad;					//case, and make the name and address each one word.
		string le;
		int len;
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
			len = devatoi(le);
			if (len > -1){
				n = 0;
			}
		}
		x->iorequest(ty, na, ad, len);
							//If the device is not online it will print the 
	}								//message below:
	else {std::cout << "ERROR: Device is offline, to complete task you must put device online." << endl;}
};


void device::printprompt(myfile* x){	//If device is online, this function prompts you for data
	string ty;					//about a file to be added to the queue.
	string na;					//When using be sure to write "read" or "write" in lower
	string ad;					//case, and make the name and address each one word.
	string le;
	int len;
	int n;
	std::cout << "This a write request." << endl;
	ty = "write";
	std::cout << "Please enter the name of your file (one word): " << endl;
	std::cin >> na;
	std::cout << "Please enter the address of your file: " << endl;
	std::cin >> ad;
	n = -1;
	while (n == -1){
		std::cout << "Please enter the length of your file as a non-negative integer value of bytes" << endl;
		std::cin >> le;
		len = devatoi(le);
		if (len > -1){
			n = 0;
		}
	}
	x->iorequest(ty, na, ad, len);				
};	


void device::findkillme(int i){			//this function takes an integer (the pid) and 
	int siz = Q.size();					//searches the device for the process and kills it if it 
	myfile* temp;						//finds it.
	queue<myfile*,list<myfile*> > f;
	queue<myfile*,list<myfile*> > retry;
	f = Q;
	for (int j = 0; j < siz; j++){
		if (f.front()->getPid() == i){
			temp = f.front();
			f.pop();
			temp->terminate();
			delete temp;
		}
		else {
			temp = f.front();
			f.pop();
			retry.push(temp);
		}
	}
	Q = retry;
}


bool device::getMode(){			//This function takes no arguments and it 
	return mode;				//returns a boolean value (mode) to anyone 
};								//that wants to see it.

bool device::mode;			




