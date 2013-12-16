#ifndef QT_H
#define QT_H


typedef struct nodetag{
	struct nodetag * left;
	struct nodetag * right;
	struct nodetag * parent;
	int bit;
	int freq;
	char x;
} node;



class queue{
	public:
		queue(int c = 52);
		~queue();
		node* pop();
		void push(node*);
		bool empty();
		int size();
		node* top();

		int leftchild(int);
		int rightchild(int);
		int parent(int);

	private:
		int capacity;
		int used;
		node** data;
};


#endif