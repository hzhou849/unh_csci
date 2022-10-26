/* Rabbit.h
 *
 */


//#ifndef RABBIT
//#define RABBIT
#pragma once
#include "tools.hpp"

class Rabbit {
	string name;
	bool good = true;

public:
	/*Rabbit(string name) {
		this->name = name;
	}

	Rabbit() {
		this->name = "Mama Rabbit";
	}*/
	~Rabbit() = default;

	Rabbit(string name = "mama default") : name(name) {}
	void print(ostream& out);
	void runAway(ostream& out);
};



//#endif // RABBIT