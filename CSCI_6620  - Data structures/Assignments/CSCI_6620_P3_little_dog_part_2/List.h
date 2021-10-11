/*
 * Filename: List.h
 *
 * CSCI_6620 - Data Structures
 * Professor:  Thomas Shokite
 * Assignment 3 - P3 Little Dog - Part 2
 * HOWARD ZHOU  - ID# 00748064
 * Fall 2021
 *
 */

#ifndef _LIST_CPP
#define _LIST_CPP
#pragma once


#include <string>

class List
{
public:
	List() {}
	~List() {}
	
	void find(std::string& pStrValue);
	void insert(std::string pStrValue);
	void print(std::ofstream& pOutFile) const;

private:
	class Cell
	{
	public:
		Cell(std::string pText, Cell *pNext = nullptr) : mData(pText), mNext(pNext) {}
		~Cell() {}

		//Cell Member variables
		std::string mData;
		Cell *mNext;
	};


	// List Member variables:
	Cell *mHead  = nullptr;
	Cell *mScan  = mHead;
	Cell *mPrior = nullptr;

};

#endif // !_LIST_CPP

