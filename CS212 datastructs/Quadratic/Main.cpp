//Nadine Dabby
//June 14, 2004
//
//Quadratic Class Test file


#include "Quad.h"
#include <iostream>

using std::cout;
using std::endl;

int main()
{	
	double r = 1.11;		// r is a variable that will be used to multiply the quadratics
	double x = 5;			// x is a variable that will be used to evaluate the functions
	

	quadratic q;			//declare q with no parameters and output the values of its members 	
	
	cout << "The quadratic formula of q has initial values of:" <<endl;
	cout <<  "a = " << q.geta() << endl;
	cout <<  "b = " << q.getb() << endl;
	cout <<  "c = " << q.getc_coef() << endl;


	quadratic p(2, 7, 1);	//declare p with paramters (2, 7, 1) and output the values of its members
	
	cout << "The quadratic formula of p has initial values of:" <<endl;
	cout <<  "a = " << p.geta() << endl;
	cout <<  "b = " << p.getb() << endl;
	cout <<  "c = " << p.getc_coef() << endl;


	q.seta(3);		//reset member a of quadratic q to 3
	q.setb(7);		//reset member b of quadratic q to 7
	q.setc(6);		//reset member c of quadratic q to 6

							//output the new values of q's members
	
	cout << "The quadratic formula of q has new values of:" <<endl;
	cout <<  "a = " << q.geta() << endl;
	cout <<  "b = " << q.getb() << endl;
	cout <<  "c = " << q.getc_coef() << endl;

quadratic s = r*q;	//declare quadratic s as the product of r and quadratic q 	
					//output the values of its members
	
cout << "The quadratic formula of s (which is r * q) has initial values of:" <<endl;
	cout <<  "a = " << s.geta() << endl;
	cout <<  "b = " << s.getb() << endl;
	cout <<  "c = " << s.getc_coef() << endl;


quadratic k = q + p;	//declare quadratic k as the sum of quadratics q and p
						//output the values of its members
	
cout << "The quadratic formula of k (which is q + p) has initial values of:" <<endl;
	cout <<  "a = " << k.geta() << endl;
	cout <<  "b = " << k.getb() << endl;
	cout <<  "c = " << k.getc_coef() << endl;

cout << "q evaluated at x = 5 is " << q.evaluate(x) << endl;	//evaluate q at x
cout << "p evaluated at x = 5 is " << p.evaluate(x) << endl;	//evaluate p at x
cout << "s evaluated at x = 5 is " << s.evaluate(x) << endl;	//evaluate s at x
cout << "k evaluated at x = 5 is " << k.evaluate(x) << endl;	//evaluate k at x


return 0;
}
