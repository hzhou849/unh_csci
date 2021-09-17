#pragma once

#ifndef _UNSORTEDTYPE_H
#define _UNSORTEDTYPE_H

#include "ItemType.h"


static const int MAX_ITEMS = 10;

class UnsortedType
{
public:
	//Abstract Data type operations: 
	// Constructor:
	UnsortedType();

	// TRANSFORMERS:
	void MakeEmpty();
	void putItem(ItemType item);
	void DeleteItem(ItemType item);
	
	// OBSERVERS
	bool IsFull() const;
	int GetLength() const;
	ItemType GetItem(ItemType item, bool &found);
	void printList();
	
	// ITERATORS
	void ResetList();
	ItemType GetNextItem();

private:
	ItemType info[MAX_ITEMS];
	int m_length;
	int currentPos;
};


#endif //_UNSORTEDTYPE_H

