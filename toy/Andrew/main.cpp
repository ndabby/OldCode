


#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
//#include "sbitmap.h"
//#include "process.h"
#include <time.h>
#define getPixel(pict,x,y) (pict->pic[y][x] &0x000000ff)
#define setPixel(pict,x,y,z) (pict->pic[y][x]=(0x000000ff & z) | (0x000000ff & (z<<8))| (0x000000ff & (z<<16))| (0x000000ff & (z<<24)))

#define DOUBLE_BUFFER 1 
void ShapeIt(int width, int height);
float rnorm();

int Width,Height;

typedef struct ant_struct{
	float x,y,z;
	float dx,dy,dz;
	float mass;
} ant;

ant *ants;
float **points;
float **colors;
FILE *logFile=0;

#define SHIFT 5.0

float MAX_X=137.7;
float MAX_Y=137.7;
float MIN_X=-137.7;
float MIN_Y =-137.7;
float MAX_Z=137.7;
float MIN_Z =-137.7;

int NUM_ANTS=2000;
float dt=(1.0/1);


//SIMPLE_BMP *pic;



float transX,transY,transZ;

float rotX,rotY;




int mouseX,mouseY;
int button1=0;
int button2=0;
int button3=0;


void do_translation(){
	int i;
	for (i=0;i<NUM_ANTS;i++){
		points[i][0]=ants[i].x+transX;
		points[i][1]=ants[i].y+transY;
		points[i][2]=ants[i].z+transZ;
	}
} 

void transform33(float **T, float **x,int num){
	int n;
	int i,j,k;
	double a,b,c;
	for (n=0;n<num;n++){
		a=T[0][0]*x[n][0] + T[0][1]*x[n][1] + T[0][2]*x[n][2];
		b=T[1][0]*x[n][0] + T[1][1]*x[n][1] + T[1][2]*x[n][2];
		c=T[2][0]*x[n][0] + T[2][1]*x[n][1] + T[2][2]*x[n][2];
		x[n][0]=a;
		x[n][1]=b;
		x[n][2]=c;
	}

}
 
void do_rotation(){
	 float **rotMat=(float**)malloc(sizeof(float*)*3);
	 int i;
	 for (i=0;i<3;i++){
		 rotMat[i]=(float*)malloc(sizeof(float)*3);
	 }


	rotMat[0][0]=cos(rotY);
	rotMat[0][1]=0.0;
	rotMat[0][2]=-sin(rotY) ;
	rotMat[1][0]=0.0;
	rotMat[1][1]=  1.0;
	rotMat[1][2]=0.0;
	rotMat[2][0]=sin(rotY);
	rotMat[2][1]=0.0;
	rotMat[2][2]=cos(rotY);

	transform33(rotMat,points,NUM_ANTS);
	
	
	
	
	
	rotMat[0][0]=1.0;
	rotMat[0][1]=0.0;
	rotMat[0][2]= 0.0;
	rotMat[1][0]=0.0;
	rotMat[1][1]= cos(rotX);
	rotMat[1][2]=sin(rotX);
	rotMat[2][0]=cos(rotX);
	rotMat[2][1]=-sin(rotX);
	rotMat[2][2]=0.0;

	 transform33(rotMat,points,NUM_ANTS);
	// [3][3]={	{, , },
	//						{,      ,       },
	//						{,, }};


}



void mouseButton(int button, int state, int x, int y)
{
	printf("MOUSE: %i %i\n",button,state);
	switch(button){
	case 0:
		if (state==0) {
			button1=1;
			mouseX=x;
			mouseY=y;
		}else button1=0;
		break;
	case 1:
		if (state==0) {
			button2=1;
			mouseX=x;
			mouseY=y;
		}else button2=0;
		break;
	case 2:
		if (state==0) {
			button3=1;
			mouseX=x;
			mouseY=y;
		}else button3=0;
		break;
	default:
		break;
	}
	glutPostRedisplay();
}

void mouseMotion(int x, int y)
{ 
	if (button3){
		rotX+=(((float)y)-((float)mouseY))/(float)Height;
		rotY+=(((float)x)-((float)mouseX))/(float)Width;
		printf("ROTATING: (%f, %f)\n",rotX,rotY);
	}
	if (button1){
		transX+=(MAX_X-MIN_X)*1*(((float)(x-mouseX))/((float)Width));
		transY-=(MAX_Y-MIN_Y)*1*(((float)(y-mouseY))/((float)Height));
		printf("TRANSLATING: (%f, %f)\n",transX,transY);
	}
	if (button2){
		float scale=-((((float)y)-((float)mouseY))/(float)Height);
		float xC=MIN_X+(MAX_X-MIN_X)/2.0;
		float yC=MIN_Y+(MAX_Y-MIN_Y)/2.0;
		float zC=MIN_Z+(MAX_Z-MIN_Z)/2.0;
		MAX_X=xC+(MAX_X-xC)*(1.0-scale);
		MAX_Y=yC+(MAX_Y-yC)*(1.0-scale);
		MAX_Z=zC+(MAX_Z-zC)*(1.0-scale);

		MIN_X=xC+(MIN_X-xC)*(1.0-scale);
		MIN_Y=yC+(MIN_Y-yC)*(1.0-scale);
		MIN_Z=zC+(MIN_Z-zC)*(1.0-scale);
	}
	mouseX=x;
	mouseY=y;
	ShapeIt(Width,Height);
	glutPostRedisplay();
}
void swapAnts(int i,int j){
	ant t;
	memcpy(&t,&(ants[i]),sizeof(ant));
	memcpy(&(ants[i]),&(ants[j]),sizeof(ant));
	memcpy(&(ants[j]),&t,sizeof(ant));

}

void ShapeItStub(int width, int height)
{
    Width  = width;
    Height = height;

	printf("RESHAPE: (%i, %i), X: [%f, %f]    Y: [%f, %f]    Z: [%f, %f]\n",width,height, MAX_X,MIN_X,MAX_Y,MIN_Y,MAX_Z,MIN_Z);
    /* Reset the viewport... */
    glViewport(0, 0, width, height);

//    glMatrixMode(GL_PROJECTION);
 // 	glLoadIdentity();
 //   glOrtho(MIN_X, MAX_X,MIN_Y, MAX_Y,MIN_Z, MAX_Z);
  //  glMatrixMode(GL_MODELVIEW);
  
//	glDisable(GL_DEPTH_TEST);
    glMatrixMode(GL_PROJECTION);
    glPushMatrix();
    glLoadIdentity();
    glOrtho(MIN_X, MAX_X,MIN_Y, MAX_Y,MIN_Z, MAX_Z);
    glMatrixMode(GL_MODELVIEW);
   	
	
	
	
	//glutReshapeWindow(winWidth,winHeight);
  //glViewport(0,0,winWidth,winHeight);
  // glViewport((w-winWidth)/2,(h-winHeight)/2,winWidth,winHeight);
//	deleteSimple_BMP(pic);
 //   pic=newSimple_BMP(Width,Height);

	
}

void ShapeIt(int width, int height){
	ShapeItStub(width,height);
	glutPostRedisplay();
}
void Keys(unsigned char key, int x, int y)
{
	int i;
	float sc=0,xCenter,yCenter;
  switch(key) {
  case 'q':
  case 'Q':
  case 0x1B://ESC key
	  fclose(logFile);
    exit(1);
    break;
  case 'i':
	  sc=(MAX_Y-MIN_Y)/SHIFT;
	  MAX_Y+=sc;
	  MIN_Y+=sc;
	  ShapeItStub(Width,Height);
	  break;
  case 'k':
	  sc=(MAX_Y-MIN_Y)/SHIFT;
	  MAX_Y-=sc;
	  MIN_Y-=sc;
	  ShapeItStub(Width,Height);
	  break;
  case 'j':
	  sc=(MAX_X-MIN_X)/SHIFT;
	  MAX_X-=sc;
	  MIN_X-=sc;
	  ShapeItStub(Width,Height);
	  break;
  case 'l':
	  sc=(MAX_X-MIN_X)/SHIFT;
	  MAX_X+=sc;
	  MIN_X+=sc;
	  ShapeItStub(Width,Height);
	  break;
  case '=':
	  xCenter=MIN_X+(MAX_X-MIN_X)/2.0;
	  yCenter=MIN_Y+(MAX_Y-MIN_Y)/2.0;

	  MAX_X=xCenter+(MAX_X-xCenter)*(1.0+(1.0/SHIFT));
	  MIN_X=xCenter-(xCenter-MIN_X)*(1.0+(1.0/SHIFT));
	  MAX_Y=yCenter+(MAX_Y-yCenter)*(1.0+(1.0/SHIFT));
	  MIN_Y=yCenter-(yCenter-MIN_Y)*(1.0+(1.0/SHIFT));

	  ShapeItStub(Width,Height);
    break;
  case '-':
	  xCenter=MIN_X+(MAX_X-MIN_X)/2.0;
	  yCenter=MIN_Y+(MAX_Y-MIN_Y)/2.0;

	  MAX_X=xCenter+(MAX_X-xCenter)*(1.0-(1.0/SHIFT));
	  MIN_X=xCenter-(xCenter-MIN_X)*(1.0-(1.0/SHIFT));
	  MAX_Y=yCenter+(MAX_Y-yCenter)*(1.0-(1.0/SHIFT));
	  MIN_Y=yCenter-(yCenter-MIN_Y)*(1.0-(1.0/SHIFT));

	  ShapeItStub(Width,Height);
    break;
  case ' ':
	  for (i=0;i<NUM_ANTS;i++){
		  int j=rand()%NUM_ANTS;
		  swapAnts(i,j);
	  }
    break;
  case '[':
    break;
  case ']':
    break;
  default:
	  break;
  }
//  glutPostRedisplay();
}
/*
void drawPic(SIMPLE_BMP*pic,int xoff,int yoff,int div){
	int x,y,R,G,B;
	float den=256;
	glBegin(GL_POINTS);
	  for (y=0;y<div*pic->height;y++){
		  for (x=0;x<div*pic->width;x++){			  
			R=0x000000ff & (pic->pic[y/div][x/div] >> 24);
			G=0x000000ff & (pic->pic[y/div][x/div] >> 16);
			B=0x000000ff & (pic->pic[y/div][x/div] >> 8);
			R=(G=(B=pic->pic[y/div][x/div] & 0x000000ff));
			glColor3f((float)(R/den),(float)(G/den),(float)(B/den));				
			
glVertex3f((float)x+xoff,(float)(y+Height-yoff-pic->height*div-2),(MAX_Z-MIN_Z)/2.0);
		  }
	  }
	glEnd();
}
*/

#define frand() (((float)(rand()%RAND_MAX))/((float)RAND_MAX))

void updateVelocitiesChase(){
	int a;
	int i;
	float tx,ty,dx,tz,dz,dy,r;
	int followers=15;

	for (i=0;i<NUM_ANTS;i++){
		dx=0;
		dy=0;
		dz=0;
		for (a=0;a<followers;a++){
			dx+=(ants[(i+1+a)%NUM_ANTS].x-ants[i].x);
			dy+=(ants[(i+1+a)%NUM_ANTS].y-ants[i].y);
			dz+=(ants[(i+1+a)%NUM_ANTS].z-ants[i].z);
		}
		r=sqrt(dx*dx+dy*dy+dz*dz);
		dx=dx/r;
		dy=dy/r;
		dz=dz/r;
		ants[i].dx=ants[i].dx*ants[i].mass+dx*dt;//+(.5-frand())/100.0;
		ants[i].dy=ants[i].dy*ants[i].mass+dy*dt;//+(.5-frand())/100.0;
		ants[i].dz=ants[i].dz*ants[i].mass+dz*dt;//+(.5-frand())/100.0;
	}

}

float antRad(int i){
	float r=ants[i].x*ants[i].x;
	r+=ants[i].y*ants[i].y;
	r+=ants[i].z*ants[i].z;
	return sqrt(r);
}





float sqAntDist(int i,int j){
	float x=(ants[i].x-ants[j].x);
	float y=(ants[i].y-ants[j].y);
	float z=(ants[i].z-ants[j].z);
	return (x*x)+(y*y)+(z*z);
}

double getAvgRad(){
	double rad;
	int i;
	double x,y,z;
	rad=0;
	for (i=0;i<NUM_ANTS;i++){
		x=ants[i].x*ants[i].x;
		x+=ants[i].y*ants[i].y;
		x+=ants[i].z*ants[i].z;
		rad+=sqrt(x);
	}
	return rad/(float)NUM_ANTS;
}

void updateVelocitiesLocalCentroid(){
	int a;
	int i,j;
	float tx,ty,dx,tz,dz,dy,r;

	float centX,centY,centZ;
	int num;

	float Radius = 1;


	for (i=0;i<NUM_ANTS;i++){
		num=0;
		centX=0;
		centY=0;
		centZ=0;
		for (j=0;j<NUM_ANTS;j++){
			if (i==j) continue;
			r=sqAntDist(i,j);
			if (r<Radius){
				num++;
				centX+=ants[j].x;
				centY+=ants[j].y;
				centZ+=ants[j].z;
			}
		}
		//if (num==0) continue;
		tx=centX/(float)num;
		ty=centY/(float)num;
		tz=centZ/(float)num;


		dx=(tx-ants[i].x);
		dy=(ty-ants[i].y);
		dz=(tz-ants[i].z);
		r=sqrt(dx*dx+dy*dy+dz*dz);
		dx=dx/r;
		dy=dy/r;
		dz=dz/r;

		ants[i].dx=dx;
		ants[i].dy=dy;
		ants[i].dz=dz;
	}
}

void moveAnts(){
	double avgRad=getAvgRad();
	if(logFile) fprintf(logFile,"%f\n",avgRad);
	for (int i=0;i<NUM_ANTS;i++){
		ants[i].x=ants[i].x+(ants[i].dx*dt);
		ants[i].y=ants[i].y+(ants[i].dy*dt);
		ants[i].z=ants[i].z+(ants[i].dz*dt);
	}
}




void getPoints(){
	int i,j,k;
	int m,n;
	double acc;
	for (i=0;i<NUM_ANTS;i++){
		points[i][0]=ants[i].x;
		points[i][1]=ants[i].y;
		points[i][2]=ants[i].z;
	}
	do_translation();
	do_rotation();
}




void drawPoints(){

	glBegin(GL_POINTS);

	//glVertex2f(0.5,0.5);
	for (int i=0;i<NUM_ANTS;i++){

		glColor3f(colors[i][0],colors[i][1],colors[i][2]);
		glVertex3f(points[i][0],points[i][1],points[i][2]/**/);
	}

	glEnd();
}

void display(void)
{

//_sleep(1000/15);
	  glClearColor(0.0, 0.0, 0.0, 1.0);
	  glClear(GL_COLOR_BUFFER_BIT);
  glLoadIdentity ();             /* clear the matrix */
      glTranslatef (0.0, 0.0, -5.0); /* viewing transformation */
    glScalef (1.0, 1.0, 1.0);      /* modeling transformation */

   // glScalef (1.0, 0.0, 0.0);      /* modeling transformation */
	//glRotatef(0.0,0.0,0.0);


	 // glDrawPixels(BitmapInfo->bmiHeader.biWidth,
        //             BitmapInfo->bmiHeader.biHeight,
          //           GL_BGR_EXT, GL_UNSIGNED_BYTE, BitmapBits);
	  //glFinish();
	  //glRasterPos2i(GLint x, GLint y)
	  //glRasterPos2f((float)BitmapInfo->bmiHeader.biWidth+10.0, 0);

	  //glDrawPixels(BitmapInfo->bmiHeader.biWidth,
        //            BitmapInfo->bmiHeader.biHeight,
         //            GL_BGR_EXT, GL_UNSIGNED_BYTE, BitmapBits);

//	drawPic(pic,0,0,1);	

//updateVelocitiesLocalCentroid();
	  updateVelocitiesChase();
	  moveAnts();
getPoints();
	  drawPoints();
  glFinish();
  
#if DOUBLE_BUFFER==1
  glutSwapBuffers();
#endif
}



#define frand() (((float)(rand()%RAND_MAX))/((float)RAND_MAX))

void initAntsRandom(){
float slow=0;
float spread=1;

	for (int i=0;i<NUM_ANTS;i++){
		ants[i].x=(rnorm())*(MAX_X-MIN_X)*spread;
		ants[i].y=(rnorm())*(MAX_Y-MIN_Y)*spread;
		ants[i].z=(rnorm())*(MAX_Z-MIN_Z)*spread;
		ants[i].dx=(2*(0.5-frand()))*slow;
		ants[i].dy=(2*(0.5-frand()))*slow;
		ants[i].dz=(2*(0.5-frand()))*slow;
		ants[i].mass=0.0;
	}
}
void initAntsGrid(){
float slow=0;
float spread=.3;
int numGrid=pow(NUM_ANTS,.333333);//for good measure...
float xSpace=(MAX_X-MIN_X)/((float)numGrid);
float ySpace=(MAX_Y-MIN_Y)/((float)numGrid);
float zSpace=(MAX_Z-MIN_Z)/((float)numGrid);

int n=0;
	for (int i=0;i<numGrid;i++){
		for (int j=0;j<numGrid;j++){
			for (int k=0;k<numGrid;k++){
				ants[n].x=((float)(i-numGrid/2))*xSpace*spread;
				ants[n].y=((float)(j-numGrid/2))*ySpace*spread;
				ants[n].z=((float)(k-numGrid/2))*zSpace*spread;
				ants[n].dx=0.0;//(2*(0.5-frand()))*slow;
				ants[n].dy=0.0;//(2*(0.5-frand()))*slow;
				ants[n].dz=0.0;
				ants[n].mass=0.0;
				n++;
				if (n==NUM_ANTS) break;
			}
			if (n==NUM_ANTS) break;
		}
		if (n==NUM_ANTS) break;
	}

}



void tick(void*param)
{
	while(1){
	  updateVelocitiesChase();
	  moveAnts();
	}
}







int main(int argc, char* argv[])
{
	transX=0;transY=0;transZ=0;
	rotX=0;rotY=0;


	ants=(ant*)malloc(sizeof(ant)*NUM_ANTS);
	int i,j;
	points=(float**)malloc(sizeof(float*)*NUM_ANTS);
	for (i=0;i<NUM_ANTS;i++){
		points[i]=(float*)malloc(sizeof(float)*3);

	}
	colors=(float**)malloc(sizeof(float*)*NUM_ANTS);
	for (i=0;i<NUM_ANTS;i++){
		colors[i]=(float*)malloc(sizeof(float)*3);

	}
//	initAntsGrid();
	initAntsRandom();

	  for (i=0;i<NUM_ANTS;i++){
		  j=rand()%NUM_ANTS;
		  swapAnts(i,j);
	  }
	  for (i=0;i<NUM_ANTS;i++){
		  if (ants[i].x<0 && ants[i].y<0 && ants[i].z<0)
		  {  colors[i][0]=.1;colors[i][1]=.1;colors[i][2]=.1;}

		  if ((ants[i].x>=0.0) && (ants[i].y<0.0) && (ants[i].z<0.0))
		  {	  colors[i][0]=.9;colors[i][1]=.1;colors[i][2]=.1;}

		  if (ants[i].x<0 && ants[i].y>=0 && ants[i].z<0)
		  {  colors[i][0]=.1;colors[i][1]=.9;colors[i][2]=.1;}

		  if (ants[i].x>=0 && ants[i].y>=0 && ants[i].z<0)
		  {	  colors[i][0]=.9;colors[i][1]=.9;colors[i][2]=.1;}

		  if (ants[i].x<0 && ants[i].y<0 && ants[i].z>=0)
		  {  colors[i][0]=.1;colors[i][1]=.1;colors[i][2]=.9;}

		  if (ants[i].x>=0 && ants[i].y<0 && ants[i].z>=0)
		  {  colors[i][0]=.9;colors[i][1]=.1;colors[i][2]=.9;}

		  if (ants[i].x<0 && ants[i].y>=0 && ants[i].z>=0)
		  { colors[i][0]=.1;colors[i][1]=.9;colors[i][2]=.9;}

		  if (ants[i].x>=0 && ants[i].y>=0 && ants[i].z>=0)
		  {  colors[i][0]=.9;colors[i][1]=.9;colors[i][2]=.9;}

	  }


	ants[0].x=0;
	ants[0].y=0;
	ants[0].z=0;
	/*
	ants[1].x=1;
	ants[1].y=1;
	ants[1].z=0.9;

	for (i=2;i<11;i++){
	ants[i].x=ants[i-1].x+1;
	ants[i].y=ants[i-1].y+1;
	ants[i].z=ants[i-1].z*10;
	}*/

//	  _beginthread(tick,0,0);

  glutInit(&argc, argv);
  Width=800;
  Height=600;
  glutInitWindowSize(Width,Height);
  glutInitWindowPosition(0, 0);
#if DOUBLE_BUFFER==1
  glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA);
#else
  glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA);
#endif
  int mainWin = glutCreateWindow("Aggregate");
//  pic=newSimple_BMP(Width,Height);

 logFile=fopen("log.txt","w");

  glutDisplayFunc(display);
  glutReshapeFunc(ShapeIt);
  glutKeyboardFunc(Keys);
  glutMouseFunc(mouseButton);
  glutMotionFunc(mouseMotion);
  glutIdleFunc(display);
  
  //glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
  //fillPixel(2,1,255,0,0);

   //gluOrtho2D(0.0,imgWidth,0.0,imgHeight);
  
  glutMainLoop();
  return 0;
}







float rnorm(){
	static int iset=0;
	static float gset;
	float fac, rsq,v1,v2;

	if (iset==0){
		 do{
			v1=2.0*frand()-1.0;
			v2=2.0*frand()-1.0;
			rsq=v1*v1+v2*v2;
		} while (rsq>=1.0||rsq==0);
	fac=sqrt(-2.0*log(rsq)/rsq);
	gset=v1*fac;
	iset=1;
	return v2*fac;
	} else {
	  iset=0;
	return gset;
	}
} 
