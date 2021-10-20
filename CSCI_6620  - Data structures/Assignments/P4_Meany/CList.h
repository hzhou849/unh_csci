/*
 * CList.h
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P4 Meany
 * Name:        HOWARD ZHOU - ID# 00748064
 */

 //Define a class named CList(circular list) 
 // helper class named Cell.
 //The last Cell on a CList points back to the first Cell, so that a program can “walk” round and round 
 //the list in a circle - See Section 4 for details and guidance.


// Circular Linked Lists
// x1.The Cell class can be defined one of two ways, below.For this program, please use method(a), 
//	two separate classes and friendship.Adapt the code from queue.hpp.
//	 a) Cell is a fully separate class that gives friendship to List.All members of Cell are private.
//	 b) Cell is a class inside the private area of List.All members of Cell are public.

// x2. In your List class, define members for the head of the list and for walking around it. You  don’t need a count field for this application.
// x3. Initially, the List should be empty, that is, the head of the list should be initialized to nullptr.
// x4. The list described here is a straight - line list until eof is reached, and the ends are joined.
// x5. All cells are inserted at the head of the list because that is easiest and most efficient.
// 6. No special action is needed to maintain circularity when a Cell is removed.
// x7. Use a 2 - pointer scan to walk around the list.This makes deletion very easy.


#ifndef _CLIST_H
#define _CLIST_H
#pragma once

#include <string>

#include "Cell.h"
#include "Student.h"


class CList
{
public:
	CList();
	~CList();

	void print();
	void insert(Student *pStudent);
	void find(Student *pStudent);
	void closeList();
	void pickLoser();
	void walkList(Cell *pCurPtr, int pNumHops);

	void memCleanup();



private:
	Cell *mHead = nullptr;
	Cell *mScan = mHead;
	Cell *mPrior = nullptr;
	Cell *mLastNode = nullptr; // Track the last node in the list
};
#endif // !_CLIST_H

