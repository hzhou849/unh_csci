/*Nest.cpp*/

#include "Nest.h"
#include "tools.hpp"

ostream& Nest::print(ostream& out) {
	if (empty()) {
		out << "\nNest is empty\n\n";
	}
	else {
		out << "\n" << count << " rabbits are in the nest:\n\n";
		
		for (start(); !atEnd(); tunnel[next++].print(out));
		out << endl;
	}

	return out;
}


/// @brief Append a new Rabbit to the end of the nest.
/// @return true=normal operation; false=Nest was full
bool Nest::arrive(Rabbit p) {
	if (full()) return false;
	else tunnel[count++] = p;
	return true;
}