//Nadine Dabby
//June 14, 2004
//
//Quadratic class header file
//
//This file defines the functions and members associated with a quadratic expression.
//The members of this class include three double variables a, b, and c that define the
//coeficients of the expression (ax*x + bx + c). The member functions of this class
//include three set functions and three get functions (to set and retrieve the values
//of each of the private members) as well as an evaluate function that evalutes the expression
//for a given value of x. Also defined are two friend functions--the overloaded + and * operators.

#ifndef QUAD_H
#define QUAD_H

class quadratic
{
public:
	quadratic(double a=0, double b=0, double c=0); //the constructor sets default values to 0
												   	
	void seta(double y);
	void setb(double y);
	void setc(double y);
	double geta() const;
	double getb() const;
	double getc_coef() const;
	double evaluate(double x);

	friend quadratic operator +(const quadratic& q1, const quadratic& q2);
	friend quadratic operator *(double r, const quadratic& q1);


private:
	double a_coef;
	double b_coef;
	double c_coef;
	};

#endif