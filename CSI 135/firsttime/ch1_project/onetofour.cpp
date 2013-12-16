#include <iostream>

int main()

{	int number1;
	int number2;
	int number3;
	int Sum;
	int Average;
	int Product;
	
	using std::cout;
	using std::cin;
	using std::endl;

	
	cout << "enter three numbers, and i will tell you the truth\n";
	cin >> number1 >> number2 >> number3;

	Sum = number1 + number2 + number3;
	Average = (number1 + number2 + number3)/3;
	Product = number1 * number2 * number3;

	cout << "Sum is " <<Sum <<endl;
	cout << "Average is " <<Average <<endl;
	cout << "Product is " <<Product <<endl;

	if (number1 > number2)
	{if (number1 > number3)
	cout << "Largest is " << number1 <<endl; };
	if (number2 > number3)
		cout << "Largest is " << number2 <<endl;
	else cout << "Largest is " << number3 <<endl;


	if (number1 < number2)
	{if (number1 < number3)
	cout << "Smallest is " << number1 <<endl; }
	else if (number2 < number3)
		cout << "Smallest is " << number2 <<endl;
	else cout << "Smallest is " << number3 <<endl;

return 0;
}