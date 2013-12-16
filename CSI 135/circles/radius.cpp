#include <iostream>

int main ()
{
	using std::cout;
	using std::cin;
	using std::endl;

	float radius;
	float diameter;
	float circumference;
	float area;
	float Pi;

	cout << "Give me your radius, and I'll take you on a magic circle ride!" << endl;
	cin >> radius;

	Pi = 3.14159;
	diameter = 2 * radius;
	circumference = 2 * Pi * radius;
	area = Pi * radius * radius;

	cout << "Diameter is " << diameter << endl;
	cout << "Circumference is " << circumference << endl;
	cout << "Area is " << area << endl;


return 0;

}