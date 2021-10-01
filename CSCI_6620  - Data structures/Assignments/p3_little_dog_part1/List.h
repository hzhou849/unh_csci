/*
 * Filename: List.h
 *
 * CSCI_6620 - Data Structures
 * Professor:  Thomas Shokite
 * Assignment 3 - P3 Little Dog - Part 1
 * HOWARD ZHOU  - ID# 00748064
 *
 */

#ifndef _LIST_H
#define _LIST_H
#pragma once

#include <string>

class List
{

public:

	// List Declarations:
	List() {}
	~List() {}

	void print(std::ofstream& pOutFile);
	void insert(std::string pStrValue);
	void find();

private:

	// List Declarations:
	class Cell
	{
	public:

		Cell(std::string pText, Cell *pNext = nullptr) : mData(pText), mNext(pNext) {}
		~Cell() {}

		// Cell Member Variables:
		std::string mData;
		Cell *mNext;
	};
	
	// other functions
	//void start(std::string pStrValue);
	

	// List Member Varaibles:
	Cell *mHead  = nullptr;
	Cell *mScan  = mHead;		
	Cell *mPrior = nullptr;	



};
#endif // !_LIST_H

