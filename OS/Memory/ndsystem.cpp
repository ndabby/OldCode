//Nadine Dabby
//CS 340
//Oct. 11, 2004
//
//System object implementation file
//
//This file implements the functions in the system object header file.

#include "ndsystem.h"


ndsystem::ndsystem(int a, int b, int c, float x, int m){	//The constructor takes three integer arguments,
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

	ram.setSize(m);
	meme* initial = new meme("hole", 0, m);			//FIX FIX FIX FIX FIX FIX FIX
	ram.pushSpace(initial);				 //fix dynamic allocation

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
		std::cout << "      base: " << temp->getPhysAddress() << " limit:" << temp->getPhysLim() << endl;
		(*counter)++;
		if ((*counter) >= 10){
			std::cout << "Press a button and hit enter to continue" << endl;
			std::cin >> n;
			*counter = 0;
		}
	}
}

void ndsystem::getlts(int* counter){
	longterm x;
	myfile* temp;
	char n;
	x = ltscheduler;
	for (int z = (x.getUsed() - 1); z >=0; z--){
		temp = x.pop(z);
		std::cout << "PID: " << temp->getPid() << "  size: " << temp->getPhysSize() <<endl;
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
	
	std::cout << "Long Term Scheduler: These process are waiting for memory allocation (in order of size)" << endl;
	(*counter)++;
	getlts(counter);


	std::cout << "Free Space Table: " <<endl;
	ram.printSpace(counter);

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


void ndsystem::arrive(int x){			//creates a new process and adds it to the scheduler queue
	myfile* me = new myfile(x, 5);
	int place = ram.getNextFree(x);
	if (place > -1){
		ram.addProcess(me);
		scheduler.push(me);
	}
	else {
		ltscheduler.push(me);
	}
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

string ndsystem::myItoA(int i){					//this function converts an integer to a string
	char th = 1/1000 + '0';
	char h = (i%1000)/100 + '0';
	char t = (i%100)/10 + '0';
	char o = i%10 + '0';
	string s = "";
	s = s + th;
	s = s+h;
	s = s+t;
	s = s+o;
	return s;
}



myfile* ndsystem::memeToFile(meme* x){
	
	int id = x->getBase();

	myqueue sched;							//finding and returning
	sched = scheduler;						//if it finds it.
	myfile* temp;
	int siz = scheduler.size();
	for (int j = 0; j < siz; j++){
		if (sched.top()->getPhysAddress() == id){
			temp = sched.pop();
			return temp;
		}
		else sched.pop();
	}
	int pr = _print.size();				//and looks for the process in the scheduler and all
	int di = _disk.size();				//devices so that it can kill it.
	int cd = _cd.size();
	
	queue<myfile*,list<myfile*> > f;
	
	for (int a = 0; a < pr; a++){
		f = _print[a]->getQ();
		for (int j = 0; j < _print[a]->getSize(); j++){
			if (f.front()->getPhysAddress() == id){
				temp = f.front();
				f.pop();
				return temp;
			}
			else f.pop();
		}
	}

	for (int y = 0; y < di; y++){
		f = _disk[y]->getQ();
		for (int h = 0; h < _disk[y]->getSize(); h++){
			if (f.front()->getPhysAddress() == id){
				temp = f.front();
				return temp;
			}
			else f.pop();
		}
	}

	for (int z = 0; z < cd; z++){
		f = _cd[z]->getQ();
		for (int l = 0; l < _cd[z]->getSize(); l++){
			if (f.front()->getPhysAddress() == id){
				temp = f.front();
				return temp;
			}
			else f.pop();
		}
	}
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
			ram.remProcess(temp);
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

void ndsystem::ltschedkill(int i){		//this function searches within the scheduler
	longterm x;							//for the process you want to kill and kills it
	x = ltscheduler;						//if it finds it.
	longterm retry;
	myfile* temp;
	int siz = ltscheduler.getUsed();
	for (int j = 0; j < siz; j++){
		if (x.getData(j)->getPid() == i){	
			temp = x.pop(j);
			temp->terminate();
			delete temp;
		}
		else {
			temp = x.pop(j);
			retry.push(temp);
		}
	}
	retry.sortme();
	ltscheduler = retry;
}

void ndsystem::suicide(int i){			//this function takes an integer (the pid of a process)
	int pr = _print.size();				//and looks for the process in the scheduler and all
	int di = _disk.size();				//devices so that it can kill it.
	int cd = _cd.size();
	
	schedkill(i);
	ltschedkill(i);

	myfile* temp;						
	queue<myfile*,list<myfile*> > f;
	queue<myfile*,list<myfile*> > empt;
	queue<myfile*,list<myfile*> > retry;
	
	for (int x = 0; x < pr; x++){
		f = _print[x]->getQ();
		retry = empt;
		for (int j = 0; j < _print[x]->getSize(); j++){
			if (f.front()->getPid() == i){
				temp = f.front();
				f.pop();
				ram.remProcess(temp);
				temp->terminate();
				delete temp;
			}
			else {
				temp = f.front();
				f.pop();
				retry.push(temp);
			}
		}
		_print[x]->setQ(retry);
	}

	for (int y = 0; y < di; y++){
		f = _disk[y]->getQ();
		retry = empt;
		for (int h = 0; h < _disk[y]->getSize(); h++){
			if (f.front()->getPid() == i){
				temp = f.front();
				f.pop();
				ram.remProcess(temp);
				temp->terminate();
				delete temp;
			}
			else {
				temp = f.front();
				f.pop();
				retry.push(temp);
			}
		}
		_disk[y]->setQ(retry);
	}

	for (int z = 0; z < cd; z++){
		f = _cd[z]->getQ();
		retry = empt;
		for (int l = 0; l < _cd[z]->getSize(); l++){
			if (f.front()->getPid() == i){
				temp = f.front();
				f.pop();
				ram.remProcess(temp);
				temp->terminate();
				delete temp;
			}
			else {
				temp = f.front();
				f.pop();
				retry.push(temp);
			}
		}
		_cd[z]->setQ(retry);
	}
}


void ndsystem::bestFit(){		//something has been terminated so need to load whatever we can
								//if there are leftovers and fragmented room, compactify!
	myfile* someone;
	if (ltscheduler.isEmpty() == 0){
		for ( int q = ltscheduler.getUsed() - 1; q > -1; q--){
			if (ram.getNextFree(ltscheduler.getData(q)->getPhysSize()) > -1){
				ram.addProcess(ltscheduler.getData(q));
				someone = ltscheduler.pop(q);
				scheduler.push(someone);
			}
		}
		int room = ram.getRoom();
		int victim = -1;
		for (int z = 0; z < ltscheduler.getUsed(); z++){
			if (ltscheduler.getData(z)->getPhysSize() <= room){
				victim = z;
			}
		}
		if (victim > -1){
			compactifyLoad(ltscheduler.getData(victim));
			ltscheduler.pop(victim);
		}
	}
}


void ndsystem::compactifyLoad(myfile* x){
	string nombre = myItoA(x->getPid());
	if(x->getPhysSize() <= ram.getRoom()){
		meme* cursor = ram.getHead();
		meme* follow = cursor;
		myfile* me = memeToFile(cursor);
		cursor->setBase(0);
		me->setPhysAddress(0);

		cursor = cursor->link();

		while (cursor != NULL){
			me = memeToFile(cursor);			
			cursor->setBase(follow->getBase() + follow->getSize() - 1);
			me->setPhysAddress(cursor->getBase());
			cursor = cursor->link();
			follow = follow->link();
		}
		int add = follow->getBase() + follow->getSize();
		int total = ram.getRoom();
		ram.emptyFree();  
		meme* consolidate = new meme("hole", add, total); 
		ram.pushFree(consolidate);         //need to consolidate it all here
		ram.addProcess(x);
		scheduler.push(x);
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
