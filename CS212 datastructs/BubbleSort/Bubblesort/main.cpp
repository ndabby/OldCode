//Nadine Dabby
//June 9, 2004
//
//Bubble Sort Main 
//
//This source file declares and initializes a 20-integer array.
//It then prints the array, calls the bubble sort function and prints the new array.


#include "bubsort.h"
#include <iostream>

using std::cout;
using std::cin;
using std::endl;

int main()
{ const int size = 20;				//declares and initializes the size of the array 
									//declares and initializes the array		
int myArray[size] = {92, 33, 45, -65, 1, 2, 0, -7, 88, 7, 5, -19, 10, 12, 5, -41, -5, 18, 100, -7};

cout << "Before bubble sort:" << endl;

for (int i = 0; i < size; i++)		//prints original array
	cout << myArray[i] << " ";
	
bubbleSort( myArray, size);			//calls bubble sort function

cout << endl << endl << "After bubble sort:" << endl;

for (int j = 0; j < size; j++)		//prints final array
	cout << myArray[j] << " ";

cout << endl;

return 0;
}