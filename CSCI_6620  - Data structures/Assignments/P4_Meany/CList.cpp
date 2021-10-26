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
#include <iomanip>

#include "CList.h"

CList::CList() {};
CList::~CList() {};


void CList::insert(Student *pStudent)
{
	// Create a new cell with the student information.
	Cell *newCell = new Cell(pStudent);

	if (mHead == nullptr)
		mHead = newCell;
	else
	{
		newCell->mNext = mHead->mNext;
		mHead->mNext = newCell;
	}
}


void CList::print(std::ofstream &pOutFile)
{
	Cell *index			= mHead->mNext;
	Cell *stopRefNode	= nullptr;
	bool loopAroundList = false;
	
	// If the List has beeen closed and circularly linked, stop reference will be the marked last node 
	if (mLastNode != nullptr)
		stopRefNode = mLastNode->mNext;

	do
	{
		std::cout <<"address: " <<index  <<"; " << index->mStudent->fName << " "  << index->mStudent->lName << std::setfill(' ') << std::setw(18) << "\tnext cell:  " << index->mNext << std::endl;
		pOutFile  <<"address: " <<index  <<"; " << index->mStudent->fName << " "  << index->mStudent->lName << std::setfill(' ') << std::setw(18) << "\tnext cell:  " << index->mNext << std::endl;
		index = index->mNext;
	} while (index != stopRefNode);

}


void CList::closeList()
{
	Cell *tempIndex = mHead;

	if (mLastNode != nullptr)
	{
		std::cout << "No Action - List is already in a closed loop." << std::endl;
		return;
	}

	find(nullptr);
	mLastNode = mPrior;
	mLastNode->mNext = mHead->mNext;
	//std::cout << "Last node found: " << mLastNode <<"\n" <<std::endl;
}


void CList::pickLoser(std::ofstream &pOutFile)
{	
	std::cout << "Start picking a loser...\n" << std::endl;
	pOutFile  << "Start picking a loser...\n" << std::endl;

	if (mLastNode == nullptr)			// Set the pointer to current - the first student on the list
	{
		std::cerr << "Cirucular list is not properly set. Please check list and try again." << std::endl;
		return;
	}
	
	Cell *current = mLastNode;			 // The Last Node is also the name of the first student from the list.
	int lastNameLength = 0;
	bool loserFound = false;
	
	while ( !loserFound )
	{
		lastNameLength = (current->mStudent)->lName.length();
		
		
		walkList(current, lastNameLength);		// Perform the hop based on the lenght of the student's last name
		current = mScan;						// Update the current position pointer
		std::cout << "Current position: " << current->mStudent->fName << " " << current->mStudent->lName << "\t" << current->mStudent->seen << std::endl;
		pOutFile  << "Current position: " << current->mStudent->fName << " " << current->mStudent->lName << "\t" << current->mStudent->seen << std::endl;

		if (current->mStudent->seen == false)
		{
			current->mStudent->seen = true;		
		}
		else
		{
			loserFound = true;
			std::cout << "Loser found: " << current->mStudent->fName << " " << current->mStudent->lName << std:: endl;
			pOutFile  << "Loser found: " << current->mStudent->fName << " " << current->mStudent->lName << std::endl;

		}
	}
}


void CList::walkList(Cell *pCurPtr, int pNumHops)
{
	mScan = pCurPtr;
	mPrior = nullptr;

	for (int i = 0; i < pNumHops; i++)
	{
		mPrior = mScan;
		mScan = mScan->mNext;
	}
}


void CList::find(Student *pStudent)
{
	// Initialize the scan point to the head of the list and prior to nullptr;
	mScan = mHead;
	mPrior = nullptr;

	// Do a 2 pointer walk down the list until scan finds the corresponding cell.
	while (mScan != nullptr)
	{
		mPrior = mScan;
		mScan = mScan->mNext;

		if (mScan == nullptr)
			return;
		if (mScan->mStudent == pStudent)
			return;
	}
}


// Cleanup all the dynamically allocated heap memory declared.
void CList::memCleanup()
{
	if (mHead == nullptr)
	{
		std::cerr << "Head pointer is empty. No action taken." << std::endl;
		return;
	}

	Cell *tempPrior = mHead;
	Cell *tempIndex = mHead->mNext;

	if (mLastNode != nullptr)
		mLastNode->mNext = nullptr;

	do
	{
		tempPrior = tempIndex;
		tempIndex = tempIndex->mNext;

		delete tempPrior->mStudent;
		delete tempPrior;
	} while (tempIndex != nullptr);
}