/*
 * Filename: List.cpp

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



void List::find(std::string pStrValue)
{
	// Reset the mScan variable to the head of the list
	mScan = mHead;

	if ( pStrValue.empty() )
	{
		std::cerr << "No valid string entered." << std::endl;
		exit(EXIT_FAILURE);
	}

	while (pStrValue != mScan->mData)
	{
		mPrior = mScan;
		mScan = mScan->mNext;
	}

	std::cout << "FOUND: " << pStrValue << "was found in address: " << mScan << std::endl;
}


// Create the first head node of the list and initialize it.
void List::start(std::string pStrValue)
{
	mHead = new Cell(pStrValue);  // initialize the head
}


// Insert a value into the a new node.
void List::insert(std::string pStrValue)
{
	Cell *newCell = new Cell(pStrValue);

	//mScan = newCell; // not used.
	newCell->mNext = mHead->mNext;
	mHead->mNext = newCell;
	counter++;
}


void List::LoadLinkedListNOTSorted()
{

	// Load the input file and create an output file.
	std::ifstream inputFile("p3Meow.txt", std::ios::in);
	std::ofstream outputFile("console_out.txt", std::ios::trunc);

	if (!inputFile || !outputFile)
	{
		// Place in fatal() function with try catch.
		std::cerr << "Error initializing I/O file descriptor." << std::endl;
		exit(EXIT_FAILURE);
	}

	std::string strData = "This is the head. Data NOT USED.";
	//std::string *ptrNodeStr = nullptr;

	start(strData);		// Initialize the head


	// Read each line of the input text file
	while ( getline(inputFile, strData) )
	{
		std::cout << counter << ") " << strData << std::endl;
		insert(strData);
	}

	find("neow!");

	inputFile.close();
	
}