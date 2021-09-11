#pragma once

#ifndef _SORTEDTYPE_H
#define _SORETEDTYPE_H

#include "ItemType.h"


// Struct declaration
struct NodeType; // Private structures go in cpp file. Public in header.


class SortedType
{
public:
	// Abstract Data type Operations:
	// Constructor:
	SortedType();
	~SortedType();

	// TRANSFORMERS:
	void MakeEmpty();
	void PutItem(ItemType item);
	void DeleteItem(ItemType item);

	// OBSERVERS:
	bool IsFull() const;
	int GetLength() const;
	ItemType GetItem(ItemType item, bool *found);
	void PrintList() const; // const cannt change member variables

	
	// ITERATORS:
	void ResetList();
	ItemType GetNextItem();


private:
	NodeType *listData;		// Stores the linked-list starting position
	NodeType *currentPos;	// Iterator node
	int m_length;


};
#endif // _SORTEDTYPE_H



