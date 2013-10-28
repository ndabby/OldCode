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
#include <cstdlib>  //srand(); rand() function ; abs()
#include <time.h>  //time() function



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


#define xres 600
#define yres 600
#define radius 5
#define decSize 9316
#define botSize 29
#define ruleSize 107

//#define conSize 8
#define prox 3



static decide decidetable[decSize]; //hardcoded 5 choose 2 
static rule ruletable[ruleSize]; //hardcoded
static nubot* bot[botSize];		//hardcoded

double distance(double, double, double, double);

void initialize(void);

void redraw(void);

//void spinDisplay(void);

void reshape(int, int);

void key(unsigned char, int, int);