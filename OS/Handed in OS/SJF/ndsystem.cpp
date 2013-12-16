//Nadine Dabby
//CS 340
//Oct. 11, 2004
//
//System object implementation file
//
//This file implements the functions in the system object header file.

#include "ndsystem.h"


ndsystem::ndsystem(int a, int b, int c, float x){	//The constructor takes three integer arguments,
											//the number of each kind of device, 
	device::mode = 0;	
	myfile::totprocess = 0;
	myfile::alpha = x;
	myfile::cputimer = 0;					//and it generates the system by creating
	myfile::terminated = 0;
	myfile::terminatedTotalCPU = 0;			//new devices based on the arguments and pushing them  
	
	
	device* name;							//into the correct vectors.
	for (int i = 0; i < a; i++){
		name = new device();				//the mode is initially set to user mode.
		_print.push_back(name);
	}
	for (int j = 0; j < b; j++){
		name = new device();
		_disk.push_back(name);
	}	
	for (int k = 0; k < c; k++){
		name = new device();
		_cd.push_back(name);
	}
};



ndsystem::~ndsystem(){						//The destructor deletes the devices pointed to 
	int a = _print.size();					//by each vector by iterating through each vector.
	int b = _disk.size();					
	int c = _cd.size();

	for (int i = 0; i < a; i++){
		delete _print[i];
	}

	for (int j = 0; j < b; j++){
		delete _disk[j];
	}	

	for (int k = 0; k < c; k++){
		delete _cd[k];
	}
}



	
void ndsystem::changeMode(){				//This function allows the user to change the mode
	if (device::getMode()== 1)				//of the system.
		device::mode = 0;
	else device::mode = 1;
};

void ndsystem::getSched(int* counter){
	myqueue x;
	myfile* temp;
	char n;
	x = scheduler;
	while (x.empty() == 0){
		temp = x.pop();
		std::cout << "PID: " << temp->getPid() << "  Last est. burst:" << temp->getTlast()
			<< "  Burst left: " << temp->getTremaining()
			<< "  Accumulated CPU time: " << temp->getTsofar() <<endl;
		(*counter)++;
		if ((*counter) >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> n;
			*counter = 0;
		}
	}
}

void ndsystem::getSysStatus(){				//This function allows the user to see the 
	int pr = _print.size();					//status and queue of each device.
	int di = _disk.size();					//To make the speed of printing this data
	int cd = _cd.size();					//manageable (neither too much info, nor
	char n;									//too slow) the function waits for the user after
	int* counter = new int; 				//every 10-12 lines printed.			
	*counter = 0;
	float done;

	if (myfile::terminated > 0){
		done = (myfile::terminatedTotalCPU / myfile::terminated);
	}
	else {done = 0;
	}
	

	std::cout << "CPU Scheduler (" << myfile::cputimer << " time has elapsed so far):" << endl;
	(*counter)++;

	std::cout << myfile::terminated << " processes have terminated, with an ave. CPU time of " 
		<< done << endl;
	(*counter)++;
	getSched(counter);

	std::cout << "Printer:" <<endl;
	(*counter)++;
	for (int i=0; i<pr; i++){
		std::cout << "p" << i << endl; 
		_print[i]->listFiles(counter);
		(*counter)++;
		if (*counter >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> n;
			*counter = 0;
		}
	}
	
	std::cout << std::endl << "Disk:" <<endl;
	(*counter)++;
	for (int j=0; j<di; j++){
		std::cout << "d" << j << endl; 
		_disk[j]->listFiles(counter);
		(*counter)++;
		if (*counter >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> n;
			*counter = 0;
		}
	}

	std::cout << std::endl << "CD-RW:" <<endl;
	(*counter)++;
	for (int k=0; k<cd; k++){
		std::cout << "c" << k << endl; 
		_cd[k]->listFiles(counter);
		(*counter)++;
		if (*counter >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> n;
			*counter = 0;
		}
	}
	delete counter;
};


void ndsystem::arrive(){			//creates a new process and adds it to the scheduler queue
	myfile* me = new myfile(5);
	scheduler.push(me);
}


int ndsystem::myownatoi(string x){		//atoi function to prevent crashes. make sure an entered
	int i = 0;							//string is really a number
	int number = 0;
	char c;
	while(x[i] != 0){
		c = x[i];
		if (0 < atoi(&c) && atoi(&c) <= 9 ){
			number = (number * 10) + atoi(&c);
		}
		else {
			if (0 == isdigit(x[i] - '0') && c == 48){
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

int ndsystem::cpuexitprompt(){		//CPU exit prompt, asks for relevent info when 
	string input;					//an interrupt or I/O request is signaled
	int number = -1;
	while (number < 0){
		std::cout << "How long has the running process been in the CPU?" <<endl;
		std::cin >> input;		
		number = myownatoi(input);
	}

	return number;
}

void ndsystem::schedkill(int i){		//this function searches within the scheduler
	myqueue x;							//for the process you want to kill and kills it
	x = scheduler;						//if it finds it.
	myqueue retry;
	myfile* temp;
	int siz = scheduler.size();
	for (int j = 0; j < siz; j++){
		if (x.top()->getPid() == i){
			temp = x.pop();
			temp->terminate();
			delete temp;
		}
		else {
			temp = x.pop();
			retry.push(temp);
		}
	}
	scheduler = retry;
}

void ndsystem::suicide(int i){			//this function takes an integer (the pid of a process)
	int pr = _print.size();				//and looks for the process in the scheduler and all
	int di = _disk.size();				//devices so that it can kill it.
	int cd = _cd.size();
	
	schedkill(i);
	
	for (int x = 0; x < pr; x++){
		_print[x]->findkillme(i);
	}
	for (int y = 0; y < di; y++){
		_disk[y]->findkillme(i);
	}
	for (int z = 0; z < cd; z++){
		_cd[z]->findkillme(i);
	}
}




void ndsystem::menu(){				//This function prints a menu for the user
	std::cout << endl << "Your system has been generated. You are currently in user mode." << endl;
	std::cout << "Devices are numbered 0 to (n-1)." << endl <<endl;
	std::cout << "Please enter one of the following commands:" << endl <<endl;
	std::cout << "s           displays the current system status" << endl;
	std::cout << "m           will change between system and user mode" <<endl;
	std::cout << "A			  signals the arrival of a new job" <<endl; 
	std::cout << "t           terminates the process currently in the CPU" <<endl;
	std::cout << "p#, d#, c#  will allow you to add the job to a device q if you are in user mode" <<endl;
	std::cout << "            or to turn the particular device on/off in system mode" <<endl;
	std::cout << "P#, D#, C#  signals an interrupt (completion of an I/O task) in either mode" << endl;
	std::cout << "k#		  if entered in sys-op mode will kill the process whose PID is entered" <<endl;
	std::cout << "Q, q        will terminate this program" <<endl;
	std::cout << endl;
};
