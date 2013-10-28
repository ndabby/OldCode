/*
 *  glfun.cpp
 *  
 *
 *  Created by Nadine Dabby on 4/19/06.
 *  Copyright 2006 __California Institute of Technology__. All rights reserved.
 *
 */

#include "glfun.h"

ofstream foutresult("results.txt", ios::out); //output file
GLuint walkList;

double distance(double x, double y, double a, double b){
	double dist = sqrt(pow((x-a),2) + pow((y-b),2));
	return dist;
}

void initialize(void)
{	ifstream inNubot("AW_nubot.txt", ios::in); //input nubot file
	int leg, rigid;
	double leg1, leg2, leg3, leg4, leg5, leg6;
	int leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, 
		leg4kind, leg4state, leg5kind, leg5state, leg6kind, leg6state;
	float Xcoor;
	float Ycoor;
	int botindex = 0;
	while(inNubot >> Xcoor >> Ycoor >> leg >> rigid){
		switch(leg){
			case 0: break;							
			case 1: inNubot>> leg1;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * leg1 - 10*(floor(leg1)));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state);
					botindex++;
					break;
			case 2: inNubot>> leg1 >> leg2;
					leg1kind = floor(leg1);
					leg1state = (int)((10 * leg1) - 10*(floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)((10 *leg2) - 10*(floor(leg2)));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state);
					botindex++;
					break;
			case 3:inNubot>> leg1 >> leg2 >> leg3;
					leg1kind = floor(leg1);
					leg1state = (int)((10 * leg1) - 10*(floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)((10 * leg2) - 10*(floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)((10 * leg3) - 10*(floor(leg3)));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state);
					botindex++;
					break;
			case 4:inNubot>> leg1 >> leg2 >> leg3 >> leg4;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * leg1 - 10*(floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)(10 * leg2 - 10*(floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)(10 * leg3 - 10*(floor(leg3)));
					leg4kind = floor(leg4);
					leg4state = (int)(10 * leg4 - 10*(floor(leg4)));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, leg4kind, leg4state);
					botindex++;
					break;
			case 5:inNubot>> leg1 >> leg2 >> leg3 >> leg4 >> leg5;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * leg1 - 10*(floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)(10 * leg2 - 10*(floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)(10 * leg3 - 10*(floor(leg3)));
					leg4kind = floor(leg4);
					leg4state = (int)(10 * leg4 - 10*(floor(leg4)));
					leg5kind = floor(leg5);
					leg5state = (int)(10 * leg5 - 10*(floor(leg5)));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, leg4kind, leg4state, leg5kind, leg5state);
					botindex++;
					break;
			case 6:inNubot>> leg1 >> leg2 >> leg3 >> leg4 >> leg5 >> leg6;
					leg1kind = floor(leg1);
					leg1state = (int)(10 * leg1 - 10*(floor(leg1)));
					leg2kind = floor(leg2);
					leg2state = (int)(10 * leg2 - 10*(floor(leg2)));
					leg3kind = floor(leg3);
					leg3state = (int)(10 * leg3 - 10*(floor(leg3)));
					leg4kind = floor(leg4);
					leg4state = (int)(10 * leg4 - 10*(floor(leg4)));
					leg5kind = floor(leg5);
					leg5state = (int)(10 * leg5 - 10 * floor(leg5));
					leg6kind = floor(leg6);
					leg6state = (int)((10 * leg6) - (10 * floor(leg6)));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state, leg3kind, leg3state, leg4kind, leg4state, leg5kind, leg5state, leg6kind, leg6state);
					botindex++;
					break;
			default: break;
			}
			

	}
	
	ifstream inRules("AW_rule.txt", ios::in); //input rule file
	bool bound1, bound2;
	double aleg1, aleg2, bleg1, bleg2;
	int tabindex = 0;
	while(inRules >> aleg1 >> bound1 >> aleg2 >> bleg1 >> bound2 >> bleg2){
		ruletable[tabindex].lega1kind = floor(aleg1);
		ruletable[tabindex].lega1state = (int)((10 * aleg1) - 10*(floor(aleg1)));
		ruletable[tabindex].bounda = bound1;
		ruletable[tabindex].lega2kind = floor(aleg2);
		ruletable[tabindex].lega2state = (int)((10 * aleg2) - 10*(floor(aleg2)));
		ruletable[tabindex].legb1kind = floor(bleg1);
		ruletable[tabindex].legb1state = (int)((10 * bleg1) - 10*(floor(bleg1)));
		ruletable[tabindex].boundb = bound2;
		ruletable[tabindex].legb2kind = floor(bleg2);
		ruletable[tabindex].legb2state = (int)((10 * bleg2) - 10*(floor(bleg2)));		
		tabindex++;
	}
	
	foutresult << "The RULES AS I READ THEM" <<endl;
	for(int jj = 0; jj< ruleSize; jj++){
		foutresult << ruletable[jj].lega1kind << "." << ruletable[jj].lega1state << "\t" << ruletable[jj].bounda
			<< "\t" << ruletable[jj].lega2kind << "." << ruletable[jj].lega2state << "\t\t"  
			<< ruletable[jj].legb1kind << "." << ruletable[jj].legb1state << "\t" << ruletable[jj].boundb
			<< "\t" << ruletable[jj].legb2kind << "." << ruletable[jj].legb2state << endl; 
	}


	for(int zz = 0; zz< decSize; zz++){
		decidetable[zz].bound = 0;
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
						if ((distance(bot[g]->getXLocation(), bot[g]->getYLocation(), bot[h]->getXLocation(), bot[h]->getYLocation()) - 2*radius) <= 1){
							decidetable[tindex].neighbor = 1;
						}
						else{ decidetable[tindex].neighbor = 0;}
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
						if ((distance(bot[g]->getXLocation(), bot[g]->getYLocation(), bot[h]->getXLocation(), bot[h]->getYLocation()) - 2*radius) <= 1){
							decidetable[tindex].neighbor = 1;
						}
						else{ decidetable[tindex].neighbor = 0;}
						tindex++;
					}
				}
			}
		}
	}
	
	tindex = 0;
	
	ifstream inConnect("AW_Connection.txt", ios::in); //input connect file
	
	float dude1, dude2;
	int cbot1, cbot2, cleg1, cleg2;
	
	while(inConnect >> dude1 >> dude2){
		cbot1 = floor(dude1);
		cleg1 = (int)((10*dude1) - 10*(floor(dude1)));
		cbot2 = floor(dude2);
		cleg2 = (int)((10*dude2) - 10*(floor(dude2)));
		tindex = 0;
//		foutresult << endl << cbot1 << "." << cleg1 <<" " << cbot2 <<"." <<cleg2;
		bot[cbot1]->setBound(cleg1, bot[cbot2]);
		bot[cbot2]->setBound(cleg2, bot[cbot1]);
		for(tindex; tindex < decSize; tindex++){
			if((decidetable[tindex].bot1 == cbot1 && decidetable[tindex].bot2 == cbot2 && decidetable[tindex].leg1 == cleg1 && decidetable[tindex].leg2 == cleg2)
			|| (decidetable[tindex].bot1 == cbot2 && decidetable[tindex].bot2 == cbot1 && decidetable[tindex].leg1 == cleg2 && decidetable[tindex].leg2 == cleg1)){
				decidetable[tindex].bound = 1;
//				foutresult << "bound";
			}
		}	
	}

	tindex = 0;

	for (tindex; tindex < decSize; tindex++){
		yes = 0;
		for(int k = 0; k < 10; k++){
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
	}
	
	
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glShadeModel(GL_FLAT);
	walkList = glGenLists(9);
	GLUquadricObj *qobj;
	qobj = gluNewQuadric();
	gluQuadricDrawStyle(qobj, GLU_FILL); // flat shaded 
	gluQuadricNormals(qobj, GLU_FLAT);
	glNewList(walkList, GL_COMPILE);			//in these logic examples, the objects 
		glColor3f(1.0, 1.0, 1.0);			//aren't changing so i am using static
		gluDisk(qobj, 0, 5.0, 20, 1);		//pictures in list form.
		glColor3f(0.0, 0.0, 1.0);
	glEndList();
	glNewList(walkList+1, GL_COMPILE);
		glColor3f(1.0, 1.0, 1.0);
		gluDisk(qobj, 0, 5.0, 20, 1);
		glColor3f(0.0, 0.0, 1.0);
		glLineWidth(4.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(walkList+2, GL_COMPILE);
		glColor3f(1.0, 1.0, 1.0);
		gluDisk(qobj, 0, 5.0, 20, 1);
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(walkList+3, GL_COMPILE);		
		glColor3f(1.0, 1.0, 1.0);			
		gluDisk(qobj, 0, 5.0, 20, 1);		
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(walkList+4, GL_COMPILE);		
		glColor3f(1.0, 1.0, 1.0);			
		gluDisk(qobj, 0, 5.0, 20, 1);		
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(walkList+5, GL_COMPILE);		
		glColor3f(1.0, 1.0, 1.0);			
		gluDisk(qobj, 0, 5.0, 20, 1);		
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(walkList+6, GL_COMPILE);		
		glColor3f(1.0, 1.0, 1.0);			
		gluDisk(qobj, 0, 5.0, 20, 1);		
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(walkList+7, GL_COMPILE);		
		glColor3f(1.0, 1.0, 1.0);			
		gluDisk(qobj, 0, 5.0, 20, 1);		
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
	glEndList();
	glNewList(walkList+8, GL_COMPILE);		
		glColor3f(1.0, 1.0, 1.0);			
		gluDisk(qobj, 0, 5.0, 20, 1);		
		glColor3f(0.0, 0.0, 1.0);
		glBegin (GL_LINES);
			glVertex2f (-5.0, 0.0);
			glVertex2f (5.0, 0.0);
		glEnd ();
		glColor3f(0.0, 0.0, 1.0);
	glEndList();
}

void redraw(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	
	int z = -1;
	int y = -1;
	bool yes = 0;
	while(z < decSize && yes == 0){				//make changes
		z++;
		if (decidetable[z].decision == 1){
			while( y < ruleSize && yes == 0){
				y++;
				if (decidetable[z].kind1 == ruletable[y].lega1kind && decidetable[z].kind2 == ruletable[y].lega2kind
					&& decidetable[z].state1 == ruletable[y].lega1state && decidetable[z].state2 == ruletable[y].lega2state
					&& decidetable[z].bound == ruletable[y].bounda){
						foutresult<< decidetable[z].bot1 << "." << decidetable[z].leg1 << "." <<decidetable[z].kind1 << "."
						<< decidetable[z].state1 << " is " << decidetable[z].bound << " with " << decidetable[z].bot2 
						<< "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 << "." << decidetable[z].state2 
						<< "   ....   " << endl;

						bot[decidetable[z].bot1]->setState(decidetable[z].leg1, ruletable[y].legb1state);
						bot[decidetable[z].bot2]->setState(decidetable[z].leg2, ruletable[y].legb2state);
						decidetable[z].state1 = ruletable[y].legb1state;
						decidetable[z].state2 = ruletable[y].legb2state;
						decidetable[z].bound = ruletable[y].boundb;
						if(ruletable[y].bounda == 0 && ruletable[y].boundb == 1){
							bot[decidetable[z].bot1]->setBound(decidetable[z].leg1, bot[decidetable[z].bot2]);
							bot[decidetable[z].bot2]->setBound(decidetable[z].leg2, bot[decidetable[z].bot1]);
						}
						else if(ruletable[y].bounda == 1 && ruletable[y].boundb == 0){
							bot[decidetable[z].bot1]->setBound(decidetable[z].leg1, NULL);
							bot[decidetable[z].bot2]->setBound(decidetable[z].leg2, NULL);
						}
						//if i am let loose i need to move
						if(decidetable[z].bot1 == 0){
							if(bot[0]->amistuck() == 0){
								bot[decidetable[z].bot1]->setX(bot[decidetable[z].bot1]->getXLocation() + 10);   //needs to be refined			
							}
						}
						else if (decidetable[z].bot2 == 0){
							if(bot[0]->amistuck() == 0){
								bot[decidetable[z].bot2]->setX(bot[decidetable[z].bot2]->getXLocation() + 10);   //needs to be refined			
							}
						}
						
						foutresult <<  "             ..........." << decidetable[z].bot1 << "." << decidetable[z].leg1 
						<< "." <<decidetable[z].kind1 << "." << decidetable[z].state1 << " is " << decidetable[z].bound 
						<< " with " << decidetable[z].bot2 << "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 
						<< "." << decidetable[z].state2 << endl << endl; 						
						
						yes = 1;
				}
				if	(decidetable[z].kind1 == ruletable[y].lega2kind && decidetable[z].kind2 == ruletable[y].lega1kind
					&& decidetable[z].state1 == ruletable[y].lega2state && decidetable[z].state2 == ruletable[y].lega1state
					&& decidetable[z].bound == ruletable[y].bounda){
						foutresult<< decidetable[z].bot1 << "." << decidetable[z].leg1 << "." <<decidetable[z].kind1 << "."
						<< decidetable[z].state1 << " is " << decidetable[z].bound << " with " << decidetable[z].bot2 
						<< "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 << "." << decidetable[z].state2 
						<< "   ....   " << endl;

						bot[decidetable[z].bot1]->setState(decidetable[z].leg1, ruletable[y].legb2state);
						bot[decidetable[z].bot2]->setState(decidetable[z].leg2, ruletable[y].legb1state);

						decidetable[z].state1 = ruletable[y].legb2state;
						decidetable[z].state2 = ruletable[y].legb1state;
						decidetable[z].bound = ruletable[y].boundb;
						
						if(ruletable[y].bounda == 0 && ruletable[y].boundb == 1){
							bot[decidetable[z].bot1]->setBound(decidetable[z].leg1, bot[decidetable[z].bot2]);
							bot[decidetable[z].bot2]->setBound(decidetable[z].leg2, bot[decidetable[z].bot1]);
						}
						else if(ruletable[y].bounda == 1 && ruletable[y].boundb == 0){
							bot[decidetable[z].bot1]->setBound(decidetable[z].leg1, NULL);
							bot[decidetable[z].bot2]->setBound(decidetable[z].leg2, NULL);
						}

						if(decidetable[z].bot1 == 0){
							if(bot[0]->amistuck() == 0){
								bot[decidetable[z].bot1]->setX(bot[decidetable[z].bot1]->getXLocation() + 10);   //needs to be refined			
							}
						}
						else if (decidetable[z].bot2 == 0){
							if(bot[0]->amistuck() == 0){
								bot[decidetable[z].bot2]->setX(bot[decidetable[z].bot2]->getXLocation() + 10);   //needs to be refined			
							}
						}
						
						foutresult<<  "             ..........." << decidetable[z].bot1 << "." << decidetable[z].leg1 
						<< "." <<decidetable[z].kind1 << "." << decidetable[z].state1 << " is " << decidetable[z].bound 
						<< " with " << decidetable[z].bot2 << "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 
						<< "." << decidetable[z].state2 << endl << endl; 						
						
						yes = 1;
				}
			}
		 }
	}
	
	//update decide table
	for(int q = 0; q< decSize; q++){
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

		if ((distance(bot[decidetable[q].bot1]->getXLocation(), bot[decidetable[q].bot1]->getYLocation(), 
			bot[decidetable[q].bot2]->getXLocation(), bot[decidetable[q].bot2]->getYLocation()) - 2*radius) <= 1){
			decidetable[q].neighbor = 1;
		}
		else{ decidetable[q].neighbor = 0;}
		yes = 0;
		for(int k = 0; k < ruleSize; k++){
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


foutresult << endl <<  "THE DECISION TABLE" << endl << "bots \t neighbors \t bound \t states \t applicable \t decision" <<endl;

	for(int p = 0; p<decSize; p++){ 
		foutresult<< decidetable[p].bot1 << "." << decidetable[p].leg1 << ", " << decidetable[p].bot2 << "." << decidetable[p].leg2
		<< "\t " << decidetable[p].neighbor << "\t" << decidetable[p].bound << "\t"
		<< decidetable[p].kind1 << "." << decidetable[p].state1 << ", " <<decidetable[p].kind2 << "." << decidetable[p].state2
		<<"\t" <<decidetable[p].applicable << "\t" << decidetable[p].decision << endl;
		}
	
	
	//Do the drawing based on above update
		
glPushMatrix();
	glTranslatef(-30.0, 0.0, 0.0);
	//glRotatef(spin, 0.0, 0.0, 1.0); //shouldn't do anything
	glColor3f(1.0, 1.0, 1.0);
	for(int coo = 0; coo < botSize; coo++){
		glTranslatef(bot[coo]->getXLocation(), bot[coo]->getYLocation(), 0.0);
		glCallList(walkList + coo);
		glTranslatef(-(bot[coo]->getXLocation()), -(bot[coo]->getYLocation()), 0.0);
	}
	glLineWidth(2.0);
	glColor3f(0.0, 0.0, 1.0);
	for(int rad = 0; rad< bot[0]->getTotLeg(); rad++){
		if (bot[0]->getBound(rad) != NULL){
			glBegin(GL_LINES);
				glVertex2f(bot[0]->getXLocation(), bot[0]->getYLocation());
				glVertex2f(0.5*(bot[0]->getXLocation() + bot[0]->getBound(rad)->getXLocation()), 
							0.5*(bot[0]->getYLocation() + bot[0]->getBound(rad)->getYLocation()));
			glEnd();
		}
		else{
			glBegin(GL_LINES);
				glVertex2f(bot[0]->getXLocation(), bot[0]->getYLocation());
				glVertex2f(bot[0]->getXLocation(), bot[0]->getYLocation()+5);
			glEnd();
		}	
	}
	for(int nub = 1; nub< botSize; nub++){
		if (bot[nub]->getBound(0) != NULL){
			glBegin(GL_LINES);
				glVertex2f(bot[nub]->getXLocation(), bot[nub]->getYLocation());
				glVertex2f(0.5*(bot[nub]->getXLocation() + bot[nub]->getBound(0)->getXLocation()), 
							0.5*(bot[nub]->getYLocation() + bot[nub]->getBound(0)->getYLocation()));
			glEnd();
		}
		else{
			glBegin(GL_LINES);
				glVertex2f(bot[nub]->getXLocation(), bot[nub]->getYLocation());
				glVertex2f(bot[nub]->getXLocation(), bot[nub]->getYLocation()-5);
			glEnd();
		}	
	}




	glColor3f(1.0, 0.0, 0.0);
	glPointSize(4.0);	
	for(int doo = 0; doo< decSize; doo++){
		if(decidetable[doo].bound == 1){
			glBegin(GL_POINTS);
				glVertex2f(0.5*(bot[decidetable[doo].bot1]->getXLocation() + bot[decidetable[doo].bot2]->getXLocation()), 
				0.5*(bot[decidetable[doo].bot1]->getYLocation() + bot[decidetable[doo].bot2]->getYLocation()));
			glEnd();
		}
	}		
	//glColor3f(0.0, 0.0, 1.0)
	glPopMatrix();
	
	glFlush();
	glutSwapBuffers();
	sleep(1);
}
/*
void spinDisplay(void)
{	spin = spin + 2.0;
	if (spin > 360.0)
	{	spin = spin - 360.0;
	}
	glutPostRedisplay();
}
*/

void reshape(int w, int h)
{	glViewport(0, 0, (GLsizei) w, (GLsizei) h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glOrtho(-50.0, 50.0, -50.0, 50.0, -1.0, 1.0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

void key(unsigned char k, int x, int y)
{
   switch (k) {
      default:
	  	for (int z = 0; z < botSize; z++){	//clean up allocated memory
			delete bot[z];
		}
		exit(0);
         break;
   }
}
