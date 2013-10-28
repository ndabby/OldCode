//
//  Maths.m
//  Cocoa OpenGL
//  
//  Contains any maths functions used by the program, that are not defined in ANSI C
//
//  Created by Suvir Venkataraman on Mon Sep 13 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#include "myMaths.h"

void loadIdentity(double* m, int n)
{
	int i,j;
	for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)
		{
			if(i==j)
				*(m+i*n+j) = 1;
			else
				*(m+i*n+j) = 0;
		}
	}
}

void loadIdentity(float* m, int n)
{
	int i,j;
	for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)
		{
			if(i==j)
				*(m+i*n+j) = 1;
			else
				*(m+i*n+j) = 0;
		}
	}
}

vector_3D vecAdd(vector_3D v1, vector_3D v2)
{
	vector_3D result = { v1.x+v2.x, v1.y+v2.y, v1.z+v2.z};
	return result;
}

vector_3D vecSub(vector_3D v1, vector_3D v2)
{
	vector_3D result = { v1.x-v2.x, v1.y-v2.y, v1.z-v2.z};
	return result;
}

vector_3D vecScalarMult(double s, vector_3D v)
{
	vector_3D result = { v.x*s, v.y*s, v.z*s};
	return result;
}

vector_3D vecMatrixMult(double m[3][3], vector_3D v)
{
	vector_3D result = { m[0][0]*v.x + m[0][1]*v.y + m[0][2]*v.z,
						 m[1][0]*v.x + m[1][1]*v.y + m[1][2]*v.z,
						 m[2][0]*v.x + m[2][1]*v.y + m[2][2]*v.z};
	return result;
}

vector_4D vecMatrixMult(double* m, vector_4D v)
{
	vector_4D result = { *(m)*v.x + *(m+1)*v.y + *(m+2)*v.z + *(m+3)*v.w,
						 *(m+4)*v.x + *(m+5)*v.y + *(m+6)*v.z + *(m+7)*v.w,
						 *(m+8)*v.x + *(m+9)*v.y + *(m+10)*v.z + *(m+11)*v.w,
						 *(m+12)*v.x + *(m+13)*v.y + *(m+14)*v.z + *(m+15)*v.w};
	return result;
}

vector_4D vecMatrixMult(float* m, vector_4D v)
{
	vector_4D result = { *(m)*v.x + *(m+1)*v.y + *(m+2)*v.z + *(m+3)*v.w,
						 *(m+4)*v.x + *(m+5)*v.y + *(m+6)*v.z + *(m+7)*v.w,
						 *(m+8)*v.x + *(m+9)*v.y + *(m+10)*v.z + *(m+11)*v.w,
						 *(m+12)*v.x + *(m+13)*v.y + *(m+14)*v.z + *(m+15)*v.w};
	return result;
}

vector_4D vecMatrixMult(float* m, float* v)
{
	vector_4D result = { *(m)**v + *(m+1)**(v+1) + *(m+2)**(v+2) + *(m+3)**(v+3),
						 *(m+4)**v + *(m+5)**(v+1) + *(m+6)**(v+2) + *(m+7)**(v+3),
						 *(m+8)**v + *(m+9)**(v+1) + *(m+10)**(v+2) + *(m+11)**(v+3),
						 *(m+12)**v + *(m+13)**(v+1) + *(m+14)**(v+2) + *(m+15)**(v+3)};
	return result;
}

//Finds the length of a 3D vector
double vecLength (vector_3D v)
{
	double result = sqrt((v.x * v.x) + (v.y * v.y) + (v.z * v.z));
	return result;
}

double vecLengthD (double *v)
{
	double result = sqrt(((*(v)) * (*(v))) + ((*(v+1)) * (*(v+1))) + ((*(v+2)) * (*(v+2))));
	return result;
}

vector_3D normaliseV (vector_3D v)
{
	double length = vecLength (v);
	if(length!=0)
	{
		v.x /= length;
		v.y /= length;
		v.z /= length;
	}
	return v;
}

void normaliseD (double *v)
{
	double length = vecLengthD(v);
	if(length!=0)
	{
		*v /= length;
		*(v+1) /= length;
		*(v+2) /= length;
	}
}
//Finds the dot product of two 3D vectors, returns a scalar
double dotProduct (vector_3D v1, vector_3D v2)
{
	double result = (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z);
	return result;
}

//Finds the cross product of two 3D vectors, returns a 3D vector
vector_3D crossProduct (vector_3D v1, vector_3D v2)
{
	vector_3D result;
	result.x = (v1.y * v2.z) - (v1.z * v2.y);
	result.y = - (v1.x * v2.z) + (v1.z * v2.x);
	result.z = (v1.x * v2.y) - (v1.y * v2.x);
	return result;
}

vector_3D normCrossProduct (vector_3D v1, vector_3D v2)
{
	
	vector_3D result;
	result.x = (v1.y * v2.z) - (v1.z * v2.y);
	result.y = - (v1.x * v2.z) + (v1.z * v2.x);
	result.z = (v1.x * v2.y) - (v1.y * v2.x);
	
	double length = vecLength(result);
	// Now normalise the result
	result.x = result.x / length;
	result.y = result.y / length;
	result.z = result.z / length;
	
	return result;
}

// Finds the angle between two vectors
double angleBetween2Vectors (vector_3D v1, vector_3D v2)
{
	double normDotProd = dotProduct(v1, v2) / (vecLength(v1) * vecLength(v2));
	double result = (acos(normDotProd) / (2 * pi)) * 360;
	return result;
}
	
int factorial (int n)
{
	int i;
	int result = 1;
	
	for(i=1; i<=n; i++)
	{result *= i;}
	return result;
}


int binomialCoefficient(int n, int k)
{
	int result = factorial(n) / (factorial(n-k) * factorial (k));
	return result;
}

double power(double X, int Y)
{
	int i;
	double result;
	if(Y==0)
	{	
		result = 1;
	}
	else
	{
		result = X;
		for (i=1; i<Y; i++)
		{ result *= X; }
	}
	return result;
}

double bernstein(int i, int n, double t)
{
	double result = binomialCoefficient(n,i) * power ( t, i) * power ( (1-t), (n-i));
	return result;
}

void rotationMatrix(double theta, vector_3D v, double *M)
{
	double tmp[3][3];
	// Normalise the vector
	v = normaliseV(v);
	double u[3] = { v.x, v.y, v.z};
	
	// Create the required matrices
	double term1[3][3];
	double term2[3][3] = {{1,0,0}, {0,1,0}, {0,0,1}};
	
	// Convert theta to radians and store its cos and sin
	double thetaRads = (theta/360) * 2 * pi;
	
	double cosTheta = cos(thetaRads);
	double sinTheta = sin(thetaRads);
	
	double term3[3][3] = {{0,-v.z * sinTheta, v.y * sinTheta}, 
						{v.z * sinTheta, 0, -v.x * sinTheta}, 
						{ -v.y * sinTheta, v.x * sinTheta, 0}};
	
	int i, j;
	for (i=0; i<3; i++)
	{
		for (j=0; j<3; j++)
		{
			term1[i][j] = u[i] * u[j];
			term2[i][j] = cosTheta * (term2[i][j] - term1[i][j]);
			*(M + 3*i + j) = term1[i][j] + term2[i][j] + term3[i][j];
			tmp[i][j] = term1[i][j] + term2[i][j] + term3[i][j];
		}
	}
}
