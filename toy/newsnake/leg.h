/*
 *  leg.h
 *  
 *
 *  Created by Nadine Dabby on 4/7/06.
 *  Copyright 2006 __California Institute of Technology__. All rights reserved.
 *
 */

#include <string>

#ifndef LEG_H
#define LEG_H

class nubot;

class leg{
public:
	leg(int, int);
	
	int getState(void);
	int getKind(void);
	void setState(int);
	void setConn(nubot*);
	nubot* getConn(void);
	
private:
	int kind;
	int state;
	nubot* connex;
};

#endif