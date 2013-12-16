//Nadine Dabby
//Algorithms
//July 26, 2004
//
//Huffman Implementation

#include <iostream>
using std::cout;
using std::cin;
using std::endl;


#include <stdio.h>
#include "qt.h"


typedef struct huff{
	node* myArray;
	node* root;
	int size;
} huffman;


node* newNode(){
	node* x = (node*)malloc(sizeof(node));
	x->bit = -1;
	x->freq = 0;
	x->left = NULL;
	x->parent = NULL;
	x->right = NULL;
	x->x = '\0';

	return x;
}


huffman* buildTree(){
	queue* Q;
	Q = new queue();
	int n = -1;
	while (n < 1){
		cout << "Please enter the number of letters you want to code:" << endl;
		cin >> n;
	}

	node* data;
	data = new node[n];
	
	cout <<  "Enter the letter followed by a space and its frequency as an integer:";
	for (int i = 0; i<n; i++){

		cin >> data[i].x >> data[i].freq;
		data[i].bit = -1;
		data[i].left = NULL;
		data[i].right = NULL;
		data[i].parent = NULL;
		Q->push(&data[i]);
	}
	
	int m = Q->size();
	for(int j = 1; j < m; j++){
		node* z= newNode();
		z->left = Q->pop();
		z->left->parent = z;
		z->left->bit = 0;
		z->right = Q->pop();
		z->right->parent = z;
		z->right->bit = 1;
		z->freq = z->left->freq + z->right->freq;
		Q->push(z);
	}
	huffman* H = (huffman*)malloc(sizeof(huffman)); 
	H->root = Q->pop();
	H->myArray = data;
	H->size = n;
	delete Q;
	return H;
}
		  
void printStuff(node* p){
	if (p->parent == NULL){
		return;
	}
	printStuff(p->parent);
	cout << p->bit;
}






int main(){

huffman* myHuff = buildTree();

for( int i = 0; i < myHuff->size; i++){
	cout << myHuff->myArray[i].x << " "; 
	printStuff(&(myHuff->myArray[i]));
	cout <<endl;
}
		

	return 0;
}

