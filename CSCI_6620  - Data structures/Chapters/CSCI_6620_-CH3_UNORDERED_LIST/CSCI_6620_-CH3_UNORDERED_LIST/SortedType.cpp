#include <iostream>
//#include <cstdbool>
#include "SortedType.h"
// Struct definition
struct NodeType
{
	ItemType info;  // The data value
	NodeType *next; // The pointer to the next linked item.
};

// CONSTRUCTOR
SortedType::SortedType()
{
	m_length = 0;
	listData = nullptr; //NULL; //nullptr?
}

SortedType::~SortedType()
{
	NodeType *tempPtr;

	// Iterate through each node and delete it from the heap
	while (listData != nullptr)
	{
		tempPtr = listData;			// Store the first node
		listData = listData->next;	// increment the new start node
		delete tempPtr;
	}
}

//--------------------------------------------------------------------------------------------------
// TRANSFORMERS:

void SortedType::MakeEmpty()
{
	NodeType *tempPtr;		// temporarily store the current node to delete

	// Iterate through the linked list and delete each note 
	while (listData != nullptr)
	{
		tempPtr = listData;
		listData = listData->next; // iterate to the next node.
		delete tempPtr;
	}

	m_length = 0;
}


void SortedType::PutItem(ItemType item)
{
	NodeType *newNode;	// Pointer to node being inserted
	NodeType *predLoc;	// Trailing pointer to store the previous node dataa
	NodeType *location; // Traveling pointer

	bool moreToSearch;
	location = listData; // Stores the linked-list starting position node

	predLoc = nullptr;
	moreToSearch = (location != nullptr); // If location NOT EQUAL nullptr, return 1/TRUE)

	// Find the insertion point
	while (moreToSearch)
	{
		switch (item.ComparedTo(location->info)) //info = data
		{
			case ItemType::GREATER :
				predLoc = location;				// Store the last current location as predLoc
				location = location->next;		// Move the current location forward +1
				moreToSearch = (location != nullptr);
				break;
			case ItemType::LESS :			// If its less, than its clearly not in the list		
				moreToSearch = false;
				break;
		}
	}

	// We have found the position, prepare node for insertion
	newNode = new NodeType;
	newNode->info = item;

	// Insert node into list
	if (predLoc == nullptr)			// If the position is the first item.
	{
		newNode->next = listData;
		listData = newNode;
	}
	else							// If the item is to be inserted between 2 existing nodes.
	{
		newNode->next = location;	// new node points to current iterator position
		predLoc->next = newNode;	// previous node points to this node.
	}

	m_length++;
}


void SortedType::DeleteItem(ItemType item)
{
	NodeType *location = listData;
	NodeType *tempLocation;

	// Locate node to be deleted.
	if (item.ComparedTo(listData->info) == ItemType::EQUAL)
	{
		tempLocation = location;
		listData = listData->next;	// if the first node is the matches, delete first node
	}
	else 
		// Check if the next node is equal to item we are searching for
	{	//  Node.next->info
		// [location->next]->info
		while (item.ComparedTo((location->next)->info) != ItemType::EQUAL)
		{
			location = location->next;  
		}
			
			// We found the node we want to delete @ location->next
			tempLocation = location->next;		

			// store the next link from the node we will be deleting
			location->next = (location->next)->next; // is this the same as tempLocation->next?
	}

	delete tempLocation;
	m_length--;
}





//--------------------------------------------------------------------------------------------------
// OBSERVER:


// ADT implementation is unbounded since this is dynamic allocation of memory
// The IsFull() test will try allocate memory in the heap and then delete it 
// just to see if it is possible. The only way this will fail is if the
// program actually runs out of memory.
bool SortedType::IsFull() const
{
	NodeType *location;
	try
	{
		// Attempty to allocate memory in heap-space
		// Return 'false' if allocation is ok!
		location = new NodeType;
		delete location;
		return false;
	}
	catch (std::bad_alloc exception)
	{
		std::cerr << "Exception Bad allocation  caught!" << std::endl;
		return true;
	}
}


int SortedType::GetLength() const
{
	return m_length;
}


ItemType SortedType::GetItem(ItemType item, bool *found)
{
	bool moreToSearch;
	NodeType *location;

	location = listData;
	*found = false;
	
	// If location NOT EQUAL NULL/nullptr return True 
	// Meaning the list has data?
	moreToSearch = (location != nullptr);

	while (moreToSearch && !found)
	{
		switch (item.ComparedTo(location->info))
		{
			case ItemType::GREATER:
				location = location->next;
				moreToSearch = (location != nullptr);
				break;

			case ItemType::EQUAL:
				item = location->info;
				*(found) = true;
				break;

			case ItemType::LESS:
				// Since this is a sorted list, 
				// nothing to search since item is smaller than the first value of the list
				moreToSearch = false;
				break;
		}
	}
	return item;
}

void SortedType::PrintList() const
{
	int listSize = GetLength();
	NodeType *tempLocation = listData;

	for ( int i=0; i < listSize; i++ )
	{
		std::cout << std::showbase << i << ") Address: " << tempLocation << " Value: " << tempLocation->info.getValue() << std::endl;
		tempLocation = tempLocation->next;
	}
}


//--------------------------------------------------------------------------------------------------
// Iterators:
void SortedType::ResetList()
{
	currentPos = nullptr;
}


ItemType SortedType::GetNextItem()
{
	ItemType item;

	if (currentPos == nullptr)
	{
		currentPos = listData;
	}

	item = currentPos->info;		// Get the current item value
	currentPos = currentPos->next;	// increment the item to the next node.
	return item;
}