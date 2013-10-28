/*
 *  glfun.cpp
 *  
 *
 *  Created by Nadine Dabby on 4/19/06.
 *  Copyright 2006 __California Institute of Technology__. All rights reserved.
 *
 */
// rotations
//collission detection
//3D
//RANDOM PARTIcle MOVEMENT
//deal with circles


#include <vector> 

#include "glfun.h"

ofstream foutresult("results.txt", ios::out); //output file
GLuint myList;

double distance(double x, double y, double a, double b){
	double dist = sqrt(pow((x-a),2) + pow((y-b),2));
	return dist;
}


void initialize(void)
{			
	ifstream inNubot("S_nubot.txt", ios::in); //input nubot file
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
					leg1state = (int)(10*leg1) - 10*(floor(leg1));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state);
					botindex++;
					break;
			case 2: inNubot>> leg1 >> leg2;
					leg1kind = floor(leg1);
					leg1state = (int)((10 * leg1) - (10*(floor(leg1))));
					leg2kind = floor(leg2);
					leg2state = (int)((10 *leg2) - 10*(floor(leg2)));
					bot[botindex] = new nubot(botindex, leg, rigid, Xcoor, Ycoor, leg1kind, leg1state, leg2kind, leg2state);
					botindex++;
					break;
			case 3:inNubot>> leg1 >> leg2 >> leg3;
					leg1kind = floor(leg1);
					leg1state = (int)((10 * leg1) - (10*(floor(leg1))));
					leg2kind = floor(leg2);
					leg2state = (int)((10 * leg2) - (10*(floor(leg2))));
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
	
	ifstream inRules("S_rule.txt", ios::in); //input rule file
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
						if ((distance(bot[g]->getXLocation(), bot[g]->getYLocation(), bot[h]->getXLocation(), bot[h]->getYLocation()) - 2*radius) <= prox){
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
	
	ifstream inConnect("S_Connection.txt", ios::in); //input connect file
	
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
		for(int k = 0; k < ruleSize; k++){
			if((decidetable[tindex].kind1 == ruletable[k].lega1kind && decidetable[tindex].kind2 == ruletable[k].lega2kind 
				&& decidetable[tindex].state1 == ruletable[k].lega1state && decidetable[tindex].state2 == ruletable[k].lega2state
				&& decidetable[tindex].bound == ruletable[k].bounda) 
				|| (decidetable[tindex].kind2 == ruletable[k].lega1kind   && decidetable[tindex].kind1 == ruletable[k].lega2kind 
				&& decidetable[tindex].state2 == ruletable[k].lega1state   && decidetable[tindex].state1 == ruletable[k].lega2state 
				&& decidetable[tindex].bound == ruletable[k].bounda)){
				yes = 1;
	/*test*/	if(ruletable[k].bounda == 0 && ruletable[k].boundb == 0 && decidetable[tindex].bot1 != decidetable[tindex].bot2){
					decidetable[tindex].neighbor = 0;
				}
			}
		}
		if(yes == 1){
			decidetable[tindex].applicable =1;
		}
		else{decidetable[tindex].applicable =0;}
		decidetable[tindex].decision = (decidetable[tindex].neighbor && decidetable[tindex].applicable);
	}
/*		
		foutresult<< "Initial decision TABLE"<< endl;
		for(int p = 0; p<decSize; p++){ 
		foutresult<< decidetable[p].bot1 << "." << decidetable[p].leg1 << ", " << decidetable[p].bot2 << "." << decidetable[p].leg2
		<< "\t " << decidetable[p].neighbor << "\t" << decidetable[p].bound << "\t"
		<< decidetable[p].kind1 << "." << decidetable[p].state1 << ", " <<decidetable[p].kind2 << "." << decidetable[p].state2
		<<"\t" <<decidetable[p].applicable << "\t" << decidetable[p].decision << endl;
		}
	
	
	
*/
	glClearColor(0.0, 0.0, 0.0, 0.0);
	glShadeModel(GL_FLAT);
	myList = glGenLists(botSize);
	GLUquadricObj *qobj;
	qobj = gluNewQuadric();
	gluQuadricDrawStyle(qobj, GLU_FILL); // flat shaded 
	gluQuadricNormals(qobj, GLU_FLAT);
	for(int siz = 0; siz < botSize; siz++){
		glNewList(myList + siz, GL_COMPILE);			//in these logic examples, the objects 
			glColor3f(1.0, 1.0, 1.0);			//aren't changing so i am using static
			gluDisk(qobj, 0, 5.0, 20, 1);		//pictures in list form.
			glColor3f(0.0, 0.0, 1.0);
		glEndList();
	}
}

void redraw(void)
{
	glClear(GL_COLOR_BUFFER_BIT);
	
	int z = -1;
	int y = -1;
	bool yes = 0;

	while((z < decSize) && (yes == 0)){				//make changes
		z++;
		if (decidetable[z].decision == 1){
			while( (y < ruleSize) && (yes == 0)){
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

							foutresult<<  "             ..........." << decidetable[z].bot1 << "." << decidetable[z].leg1 
							<< "." <<decidetable[z].kind1 << "." << decidetable[z].state1 << " is " << decidetable[z].bound 
							<< " with " << decidetable[z].bot2 << "." << decidetable[z].leg2 << "." <<decidetable[z].kind2 
							<< "." << decidetable[z].state2 << endl << endl; 						
						
							yes = 1;
			
				}
			}
		 }
	}
	
	
	
	//srand((unsigned)time(NULL));
	int move, matex;

	move = rand() % botSize;
	nubot* whome = bot[move]; 	
	
	if(yes == 0){	//only rotates if no reaction occurred...
		rotate(whome);
	}
	
	/*
	while(yes == 0){
		move = rand() % botSize;
		if(bot[move]->amistuck() == 0){
				switch(bot[move]->getTotLeg()){
					case 1: if(move == 0){
							bot[move]->setX(bot[move]->getXLocation()-500);
							yes = 1;
						}
						
						else if(move == 28 && bot[28]->getXLocation() == (bot[1]->getXLocation()+ 6*radius) && bot[27]->amistuck()==0){
							bot[move]->setX(bot[move]->getXLocation()+100);
							yes = 1;
						}
						else if(move == 28 ){
							yes = 1;
						}
						break;
					case 5: if(move == 1 ){
							bot[1]->setX(15);
							bot[1]->setY(-9);
						}
						else if(move == 4 && bot[1]->amistuck() == 1 ){
							bot[4]->setX(bot[1]->getXLocation()+ 2*radius);
							bot[4]->setY(bot[1]->getYLocation());						
							whome = bot[4]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[4]->getXLocation() - (matex)*(radius));
								whome->setY(bot[4]->getYLocation() - (matex)*2*radius);						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;
						}
						else if(move == 5 && bot[4]->amistuck() == 1 ){
							bot[5]->setX(bot[1]->getXLocation() + radius);
							bot[5]->setY(bot[1]->getYLocation() - 1.73*radius);						
							nubot* whome = bot[5]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[5]->getXLocation() - (matex)*radius);
								whome->setY(bot[5]->getYLocation() - (matex)*1.73*radius);						
								whome = whome->getBound(2);
								matex++;
								}
							yes = 1;	
						}
						else if(move == 6 && bot[5]->amistuck() == 1 ){
							bot[6]->setX(bot[1]->getXLocation() - radius );
							bot[6]->setY(bot[1]->getYLocation() - 1.73*radius);						
							nubot* whome = bot[6]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[6]->getXLocation() - matex*2*radius);
								whome->setY(bot[6]->getYLocation());						
								whome = whome->getBound(2);
								matex++;
								}		
							yes = 1;			
						}
						else if(move == 7 && bot[6]->amistuck() ==1 ){
							bot[7]->setX(bot[1]->getXLocation() - 2*radius);
							bot[7]->setY(bot[1]->getYLocation());						
							nubot* whome = bot[7]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[7]->getXLocation() - matex*radius);
								whome->setY(bot[7]->getYLocation() + matex*1.73*radius);						
								whome = whome->getBound(2);
								matex++;
								}							
							yes = 1;	
						}
						else if(move == 9 && bot[move-1]->amistuck() ==1 ){
							bot[9]->setX(bot[1]->getXLocation() - 2*radius);
							bot[9]->setY(bot[1]->getYLocation() + 1.73*2*radius);						
							nubot* whome = bot[9]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[9]->getXLocation() + matex*radius);
								whome->setY(bot[9]->getYLocation() + matex*1.73*radius);						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;							
						}
						else if(move == 10 && bot[move-1]->amistuck() ==1 ){
							bot[10]->setX(bot[1]->getXLocation());
							bot[10]->setY(bot[1]->getYLocation() + 1.73*2*radius);						
							nubot* whome = bot[10]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[10]->getXLocation() + matex*2*radius);
								whome->setY(bot[10]->getYLocation());						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;							
						}
						else if(move == 12 && bot[move-1]->amistuck() ==1 ){
							bot[move]->setX(bot[1]->getXLocation() + 3*radius);
							bot[move]->setY(bot[1]->getYLocation() + 1.73*radius);						
							nubot* whome = bot[move]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[move]->getXLocation() + matex*radius);
								whome->setY(bot[move]->getYLocation() - matex*1.73*radius);						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;							
						}
						else if(move == 14 && bot[move-1]->amistuck() ==1 ){
							bot[move]->setX(bot[1]->getXLocation() + 3*radius);
							bot[move]->setY(bot[1]->getYLocation() - 1.73*radius);						
							nubot* whome = bot[move]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[move]->getXLocation() - matex*radius);
								whome->setY(bot[move]->getYLocation() - matex*1.73*radius);						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;							
						}		
						else if(move == 16 && bot[move-1]->amistuck() ==1 ){
							bot[move]->setX(bot[1]->getXLocation());
							bot[move]->setY(bot[1]->getYLocation() - 2*1.73*radius);						
							nubot* whome = bot[move]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[move]->getXLocation() - matex*2*radius);
								whome->setY(bot[move]->getYLocation());						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;							
						}
						else if(move == 18 && bot[move-1]->amistuck() ==1 ){
							bot[move]->setX(bot[1]->getXLocation()- 3*radius);
							bot[move]->setY(bot[1]->getYLocation() - 1.73*radius);						
							nubot* whome = bot[move]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[move]->getXLocation() - matex*radius);
								whome->setY(bot[move]->getYLocation() +matex*1.73*radius);						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;
						}	
						else if(move == 21 && bot[move-2]->amistuck() ==1 ){
							bot[move]->setX(bot[1]->getXLocation()- 4*radius);
							bot[move]->setY(bot[1]->getYLocation() + 2*1.73*radius);						
							nubot* whome = bot[move]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[move]->getXLocation() + matex*radius);
								whome->setY(bot[move]->getYLocation() +matex*1.73*radius);						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;
						}						

						else if(move == 23 && bot[move-2]->amistuck() ==1 ){
							bot[move]->setX(bot[1]->getXLocation()- radius);
							bot[move]->setY(bot[1]->getYLocation() + 3*1.73*radius);						
							nubot* whome = bot[move]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[move]->getXLocation() + 2*matex*radius);
								whome->setY(bot[move]->getYLocation());						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;
						}						
						else if(move == 26 && bot[move-3]->amistuck() ==1){
							bot[move]->setX(bot[1]->getXLocation()+ 4*radius);
							bot[move]->setY(bot[1]->getYLocation() + 2*1.73*radius);						
							nubot* whome = bot[move]->getBound(2);
							matex = 1;
							while (whome!= NULL){
								whome->setX(bot[move]->getXLocation() + matex*radius);
								whome->setY(bot[move]->getYLocation() - 1.73*radius);						
								whome = whome->getBound(2);
								matex++;
							}
							yes = 1;
						}
						break;
				}
			}
	}		
	
	*/

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
			bot[decidetable[q].bot2]->getXLocation(), bot[decidetable[q].bot2]->getYLocation()) - 2*radius) <= prox){
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
	/*test*/	if(ruletable[k].bounda == 0 && ruletable[k].boundb == 0 && decidetable[q].bot1 != decidetable[q].bot2){
					decidetable[q].neighbor = 0;
				}
			}
		}
		if(yes == 1){
			decidetable[q].applicable =1;
		}
		else{decidetable[q].applicable =0;}
		decidetable[q].decision = (decidetable[q].neighbor && decidetable[q].applicable);
	}



/*
foutresult << endl <<  "THE DECISION TABLE" << endl << "bots \t neighbors \t bound \t states \t applicable \t decision" <<endl;

	for(int p = 0; p<decSize; p++){ 
		if(decidetable[p].bot1 == 27 && decidetable[p].leg1 == 1 && decidetable[p].bot2 == 27 && decidetable[p].leg2 == 3){  
		foutresult<< decidetable[p].bot1 << "." << decidetable[p].leg1 << ", " << decidetable[p].bot2 << "." << decidetable[p].leg2
		<< "\t " << decidetable[p].neighbor << "\t" << decidetable[p].bound << "\t"
		<< decidetable[p].kind1 << "." << decidetable[p].state1 << ", " <<decidetable[p].kind2 << "." << decidetable[p].state2
		<<"\t" <<decidetable[p].applicable << "\t" << decidetable[p].decision << endl;
		}
		}
*/	
	//Do the drawing based on above update

// srand((unsigned)time(NULL));
 int mydegree;		
glPushMatrix();
	glTranslatef(-80.0, 20.0, 0.0);
	glColor3f(1.0, 1.0, 1.0);
	for(int coo = 0; coo < botSize; coo++){
		glTranslatef(bot[coo]->getXLocation(), bot[coo]->getYLocation(), 0.0);
		glCallList(myList + coo);
		glTranslatef(-(bot[coo]->getXLocation()), -(bot[coo]->getYLocation()), 0.0);
	}
	glLineWidth(2.0);
	glColor3f(0.0, 0.0, 1.0);
	for(int nub = 0; nub< botSize; nub++){ 
		for(int rad = 0; rad< bot[nub]->getTotLeg(); rad++){ 
			if (bot[nub]->getBound(rad) != NULL){
				if(rad == 0 || rad == 2){
					glColor3f(1.0, 0.0, 1.0);
					glBegin(GL_LINES);
						glVertex2f(bot[nub]->getXLocation(), bot[nub]->getYLocation());
						glVertex2f(0.5*(bot[nub]->getXLocation() + bot[nub]->getBound(rad)->getXLocation()), 
							0.5*(bot[nub]->getYLocation() + bot[nub]->getBound(rad)->getYLocation()));
					glEnd();
					glColor3f(0.0, 0.0, 1.0);
				}
				else{
					glBegin(GL_LINES);
						glVertex2f(bot[nub]->getXLocation(), bot[nub]->getYLocation());
						glVertex2f(0.5*(bot[nub]->getXLocation() + bot[nub]->getBound(rad)->getXLocation()), 
							0.5*(bot[nub]->getYLocation() + bot[nub]->getBound(rad)->getYLocation()));
					glEnd();
				}
			}
			else{
				mydegree = rand() % 360;
				glBegin(GL_LINES);
					glVertex2f(bot[nub]->getXLocation(), bot[nub]->getYLocation());
					glVertex2f((bot[nub]->getXLocation() +radius*sin(mydegree)), (bot[nub]->getYLocation() + radius*cos(mydegree)));
				glEnd();
			}	
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
	glOrtho(-200.0, 200.0, -200.0, 200.0, -1.0, 1.0);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}


void key(unsigned char k, int x, int y)
{
   switch (k) {
		case 'p':
			bot[28]->setX(bot[1]->getXLocation() + 7*radius);
			bot[28]->setY(bot[1]->getYLocation() + 1.73*radius);
			break;
		
		case 'q':
			for (int z = 0; z < botSize; z++){	//clean up allocated memory
				delete bot[z];
			}
			exit(0);
			break;
		default:
			break;
   }
}


////////////////////////////////////////////////////////////////////


void rotate(nubot* me){   //i could return a bool to see if rotation happened... 
	
	if(me->amistuck() == 1){
		return;
		}								//not stuck and we have a branch we can turn sort of
										//what to do if we have a circle? STILL NEED TO GRAPPLE WITH THIS ISSUE 
	//check for circle here				//collission detection NEED TO DO THIS (with other random particles)
										//////may incorporate it into 3-d version
										//n^2 check both left and right
									//if bond is possible then do it, if not we pick a random angle
//	srand((unsigned)time(NULL));
	int myleg = rand() % 5;            //pick a leg, any leg
	if(me->getTotLeg() < 5 || me->getBound(myleg) == NULL){	//fix this later depending on legs quantity
		return;
		}	

							
	std::vector<nubot*> groupAbots;			//leftbot   vector
	std::vector<nubot*> groupBbots;			//rightbot vector

	me->setDiscoverBit(1);
	groupAbots = DFSvisit(groupAbots, me->getBound(myleg));
	
	clearDFS(bot, botSize);

	cout<< endl<< endl<< me->getIndex() <<endl;
	
	me->getBound(myleg)->setDiscoverBit(1);
	me->setDiscoverBit(1);
	for(int m = 0; m < me->getTotLeg(); m++){							//put for-loop here so that we 
		if(me->getBound(m) != NULL){									//we don't include pivot in groupB
			if(me->getBound(m)->getDiscoverBit() == 0){
				groupBbots = DFSvisit(groupBbots, me->getBound(m));
			}
		}
	}
	
	clearDFS(bot, botSize);					//clear discover bits
	
	if(groupAbots.empty() == 1|| groupBbots.empty() ==1){
		return;
	}
	
	double angle[groupAbots.size()][groupBbots.size()];
	
	double dista, distb, distab, asmall, abig;
	double smalldist = 2*radius;
	double x, y;

	//first find angles	
	for (int a = 0; a < groupAbots.size(); a++){
		for(int b = 0; b< groupBbots.size(); b++){
			angle[a][b] = (double)2*pi;				//initialize to max degree			
			
			if((dista - distb)>= (-2*radius) && (dista - distb) <= (2*radius)){ //only check for proximal matches

				dista = distance(me->getXLocation(), me->getYLocation(), groupAbots.at(a)->getXLocation(), groupAbots.at(a)->getYLocation());
				distb = distance(me->getXLocation(), me->getYLocation(), groupBbots.at(b)->getXLocation(), groupBbots.at(b)->getYLocation());
				distab = distance(groupAbots.at(a)->getXLocation(), groupAbots.at(a)->getYLocation(), groupBbots.at(b)->getXLocation(), groupBbots.at(b)->getYLocation());
													//my vast knowledge of the law of cosines at play!
				x = (pow(dista, 2) + pow(distb, 2) - pow(smalldist, 2)) /(2*dista*distb);
				y = (pow(dista, 2) + pow(distb, 2) - pow(distab, 2)) /(2*dista*distb);
				if(x >= -1 && x<=1 && y>=-1 && y<= 1){
					asmall = acos(x);
					abig = acos(y);
					angle[a][b]= abig - asmall;
				}
			//	else if(distab = dista + distb){
			//		angle[a][b] = 0;
			//	}
			}
		}
	}
	
	//then pick smallest (each direction)
	double least = 2*pi;
	int lowa, lowb;
	int higha = -1; 
	int highb = -1;
	double most = 0;
	for(int aa = 0; aa< groupAbots.size(); aa++){
		for(int bb= 0; bb<groupBbots.size(); bb++){
			if(angle[aa][bb] < least){
				least = angle[aa][bb];
				lowa = aa;
				lowb = bb;
			}
			if(angle[aa][bb] > most && angle[aa][bb] < 2*pi){
				most = angle[aa][bb];
				higha = aa;
				highb = bb;
			}
		}
	}
	//FIX THIS NOT JUST MOST BUT ALSO IF NOT COUNTER CLOCKWISE
	double repair = 0;
	if(higha != -1){
		dista = distance(me->getXLocation(), me->getYLocation(), groupAbots.at(higha)->getXLocation(), groupAbots.at(higha)->getYLocation());
		distb = distance(me->getXLocation(), me->getYLocation(), groupBbots.at(highb)->getXLocation(), groupBbots.at(highb)->getYLocation());
		double correction = (pow(dista, 2) + pow(distb, 2) - pow(4 * pi, 2)) /(2*dista*distb);
		if(correction >= -1 && correction<=1){
			repair = acos(correction);
		}
		most = most + repair; //modify high angle to put it on the other side
	}

//then see if collision results in a move
	bool lowresult = 0;
	bool highresult = 0;
	if(lowa < lowb){
		for(int d = 0; d < decSize; d++){
			if (decidetable[d].bot1 == lowa && decidetable[d].bot2 == lowb && decidetable[d].applicable == 1){
				lowresult = 1;
			}
		}
	}
	else{
		for(int dd = 0; dd< decSize; dd++){
			if (decidetable[dd].bot1 == lowb && decidetable[dd].bot2 == lowa && decidetable[dd].applicable == 1){
				lowresult = 1;
			}
		}
	}
	if(higha < highb){
		for(int c = 0; c < decSize; c++){
			if (decidetable[c].bot1 == higha && decidetable[c].bot2 == highb && decidetable[c].applicable == 1){
				highresult = 1;
			}
		}
	}
	else{
		for(int cc = 0; cc< decSize; cc++){
			if (decidetable[cc].bot1 == highb && decidetable[cc].bot2 == higha && decidetable[cc].applicable == 1){
				highresult = 1;
			}
		}
	}
	double rotationangle = 0;
	
	if(lowresult == 0 && highresult == 0){
		int numb = rand()%100;
		if (numb < 50){
			rotationangle = 5;
		}
		else{ 
			rotationangle = -5; //COME BACK HERE AND DEAL
		}
	}
	else if(lowresult == 1 && highresult == 0){
		rotationangle = least;
	}
	else if(lowresult == 0 && highresult == 1){
		rotationangle = most;
	}
	else if(lowresult == 1 && highresult == 1){
		int number = rand()%100;
		if (number < 50){
			rotationangle = least;
		}
		else{ 
			rotationangle = most;
		}
	}


//then rotate //then go back and fix angle determination	
	double rad = distance(me->getXLocation(), me->getYLocation(), groupAbots.at(0)->getXLocation(), groupAbots.at(0)->getYLocation());
	double theta = acos((groupAbots.at(0)->getXLocation() - me->getXLocation())/ rad); //gives me theta in polar coord
	rotationangle = rotationangle + theta;
	float relX, relY;
	for(int poodle = 0; poodle < groupAbots.size(); poodle++){ //move each bot in groupA one by one
		rad = distance(me->getXLocation(), me->getYLocation(), groupAbots.at(poodle)->getXLocation(), groupAbots.at(poodle)->getYLocation());
		relX = rad*cos(rotationangle) + me->getXLocation();
		relY = rad*sin(rotationangle) + me->getYLocation();
		groupAbots.at(poodle)->setX(relX);
		groupAbots.at(poodle)->setY(relY);		
	}

} 
	
														
std::vector<nubot*> DFSvisit(std::vector<nubot*> group, nubot* me){  //Depth-First Search from CLRS (recursive) 
	me->setDiscoverBit(1);							  //called from rotate function
	group.push_back(me);
	for(int i = 0; i < me->getTotLeg(); i++){							//leg count here
		if(me->getBound(i) != NULL){
			if(me->getBound(i)->getDiscoverBit() == 0){
				group = DFSvisit(group, me->getBound(i));
			}
		}
	}
	return group;
}

void clearDFS(nubot** x, int size){   //clears discoverbit after DFS is done
	for (int i = 0; i< size; i++){		//be careful with this guy
		x[i]->setDiscoverBit(0);
	}
}
