#include <list>
#include <queue>

#include <iostream>

using namespace std;

int main(){
	 
	queue<int,list<int> > j;
	j.push(7);
	int k =5;
	cout << k;

	queue<int,list<int> > f;

	f = j;
	cout << f.front();
	f.pop();
	cout << f.empty() << endl;

	//int * f = &(j.front());
	//cout << *f;

 cout << 	j.front();
	return 0;



}