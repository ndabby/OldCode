/*
 *  glfun.h
 *  
 *
 *  Created by Nadine Dabby on 4/19/06.
 *  Copyright 2006 __California Institue of Technology__. All rights reserved.
 *
 */

#include <Carbon/Carbon.h>

#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>
#include <stdlib.h>
#include <math.h>

#include <iostream>
using std::ios;
using std::cout;
using std::cin;
using std::endl;

#include <fstream>
using std::ifstream;    //need to input nubots and rules
using std::ofstream;    //need to create output file tracking logic moves

#include "leg.h"
#include "nubot.h"

typedef struct rule_struct{
	int lega1kind, lega1state, lega2kind, lega2state, legb1kind, legb1state, legb2kind, legb2state;
	bool bounda, boundb;
} rule;

typedef struct decide_struct{
	bool neighbor, bound, applicable, decision;
	int bot1, bot2, leg1, leg2, kind1, kind2, state1, state2;  
} decide;


#define xres  500
#define yres 500
#define radius 5
#define decSize 325
#define botSize 9
#define ruleSize 10
#define conSize 9


static decide decidetable[decSize]; //hardcoded 5 choose 2 
static rule ruletable[ruleSize]; //hardcoded
static nubot* bot[botSize];		//hardcoded

double distance(double, double, double, double);

void initialize(void);

void redraw(void);

//void spinDisplay(void);

void reshape(int, int);

void key(unsigned char, int, int);