/*
 *  glFunctions.cpp
 *  Last modified Mon Mar 13th 2006.
 */

#include "glFunctions.h"


// View stuff
GLdouble projMatrix[16];
GLint viewport[4];
double cameraMatrix[16];
double aspectRatio;

// GLUT variables
int windowWidth, windowHeight;
double myTime = 0.0;

// ===================================================================
void initGL()
{
	glEnable(GL_DEPTH_TEST);
	glShadeModel(GL_SMOOTH);

	glEnable(GL_CULL_FACE);
	glFrontFace(GL_CCW);
	glPolygonOffset (1.0f, 1.0f);

	glLineWidth(1.5);
	glClearColor(1.0, 1.0, 1.0, 1.0); // Clear with bg colour

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
}

// ===================================================================
// OpenGL call-back functions
void redraw(void)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);	// clear the window

	// Insert main code here


	// before here
	glutSwapBuffers();
}

// ================================

void resize(int w, int h)
{

	// Prevent a divide by zero, when window is too short
	// (you cant make a window of zero width).
	if(h == 0)
		h = 1;

	aspectRatio = 1.0f * w / h;

	// Reset the coordinate system before modifying
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	// Set the viewport to be the entire window
	glViewport(0, 0, w, h);

}

