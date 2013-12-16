//Nadine Dabby
//July 26, 2004
//
//queue header file




#ifndef QUEUE_H
#define QUEUE_H





class queue{
	public:
		queue(int c = 10);
		~queue();
		int pop();
		void push(const int&);
		bool empty();
		int size();
		int top();
		int getData(int);
		int getCapacity();

		int leftchild(int);
		int rightchild(int);
		int parent(int);


	private:
		int capacity;
		int used;
		int * data;
		int * order;		
		

};


#endif