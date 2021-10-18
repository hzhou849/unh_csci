/*
 * CList.cpp
 *
 * CSCI_6620 - Data Structures
 * Professor:   Thomas Shokite
 * Assignment:  P4 Meany
 * Name:        HOWARD ZHOU - ID# 00748064
 */

#include <iostream>
#include <fstream>
#include <string>

//#include "Student.h"
#include "CList.h"

CList::CList() {};
CList::~CList() {};

void CList::insert(Student *pStudent)
{
	// insert
	// Instantiate anew Cell and point to 
	Cell *newCell = new Cell(pStudent);

	// Install the Student object to the cell
	//newCell->mStudent = pStudent;
	
	if (mHead == nullptr)
		mHead = newCell;
	else
	{
		newCell->mNext = mHead->mNext;
		mHead->mNext = newCell;
	}

}


void CList::print()
{
	Cell *index = mHead->mNext;

	while (index != nullptr)
	{
		std::cout <<"ddf" << index->mStudent->fName << " " << index->mStudent->lName << std::endl;
		index = index->mNext;
	}

}
