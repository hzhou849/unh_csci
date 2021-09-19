/* 
 * 
 * Circular linked list SORTED
 *
 * ///NOTE we are using templates for bothe struct and class 
 * because the argument list for ItemType is not known so we have to use a template class type 
 * unless we explicitly code the type in ie. ItemType<int or ItemType<float>
 *
 * 
 * 
 */


#pragma once

#ifndef _SORTEDTYPE_H
#define _SORTEDTYPE_H

#include "ItemType.h"

// Struct declaration
// If using header file
/*template <class ItemType>
struct NodeType;	*/	// Private structures go in the cpp file, public in the head



// Inline template ( no point using a seperate declartion/definition)
// Becuase ItemType is a Template object you have to use template of ItemType because it doesn't know what type it is yet
template <class ItemType>
struct NodeType
{
	ItemType info; // The data of the value
	NodeType *next // The pointer to the next linked item.
};


template <class ItemType>
class SortedType
{
public:
	// Constructor:
	SortedType();
	~SortedType();

	// Transformers;
	void MakeEmpty();
	void PutItem(ItemType item);
	void DeleteItem(ItemType item);

	// Observers: // These functions should be const because you are only viewing, not modifying
	void FindItem(NodeType<ItemType>* listData, ItemType item, NodeType<ItemType>*& location, NodeType<ItemType>*& predLoc, bool &found) const;
	bool IsFull() const;
	bool GetLength() const;
	ItemType GetItem(ItemType item, bool *found);
	void PrintList(); const;



	// Iterators
	void ResetList();
	ItemType GetNextItem();

private:
	NodeType<ItemType> *listData;			// Stores the linked-list starting-position
	NodeType<ItemType> *currentPos;		// Iterator node
	int m_length;

};
#endif // _SORTEDTYPE_H

// CONSTRUCTOR:
// SortedType - Implementation
template <class ItemType>
SortedType<ItemType>::SortedType() : m_length(0), listData(nullptr) {}

template <class ItemType>
SortedType<ItemType>::~SortedType() 
{
	MakeEmpty();
}



// TRANSFORMER TYPES:
template <class ItemType>
void SortedType<ItemType>::MakeEmpty()
{
	NodeType<ItemType> *tempPtr;

	// Iterate through each node and delete it from the heap
	while (listData != nullptr)
	{
		tempPtr = listData;				// Store the first node of the list
		listData = listData->next;		// increment the new start node
		delete tempPtr;
	}

	m_length = 0;
}

template <class ItemType>
void SortedType<ItemType>::PutItem(ItemType item)
{
	NodeType<ItemType> *newNode;
	NodeType<ItemType> *predLoc;
	NodeType<ItemType> *location;
	bool found; 

	newNode = new NodeType<ItemType>;
	newNode->info = item;

	if ((listData->info.ComparedTo(item) == RelationshipType::LESS))
	{
		FindItem(listData, item, location, predLoc, found);
		newNode->next = redLoc->next;


	}
}



// OBSERVERS:


//Find Item Search
// Precondition: list is not empty
// Post: ex. if there is an item that matches key, found = true
template <class ItemType>
void SortedType<ItemType>::FindItem(NodeType<ItemType>* listData, ItemType item,
	NodeType<ItemType>*& location,
	NodeType<ItemType>*& predLoc, bool &found) const
{
	// Set inital values
	bool moreToSearch = true;
	location = listData->next;
	predLoc  = listData;
	found = false;

	while (moreToSearch && !found)
	{
		if (item.CompareTo(location->info) == RelationshipType::LESS)
		{
			moreToSearch = false;
		}
		else if (item.CompareTo(location->info) == RelationshipType::GREATER)
		{
			found == True;
		}
		else
		{
			predLoc = location;
			location = location->next;
			moreToSearch = (location != listData->next); // if currentlocation NOT EQUAL listData->next; 
		}
	}
}