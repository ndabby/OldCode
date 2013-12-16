//Nadine Dabby
//June 14, 2004
//
//Quadratic Class implementation file



#include "Quad.h"

quadratic::quadratic(double a, double b, double c)	//this is the constructor, it sets members
													//a, b, c to zero if double values are not given
{ a_coef = a;
  b_coef = b;
  c_coef = c;
}

void quadratic::seta(double y)			//sets member a, does not return a value
{ a_coef = y;
}

void quadratic::setb(double y)			//sets member b, does not return a value
{ b_coef = y;
}

void quadratic::setc(double y)			//sets member c, does not return a value
{ c_coef = y;
}

double quadratic::geta() const			//this function returns the value of a 
{ return a_coef;
}

double quadratic::getb() const			//this function returns the value of b
{ return b_coef;
}

double quadratic::getc_coef() const		//this function returns the value of c
{ return c_coef;
}

double quadratic::evaluate(double x)	//this function returns takes a double parameter (x)
										//and returns a double, the value of the expression
										//evaluated at x.
{ return (a_coef*x*x + b_coef*x + c_coef);
}


quadratic operator +(const quadratic& q1, const quadratic& q2)	
										//this is the implementation of the overloaded + operator
{	double asum, bsum, csum;			//it returns a quadratic object whose member values
	asum = (q1.geta() + q2.geta());		//are the sums of the member values of the 2 objects
	bsum = (q1.getb() + q2.getb());		//that were added together.
	csum = (q1.getc_coef() + q2.getc_coef());

	quadratic sum(asum, bsum, csum);

	return sum;
}

quadratic operator *(double r, const quadratic& q1)
{										//this is the implementation of the overloaded * operator
  double aprod, bprod, cprod;			//it returns a quadratic object whose member values
  aprod = r * (q1.geta());				//are the product of the double r multiplied by the 
  bprod = r * (q1.getb());				//members of quadratic q1.
  cprod = r * (q1.getc_coef());

  quadratic product(aprod, bprod, cprod);

  return product;
}
