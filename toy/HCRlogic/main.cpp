/*
*main.cpp
*
*
* Created by Nadine Dabby on 3/29/06.
* Copyright 2006 __California Institute of Technology__. All Rights Reserved.
*
*/
/*
short to do list:
parse input files
implement rule set
movement
get graphics to work ( translation)
temporary move set vs. plunk and go?
implement walking
output each step, move
put opengl stuff into its own header file
*/

/* INPUT: nubot.txt, rule.txt
nubot.txt specifies nubot set input as follows:
	#bots, index, #legs, #rigid, type.state(of each leg);
rule.txt specifies rule set input as follows:
	type.state bound type.state = type.state bound type.state;
also for now input rules twice for table to work (???)
*/

/*
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
*/
#include "glfun.h"

//static GLfloat spin = 0.0;
//int MAX_X=100;
//int MAX_Y=100;
//int MIN_X=-100;
//int MIN_Y =-100;
/*

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

decide decidetable[10]; //hardcoded 5 choose 2
rule ruletable[4]; //hardcoded
nubot* bot[3];		//hardcoded
ofstream fout("results.txt", ios::out); //output file
GLuint myList;


double distance(double x, double y, double a, double b){
	double dist = sqrt(pow((x-a),2) + pow((y-b),2));
	return dist;
}


void initialize(void)
{	
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glShadeModel(GL_FLAT);
	myList = glGenLists(3);
	GLUquadricObj *qobj;
	qobj = gluNewQuadric();
	gluQuadricDrawStyle(qobj, GLU_FILL); // flat shaded 
	gluQuadricNormals(qobj, GLU_FLAT);
	glNewList(myList, GL_COMPILE);			//in these logic examples, the objects 
		glColor3f(1.0, 1.0, 1.0);			//aren't changing so i am using static
		gluDisk(qobj, 0, 5.0, 20, 1);		//pictures in list form.
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (0.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(myList+1, GL_COMPILE);
		glColor3f(1.0, 1.0, 1.0);
		gluDisk(qobj, 0, 5.0, 20, 1);
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(myList+2, GL_COMPILE);
		glColor3f(1.0, 1.0, 1.0);
		gluDisk(qobj, 0, 5.0, 20, 1);
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
}

void redraw(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	
	int z = -1;
	int y = -1;
	bool yes = 0;
	while(z < 10 && yes == 0){				//make changes
		z++;
		if (decidetable[z].decision == 1){
			while( y < 4 && yes == 0){
				y++;
				if (decidetable[z].kind1 == ruletable[y].lega1kind && decidetable[z].kind2 == ruletable[y].lega2kind
					&& decidetable[z].state1 == ruletable[y].lega1state && decidetable[z].state2 == ruletable[y].lega2state
					&& decidetable[z].bound == ruletable[y].bounda){
						fout<< decidetable[z].bot1 << "." << decidetable[z].leg1 << "." <<decidetable[z].kind1 << "."
						<< decidetable[z].state1 << " is " << decidetable[z].bound << " with " << decidetable[z].bot2 
						<< "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 << "." << decidetable[z].state2 
						<< "   ....   " << endl;

						bot[decidetable[z].bot1]->setState(decidetable[z].leg1, ruletable[y].legb1state);
						bot[decidetable[z].bot2]->setState(decidetable[z].leg2, ruletable[y].legb2state);
						bot[decidetable[z].bot1]->setX(bot[decidetable[z].bot1]->getXLocation() + 2);   //needs to be refined
						bot[decidetable[z].bot2]->setX(bot[decidetable[z].bot2]->getXLocation() - 1);
						decidetable[z].state1 = ruletable[y].legb1state;
						decidetable[z].state2 = ruletable[y].legb2state;
						decidetable[z].bound = ruletable[y].boundb;
						
						fout <<  "             ..........." << decidetable[z].bot1 << "." << decidetable[z].leg1 
						<< "." <<decidetable[z].kind1 << "." << decidetable[z].state1 << " is " << decidetable[z].bound 
						<< " with " << decidetable[z].bot2 << "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 
						<< "." << decidetable[z].state2 << endl << endl; 						
						
						yes = 1;
				}
				if	(decidetable[z].kind1 == ruletable[y].lega2kind && decidetable[z].kind2 == ruletable[y].lega1kind
					&& decidetable[z].state1 == ruletable[y].lega2state && decidetable[z].state2 == ruletable[y].lega1state
					&& decidetable[z].bound == ruletable[y].bounda){
						fout<< decidetable[z].bot1 << "." << decidetable[z].leg1 << "." <<decidetable[z].kind1 << "."
						<< decidetable[z].state1 << " is " << decidetable[z].bound << " with " << decidetable[z].bot2 
						<< "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 << "." << decidetable[z].state2 
						<< "   ....   " << endl;

						bot[decidetable[z].bot1]->setState(decidetable[z].leg1, ruletable[y].legb2state);
						bot[decidetable[z].bot2]->setState(decidetable[z].leg2, ruletable[y].legb1state);
						if (decidetable[z].bot1 == 1 && decidetable[z].bot2 == 0){
							bot[decidetable[z].bot2]->setX(bot[decidetable[z].bot2]->getXLocation() + 2);
							}
							else if(decidetable[z].bot1 == 0 && decidetable[z].bot2 == 1){
							bot[decidetable[z].bot1]->setX(bot[decidetable[z].bot1]->getXLocation() + 2);
							} 
							else if(decidetable[z].bot1 == 1 && decidetable[z].bot2 == 2){
							bot[decidetable[z].bot2]->setX(bot[decidetable[z].bot2]->getXLocation() - 2);
							} 
							else if(decidetable[z].bot1 == 2 && decidetable[z].bot2 == 1){
							bot[decidetable[z].bot1]->setX(bot[decidetable[z].bot1]->getXLocation() - 2);
							} 
							
							
							
						decidetable[z].state1 = ruletable[y].legb2state;
						decidetable[z].state2 = ruletable[y].legb1state;
						decidetable[z].bound = ruletable[y].boundb;
						
						
						fout<<  "             ..........." << decidetable[z].bot1 << "." << decidetable[z].leg1 
						<< "." <<decidetable[z].kind1 << "." << decidetable[z].state1 << " is " << decidetable[z].bound 
						<< " with " << decidetable[z].bot2 << "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 
						<< "." << decidetable[z].state2 << endl << endl; 						
						
						yes = 1;
				}
			}
		}
	}
	
	//update rule table
	for(int q = 0; q< 10; q++){
		if(decidetable[q].bot1 == decidetable[z].bot1 && decidetable[q].leg1 == decidetable[z].leg1){
			decidetable[q].state1 = decidetable[z].state1;
		}
		if(decidetable[q].bot2 == decidetable[z].bot1 && decidetable[q].leg2 == decidetable[z].leg1){
			decidetable[q].state2 = decidetable[z].state1;
		}
		if(decidetable[q].bot2 == decidetable[z].bot2 && decidetable[q].leg2 == decidetable[z].leg2){
			decidetable[q].state2 = decidetable[z].state2;
		}
		if(decidetable[q].bot1 == decidetable[z].bot2 && decidetable[q].leg1 == decidetable[z].leg2){
			decidetable[q].state1 = decidetable[z].state2;
		}		

		if (distance(bot[decidetable[q].bot1]->getXLocation(), bot[decidetable[q].bot1]->getYLocation(), 
			bot[decidetable[q].bot2]->getXLocation(), bot[decidetable[q].bot2]->getYLocation()) - (2*radius) <= 5){
			decidetable[q].neighbor = 1;
		}
		else{ decidetable[q].neighbor = 0;}
		yes = 0;
		for(int k = 0; k < 4; k++){
			if((decidetable[q].kind1 == ruletable[k].lega1kind && decidetable[q].kind2 == ruletable[k].lega2kind 
				&& decidetable[q].state1 == ruletable[k].lega1state && decidetable[q].state2 == ruletable[k].lega2state
				&& decidetable[q].bound == ruletable[k].bounda) 
				|| (decidetable[q].kind2 == ruletable[k].lega1kind   && decidetable[q].kind1 == ruletable[k].lega2kind 
				&& decidetable[q].state2 == ruletable[k].lega1state   && decidetable[q].state1 == ruletable[k].lega2state 
				&& decidetable[q].bound == ruletable[k].bounda)){
				yes = 1;
			}
		}
		if(yes == 1){
			decidetable[q].applicable =1;
		}
		else{decidetable[q].applicable =0;}
		decidetable[q].decision = (decidetable[q].neighbor && decidetable[q].applicable);
}


fout << endl <<  "THE DECISION TABLE" << endl << "bots \t neighbors \t bound \t states \t applicable \t decision" <<endl;

	for(int p = 0; p<10; p++){ 
		fout<< decidetable[p].bot1 << "." << decidetable[p].leg1 << ", " << decidetable[p].bot2 << "." << decidetable[p].leg2
		<< "\t " << decidetable[p].neighbor << "\t" << decidetable[p].bound << "\t"
		<< decidetable[p].kind1 << "." << decidetable[p].state1 << ", " <<decidetable[p].kind2 << "." << decidetable[p].state2
		<<"\t" <<decidetable[p].applicable << "\t" << decidetable[p].decision << endl;
		}
		
	
	
	
	//Do the drawing based on above update
	glPushMatrix();
	
	//glRotatef(spin, 0.0, 0.0, 1.0); //shouldn't do anything
	glColor3f(1.0, 1.0, 1.0);
	glTranslatef(bot[0]->getXLocation(), bot[0]->getYLocation(), 0.0);
	glCallList(myList);
	glTranslatef(-(bot[0]->getXLocation()), -(bot[0]->getYLocation()), 0.0);
	glTranslatef(bot[1]->getXLocation(), bot[1]->getYLocation(), 0.0);
	glCallList(myList+1);
	glTranslatef(-(bot[1]->getXLocation()), -(bot[1]->getYLocation()), 0.0);
	glTranslatef(bot[2]->getXLocation(), bot[2]->getYLocation(), 0.0);
	glCallList(myList+2);
	glTranslatef(-(bot[2]->getXLocation()), -(bot[2]->getYLocation()), 0.0);
	
	glPopMatrix();
	glFlush();
	glutSwapBuffers();
}

void spinDisplay(void)
{	spin = spin + 2.0;
	if (spin > 360.0)
	{	spin = spin - 360.0;
	}
	glutPostRedisplay();
}

void reshape(int w, int h)
{	glViewport(0, 0, (GLsizei) w, (GLsizei) h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-50.0, 50.0, -50.0, 50.0, -1.0, 1.0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}
*/
//HARDCODE MY PARSER!!!!!!

int main(int argc, char** argv) 
{	
/*	ifstream inNubot("HCR_nubot.txt", ios::in); //input nubot file
	int numb, leg, rigid;
	double leg1, leg2, leg3, leg4, leg5, leg6;
	int leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, 
		leg4kind, leg4state, leg5kind, leg5state, leg6kind, leg6state;
	float Xcoor = 0.0;
	float Ycoor = 0.0;
	int botindex = 0;
	int zz;
	while(inNubot>> numb >> leg >> rigid){
		switch(leg){
			case 0: break;							
			case 1: inNubot>> leg1;
					leg1kind = floor(leg1);
					leg1state = (int)((10 * leg1) - (10*floor(leg1)));
					for(zz = 0; zz < numb; zz++){
						bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state);
						botindex++;
						Xcoor+= 11.0;
					}
					break;
			case 2: inNubot>> leg1 >> leg2;
					leg1kind = floor(leg1);
					leg1state = (int)((10 * leg1) - (10*floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)((10 * leg2) - (10*floor(leg2)));
					for(zz = 0; zz < numb; zz++){
						bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state);
						botindex++;
						Xcoor+=11.0;
					}
					break;
			case 3:inNubot>> leg1 >> leg2 >> leg3;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * (leg1 - floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)(10 * (leg2 - floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)(10 * (leg3 - floor(leg3)));
					for(zz = 0; zz < numb; zz++){
						bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state);
						botindex++;
					}
					break;
			case 4:inNubot>> leg1 >> leg2 >> leg3 >> leg4;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * (leg1 - floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)(10 * (leg2 - floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)(10 * (leg3 - floor(leg3)));
					leg4kind = floor(leg4);
					leg4state = (int)(10 * (leg4 - floor(leg4)));
					for(zz = 0; zz < numb; zz++){
						bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, leg4kind, leg4state);
						botindex++;
					}
					break;
			case 5:inNubot>> leg1 >> leg2 >> leg3 >> leg4 >> leg5;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * (leg1 - floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)(10 * (leg2 - floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)(10 * (leg3 - floor(leg3)));
					leg4kind = floor(leg4);
					leg4state = (int)(10 * (leg4 - floor(leg4)));
					leg5kind = floor(leg5);
					leg5state = (int)(10 * (leg5 - floor(leg5)));
					for(zz = 0; zz < numb; zz++){
						bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, leg4kind, leg4state, leg5kind, leg5state);
						botindex++;
					}
					break;
			case 6:inNubot>> leg1 >> leg2 >> leg3 >> leg4 >> leg5 >> leg6;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * (leg1 - floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)(10 * (leg2 - floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)(10 * (leg3 - floor(leg3)));
					leg4kind = floor(leg4);
					leg4state = (int)(10 * (leg4 - floor(leg4)));
					leg5kind = floor(leg5);
					leg5state = (int)(10 * (leg5 - floor(leg5)));
					leg6kind = floor(leg6);
					leg6state = (int)(10 * (leg6 - floor(leg6)));
					for(zz = 0; zz < numb; zz++){
						bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, leg4kind, leg4state, leg5kind, leg5state, leg6kind, leg6state);
						botindex++;
					}
					break;
			default: break;
			}
			

	}
	
	ifstream inRules("HCR_rule.txt", ios::in); //input rule file
	bool bound1, bound2;
	double aleg1, aleg2, bleg1, bleg2;
	int tabindex = 0;
	while(inRules >> aleg1 >> bound1 >> aleg2 >> bleg1 >> bound2 >> bleg2){
		ruletable[tabindex].lega1kind = floor(aleg1);
		ruletable[tabindex].lega1state = (int)((10 * aleg1) - (10*floor(aleg1)));
		ruletable[tabindex].bounda = bound1;
		ruletable[tabindex].lega2kind = floor(aleg2);
		ruletable[tabindex].lega2state = (int)((10 * aleg2) - (10*floor(aleg2)));
		ruletable[tabindex].legb1kind = floor(bleg1);
		ruletable[tabindex].legb1state = (int)((10 * bleg1) - (10*floor(bleg1)));
		ruletable[tabindex].boundb = bound2;
		ruletable[tabindex].legb2kind = floor(bleg2);
		ruletable[tabindex].legb2state = (int)((10 * bleg2) - (10*floor(bleg2)));		
		tabindex++;
	}
	
	fout << "The RULES AS I READ THEM" <<endl;
	for(int jj = 0; jj< 4; jj++){
		fout << ruletable[jj].lega1kind << "." << ruletable[jj].lega1state << "\t" << ruletable[jj].bounda
			<< "\t" << ruletable[jj].lega2kind << "." << ruletable[jj].lega2state << "\t\t"  
			<< ruletable[jj].legb1kind << "." << ruletable[jj].legb1state << "\t" << ruletable[jj].boundb
			<< "\t" << ruletable[jj].legb2kind << "." << ruletable[jj].legb2state << endl; 
	}
	
	int tindex = 0;
	int yes= 0;

	for (int g = 0; g < botindex; g++){
		for (int h = g; h < botindex; h++){
			if (bot[g] == bot[h]){
				for( int i = 0; i < bot[g]->getTotLeg(); i++){
					for( int j = i + 1; j < bot[h]->getTotLeg(); j++){		
						decidetable[tindex].bot1 = g;
						decidetable[tindex].bot2 = h;
						decidetable[tindex].leg1 = i;
						decidetable[tindex].leg2 = j;
						decidetable[tindex].kind1 = bot[g]->getType(i);
						decidetable[tindex].kind2 = bot[h]->getType(j);
						decidetable[tindex].state1 = bot[g]->getState(i);
						decidetable[tindex].state2 = bot[h]->getState(j);
						if (distance(bot[g]->getXLocation(), bot[g]->getYLocation(), bot[h]->getXLocation(), bot[h]->getYLocation()) - (2*radius) <= 5){
							decidetable[tindex].neighbor = 1;
						}
						else{ decidetable[tindex].neighbor = 0;}
						decidetable[tindex].bound = 0;
						yes = 0;
						for(int k = 0; k < 4; k++){
							if((decidetable[tindex].kind1 == ruletable[k].lega1kind && decidetable[tindex].kind2 == ruletable[k].lega2kind 
								&& decidetable[tindex].state1 == ruletable[k].lega1state && decidetable[tindex].state2 == ruletable[k].lega2state
								&& decidetable[tindex].bound == ruletable[k].bounda) 
								|| (decidetable[tindex].kind2 == ruletable[k].lega1kind   && decidetable[tindex].kind1 == ruletable[k].lega2kind 
								&& decidetable[tindex].state2 == ruletable[k].lega1state   && decidetable[tindex].state1 == ruletable[k].lega2state 
								&& decidetable[tindex].bound == ruletable[k].bounda)){
								yes = 1;
							}
						}
						if(yes == 1){
							decidetable[tindex].applicable =1;
						}
						else{decidetable[tindex].applicable =0;}
						decidetable[tindex].decision = (decidetable[tindex].neighbor && decidetable[tindex].applicable);
						tindex++;
					}	
				}
			}

			else {			
				for( int i = 0; i < bot[g]->getTotLeg(); i++){
					for( int j = 0; j < bot[h]->getTotLeg(); j++){
						decidetable[tindex].bot1 = g;
						decidetable[tindex].bot2 = h;
						decidetable[tindex].leg1 = i;
						decidetable[tindex].leg2 = j;
						decidetable[tindex].kind1 = bot[g]->getType(i);
						decidetable[tindex].kind2 = bot[h]->getType(j);
						decidetable[tindex].state1 = bot[g]->getState(i);
						decidetable[tindex].state2 = bot[h]->getState(j);
						if (distance(bot[g]->getXLocation(), bot[g]->getYLocation(), bot[h]->getXLocation(), bot[h]->getYLocation()) - (2*radius) <= 5){
							decidetable[tindex].neighbor = 1;
						}
						else{ decidetable[tindex].neighbor = 0;}
						decidetable[tindex].bound = 0;
						yes = 0;
						for(int k = 0; k < 4; k++){
							if((decidetable[tindex].kind1 == ruletable[k].lega1kind && decidetable[tindex].kind2 == ruletable[k].lega2kind 
								&& decidetable[tindex].state1 == ruletable[k].lega1state && decidetable[tindex].state2 == ruletable[k].lega2state
								&& decidetable[tindex].bound == ruletable[k].bounda) 
								|| (decidetable[tindex].kind2 == ruletable[k].lega1kind   && decidetable[tindex].kind1 == ruletable[k].lega2kind 
								&& decidetable[tindex].state2 == ruletable[k].lega1state   && decidetable[tindex].state1 == ruletable[k].lega2state 
								&& decidetable[tindex].bound == ruletable[k].bounda)){
								yes = 1;
							}
						}
						if(yes == 1){
							decidetable[tindex].applicable =1;
						}
						else{decidetable[tindex].applicable =0;}
						decidetable[tindex].decision = (decidetable[tindex].neighbor && decidetable[tindex].applicable);
						tindex++;
					}
				}
			}
		}
	}
	
*/
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
	glutInitWindowSize(xres, yres);
	glutInitWindowPosition(100, 100);
	glutCreateWindow("Nubot Simulator");    

	initialize();       //hmmmmmmm...

	glutDisplayFunc(redraw);
	glutReshapeFunc(reshape);
	glutIdleFunc(redraw);
	glutKeyboardFunc(key);
	glutMainLoop();
	
	return 0;
}

