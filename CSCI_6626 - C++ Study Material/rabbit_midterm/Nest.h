/* Nest.h */

#include "Rabbit.h"
#include "tools.hpp"

#define LITTER 3

class Nest {
	Rabbit *tunnel;		// Beginning of array of Rabbits
	int count;			// Number of rabbits living in the nest
	int capacity;		// Max number of rabbits that will fit in the nest
	int next;			// Index of current rabbit being examined.

	void start() { next = 0; };
	bool atEnd() { return next == count; }

public:
	Nest(int n = LITTER + 1) {
		capacity = n;
		tunnel = new Rabbit[capacity];
		count = next = 0;
	}

	~Nest() { /* Left for you to write */ }

	bool full() { return (count == capacity); }
	bool empty() { return (count == 0);  }			

	Rabbit getNext() { return tunnel[next++]; }
	Rabbit leave() { return tunnel[--count]; }

	bool arrive(Rabbit p);
	ostream& print(ostream& out);


};