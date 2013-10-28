/*
 *  Created by Suvir Venkataraman on Wed Oct 28 2004.
 *  glFunctions.h
 */

#ifdef __APPLE__
	#include <GLUT/glut.h>
	#include <OpenGL/glext.h>
#else
	#include <GL/glut.h>
	#include "gle.h"
#endif

using namespace std;

// ===================================================================
void initGL();

// ===================================================================
// Scene redraws
void redraw(void);

void resize(int w, int h);

