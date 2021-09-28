#include <iostream>
#include <fstream>
#include "SList.h"

SList::SList() {}
SList::~SList() {}

///@tparam T is template param

/*
* Insertion works like this
 * Head ->Null 
 * Head -> N1 ->Null 
 * Head -> N2 -> N1 -> Null
 *
 * 

 */

/// @brief	Insert a  value
/// 
/// 
/// 
///	@param:
///		Cell *scan			- walking list pointer
///		Cell *head			- Permanent head address
///		BT (typedef string) - string value of the node
///
/// @return none
void SList::insert(BT value)
{
	Cell *newCell = new Cell(value);		// Allocate a new cell on the heap
	scan = newCell;							// Useless like my professor
	newCell->next = head->next;				// Assign head->next to newCell->next
	head->next = newCell;					// Point the head to the newCell address
	++count;								// Increment the list counter
}

void SList::loadLinkedListNotSorted()
{
	std::ifstream fileInput;
	fileInput.open("Lecture4_linked_list.txt", std::ios::in);
	std::string myString = "This is the head. Data not used.";
	std::string *ptrMyString = nullptr;

	start(myString);

	while (getline(fileInput, myString))  // getline from <input> and store it in <string>
	{
		std::cout << myString << std::endl;
		insert(myString);					// Create a new node and insert it into the list
	}

	fileInput.close();

}

/// @brief Create the first head node of the list
///
/// @param BT value  - (Template string) string value for the node 
/// 
/// 
void SList::start(BT value)
{
	head = new Cell(value);
}