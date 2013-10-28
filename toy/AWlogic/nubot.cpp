/*
 *  nubot.cpp
 *  
 *
 *  Created by Nadine Dabby on 4/5/06.
 *  Copyright 2006 __California Institute of Technology__. All rights reserved.
 *
 */
#include "leg.h"
#include "nubot.h"

nubot::nubot(int i, int t, int r, float Xloc, float Yloc, int firsttype, int firststate){    // one leg
	index = i;
	totleg = t;
	rigid = r;
	flexible = totleg - rigid;
	Xcoor = Xloc;
	Ycoor = Yloc;
	feet[0] = new leg(firsttype, firststate);
	for (int j = 1; j < 6; j++){
		feet[j] = NULL;
	}
}

nubot::nubot(int i, int t, int r, float Xloc, float Yloc, int firsttype, int firststate, int secondtype, int secondstate){	// two legs
	index = i;
	totleg = t;
	rigid = r;
	flexible = totleg - rigid;
	Xcoor = Xloc;
	Ycoor = Yloc;
	feet[0] = new leg(firsttype, firststate);
	feet[1] = new leg(secondtype, secondstate);
	for (int j = 2; j < 6; j++){
		feet[j] = NULL;
	}
}

nubot::nubot(int i, int t, int r, float Xloc, float Yloc, int firsttype, int firststate, int secondtype, int secondstate, int thirdtype, int thirdstate){	// three legs
	index = i;
	totleg = t;
	rigid = r;
	flexible = totleg - rigid;
	Xcoor = Xloc;
	Ycoor = Yloc;
	feet[0] = new leg(firsttype, firststate);
	feet[1] = new leg(secondtype, secondstate);
	feet[2] = new leg(thirdtype, thirdstate);
	for (int j = 3; j < 6; j++){
		feet[j] = NULL;
	}
}

nubot::nubot(int i, int t, int r, float Xloc, float Yloc, int firsttype, int firststate, int secondtype, int secondstate, int thirdtype, int thirdstate, int fourthtype, int fourthstate){	// four legs
	index = i;
	totleg = t;
	rigid = r;
	flexible = totleg - rigid;
	Xcoor = Xloc;
	Ycoor = Yloc;
	feet[0] = new leg(firsttype, firststate);
	feet[1] = new leg(secondtype, secondstate);
	feet[2] = new leg(thirdtype, thirdstate);
	feet[3] = new leg(fourthtype, fourthstate);
	for (int j = 4; j < 6; j++){
		feet[j] = NULL;
	}
}

nubot::nubot(int i, int t, int r, float Xloc, float Yloc, int firsttype, int firststate, int secondtype, int secondstate, int thirdtype, int thirdstate, int fourthtype, int fourthstate, int fifthtype, int fifthstate){	// five legs
	index = i;
	totleg = t;
	rigid = r;
	flexible = totleg - rigid;
	Xcoor = Xloc;
	Ycoor = Yloc;
	feet[0] = new leg(firsttype, firststate);
	feet[1] = new leg(secondtype, secondstate);
	feet[2] = new leg(thirdtype, thirdstate);
	feet[3] = new leg(fourthtype, fourthstate);
	feet[4] = new leg(fifthtype, fifthstate); 
	feet[5] = NULL;
}

nubot::nubot(int i, int t, int r, float Xloc, float Yloc, int firsttype, int firststate, int secondtype, int secondstate, int thirdtype, int thirdstate, int fourthtype, int fourthstate, int fifthtype, int fifthstate, int sixthtype, int sixthstate){	// six legs
	index = i;
	totleg = t;
	rigid = r;
	flexible = totleg - rigid;
	Xcoor = Xloc;
	Ycoor = Yloc;
	feet[0] = new leg(firsttype, firststate);
	feet[1] = new leg(secondtype, secondstate);
	feet[2] = new leg(thirdtype, thirdstate);
	feet[3] = new leg(fourthtype, fourthstate);
	feet[4] = new leg(fifthtype, fifthstate);
	feet[5] = new leg(sixthtype, sixthstate);
}

nubot::~nubot(){							//destructor
	for (int i = 0; i < totleg; i++){
		delete feet[i];
	}
}

void nubot::setState(int i, int s){
	feet[i]->setState(s);
}

int nubot::getState(int i){	//returns state of leg at index i
	int n = -1;				//or returns -1 if input is invalid
	if (i >= 0 && i < totleg){
		n = feet[i]->getState();
	}
	return n;	
}

int nubot::getType(int i){	//returns type of leg at index i
	int n = -1;				//or returns -1 if input is invalid
	if (i >= 0 && i < totleg){
		n = feet[i]->getKind();
	}
	return n;	
}

void nubot::setBound(int i, nubot* n){
	feet[i]->setConn(n);
}

nubot* nubot::getBound(int i){
	feet[i]->getConn();
}

bool nubot::amistuck(void){
	for(int i = 0; i < totleg; i++){ //my nubot leg
		if (getBound(i) != NULL){
			for(int j = i+1; j< totleg; j++){ //other nubot leg
				if (getBound(j) != NULL){
					for(int k = 0; k < getBound(j)->getTotLeg(); k ++){
						if(getBound(j)->getBound(k) == getBound(i)){
							return 1;
						}
					}
				}
			}
		}
	}	
	return 0;
}

int nubot::getTotLeg(void){	//returns total number of legs
	return totleg;
}

float nubot::getXLocation(void){	//returns center of nubot
	return Xcoor;
}

float nubot::getYLocation(void){
	return Ycoor;
}

void nubot::setX(float i){
	Xcoor = i;
}

void nubot::setY(float i){
	Ycoor = i;
}
