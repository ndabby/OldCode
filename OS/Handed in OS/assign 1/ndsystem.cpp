//Nadine Dabby
//CS 340
//Oct. 11, 2004
//
//System object implementation file
//
//This file implements the functions in the system object header file.

#include "ndsystem.h"


ndsystem::ndsystem(int a, int b, int c){	//The constructor takes three integer arguments,
											//the number of each kind of device, 
	device::mode = 0;						//and it generates the system by creating
											//new devices based on the arguments and pushing them  
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



void ndsystem::getSysStatus(){				//This function allows the user to see the 
	int pr = _print.size();					//status and queue of each device.
	int di = _disk.size();					//To make the speed of printing this data
	int cd = _cd.size();					//manageable (neither too much info, nor
	char n;									//too slow) the function waits for the user after
	int* counter = new int; 				//every 10-12 lines printed.			
	*counter = 0;

	std::cout << "Printer:" <<endl;
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


void ndsystem::menu(){				//This function prints a menu for the user
	std::cout << endl << "Your system has been generated. You are currently in user mode." << endl;
	std::cout << "Devices are numbered 0 to (n-1)." << endl <<endl;
	std::cout << "Please enter one of the following commands:" << endl <<endl;
	std::cout << "s           displays the current system status" << endl;
	std::cout << "m           will change between system and user mode" <<endl;
	std::cout << "p#, d#, c#  will allow you to add a job to the device q if you are in user mode" <<endl;
	std::cout << "            or to turn the particular device on/off in system mode" <<endl;
	std::cout << "P#, D#, C#  signals an interrupt (completion of the task) in either mode" << endl;
	std::cout << "Q           will terminate this program" <<endl;
	std::cout << endl;
};
