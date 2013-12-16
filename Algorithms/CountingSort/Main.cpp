//Nadine Dabby
//June 28, 2004
//
//Counting Sort implementation in C++
//
//This interactive program asks the user to input a size of the array to be sorted, 
//followed by the numbers in that array. The program assumes all elements int the array are 
//integers greater than zero.
//The program than returns to the user the original array, the largest element in the array
//and the sorted array.

#include <iostream>
using std::cout;
using std::cin;
using std::endl;

#include <vector>				//Because the array is a dynamic one (ie memory is allotted during
using std::vector;				//execution) I used a vector to store and sort the elements.


int largest(vector<int>, int);							//prototype for largest function		
vector<int> countSort(vector<int>, vector<int>, int, int);	//prototype for countSort



int main()
{

int n = -1;			//variable to store size of vector
int k;				//variable to store maximum 

while (n < 1)		//the program will not proceed until the user enters a number greater than 0
{cout << "Please input the size of your array." << endl;
cin >> n;
}

vector<int> arrayA;			//arrayA created
vector<int> arrayB;			//arrayB created

arrayA.resize(n+1);			//arrayA is allotted capacity n+1
arrayB.resize(n+1);			//arrayB is allotted capacity n+1


for (int z = 1; z < n+1; z++)	//arrayB is initialized to zero
	arrayB[z] = 0;


cout << "Please input the elements of your array separated by spaces." <<endl;
for (int i = 1; i < n+1; i++)
	{cin >> arrayA[i];}			//arrayA is initizalized to user-entered values



cout << "You have entered the following array:" << endl;

for (int j = 1; j < n+1; j++)	//outputs arrayA	
	cout << arrayA[j] << " ";
	
cout << endl;



k = largest(arrayA, n);			//largest value in arrayA is stored in variable k

cout << "The largest element in this array is: " << k << endl;

arrayB = countSort(arrayA, arrayB, k, n);	//arrayB "gets" sorted arrayA
	
cout << "Your sorted array is: ";			//sorted array is output
for ( int r = 1; r < n+1; r++)
	cout << arrayB[r] << " ";	


	return 0;
}




int largest(vector<int> A, int size)		//this funtion uses a for loop to find the
{ int largest = 0;							//largest number in the array. it takes a vector
	for (int i = 1; i < size + 1; i++)		//and the vector size as parameters and it returns 
		if (A[i] >= largest)				//the largest integer.
			largest = A[i];
	return largest;
}



vector<int> countSort(const vector<int> A, vector<int> B, int k, int n)
{
vector<int> C;								//This is the countSort function, implementation
C.resize(k+1);								//is based on the algorithm from "Introduction to
for (int i = 0; i < (k+1); i++)				//Algorithms" (CRLS)
	C[i] = 0;
for (int j = 1; j < n+1; j++)
	C[A[j]] = C[A[j]] + 1;
for (int g = 1; g <(k+1); g++)
	C[g] = C[g] + C[g-1];
for (int t = n; t > 0; t--)
	{B[C[A[t]]] = A[t];
	C[A[t]] = C[A[t]] - 1;
	}
return B;	
}	

