//first addition program 2-9-04
#include <iostream>

int main()
{
	int temp;
	int me[] = {1, 5, 3, 8, 6, 100, -3, 34, 88, 12};
	int used = 10;
	for (int i = 0; i < (used - 1); i++){
		for (int j = 0; j < (used - 1 - i); j++){
			if (me[j] > me[j + 1]){
				temp = me[j];
				me[j] = me[j+1];
				me[j+1] = temp;
			}
		}
	}

	for (int k = 0; k < used; k++){
		std::cout << me[k];
	}




	int integer1;
	int integer2;
	int sum;
	int product;
	int difference;
	int quotient;

	std::cout << "Enter First Integer!\n";
	std::cin >> integer1;

	std::cout << "Enter Second Integer!\n";
	std::cin >> integer2;

	sum = integer1 + integer2;
	product = integer1 * integer2;
	difference = integer1 - integer2;
	quotient = integer1 / integer2;


	std::cout << "Sum is " << sum << std::endl;
	std::cout << "Product is " << product << std::endl;
	std::cout << "Difference is " << difference << std::endl;
	std::cout << "quotient is " << quotient << std::endl;

	return 0;
}