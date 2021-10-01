/*
 * Filename: List.cpp
 *
 * CSCI_6620 - Data Structures
 * Professor:  Thomas Shokite
 * Assignment 3 - P3 Little Dog - Part 1
 * HOWARD ZHOU  - ID# 00748064
 *
 */


#include <iostream>
#include <fstream>
#include <string>

#include "List.h"


void List::find()
{
	mPrior = mScan;							// sets mPrior to the newest node on the list.

	/* Additional Features to be implemented  
	 * for Part 2 of assignment
	 */
}


void List::insert(std::string pStrValue)
{
	find();									// Re-assess the current state of the linked list

	Cell *newCell = new Cell(pStrValue);
	mScan = newCell;						// Increment the current position

	if (mPrior == nullptr)		
	{
		mHead = newCell;
	}
	else
	{
		newCell->mNext = mHead->mNext;
		mHead->mNext = newCell;
	}
}


void List::print(std::ofstream& pOutFile)
{
	Cell *index = mHead->mNext;

	if (!pOutFile)
	{
		exit(EXIT_FAILURE);
	}

	while (index != nullptr)
	{
		std::cout << index->mData << std::endl;
		pOutFile  << index->mData << std::endl;
		index = index->mNext;
	}
}
