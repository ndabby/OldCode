//Nadine Dabby
//CS 340
//October 11, 2004
//
// file object implementation file
//
//This file implements the functions from the file object header. 



#include "myfile.h"


myfile::myfile(int size, float t){						
	
	increment_totprocess();
	pid = totprocess;
	tlast = t;				// all new processes must be initialized to 5.0
	tnext = t;
	tremaining = tnext;
	tsofar = 0;
	tburstsofar = 0;

	type = "read";
	name = "";
	address = 0;
	length = 0;

	physAddress = 0;
	physSize = size;

};

myfile::myfile(){						//default constructor to create dummy processes 
	type = "read";						//for functions
	name = "";
	address = 0;
	length = 0;
	pid = -1;
	tlast = 5.0;
	tnext = (1 - alpha) * tlast;
	tremaining = tnext;
	tsofar = 0;
	tburstsofar = 0;
	physAddress = 0;
	physSize = 0;
}


string myfile::getType(){					//This function takes no arguments 	
	return type;							//and returns a string (the type).
};

string myfile::getName(){					//This function takes no arguments 	
	return name;							//and returns a string (the name).
};

int myfile::getAddress(){				//This function takes no arguments 	
	return address;							//and returns a string (the address).
};

int myfile::getLength(){					//This function takes no arguments 	
	return length;							//and returns an unsigned int(the length).
};


int myfile::getPid(){						//This function takes no arguments 
	return pid;								//and returns an int(the pid).
};

float myfile::getTlast(){					//This function takes no arguments 
	return tlast;							//and returns a float(tlast).
};

float myfile::getTnext(){					//This function takes no arguments 
	return tnext;							//and returns a float(tnext).
};

unsigned int myfile::getTsofar(){			//This function takes no arguments 
	return tsofar;							//and returns an unsigned int(the tsofar).
};

unsigned int myfile::getTburstsofar(){		//This function takes no arguments 
	return tburstsofar;						//and returns an unsigned int(the tburstsofar).
};


float myfile::getTremaining(){				//This function takes no arguments 
	return tremaining;						//and returns a float(the time remaining).
};

void myfile::terminate(){					//prints terminated file info
	myfile::terminated = myfile::terminated + 1;
	myfile::terminatedTotalCPU = myfile::terminatedTotalCPU + tsofar;
	std::cout << "PID " << getPid() << " accumulated CPU time: " << getTsofar() << endl;
}


int myfile::totprocess;						//keeps track of total processes
	
void myfile::increment_totprocess(){		//incrementes total processes
	totprocess++;
};

float myfile::alpha;						//history parameter

unsigned int myfile::cputimer;				//static cpu clock

int myfile::terminated;						//total terminated processes						

unsigned int myfile::terminatedTotalCPU;	//total time used by terminated processes



void myfile::evictFileInterrupt(int x){	//This function takes an integer argument
	tsofar = tsofar + x;				//and updates all of the relevent file info
	tburstsofar = tburstsofar + x;		//when an interrupt is signaled
	cputimer = cputimer + x;
	tremaining = tnext - tburstsofar;
};

void myfile::evictFileIO(int x){		//This function takes an integer argument
	tburstsofar = tburstsofar + x;					//and updates all relevent file info
	tsofar = tsofar + x;				//when an I/O request is signaled
	cputimer = cputimer + x;
	float temp = tnext;
	tnext = (alpha * tburstsofar) + ((1 - alpha) * tlast);
	tlast = temp;	
	tburstsofar = 0;
	tremaining = tnext - tburstsofar;
};


void myfile::iorequest(string t, string n, int a, unsigned int l){
	type = t;							//This function takes 3 strings and an unsigned
	name = n;							//int as parameters to update file info
	address = a;						//when I/O is requested
	length = l;

}


int myfile::getPhysAddress(){
	return physAddress;
}

int myfile::getPhysSize(){
	return physSize;
}


void myfile::setPhysAddress(int local){
	physAddress = local;
}

int myfile::getPhysLim(){
	int limit = physAddress + physSize -1;
	return limit;
}



void myfile::operator =(myfile &source){	//overloaded =
	name = source.getName();
	type = source.getType();
	address = source.getAddress();
	length = source.getLength();
	pid = source.getPid();
	tlast = source.getTlast();
	tnext = source.getTnext();
	tsofar = source.getTsofar();
	tremaining = source.getTremaining();
	physAddress = source.getPhysAddress();
	physSize = source.getPhysSize();
}