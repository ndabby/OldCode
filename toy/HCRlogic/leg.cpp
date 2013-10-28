/*
 *  leg.cpp
 *  
 *
 *  Created by Nadine Dabby on 4/7/06.
 *  Copyright 2006 __California Institute of Technology__. All rights reserved.
 *
 */

#include "leg.h"

leg::leg(int k, int s){ 
	kind = k; 
	state = s;
	connex = NULL;
}

int leg::getState(void){
	return state;
}

int leg::getKind(void){
	return kind;
}

void leg::setState(int x){
	state = x;
}

void leg::setConn(nubot* n){
	connex = n;
}

nubot* leg::getConn(void){
	return connex;
}