#include <iostream>
using namespace std;
main() {
                                                                               
  struct{
    int x[100];
    int var1;
    int y[10];
    } foo;
  int var2;
  int i;
  int *p, *q;
                                                                               
  for (i=0; i<100; i++) foo.x[i]=100+i;
  for (i=0; i<10; i++)  foo.y[i]=300+i;
  foo.var1 = 250;
                                                                               
  p=&(foo.x[5]);       cout << *p << "\n";
  q = p+16;            cout << *q << "\n";
  i = ((int) p) + 16;
  q = (int *) i;       cout << *q << "\n";
  q = p+95;            cout << *q << "\n";
  q = p+98;            cout << *q << "\n";
  i = ((int) p) + 17;
  q = (int *) i;       cout << *q << "\n";
                                                                               
}