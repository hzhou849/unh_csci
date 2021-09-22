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

 /*
  * Note with templates, The compiler cannot instantiate a fucntion template unless it knows the actual
  * parameter to the template and teh this acutal parameter apperies in the client code
  * Which is why you cannot put class definition in header and member function definition in cpp file
  *
  *
  *
  * A template is not like a function which can be compiled into byte code.
  * It is just a pattern to generate such a function. If you put a template on its own into a *.cpp file,
  * there is nothing to compile. Moreover, the explicite instanciation is actually not a template, but the
  * starting point to make a function out of the template which ends up in the *.obj file.
  *
  * Compiler instantiates a template similar to a macro text replacement which is why the declaration/defintion
  * must be placed in the same file.
  */


#pragma once
#include <iostream>

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
	ItemType info; // node of data
	NodeType *next; // The pointer to the next linked item.

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
	void PrintList() const;



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
	//MakeEmpty();
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


// Circular List PUT
template <class ItemType>
void SortedType<ItemType>::PutItem( ItemType item)
{
	NodeType<ItemType> *newNode;
	NodeType<ItemType> *predLoc;
	NodeType<ItemType> *location;
	bool found; 

	newNode = new NodeType<ItemType>; // Creates the Node struct
	newNode->info = item;			  // Stores the ItemType item info is actually the node holder

	if (listData != nullptr)
	{
		if (listData != nullptr && (listData->info.ComparedTo(item) == RelationshipType::LESS))
		{
			std::cout << "LESS" << std::endl;
			FindItem(listData, item, location, predLoc, found);
			newNode->next = predLoc->next;
			predLoc->next = newNode;

			// If this is the last node in the list, reassign listData.
			if (listData->info.ComparedTo(item) == RelationshipType::LESS)
				listData = newNode;
		}
		else if (listData != nullptr && listData->info.ComparedTo(item) == RelationshipType::GREATER)
		{
			FindItem(listData, item, location, predLoc, found);
			newNode->next = predLoc->next;
			predLoc->next = newNode;
		}
	}
	else // Inserting in to an empty list.
	{
		listData = newNode;
		newNode->next = newNode; 
	}
	m_length++;


}

template <class ItemType>
void SortedType<ItemType>::DeleteItem(ItemType item)
{
	NodeType<ItemType>* location;
	NodeType<ItemType>* predLoc;
	bool found;
	
	FindItem(listData, item, location, predLoc, found);
	
	if (predLoc == location) // Only node in list?
	{
		listData = nullptr;
	}
	else
	{
		predLoc->next = location->next;
		
		if (location == listData) // Deleting last node in the list?
		{
			listData = predLoc;
		}
	}

	delete location;
	m_length--;
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
		if (item.ComparedTo(location->info) == RelationshipType::LESS)
		{
			moreToSearch = false;
		}
		else if (item.ComparedTo(location->info) == RelationshipType::EQUAL)
		{
			found = true;
		}
		else
		{
			predLoc = location;
			location = location->next;
			moreToSearch = (location != listData->next); // if currentlocation NOT EQUAL listData->next; 
		}
	}
}