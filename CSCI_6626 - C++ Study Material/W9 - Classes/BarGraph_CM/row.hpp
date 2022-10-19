/*
 * Week 9 - Interacting classes
 * Program: Bar graph				File: row.hpp
 *
 * @brief: Class for a linked-list row and its cells
 */

#pragma once
#include "item.hpp"
#include "tools.hpp"

class Cell {
	friend class Row;

private:
	Item info;
	Cell* next;

	Cell(char* name, int sc, Cell* next) : info(name, sc), next(next) {}
	~Cell() { cout << "[*] Cell Destructor Called" << endl; }

};


//-----------------------------------------------------------------------------
// Row Data Structure Class each
// Each row stores a cell 
class Row {
private:
	static int rowNum;
	char label[10] = " 0.. 9: ";				// Row header label, empty spaces in [0] and [4]
	Cell* head = nullptr;					// Pointer to row of cells, empty.

public:
	Row();
	~Row();
	void insert(char *name, int score);		// delegation
	ostream& print(ostream& os) const ;
};
inline ostream& operator<< (ostream& os, const Row& rObj) {
	return rObj.print(os);
}