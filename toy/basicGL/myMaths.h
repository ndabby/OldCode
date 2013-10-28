//
//  Maths.h
//
//  Created by Suvir Venkataraman on Mon Sep 13 2004.
//

#include <math.h>
#include <vector>

#define pi 3.1415926535898
#define PI 3.1415926535898
#define deg2rad 0.017453292
#define rad2deg 57.29577951

#define TINY 1.0e-20

#define FALSE 0
#define TRUE 1

#ifndef VECTOR_3D
#define VECTOR_3D
typedef struct vector_3D{
	double x,y,z;
};
#endif

#ifndef VECTOR_4D
#define VECTOR_4D
typedef struct vector_4D{
	double x,y,z,w;
};
#endif

// Load identity matrix into a square matrix
void loadIdentity(double* m, int n);
void loadIdentity(float* m, int n);

// 3D Vector Addition and Subtraction
vector_3D vecAdd(vector_3D v1, vector_3D v2);
vector_3D vecSub(vector_3D v1, vector_3D v2);   // v1 - v2

// Multiply a 3D vector by a scalar
vector_3D vecScalarMult(double s, vector_3D v);

// Multiply a 3D vector by a 3x3 matrix
vector_3D vecMatrixMult(double m[3][3], vector_3D v);
// Multiply a 4D vector by 4x4 matrix
vector_4D vecMatrixMult(double* m, vector_4D v);
vector_4D vecMatrixMult(float* m, vector_4D v);
vector_4D vecMatrixMult(float* m, float* v);

// Finds the length of a 3D vector
double vecLength (vector_3D v);
double vecLengthD (double *v);

// Normalise a vector
vector_3D normaliseV (vector_3D v);
void normaliseD (double *v);

// Finds the dot product of two 3D vectors, returns a scalar
double dotProduct (vector_3D v1, vector_3D v2);

// Finds the cross product of two 3D vectors, returns a 3D vector
vector_3D crossProduct (vector_3D v1, vector_3D v2);

// Finds the cross product of two 3 vectors, returns a normalised 3D vector
vector_3D normCrossProduct (vector_3D v1, vector_3D v2);

// Finds the angle between two 3D vectors
double angleBetween2Vectors (vector_3D v1, vector_3D v2);

// Calculates the factorial
int factorial (int n);

// Calculates the binomial coefficient 
// (k unordered outcomes from n possibilities)
// also known as the combination or combinatorial number
int binomialCoefficient (int C, int k);

// Calculates x^y
double power (double X, int Y);

// Calculates the Bernstein polynomial of degree n, index i, evaluated at t ( 0 < t < 1 )
double bernstein(int i, int n, double t);

// Calculates the rotation matrix for a given theta (degrees) and an axis of rotation
// The result is stored in M, which should be a pointer to a 3x3 array
// This is based on the formula M = v * vTranspose + cos(Theta)(I - v * vTranspose) + sin(Theta) * S
// where S = [ [0, -z, -y], [z, 0, x], [-y, x, 0] ]
// Please refer to appendix F of the OpenGL programming guide for more information
void rotationMatrix(double theta, vector_3D v, double *M);
