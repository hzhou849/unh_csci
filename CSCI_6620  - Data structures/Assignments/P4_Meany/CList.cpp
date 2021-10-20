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

void CList::insert(Student *pStudent)
{
	find(pStudent);



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
	Cell *index			= mHead->mNext;
	Cell *stopRefNode	= nullptr;
	bool loopAroundList = false;
	
	// If the List has beeen closed and circularly linked, stop reference will be the last node
	if (mLastNode != nullptr)
		stopRefNode = mLastNode->mNext;

	do
	{
		std::cout <<"address: " <<index  <<"; " << index->mStudent->fName << "  \t" << index->mStudent->lName <<"\t;next:\t" << index->mNext << std::endl;
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
	
	/* Method 1 - Using while loop to iterate*/
	//while (tempIndex != nullptr && mLastNode == nullptr)
	//{
	//	if (tempIndex->mNext == nullptr)
	//	{
	//		std::cout << "Last node found: " << tempIndex << std::endl;
	//		tempIndex->mNext = mHead->mNext;
	//		mLastNode = tempIndex;
	//		
	//		return;
	//	}
	//	
	//	tempIndex = tempIndex->mNext; // Increment to the next node
	//}


	/* Method 2 using find() to locate the last cell*/
	find(nullptr);

	mLastNode = mPrior;
	mLastNode->mNext = mHead->mNext;
	std::cout << "Last node found: " << mLastNode << std::endl;

	std::cerr << "out" << std::endl;
}


void CList::pickLoser()
{	
	// Set the pointer to current - the first student on the list
	
	if (mLastNode == nullptr)
	{
		std::cerr << "Cirucular list is not properly set. Please check list and try again." << std::endl;
		return;
	}
	
	Cell *current = mLastNode;  // The Last Node is also the name of the first student from the list.
	int lastNameLength = 0;
	bool loserFound = false;
	
	while ( !loserFound )
	{
		lastNameLength = (current->mStudent)->lName.length();
		
		// Set the mScan and mPrior to the number of of positions based on length current's last name
		walkList(current, lastNameLength);	
		
		// Update the current position pointer
		current = mScan;
		std::cout << "current: " << current->mStudent->fName << "\t" << current->mStudent->lName << "\t" << current->mStudent->seen << std::endl;

		if (mPrior->mStudent->seen == false)
		{
			mPrior->mStudent->seen = true;	// Set seen to Prior pointer
		}
		else
		{
			loserFound = true;
			std::cout << "Loser found: " << mPrior->mStudent->fName << " " << mPrior->mStudent->lName << std:: endl;
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

// Cleanup all the dynamically allocated heap memory declared.
void CList::memCleanup()
{
	if (mHead == nullptr)
	{
		std::cerr << "Head pointer is empty. No action taken." << std::endl;
		return;
	}

	//std::cout << "mHead->next: " << mHead->mNext << "; " << mHead->mNext->mStudent->fName << ";\t" << mHead->mNext->mStudent->lName << std::endl;
	Cell *tempPrior = mHead;
	Cell *tempIndex = mHead->mNext;
	mLastNode->mNext = nullptr; // make the last node point to null

	do
	{
		std::cout << "cleaning->address: " << tempIndex << "; " << tempIndex->mStudent->fName 
				  << "  \t" << tempIndex->mStudent->lName << "\t;next:\t" << tempIndex->mNext 
				  << std::endl;
		tempPrior = tempIndex;
		tempIndex = tempIndex->mNext;

		delete tempPrior->mStudent;
		delete tempPrior;
		*tempPrior = NULL;
	
		
	} while (tempIndex != nullptr);
		




}