/* Rabbit.cpp */

#include "Rabbit.h"

void Rabbit::runAway(ostream& out) {
	out << "See you later! ";
}

void Rabbit::print(ostream& out) {
	out << name << " is";
	
	if (!good) {
		out << " not";
	}

	out << " a good little rabbit.\n";
}