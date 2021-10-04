/*
 * Filename: List.cpp
 *
 * CSCI_6620 - Data Structures
 * Professor:  Thomas Shokite
 * Assignment 3 - P3 Little Dog - Part 2
 * 
 * HOWARD ZHOU  - ID# 00748064
 * Fall 2021
 *
 */

#include <iostream>
#include <fstream>
#include <string>

#include "List.h"


void List::find( std::string& pStrValue )
{
	//initialize the scan pointer to the head of the list and prior nullptr.
	mScan = mHead;
	mPrior = nullptr;

	// Do a 2 pointer walk down the list until scan points at a cell greater than the new data.
	while (mScan != nullptr)
	{
		mPrior = mScan;
		mScan  = mScan->mNext;

		if (mScan == nullptr)
			return;
		if (pStrValue < mScan->mData)
			return;
	}
}


void List::insert(std::string pStrValue)
{
	// Position the scan and prior pointers
	find(pStrValue);

	//Instantiate a new Cell and pointing to whatever scan currently points to.
	Cell *newCell = new Cell(pStrValue);
	newCell->mNext = mScan;

	// Then check prior : if it is nullptr, make head point at the new cell.
	// Otherwise, make the cell that prior points at point at the new
	if (mPrior == nullptr)
		mHead = newCell;
	else
		mPrior->mNext = newCell;
}


void List::print(std::ofstream& pOutFile) const
{
	int counter = 0;
	Cell *tempIndex = mHead->mNext;

	while (tempIndex!= nullptr)
	{
		std::cout << tempIndex->mData << std::endl;
		pOutFile  << tempIndex->mData << std::endl;
		
		tempIndex = tempIndex->mNext;
	}
}






