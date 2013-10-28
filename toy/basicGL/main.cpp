#include "glFunctions.h"

using namespace std;

// Global variables
int xres = 500;
int yres = 500;
int myError;

int main(int argc, char* argv[]) 
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE);
	
	glutInitWindowSize(xres, yres);
	glutInitWindowPosition(100, 100);

	glutCreateWindow("Test program");
	glEnable(GL_CULL_FACE);
	glEnable(GL_DEPTH_TEST);
	glCullFace(GL_BACK);

	initGL();

	glutDisplayFunc(redraw);
	glutReshapeFunc(resize);

	glutMainLoop();
	return 0;
}

