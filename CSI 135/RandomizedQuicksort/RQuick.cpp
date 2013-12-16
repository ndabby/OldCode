//Nadine Dabby
//CSC 22000
//July 7, 2004

//Randomized Quicksort implementation





	
#include <iostream>
using std::cout;
using std::cin;
using std::endl;


#include <stdlib.h>				//contains rand function
using namespace std;

int Part(int *A, int p, int r);
int RandPartition(int *A, int p, int r);
void RandQuickSort(int *A, int p, int r);
int ns;
int main()
{

int n = -1;			//variable to store size of vector
 

while (n < 1)		//the program will not proceed until the user enters a number greater than 0
{cout << "I beseech thee to input the size of your array." << endl;
cin >> n;
}
ns=n;
int * arrayA=(int*)malloc(sizeof(int)*ns);			//arrayA created
							//arrayB create



for (int z = 0; z <= n; z++)	//arrayA is initialized to zero
	arrayA[z] = 0;


cout << "Please input the elements of your array separated by spaces." <<endl;
for (int i = 0; i < n; i++)
	{cin >> arrayA[i];}			//arrayA is initizalized to user-entered values



cout << "You have entered the following array:" << endl;

for (int j = 0; j < n; j++)	//outputs arrayA	
	cout << arrayA[j] << " ";
	
cout << endl;

//vector<int> arrayB;
//arrayB.resize(n);
//arrayB = 

RandQuickSort(arrayA, 0, (n-1));
	
cout << "Your sorted array is: ";			//sorted array is output
for ( int r = 0; r < n; r++)
	{cout << arrayA[r] << " ";		
	}
return 0;
}



void printA(int *a){
	for (int i=0;i<ns;i++){printf("%i ",a[i]);}printf("\n");
}






int Part(int* A, int p, int r){
	int key = A[p];
	int i = p - 1;
	int j = r+1;
	while (1){
		printA(A);
		do j=j-1;
		while (A[j] > key && j>=p);
				  
		do i=i+1; 
		while (A[i] < key && i <= r);
		
		if (i < j)
		{	int temp = A[i];
			A[i] = A[j];
			A[j] = temp;
			} 
		else return j;
	}
}



int RandPartition(int *A, int p, int r){
	int x = p+rand() % (r-p+1);
	int temp = A[p];
	A[p] = A[x];
	A[x] = temp;
	return Part(A, p, r);
}

void RandQuickSort(int *A, int p, int r){
	printA(A);
	if (p < r){
		int q = RandPartition(A, p, r);
		RandQuickSort(A, p, q);
		RandQuickSort(A, (q + 1), r);
	}
}





/////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
/*
int Part(int *A, int l, int r){
	int key = A[l];
	int temp = 0;
	int count;
	while (l < r){
	for (count = l + 1; count <= r; count++){
		printA(A); 
		if (A[count] < key){
			temp = A[l];
			A[l] = A[count];
			A[count] = temp;
			l++;
		} else if (A[count] > key){
			temp = A[r];
			A[r] = A[count];
			A[count] = temp;
			r--;
		}
	}
	}
	return l;
}
*/