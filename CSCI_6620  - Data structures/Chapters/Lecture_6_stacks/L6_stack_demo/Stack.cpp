/*CSCI 6620 - Data Structures
* Fall 2021
*
* Lecture 6 Stacks
 * Stack demo with Exception Handling
 *
 * Stack.h
 */

#include <iostream>
#include "Stack.h"


Stack::Stack(int pMaxSize)
{
	MAX_ITEMS = pMaxSize;
	top = -1;
	stackPtr = new std::string[pMaxSize];
}

Stack::~Stack() 
{
	std::cerr << "Destructor called" << std::endl;
	delete[] stackPtr;
}

void Stack::Push(std::string mData ) 
{
	try 
	{
		if (IsFull())
		{
			throw FullStack();
		}	

		top++;
		stackPtr[top] = mData;

		std::cout << "stackPtr: " << stackPtr[top] << std::endl;

	}
	catch (FullStack& exObj)
	{
		std::cerr << exObj.getInfo() << std::endl;
		exit(EXIT_FAILURE);
	}

	std::cerr << "keep going" << std::endl;
}

void Stack::Pop()
{
	try
	{
		if (IsEmpty())
		{
			throw EmptyStack();
		}

		top--;
	}
	catch (EmptyStack& exObj)
	{
		std::cerr << exObj.getInfo() << std::endl;
		exit(EXIT_FAILURE);
	}
}

std::string Stack::getTop()
{
	if (IsEmpty())
	{
		throw EmptyStack();
	}

	return stackPtr[top];
}

bool Stack::IsEmpty() const
{
	return (top == -1);
}


bool Stack::IsFull() const
{
	return (top == MAX_ITEMS - 1);
}


void Stack::Print()
{
	for (int i = 0; i < MAX_ITEMS; i++)
	{
		std::cout << "[" << i << "]: " << stackPtr[i];
		if (i == top)
			std::cout << " <--TOP";
		std::cout <<  std::endl;
	}
	std::cout << "\n" << std::endl;
}