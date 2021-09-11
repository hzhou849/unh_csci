#include <iostream>
#include "UnsortedType.h"

UnsortedType::UnsortedType()
{
	currentPos = 0;
	m_length   = 0;
}

//--------------------------------------------------------------------------------------------------
// TRANSFORMERS:
void UnsortedType::MakeEmpty()
{
	// Set the length of the list to zero
	m_length = 0;
}

void UnsortedType::putItem(ItemType item)
{
	// Put the item in the list and increment the length counter
	info[m_length] = item;
	m_length++;
}

void UnsortedType::DeleteItem(ItemType item)
{
	// *Unsorted delete, we will just replace the last element
	// 	in the cell of the deleted element and decrement the length count.
	// Search all elements in the list then delete the matching item
	
	
	int location = 0;

	while ( item.ComparedTo(info[location]) != ItemType::EQUAL 
			&& ( location < (m_length-1) ) 
		  )
	{
		location++;
	}
	
	// Since this is an unsorted list, we will just replace the 
	// found cell with the last element and decrement the length of the list.
	info[location] = info[m_length - 1];
	m_length--;
	

}



//--------------------------------------------------------------------------------------------------
// OBSERVERS:
bool UnsortedType::IsFull() const
{
	return bool(m_length == MAX_ITEMS);
}

int UnsortedType::GetLength() const
{
	return m_length;
}

ItemType UnsortedType::GetItem(ItemType item, bool &found)
{
	// Pre: Key member(s) of this item is initialized.
	// Post: If found, item's key matches an element's key in the
	//		list and a copy of that element has been returned;
	//	     otherwise, item is returned.

	// Initialize values
	found = false;
	bool moreToSearch;
	int location = 0;

	// Continue searching if the current location has not reached the present 
	// length of the list.
	moreToSearch = (location < m_length);

	// While moreToSearch is True and found==false
	while (moreToSearch && !found)
	{
		switch ( item.ComparedTo(info[location]) )
		{
			case ItemType::LESS:

			case ItemType::GREATER:
				location++;
				break;
			case ItemType::EQUAL:
				found = true;
				item = info[location];
				break;
		}
	}

	return item;
}


void UnsortedType::printList()
{
	for (int i = 0; i < m_length; i++)
	{
		std::cout << info[i].getValue() << std::endl;
	}
}



//--------------------------------------------------------------------------------------------------
// ITERATORS:
void UnsortedType::ResetList()
{
	// -1 is the Null value for the current position.
	currentPos = -1;
}

ItemType UnsortedType::GetNextItem()
{
	// Move the current position up one position
	currentPos++;
	return info[currentPos];
}

