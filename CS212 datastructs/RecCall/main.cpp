//Nadine Dabby	
//July 19, 2004
//
//Recursive Function Program

#include <iostream>
using std::cout;
using std::cin;
using std::endl;



void recCall(int i);
void revRec(int j);
void recurseMe(int n);

int main(){

	int n = -1;

	while (n < 1){
		cout << "Please enter a number greater than 0..." <<endl;
		cin >> n;
	}

	recurseMe(n);

	return 0;
}





void recCall(int i){						//recursive calls to establish the first 
	if ( i > 0){							//half of the pattern.

		recCall(i-1);
		
		for (int x = 0; x < i; x++){
			cout << " ";
		}
		cout  << "This was written by call number " << i << "." << endl;
	}
}

void revRec(int i){							//recursive calls to establish the second 
	if ( i > 0){							//half of the pattern.
		for (int x = 0; x < i; x++){
			cout << " ";
		}
		cout  << "This ALSO written by call number " << i << "." << endl;
		revRec(i-1);
	}
}



void recurseMe(int n){						//this function packages the two recursively 
	recCall(n);								//calling functions into one easy-to-use function
	revRec(n);
}
