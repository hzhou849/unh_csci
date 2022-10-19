/*
 * Week 9 - Interacting classes
 * Program: Bar graph				File: item.hpp
 *
 * Data class to model a student exam score
 */

#pragma once
#include "tools.hpp"

class Item {
private:
	char initials[4];				// Array of char for student names
	int score;

public:
	Item (char* inits, int sc)
		: score(sc) { strcpy_s(initials, inits); }

	~Item() { cerr << "[*] Item Destructor [" << initials << "]"; }

	ostream& print(ostream& os) const {return os << initials << " " << score << " "; }
};

inline ostream& operator<<(ostream& os, const Item& iObj) {
	return iObj.print (os);
}
