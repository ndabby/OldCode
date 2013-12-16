//Nadine Dabby
//CS 340
//November 8, 2004
//
//file object header file
//
//The file class has ten main components: a PID, an enumerated type (read or write), a string name,
//a string address, an unsigned integer length, total time so far, time in CPU since last burst, 
//estimated Tremaining (burst time left), and estimated Tnext (next burst). 
//The ten public functions allow for this data to be retrieved.
//this file also contains the following static public variables: tal process count, history 
//parameter alpha, CPU timer, total terminated processes and total CPU time used by terminated
//processes.


#include <string>
using std::string;

#include <iostream>
using namespace std;


#ifndef MYFILE_H
#define MYFILE_H

class myfile{
public:
	myfile(int, float);					//constructor
	myfile();						//default constructor to be used in functions
	string getType();				//returns type
	string getName();				//returns name
	int getAddress();			//returns address
	int getLength();				//returns length
	int getPid();					//returns pid
	float getTlast();				//returns last est. burst
	float getTnext();				//returns next estimated burst
	unsigned int getTsofar();		//returns total time of process in CPU
	unsigned int getTburstsofar();	//returns total time since last burst
	float getTremaining();			//returns estimates time remaining
	
	void terminate();				//termination function
	
	static int totprocess;			//keeps track of total processes
	void increment_totprocess();	//increments totprocess
	static float alpha;					//history parameter
	static unsigned int cputimer;		//total time in CPU
	static int terminated;				//total processes terminated
	static unsigned int terminatedTotalCPU;	//total time used by terminated processes



	void iorequest(string, string, int, unsigned int = 0);	//io request sets io details

	void evictFileInterrupt(int);		//increments process time values when interrupted
	void evictFileIO(int);				//increments process time values when IO request is made


	int getPhysAddress();
	int getPhysSize();
	void setPhysAddress(int);
	int getPhysLim();


	void operator =( myfile&);			//overloaded =


private:
	string type;			//type of io request
	string name;			//name
	int address;			//address
	int length;				//length
	enum ttype {read, write};

	int pid;				//pid

	float tlast;				//tlast
	float tnext;				//tnext
	unsigned int tsofar;		//tsofar
	unsigned int tburstsofar;	//tburstsofar
	float tremaining;			//tremaining

	int physAddress;
	int physSize;

};

#endif
