#pragma once

#include "Cell.h"

class SList
{
public:
	SList();
	~SList();

	int size();
	bool isEmpty();
	void loadLinkedListNotSorted();

private:

	// Member Variables
	int count = 0;				// # of current items.
	Cell *head= nullptr;		// Permanent head pointer
	Cell *scan = nullptr;		// for walking down the list
	Cell *follow = nullptr;		 

	// Member Functions
	void insert(BT value);
	void start(BT value);

};

