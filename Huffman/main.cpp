//Nadine Dabby
//CS 129
//Nov. 2, 2006
//
//Huffman Implementation

#include <stdlib.h>

#include <iostream>
using std::ios;
using std::cout;
using std::cin;
using std::endl;

#include <fstream>
using std::ifstream;    //need to input files
using std::ofstream;    //need to create output file 


#include <iostream>
using std::cout;
using std::cin;
using std::endl;


#include <stdio.h>
#include "qt.h"

ofstream fc("compressed.txt", ios::out); //compressed text
ofstream fd("decompressed.txt", ios::out); // decompressed

ofstream fout("codeword.txt", ios::out); //codewords

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


huffman* buildTree( int* freaky){
	queue* Q;
	Q = new queue();
/*	int n = -1;
	while (n < 1){
		cout << "Please enter the number of letters you want to code:" << endl;
		cin >> n;
	}
*/
	node* data;
	data = new node[256];
	
//	cout <<  "Enter the letter followed by a space and its frequency as an integer:";
	for (int i = 0; i<256; i++){
		data[i].x = (char)(i);
		data[i].freq = freaky[i];
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
	H->size = 256;
	delete Q;
	return H;
}
		  
void printStuff(node* p){
	if (p->parent == NULL){
		return;
	}
	printStuff(p->parent);
	fout << p->bit;
}

void printcomp(node* p){
	if (p->parent == NULL){
		return;
	}
	printcomp(p->parent);
	fc << p->bit;
}



int main(){



ifstream inText("book.txt", ios::in); //input War and Peace


char x;
unsigned int myx; 
int freq[256];

for (int i = 0; i < 256; i++){
	freq[i] = 0;
}

while(inText.eof() != 1){
	x = inText.get();
	myx = (unsigned int)(x);
	freq[myx]++;
}
				


huffman* myHuff = buildTree(freq);


fout << "Here are my Huffman codewords" << endl;

for( int j = 0; j < myHuff->size; j++){
	if (myHuff->myArray[j].freq != 0){
		fout << myHuff->myArray[j].x << " "; 
		printStuff(&(myHuff->myArray[j]));
		fout <<endl;
		}
}		

//need to compress

inText.clear();
inText.seekg(0, ios::beg);

while(inText.eof() != 1){
	x = inText.get();
	for(int a = 0; a< myHuff->size; a++){
		if (x == (myHuff->myArray[a].x)){
			printcomp(&(myHuff->myArray[a]));
			}
	}
}


//need to decode

ifstream decode("decompressed.txt", ios::in);

node* me;

while(decode.eof() != 1){
//	cout << "---------------------------------------------------------->" << endl;
	x = decode.get();
	me = myHuff->root;
	while(me->left != NULL && me->right != NULL){
	
		x = decode.get();
		if ((int)x == (me->left->bit)){
			me = me->left;
			}
		else if((int)x == (me->right->bit)){
			me = me->right;
			}
		}
	fd << me->x;
//	cout << me->x;	
}

	return 0;
}

