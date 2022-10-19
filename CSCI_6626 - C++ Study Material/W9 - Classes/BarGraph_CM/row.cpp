/*
 * Week 9 - Interacting classes
 * Program: Bar graph				File: row.hpp
 *
 * @brief: Class for a linked-list row and its cells
 */

#include "row.hpp"

// Static initializers
int Row::rowNum = 0;			// Row number used to construct a label for the row

// Default constructor
Row::Row() {
	if (rowNum == 10) strcpy_s(label, "Errors: ");
	else {
		label[0] = label[4] = rowNum + '0';
	}
	++rowNum;
}

// Destructor
Row::~Row() {
	cout << "[*] Row Destructor called." << label;
	Cell *curr;					/// Scanning/walking pointer
	while (head != nullptr) {
		curr = head;
		head = head->next;
		delete curr;
	}
	cout << "End. " << endl;
}

// Create and insert Cell into linked list at head
void Row::insert(char* name, int score) {
	head = new Cell(name, score, head); // put new cell at the head of the list
}

//Print Cell data directly; no delegation of print
ostream& Row::print(ostream& os) const {
	os << label;

	for (Cell* cur = head; cur != nullptr; cur = cur->next) { os << cur->info; }
	return os;
}