//Nadine Dabby
//June 9, 2004
//
//Bubble Sort Function Implementation
//
//This source file contains the implementation of the function defined in "bubsort.h".
//The function sorts an array of numbers by comparing each element in the array against 
//all of the other elements that are not sorted yet. It then swaps the elements if the 
//largest number of the two occurs earlier in the array. The biggest number will sink to the 
//end of the array on its first pass through the second for loop. 
//The outer for loop runs as many times as there are elements in the array. 

#include "bubsort.h"        

void bubbleSort (int array[], const int arraySize)

{int temp = 0;          //this variable will store the number to be swapped
int *arrayPt;			//this variable points to the address of the array	
arrayPt = array;
	
for (int loop = 0; loop < (arraySize - 1); loop++)        
	for (int i = 0; i < (arraySize - 1 - loop); i++) 
		 if (arrayPt[i] > arrayPt[i + 1])
			{temp = arrayPt[i];
			arrayPt[i] = arrayPt[i + 1];
			arrayPt[i + 1] = temp;
			}		
	
} 