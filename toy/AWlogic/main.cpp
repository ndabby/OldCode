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
implement move set, rotation sweeping check
get graphics to work ( rotation, translation, cosmetics)
implement walking
*/

/* INPUT: nubot.txt, rule.txt, connect.txt 
nubot.txt specifies nubot set input as follows:
	#bots, index, #legs, #rigid, type.state(of each leg);
rule.txt specifies rule set input as follows:
	type.state bound type.state = type.state bound type.state;
also for now input rules twice for table to work (???)
*/


#include "glfun.h"


//static GLfloat spin = 0.0;
//int MAX_X=100;
//int MAX_Y=100;
//int MIN_X=-100;
//int MIN_Y =-100;

int main(int argc, char** argv) 
{	

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

