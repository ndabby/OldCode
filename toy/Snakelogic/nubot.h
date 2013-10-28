/*
 *  nubot.h
 *  
 *
 *  Created by Nadine Dabby on 4/5/06.
 *  Copyright 2006 __California Institute of Technology__. All rights reserved.
 *
 */

#include <Carbon/Carbon.h>


#ifndef NUBOT_H
#define NUBOT_H

//max number of legs = 6
class leg;

class nubot{

public:							//NEED to deal with states, relative angles later
								//6 constructors for all # of legs
								//#index, #tot number of legs, #rigid, location 
nubot(int, int, int, float, float, int, int);    // one leg
nubot(int, int, int, float, float, int, int, int, int);	// two legs
nubot(int, int, int, float, float, int, int, int, int, int, int);	// three legs
nubot(int, int, int, float, float, int, int, int, int, int, int, int, int);	// four legs
nubot(int, int, int, float, float, int, int, int, int, int, int, int, int, int, int);	// five legs
nubot(int, int, int, float, float, int, int, int, int, int, int, int, int, int, int, int, int);	// six legs
~nubot();

void setState(int, int);  //sets state of leg


int getState(int);	//returns state of leg at index i
int getType(int);	//returns type of leg at index i
void setBound(int, nubot*); //sets leg's pointer to nubot
nubot* getBound(int); //gets pointer to nubot
bool amistuck(void); //checks if any of legs are connected to two neighbors

int getTotLeg(void);	//returns total number of legs
float getXLocation(void);	//returns x-coor of center of nubot
float getYLocation(void);	//returns y-coor of center of nubot
void setX(float);    //need to write this
void setY(float);

private:

leg* feet[6];				//max number of legs is six
int index;
int totleg;
int rigid;
int flexible;
float Xcoor;               //center location
float Ycoor;
};

#endif